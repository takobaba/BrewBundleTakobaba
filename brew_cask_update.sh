#!/bin/sh

CASKNAME="$1"
CASKROOM=$(brew --caskroom)
CASKDIR="$CASKROOM/$CASKNAME"
DATE=$(date +"%Y%m%d%H%M%S.000")
BACKUPDIR="$CASKDIR/.backup"

BLACK='\033[30m'
RED='\033[31m'
BLUE='\033[34m'
NC='\033[0m'

#
# show usage
#

if [ "$1" = "" ]; then
  echo "USAGE:\n\t$0 caskname"
  exit
fi

if ! [ -x "$(command -v jq)" ]; then
  echo "${RED}Error:${NC} This script requires ${BLUE}jq${NC} to work, install it using ${BLUE}brew install jq${NC}"
  exit
fi

#
# show warning
#

echo "${RED}WARNING!${NC}"
echo "${RED}This script aimed to update cask version without reinstalling cask.${NC}"
echo "${RED}There is no official way to do it, so, use this script on your risk!${NC}"
echo "${RED}You will get no support for issues that arise from using this script!${NC}"
echo; echo "${BLACK}See\thttps://github.com/Homebrew/homebrew-cask/issues/88440\n\thttps://stackoverflow.com/questions/63651114/update-homebrew-casks-versions${NC}"
# echo; read -n 1 -s -r -p "Press any key to proceed or Ctrl+C to abort..."; echo

set -x

#
# check outdated
#

{ echo; echo "${BLACK}Check if cask ${RED}$CASKNAME${BLACK} requires updates${NC}"; } 2> /dev/null
if [ "$(brew outdated --cask --greedy $CASKNAME)" = "" ]; then
  { echo "${RED}Looks like cask ${BLACK}$CASKNAME${RED} either not exists, or not needed to update${NC}"; } 2> /dev/null
  exit
fi

{ echo; echo "${BLACK}Get versions${NC}"; } 2> /dev/null
INSTALLED=$(brew outdated --cask --greedy --json=v2 $CASKNAME | jq -r '.casks[0].installed_versions')
echo $installed
CURRENT=$(brew outdated --cask --greedy --json=v2 $CASKNAME | jq -r '.casks[0].current_version')
# Get The Real Installed From the Applications Folder
INSTALLATIONFOLDER=$(brew info --json=v2 $CASKNAME | jq ".casks[].artifacts[].app[0] | select( . != null )" | tr -d \")
REAL_INSTALLED=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" /Applications/$INSTALLATIONFOLDER/Contents/Info.plist)
if [ "$INSTALLED" = "latest" ]; then
  { echo "${RED}Looks like cask ${BLACK}$CASKNAME${RED} has ${BLUE}latest${RED} version, ignore such casks${NC}"; } 2> /dev/null
  exit
elif [ "$INSTALLED" = "$CURRENT" ]; then
  { echo "${RED}Looks like cask ${BLACK}$CASKNAME${RED} has ${BLUE}${REAL_INSTALLED}${RED} version, Update Brew${NC}"; } 2> /dev/null
  # Dont exit
fi
echo "${RED}Looks like cask ${BLACK}$CASKNAME${RED} has ${BLUE}${REAL_INSTALLED}${RED} version"
#
# backup current cask
#

{ echo; echo "${BLACK}Check/create backup directory ${RED}$BACKUPDIR${NC}"; } 2> /dev/null
[[ ! -e "$BACKUPDIR" ]] && mkdir "$BACKUPDIR"

{ echo; echo "${BLACK}Creating backup directory ${RED}$BACKUPDIR/$DATE${NC}"; } 2> /dev/null
mkdir -p "$BACKUPDIR/$DATE"

{ echo; echo "${BLACK}Backing up current cask files${NC}"; } 2> /dev/null
cp -R "$CASKDIR/.metadata" "$BACKUPDIR/$DATE"
cp -R "$CASKDIR/$INSTALLED" "$BACKUPDIR/$DATE"

#
# rename installed cask version to current
#

{ echo; echo "${BLACK}Rename ${BLUE}$INSTALLED${BLACK} with ${BLUE}$CURRENT${NC}"; } 2> /dev/null
mv "$CASKDIR/$INSTALLED" "$CASKDIR/$CURRENT"
mv "$CASKDIR/.metadata/$INSTALLED" "$CASKDIR/.metadata/$CURRENT"

for install_date in $(ls -1 "$CASKDIR/.metadata/$CURRENT" | head -1); do
  mv "$CASKDIR/.metadata/$CURRENT/$install_date" "$CASKDIR/.metadata/$CURRENT/$DATE"
done

#
# replace cask script
#

{ echo; echo "${BLACK}Replace cask script with latest version${NC}"; } 2> /dev/null
brew cat --cask $CASKNAME > "$CASKDIR/.metadata/$CURRENT/$DATE/Casks/$CASKNAME.rb"

