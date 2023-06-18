# My Brew Bundle  

## How to:

* Dell 7280 &rarr;
    > `brew bundle dump --file=/Users/tarikkaya/Documents/BrewBundleTakobaba/BrewFile7280 --force`
* Thinkpad L490 &rarr;
    > `brew bundle dump --file=/Users/tarikkaya/Documents/BrewBundleTakobaba/BrewFileL490 --force`
* M1Pro &rarr;
    > `brew bundle dump --file=/Users/tarikkaya/Documents/BrewBundleTakobaba/BrewFileM1 --force`

* BrewFileMerged &rarr;
    > `cd /Users/tarikkaya/Documents/BrewBundleTakobaba/`
    
    > `cat BrewFile7280 BrewFileL490 BrewFileM1 | sort -fu > BrewfileMerged`
    
### Run brew cask update script:
    brew_cask_update.sh microsoft-teams > /dev/null 2>&1
