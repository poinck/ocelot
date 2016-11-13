#---------------------------------------------
# Gentoo functions
#---------------------------------------------

source '/lib/gentoo/functions.sh'

__emerge() { sudo emerge "$@" ;}

# R
C() { __emerge --ask --unmerge "$@" ;}

# Qtdq/Rsnc
orphans() { __emerge --ask --verbose --depclean ;}

rebuild() { __emerge --ask --update --deep --newuse --with-bdeps=y '@world' ;}

# Syu
update() {
    einfo 'Running sync' 
    __emerge --sync

    einfo 'Running emaint' 
    sudo emaint --fix cleanresume

    einfo 'Running portage update' 
    __emerge --oneshot --update portage

    einfo 'Running system update' 
    rebuild

    einfo 'Running metadata regeneration' 
    __emerge --regen --quiet

    sudo cp -r /var/cache/eix/{portage.eix,previous.eix}
    einfo 'Running eix update' 
    sudo eix-update  # eix-diff to see whats new
    eix-diff

    einfo 'Running external kernel modules rebuild' 
    __emerge '@module-rebuild'

    einfo 'Running preserved libs rebuild'
    preserved-rebuild

    einfo 'Running Reverse Dep. Rebuilder'
    revdep
;}

preserved-rebuild() { __emerge '@preserved-rebuild' ;}

revdep() { sudo revdep-rebuild ;}

# Qo
belongs() { equery belongs $(which "$@") ;}

depends() { equery depends "$@" }

# Ql
list() { equery files "$@" ;}

# Qqs
match() {
    eix -S -I "$@"
    eix "$@"
    qlist --installed "$@"
;}

resume() { __emerge --resume ;}

# manage /etc diff. changes, mostly 'z'
dispatch() { sudo dispatch-conf ;}

# This one is really handy, query the compile time log
compiletime() { qlop --verbose --human --time --gauge "$@" ;}

# Output all packages compiled with given USE flag
hasuse() {
    eix --installed-with-use --format \
        '(purple,1)<category>()/{installed}(yellow,1){}<name>()-<installedversions:IVERSIONS>\n' \
        "$@"
;}


# Add all programs and their USE flags
insertallpackswithuseflags() {
    set -A remove_flags
    local the_packs='/etc/portage/package.use/allpacks'

    qlist --installed --umap --nocolor --verbose | \
      sudo tee "${the_packs}" > /dev/null

    remove_flags=(
      '(' ')'
    # some `sed' regex kung fu
      '\S*\('{abi_,elibc_,kernel_,video_}'\)\S*'
      '\S*\('{input_,linguas_,userland_}'\)\S*'
      '\S*\(cpu_flags\|python_\)\S*'
    )

    # grep --invert-match \
    #   --file=<(printf '%s\n' "${remove_flags[@]}") "${the_packs}"

    for x in "${remove_flags[@]}"
    do
        sudo sed -i "s/${x}//g" "${the_packs}"
    done

    # make sure the rest $ are not empty
    gawk '{
      for (x=2; x <= NF; x++) {
        if ("" != $x) {
          print ">="$0;
          break;
        }
      }
    }' "${the_packs}" \
        | sudo tee "${the_packs}" > /dev/null
;}


# Obtain some safe cpu flags
cpuflags() {
  gcc '-###' -march=native -x c - 2>&1 | \
    gawk -lfilefuncs '{
      gsub(/\"/,"");
      for (x=1; x < NF; x++) {
        if (match($x,/march|cache/)) {
          cflagz[$x]++;
        } else if (match($x,/mpopcnt|m3dnow|msse|mssse|maes/)) {
          x86[substr($x,3)]++;
        } else if (match($x,/mcx16|mabm|mlzcnt|msahf/)) {
          x86[substr($x,2)]++;
        }
      }
    }
    function concatMe(arr) {
      ret="";
      for (x in arr) {
        str=(match(x,/cache/) ? "--param"" "x : x);
        ret=ret" "str;
      }
      return ret;
    }
    END {
      PROCINFO["sorted_in"]="@ind_str_asc";
      cpuf="/proc/cpuinfo";
      if (0 == stat(cpuf, buf)) {
        while (0 != (getline cur_line < cpuf)) {
          if (match(cur_line, "flags")) {
            split(cur_line, arr, " ");
            if (0 != arr_len=length(arr)) {
              for (x=1; x < arr_len; x++) {
                if (match(arr[x],/mmxext|3dnowext/)) {
                  x86[arr[x]]++;
                }
              }
            }
            break;
          }
        }
        close(cpuf);
      }

      if (0 != length(x86)) {
        printf("CPU_FLAGS_X86=\"...%s\"\n",concatMe(x86));
      }

      if (0 != length(cflagz)) {
        printf("CFLAGS=\"...%s\"\n",concatMe(cflagz));
      }
    }'
;}

rest() {
    set -A _t
    _t=(
    'eclean distfiles'
    'euse -i USEFLAG'
    'eix --installed-with-use USEFLAG'
    'gcc-config'
    'q'
    'qatom'
    'qcache'
    'qcheck'
    'qdepends'
    'qfile'
    'qglsa'
    'qgrep'
    'qlist'
    'qlop'
    'qsearch'
    'qsize'
    'quse'
    'eclean'
    'eclean-dist'
    'eclean-pkg'
    'enalyze'
    'eread'
    'euse'
    'eshowkw'
    'glsa-check -l|-p|-f affected'
    'glsa-check --test all'
    'glsa-check --fix all'
)
    printf '%s\n' "${_t[@]}"
;}
