#-----------------------------------------------------------
# Create meatballs with the highest possible compression.
# The first entry will be used as archive name.
# You can compress multiple directories and files
# that doesn't belong to the current directory.
# Example:
# compresslz4 /var/log /usr/bin /usr/include $HOME/.xinitrc
# Mind that the archive will be created in the
# current working directory, so you need "write" permission.
#
#
# The best of all is that you can easily provide "compress"
# and "extract" action options in your file manager, no-brainer!
# See ~/.config/misc/my_thunar_plugin.zsh
# Right click 'n enjoy :}
#-----------------------------------------------------------

compresstar() { tar --verbose --dereference --create --file\
                 `basename $1`.tar "$@" ;}
compressxz()  { compresstar "$@"
                 xz --verbose --force -9 --extreme `basename $1.tar` ;}
compressgz()  { compresstar "$@"
                 __run_parallel pigz gzip $1 ;}
compressbz()  { compresstar "$@"
                 __run_parallel lbzip2 bzip2 $1 ;}
compresslz()  { compresstar "$@"
                 xz --verbose --force -9 --extreme \
                    --format=lzma `basename $1.tar` ;}
compresslz4() { compresstar "$@"
                 lz4 -vf9 `basename $1.tar`
                 rm `basename $1.tar` ;}
compresslzo() { compresstar "$@"
                 lzop --verbose --force -9 `basename $1.tar`
                 rm `basename $1.tar` ;}
compresslrz() { compresstar "$@"
                 lrzip --verbose --force -f -L 9 `basename $1.tar`
                 rm `basename $1.tar` }
compress7z()  { 7za a -mx=9 `basename $1`.7z "$@" ;}
# zlib is required for ZIP_DEFLATED
# compresszip 'dir1 dir2 dir3 file file1 file2'
# The quotes are mandatory for multiple entries.
compresszip() {
    python2 -c"import os;from zipfile import ZipFile,ZIP_DEFLATED;
ufo_obj='"$1"'.split(' ');the_list=list();path_join=os.path.join;
norm='\033[0m';blue='\033[1;94m';magenta='\033[1;95m';
def zip_filez():
  with ZipFile(os.path.basename(ufo_obj[0])+'.zip','a',ZIP_DEFLATED) as archive:
    [archive.write(x) for x in the_list];
    for x in the_list:
      x=(x if not x.startswith(os.sep) else x.replace(os.sep,str(),1));
      print(' {0}adding{1}: {2}{3}{1}'.format(magenta,norm,blue,x));
for x in ufo_obj:
  if os.path.isdir(x):
    for root,_,files in os.walk(x):
      for z in files:
         the_list.append(path_join(root,z));
  else:  the_list.append(x);
zip_filez();"
;}


# The functions below are used
# to crash and infect my system

tarhome() {
    # directories or files to exclude
    set -A snooP
    snooP=(
        $HOME/{.cache,.local,.gvfs,.dbus}
        "$HOME/.config/wine"
        "$HOME/.thumbnails"
)
    tar --dereference --sparse --one-file-system \
    --exclude-from=<(printf '%s\n' ${snooP[@]}) \
    --create --file "/tmp/home_${USER}_`date +%Y_%m_%d`.tar" \
    $HOME --totals
;}

# Strip the histfile manually and
# leave the information that's
# important to you.
hgz() {
    local hist_f="hist.gz"
    cd "${ZDOTDIR}"
    set -A fileZ
    [[ -f "${hist_f}" ]] && {
        fileZ+="hist"
        gunzip "${hist_f}"
    }
    fileZ+="histfile"
    cat "${fileZ[@]}" | gzip -9 >>! "${hist_f}"
    rm --force "${fileZ[@]}"
;}
