#---------------------------------------------
# backup functions ($HOME and '/etc' folders)
#---------------------------------------------


# do not touch those variables
docsz="$HOME/Documents"
real_homez="${docsz%/*}"
dirz="${docsz}/openbox"
homez="${dirz}${real_homez}"
dotfz="${docsz}/dotfiles"
dotdz="${dotfz}/gentoo"
dothomez="${dotdz}${real_homez}"
archnamez='openbox'
archivez="${docsz}/${archnamez}.tar"
ob_etc="${dirz}/etc"
dot_etc="${dotdz}/etc"
installed_packs="${homez}/OPEN_ME/installed_packages.txt"

# The primary backup function
dot() {
    local allusepacks='/etc/portage/package.use/allpacks'

    qlist --installed > "${installed_packs}"
    sort -u "${installed_packs}" -o "${installed_packs}"

    cp -r '/etc/portage/make.conf' "${ob_etc}/portage"
    cp -r "${allusepacks}" "${ob_etc}/portage/package.use"
    sort -u "${allusepacks}" -o "${ob_etc}/portage/package.use/allpacks"

    cd "${docsz}"
    tar --exclude='.git' --create --file "${archivez}" "${archnamez}"
    gzip --force -9 "${archivez}"
    cp --recursive "${archivez}.gz" "${docsz}/mega-drive"
;}


# The dofiles repo folder
# dot() {
#     ob
#     set -A excludeF
#     excludeF=(
#       'not_included' '.git'
#       'histfile' 'offsite'
#       'hist.gz' 'accels.scm'
#     )
#     rsync --archive --recursive --delete \
#       --exclude-from=<(printf '%s\n' "${excludeF[@]}") \
#         "${dirz}"/{boot,home,usr,etc} "${dotdz}"
# ;}
