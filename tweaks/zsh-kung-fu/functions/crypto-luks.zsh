#---------------------------------------------
# LUKS encryption functions
#---------------------------------------------

# Create or expand LUKS encrypted file system
# within single file that will act as
# Truecrypt-like container.
# I do not wish my $USER to be able to access
# the LUKS encrypted fs. created by the function
# below, instead 'root' access is required for
# every single action. If you want to copy something
# from the encrypted fs. back to your $HOME dir and
# restore the file/folder owner, you can always `chown'
# example: chown user:group -R given_file
# This function will create LUKS encrypted file system (fs.)
# within single file with prefixed file size, you can always
# expand the file size at any time without damaging the encrypted
# data in it.
luks() {
    cd $HOME

    __am_i_null $1 && return 1

    case $1 in
        4200) # DVD disc
                local fname='cryptdvd'
                local device_name='encdvd'
                local SiZe=4200
           ;;
         690) # CD disc
                local fname='cryptcd'
                local device_name='enccd'
                local SiZe=690
           ;;
           *) # Custom size
                local fname='cryptdb'
                local device_name='encdb'
                local SiZe=$1
           ;;
    esac

    local the_mappeR="/dev/mapper/${device_name}"

    # if ${fname} exists, we assume that
    # the user wants to extend/expand it.
    if [[ -f ${fname} ]]
    then
        [[ -e ${the_mappeR} ]] && closecrypt ${device_name}

        dd if=/dev/urandom bs=1MB count=${SiZe} \
            iflag=fullblock | cat - >> ${fname}

        printf '%s\n' "Now we are going to expand ${fname}"
        __opencrypt_mini sudo cryptsetup open --type luks ${fname} ${device_name}
        sudo e2fsck -f ${the_mappeR}
        sudo resize2fs ${the_mappeR}
        sudo cryptsetup close ${device_name}

        return 0
    else
        dd if=/dev/urandom of=${fname} bs=1MB count=${SiZe} \
            iflag=fullblock conv=fsync
    fi

    # spend 50 seconds in iteration before any action
    # to take place, 50000 = 50 seconds. If anyone
    # manages to get your CD/DVD disc, they will
    # have only 1 bruteforce attempt every 50 seconds.
    sudo cryptsetup --verbose --cipher aes-xts-plain64 --key-size 512 \
        --hash sha512 --iter-time 50000 --use-random luksFormat ${fname}

    __loop_until_ok sudo cryptsetup --verbose --cipher aes-xts-plain64 --key-size 512 \
        --hash sha512 --iter-time 50000 --use-random luksFormat ${fname}

    __opencrypt_mini sudo cryptsetup open --type luks ${fname} ${device_name}
    # https://unix.stackexchange.com/questions/14010/the-merits-of-a-partitionless-filesystem/14062#14062
    sudo mkfs.ext4 ${the_mappeR}
    sudo mount -t ext4 ${the_mappeR} '/mnt'

    printf '%s\n' 'Transfer your data in /mnt, once done invoke:'
    printf '%s\n' "closecrypt ${device_name}"

    cat <<EOF > "${fname}-readme.txt"
Access your files back:

sudo cryptsetup open --type luks ${fname} ${device_name}
sudo mount -t ext4 ${the_mappeR} /mnt

sudo umount -R /mnt
sudo cryptsetup close ${device_name}
EOF
    printf '%s\n' "Created ${fname}-readme.txt"
;}


# unlock and mount partition/device
opencrypt() {
    __null_test $2

    __opencrypt_mini sudo cryptsetup open --type luks $1 ${dmnqme}
    sudo mount -t ext4 "/dev/mapper/${dmnqme}" ${_mount_point}

    unset dmnqme _mount_point
;}

# unmount and close the unlocked partition/device
closecrypt() {
    __null_test $1

    sudo umount -R ${_mount_point}
    sudo cryptsetup close ${dmnqme}

    unset dmnqme _mount_point
    clearbuff
;}
