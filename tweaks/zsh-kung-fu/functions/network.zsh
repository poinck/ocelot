#---------------------------------------------
# Bring the network card up with some
# random IP and MAC addresses assigned on it
#---------------------------------------------


bHz='192.168.10'
inftz='eth0'
netmazk='24'
typeset -gA dT


netup() {
    __gen_rants

    sudo ip link set dev ${inftz} \
        address ${dT[fakemac]}

    __loop_until_ok \
        __gen_rants; \
        sudo ip link set dev ${inftz} \
            address ${dT[fakemac]}

    sudo ip link set dev ${inftz} up
    sudo ip addr add ${dT[addr]}/${netmazk} \
        broadcast ${dT[broadcast]} dev ${inftz}

    sudo ip route add default via ${dT[gateway]}
    sleep 2  # it takes some time to bring the NIC up
    sudo ip -family inet6 addr del \
        `ip a | gawk '/inet6/ {x=$2};END{print x}'` dev ${inftz}

    printf '%s\n' 'You are good to go.'

;}

netdown() {
    sudo ip addr flush dev ${inftz}
    sudo ip route flush dev ${inftz}
    sudo ip link set dev ${inftz} down

    sudo pkill dhcpcd
    sudo pkill dnsmasq
    sudo pkill dnscrypt-proxy
;}


# wifiup() {
#   sudo modprobe -a ath9k_htc
#   sudo wpa_supplicant -Dnl80211,wext -iwlan0 -c/etc/wpa.conf -B
#   sudo dhcpcd wlan0
# ;}

# ===================================================================
# systemd-networkd[907]: Event loop failed: Transport endpoint is not connected
# netctl fails shortly after you bridge or bond
# 2 or more NICs
# https://wiki.archlinux.org/index.php/Network_configuration#Static_IP_address
# 
# Wifi
# sudo emerge -a iw wireless-tools wpa_supplicant
# wpa_passphrase "NETWORK" "PASS"
# sudo nano /etc/wpa.conf
# sudo chmod -v 600 /etc/wpa.conf
# sudo wpa_supplicant -Dnl80211,wext -iwlan0 -c/etc/wpa.conf -B
