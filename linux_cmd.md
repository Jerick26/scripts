* [Terminal color and format](#set-Linux-Terminal-command-color-and-format)
* [ack](#ack)
* [grep](#grep)
* [find files according to time](#find-files-according-to-time)
* [convert time stamp to date and inverse](#convert-time-stamp-to-date-and-inverse)
* [cscope and ctags](#cscope-and-ctags)


## set Linux Terminal command color and format:
edit ~/.bashrc
PS1='\[\033[1;32;1m\]\u:\W \t$\[\033[1;37;1m\] '

## ack
ack image_tag --ignore-file=ext:out --ignore-dir=build64_debug
ack image_tag --ignore-file='match:/tags|cscope.*/' --ignore-dir=build64_release

## grep
grep -C 3 "match_pattern" file_name --color=auto

## find files according to time
find . -type f -atime +7
find . -type f -amin -10

## convert time stamp to date and inverse
date +%s
date -d '2017-1-4 17:08' +%s
date -d @1483520880
date -d @1483520880 +"%Y-%m-%d %H:%M:%S"

## cscope and ctags
find . -regex ".*\.\(h\|cpp\|cc\)" > cscope.files
find . 
cscope -bkq -i cscope.files
ctags -L cscope.files
usage for ctag
:tag {ident}    "jump to ident tag
:tags    "show tag stack
:ts    "show all tags found
:tp    "show previous tag
:tn    "show next tags
shortcut
Ctrl+t    "return the last place
Ctrl+]    "jump to the tag place
