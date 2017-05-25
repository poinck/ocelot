#---------------------------------------------
# Miscellaneous encryption functions
#---------------------------------------------

# Generate new ssh key
sshgen() { ssh-keygen -t rsa -b 4096 -E sha512 -C $USER@$HOST -o -a 5000 ;}

# dns encryption
encdns() {
    set -A _srvs CUR_SERV
    source "${XDG_CONFIG_HOME}/misc/dns_servers/servers5.conf"

    # Don't touch
    _Num=$[RANDOM%${#_srvs[@]}]
    while [[ ${_Num} == 0 ]]; do _Num=$[RANDOM%${#_srvs[@]}]; done
    CUR_SERV=("${(@s/,/)_srvs[_Num]}")

    netdown
    netup
    sudo service dnsmasq restart
	sudo dnscrypt-proxy \
	--provider-key=${CUR_SERV[1]} \
	--provider-name=${CUR_SERV[2]} \
	--resolver-address=${CUR_SERV[3]}:443 \
	--local-address=127.0.0.2:53 \
	--user=nobody --daemonize
;}

# generate random password
ranp() {
    local pass_len=25 gen_pass=10

    tr -dc '[:print:]' < /dev/urandom | \
        fold --width ${pass_len} | \
        gawk '{
            for (x = 1; x < '${gen_pass}'; x++) {
                getline;
                print;
            }
            exit;
        }'
;}
