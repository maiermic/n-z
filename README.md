# n-z
[ncurses][ncurses] based text user interface for [z][z] to jump to directories - the combined power of [z][z] and [zsh-navigation-tools][zsh-navigation-tools].

## Motivation
If you like to know to which directory you would change with [z][z] you would have to first call
```
$ z -l foo
/first/path/foofoo
/second/path/foobar
```

If you like to change directory to the first match `/first/path/foofoo` you run the same command without `-l` option, i.e. you type `z foo`.
If the first matching directory is not the directory you'd like to change to (e.g. `/second/path/foobar`) you call a similar command like `z -l foobar` or `z foobar`.

If you use ` n-z` you just call `n-z foo` and select one of the matching directories from the ncurses list.

## Setup/Install
Copy *n-z.zsh* to *~/.oh-my-zsh/custom*

**Note:** The [zsh-navigation-tools][zsh-navigation-tools] are required. Install them first.

## Usage
Similar options as for [z][z] are supported.

### Options
* `-c`     restrict matches to subdirectories of the current directory
* `-r`     match by rank only
* `-t`     match by recent access only

[ncurses]: https://en.wikipedia.org/wiki/Ncurses
[z]: https://github.com/rupa/z
[zsh-navigation-tools]: https://github.com/psprint/zsh-navigation-tools