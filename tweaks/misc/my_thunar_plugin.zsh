#!/usr/bin/env zsh
# Providing "right click" action options for thunar.
# You have to copy my ~/.config/Thunar/uca.xml
# The plugin replaces: unzip, zip,
# xarchiver/file-roller/ark,
# thunar-archive-plugin

# supplying the functions
files_to_source=(
    'compress.zsh' 'extract.zsh'
    'not-interactive-funcs.zsh'
)

for x in ${files_to_source[@]}
do
    source "$HOME/.config/zsh/functions/$x"
done
unset x files_to_source

case $1 in
   gzf) shift; compressgz "$@" ;;
  extr) shift; extract "$@"    ;;
     *)                        ;;
esac
