#---------------------------------------------
# Short and miscellaneous functions
#---------------------------------------------

# From now on I don't have to 'chmod'
cpr() { cp --verbose --preserve=mode --recursive $1 $2 ;}

# Check for process (when in doubt that's still running)
p() { ps -A | grep $1 ;}

# Query history
zhist() { grep -i "$1" "$ZDOTDIR"/histfile ;}

# Grab pid
pids() { ps aux | grep "$1" ;}

# refer to `man ps' for more details
vs() { ps awwlx --sort=vsz ;}

# `man ss' ; ss -untap
untap() { netstat -untap ;}

# Test my firewalls
pwnhost() { sudo nmap -sV -O -PN $1 ;}

# Show the difference between files/folders
compare() { diff -Nwaur $1 $2 ;}

# Reload zsh
rldzsh() { source "$XDG_CONFIG_HOME/zsh/.zshrc" ;}

# Rebuild the font cache (eselect fontconfig enable/disable)
rldfonts() {
    cd ~
    sudo rm -rf /var/cache/fontconfig
    rm -rf ~/.cache/fontconfig
    rm -rf ~/.fontconfig
    fc-cache --force
    cd /
    sudo fc-cache --force
    clearbuff
;}

# Ignore comment lines
nc() { egrep --invert-match "^[ \t]*#|^[ \t]*$" "$@" ;}

# Query the compressed history,
# see `hgz' in "compress_extract.zsh"
xhist() { gunzip --to-stdout "$ZDOTDIR/hist.gz" | grep $1 ;}

# clear the copy and cache buffer (copied passwords for example)
clearbuff() { sudo sysctl --write vm.drop_caches=3 ;}

# Do not reuse any Tor configuration file
remtor() { rm -rf /tmp/{INSTALL,LOG,VERSION} ;}

# `dd' image to external media
# type `info dd' to learn more.
# Usage: ddf /dev/NSA /path/to/iso
ddf() {
    { __am_i_null $1 || __am_i_null $2 } && return 1
    sudo dd if=$2 of=$1 bs=1M conv=fsync
;}

# Recursively `chmod' folders and files
chmodthis() {
    for x in $@
    do
        find $x -type d -print0 | xargs -0 chmod 700 2> /dev/null
        find $x -type f -print0 | xargs -0 chmod 600 2> /dev/null
    done
    unset x
;}

# Search the given dir for images
# and start `sxiv' in thumbnail mode
thumbs() { sxiv -trq ${1:-PWD} ;}

# list all files that have been modified yesterday
# VFS won't be crawled, cool right ?
changes() { sudo find / -xdev -type f -mtime -1 >> /tmp/changes ;}

# See my tor-router configuration
# file to understand those options
torc() {
    set -A _opts
    _opts=(
        'ExcludeNodes {??},{gb},{us},{fr}'
        'AllowSingleHopCircuits 0'
        'ExcludeSingleHopRelays 1'
)
    for x in ${_opts[@]}
    do
        echo "${x}" >> /tmp/INSTALL/Browser/TorBrowser/Data/Tor/torrc-defaults
    done
    exit
;}

# quick `man' page search 'n match
mans() { man -k $1 ;}

# wake up the firewall
fw() { sudo bash "${XDG_CONFIG_HOME}/misc/dns_servers/fw" ;}

cpblog() {
    rm -rf /tmp/blog{,.tar}
    cp -r ~/Documents/blog /tmp
    rm -rf /tmp/blog/{.git,dev/temp,dev/node_modules}
    cd /tmp
    compresstar 'blog'
;}

# clone all of my GitHub repos
clonemyrepos() {
  repos_to_ignore=(
    'python-for-android.git'
    'prism-break.git'
    'bootswatch.git'
    'dotfiles.git'
    'wifiextender.github.io.git'
  )
  mkdir -p --mode=700 "${HOME}/git-repos"
  cd "${HOME}/git-repos"

  wget --quiet --output-document=- \
     'https://api.github.com/users/wifiextender/repos?per_page=500' | \
    gawk '/clone_url/ { gsub("[,\"]",""); print $2; }' | \
    while read x
    do
      [[ ! " ${repos_to_ignore[@]} " =~ " ${x##*/} " ]] && {
        git clone --depth 1 "${x}"
      }
    done
;}
