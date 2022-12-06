# My Brew Bundle  

brew bundle dump

## How to:

* 7280 &rarr;
    > brew bundle dump --file=/Users/tarikkaya/Documents/BrewBundleTakobaba/BrewFile7280 --force
* L490 &rarr;
    > brew bundle dump --file=/Users/tarikkaya/Documents/BrewBundleTakobaba/BrewFileL490 --force
* M1Pro &rarr;
    > brew bundle dump --file=/Users/tarikkaya/Documents/BrewBundleTakobaba/BrewFileM1 --force

* BrewFileMerged &rarr;
    > cd <BrewBundleDump Folder>
    > cat BrewFile7280 BrewFileL490 BrewFileM1 | sort -fru > BrewfileMerged

**Merged file is a merged of above 3** 