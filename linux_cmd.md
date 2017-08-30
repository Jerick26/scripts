* [Terminal color and format](#set-Linux-Terminal-command-color-and-format)
* [ack](#ack)
* [grep](#grep)
* [find files according to time](#find-files-according-to-time)
* [convert time stamp to date and inverse](#convert-time-stamp-to-date-and-inverse)
* [cscope and ctags](#cscope-and-ctags)


## set Linux Terminal command color and format
edit ~/.bashrc<br/>
PS1='\[\033[1;32;1m\]\u:\W \t$\[\033[1;37;1m\] '<br/>

## ack
`ack image_tag --ignore-file=ext:out --ignore-dir=build64_debug`<br>
`ack image_tag --ignore-file='match:/tags|cscope.*/' --ignore-dir=build64_release`<br>

## grep
`grep -C 3 "match_pattern" file_name --color=auto`<br>

## find files according to time
`find . -type f -atime +7`<br>
`find . -type f -amin -10`<br>

## convert time stamp to date and inverse
`date +%s`<br>
`date -d '2017-1-4 17:08' +%s`<br>
`date -d @1483520880`<br>
`date -d @1483520880 +"%Y-%m-%d %H:%M:%S"`<br>

## cscope and ctags
`find . -regex ".*\.\(h\|cpp\|cc\)" > cscope.files`<br>
`find -E . -regex '.*(h|hpp|cpp|cc)$' > cscope.files` (in BSD)<br>
`cscope -bkq -i cscope.files`<br>
`ctags -L cscope.files`<br>
usage for ctag<br>
:tag {ident}    "jump to ident tag<br>
:tags    "show tag stack<br>
:ts    "show all tags found<br>
:tp    "show previous tag<br>
:tn    "show next tags<br>
shortcut<br>
Ctrl+t    "return the last place<br>
Ctrl+]    "jump to the tag place<br>


