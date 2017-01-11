
2017.1.10
ack
ack image_tag --ignore-file=ext:out --ignore-dir=build64_debug
ack image_tag --ignore-file='match:/tags|cscope.*/' --ignore-dir=build64_release

grep
grep -C 3 "match_pattern" file_name --color=auto

2017.1.5
find files according to time
find . -type f -atime +7
find . -type f -amin -10

2017.1.4
convert linux time stamp to date and inverse
date +%s
date -d '2017-1-4 17:08' +%s
date -d @1483520880
date -d @1483520880 +"%Y-%m-%d %H:%M:%S"

2016.12.28
cscope, ctags
find . -regex ".*\.\(h\|cpp\|cc\)" > cscope.files
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