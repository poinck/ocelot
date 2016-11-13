#---------------------------------------------
# Archive(s) extraction functions
#---------------------------------------------


#--------------------------------------------------
# Extract single/multiple archives
# Lazy people: extract *
#--------------------------------------------------
extract() {
  for xXx in "$@"
  do
    if [[ -f $xXx ]]
    then
      # --bzip2, --gzip, --xz, --lzma, --lzop
      # are 'long' `tar' options standing for:
      # extract the archive and filter it
      # through program --xxx
      case $xXx in
         *.tar.bz2) __fucktard $xXx  --bzip2          ;;
         *.bz2)     __fucktard $xXx  bz2-orig         ;;
         *.t[zb]?*) __fucktard $xXx  --bzip2          ;;
         *.tar.gz)  __fucktard $xXx  --gzip           ;;
         *.gz)      __fucktard $xXx  gz-orig          ;;
         *.t[ag]z)  __fucktard $xXx  --gzip           ;;
         *.tz)      __fucktard $xXx  --gzip           ;;
         *.tar.xz)  __fucktard $xXx  --xz             ;;
         *.xz)      __fucktard $xXx  xz-orig          ;;
         *.txz)     __fucktard $xXx  --xz             ;;
         *.tpxz)    __fucktard $xXx  --xz             ;;
         *.lzma)    __fucktard $xXx  --lzma           ;;
         *.tlz)     __fucktard $xXx  --lzma           ;;
         *.tar)     __fucktard $xXx  tar-orig         ;;
         *.rar)     __fucktard $xXx  rar-orig         ;;
         *.zip)     __fucktard $xXx  zip-orig         ;;
         *.xpi)     __fucktard $xXx  zip-orig         ;;
         *.lz4)     __fucktard $xXx  lz4-orig         ;;
         *.lrz)     __fucktard $xXx  lrz-orig         ;;
         *.tar.lzo) __fucktard $xXx  --lzop           ;;
         *.lzo)     __fucktard $xXx  lzo-orig         ;;
         *.Z)       uncompress $xXx                   ;;
         *.7z)      __fucktard $xXx  seven_zip        ;;
         *.exe)     cabextract $xXx                   ;;
         *)                                           ;;
      esac
    fi
  done
  unset xXx
;}
