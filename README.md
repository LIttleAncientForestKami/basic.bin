Basic bin
=========

Useful shell scripts I wanna have with me. **Unless otherwise mentioned in the file: GNU GPL v3 applies.**

![GPLv3 - Free as in Freedom](http://upload.wikimedia.org/wikipedia/commons/thumb/9/93/GPLv3_Logo.svg/200px-GPLv3_Logo.svg.png)




Git-quote
---------

A fun side-project, when I was learning Git. Uses `fortune` and `git` to append a random quote to git log message.

### Howto

* clone the repository
* `sudo apt-get install fortune` if you don't have it already
* put prQ file where fortune was installed (/usr/share/games/fortune ?)

#### If you want your own fortune file
[Ubuntu Forum](http://ubuntuforums.org/showthread.php?t=1343692) (specifically Qrwe) provides. In case link doesn't work:
* create a text file with `%` as separator lines between fortunes
  * separator lines means just one `%` occupies one whole line between entries
* move the file to fortune directory
* `strfile -c % yourFortuneFile yourFortuneFile.dat`

Remarks:
* fortune operates on dat file, not on text file. You edit a text and strfile it again if you want your change to be seen while using fortune
* strfile converts text into structural file, with header and offsets - allows randomization of quotes
* moving to fortune dir allows fortune to use it simply, with no path to fortune file given, just `fortune yourFortuneFile`, no `fortune your/path/to/yourFortuneFile`

Again - credits for this README section go to Qrwe from Ubuntu Forums.
### Adding your own quotes
Is quite simple, there's script for that. Just run it and it will ask you for quote text and it's author, append them to `prQ` file in proper format and later convert the file into `DAT` format and put it where `fortune` is usually installed.

For different place, modify `$FORTUNE_PATH` in the script.
For now bulk addition is not supported as I never needed it.
