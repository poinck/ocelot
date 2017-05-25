#---------------------------------------------
# GPG encryption functions
#---------------------------------------------

# Encrypt single file or crawl the entire directory
# and encrypt everything. To replace the "pub_key" below
# type: gpg --keyid-format long --list-keys your@email.null
# Usage: encrypt 'somethin g'
encrypt() {
python2 -c'pub_key="2274B73C896AE578";
import os,shlex,shutil;from subprocess import check_output;
path_join=os.path.join;temp_list=list();
ff="'$1'";ff=(ff if not ff.endswith(os.sep) else ff[:-1]);enc="encrypted_"+ff;
def gpg(f):  check_output(shlex.split(("gpg --hidden-recipient {0}\
 --encrypt \"{1}\"".format(pub_key,f))));os.remove(f);
if os.path.isfile(ff):  shutil.copy(ff,enc);temp_list.append(enc);
else:
  if os.path.exists(enc):  shutil.rmtree(enc);
  shutil.copytree(ff,enc);
  for root,_,files in os.walk(enc):
    for x in files:
      temp_list.append(path_join(root,x))
print("\n\033[1;95m{0} \033[0;0m-> \033[1;94m{1}\033[0;0m\n".format(ff, enc));
[gpg(x) for x in temp_list]'
}

# The opposite action of 'encrypt'
# Grab a cup of tea and settle in.
decrypt() {
python2 -c'import os,shlex;from subprocess import check_output;
def big_mama():
  path_join=os.path.join;temp_list=list();
  ff="'$1'";ff=(ff if not ff.endswith(os.sep) else ff[:-1]);
  def gpg_decrypt(f):  check_output(shlex.split(("gpg  --quiet\
    \"{0}\"".format(f))));os.remove(f);
  if os.path.isfile(ff):  temp_list.append(ff);
  else:
    for root,_,files in os.walk(ff):
      for x in files:
        temp_list.append(path_join(root,x))
  [gpg_decrypt(x) for x in temp_list]
try:
  big_mama()
except Exception:
  raise SystemExit("\033[1;41m Are you trying to decrypt\
 something thats not encrypted ?\033[0;0m")'
}


__printf() { printf '%s\n' "$@" ;}

__skilcrypt_rmcmd() {
    _switch_opt="$1"
    shift

    find "$@" -type f ${_switch_opt} -name "*.gpg" -print0 | xargs -0 rm --force

    __printf 'Done !'
}

__skilcrypt_invoke_gpg() {
    _da_action=$1
    shift

    [[ $1 == "pwf" ]] && {
        shift

        _da_pazZz=$1
        [[ ! -f ${_da_pazZz} ]] && {
            __printf "Ooops, ${_da_pazZz} doesnt exist."
            __printf 'Point the correct location of your password.'
            return
        }

        _pw_switch='--passphrase-file'
        shift

    } || {
        while [[ -z ${_da_pazZz} ]]
        do
            __printf "Enter your password to ${_da_action} your files."
            __printf 'Make sure that you remember your password !'
            read -s -r _da_pazZz
        done

        _pw_switch='--passphrase'
    }

    __printf 'Working... please wait'

    [[ ${_da_action} == "encrypt" ]] && {
        find "$@" -type f ! -name "*.gpg" -print0 | xargs -0 -I{} \
            gpg --batch --quiet ${_pw_switch} ${_da_pazZz} \
            --cert-digest-algo SHA512 --cipher-algo AES256 \
            --digest-algo SHA512 --s2k-cipher-algo AES256 --s2k-digest-algo SHA512 \
            --s2k-mode 3 --s2k-count 64981052 --compress-algo 0 --symmetric {}
    } || {
        find "$@" -type f -name "*.gpg" -print0 | xargs -0 -I{} \
            gpg --batch --quiet ${_pw_switch} ${_da_pazZz} {}
    }

    __printf 'Done !'

    unset _da_pazZz
}

skilcrypt() {
    declare -a _targets
    _targets=('encrypt' 'decrypt' 'rmsrc' 'rmgpg')
    [[ -z $1 ]] || [[ ! " ${_targets[@]} " =~ " $1 " ]] && {
        __printf 'skilcrypt [option] target(s)'
        __printf 'Available options: encrypt [pwf], decrypt [pwf], rmsrc, rmgpg'
        __printf ''
        __printf 'Non-interactive (password stored in file) encryption/decryption:'
        __printf 'skilcrypt encrypt/decrypt pwf /tmp/password file1 file2 folder3'
        __printf ''
        __printf 'Interactive (ask for password) encryption/decryption:'
        __printf 'skilcrypt encrypt/decrypt file1 file2 folder3'
        __printf ''
        __printf 'Think before you invoke the rmsrc and rmgpg options !'
        __printf 'rmsrc  --  remove the source files and leave only the encrypted one'
        __printf 'rmgpg  --  remove the encrypted files and leave only the source one'
        return
    }

    [[ -z $2 ]] && {
        __printf 'The target(s) cannot be empty.'
        return
    }

    [[ $2 == "pwf" ]] && {
        [[ -z $3 ]] || [[ ! -f $3 ]] && {
            __printf 'Point the correct location of your password.'
            return
        }

        [[ -z $4 ]] && {
            __printf "What are we going to $1 ?"
            return
        }
    }

    _sw_opt=$1
    shift

    case ${_sw_opt} in
        encrypt)     __skilcrypt_invoke_gpg   'encrypt'   "$@"      ;;
        decrypt)     __skilcrypt_invoke_gpg   'decrypt'   "$@"      ;;
        rmsrc)       __skilcrypt_rmcmd        '!'         "$@"      ;;
        rmgpg)       __skilcrypt_rmcmd        ''          "$@"      ;;
    esac

}

