#!/bin/bash
#
# source this file for elements; currently provides functions for
# - colors
# - dirs?
#
#    ^   ^
#  +-------+
#  |  o_O  |
#  |  >.<  |__/
#  +-------+
#
# ocelot by André Klausnitzer, CC0

#cfont="cbdbfc"
#cdarkfont="9badb7"
cfont="aaaaaa"
cdarkfont="777777"
cdarkgrey="1c1c1c"
cdarkblue="3f3f74"
cblue="6767a1"
cdarkpurple="45283c"
cyellow="fbf236"
cdarkyellow="4b692f"
#ccbdbfc

# get color between start and end color
# - without leading '#'
get_hex_color() {
    start_color=$1  # 0%
    end_color=$2    # 100%
    percent=$3

    sc_r=${start_color:0:2}
    sc_g=${start_color:2:2}
    sc_b=${start_color:4:2}
    ec_r=${end_color:0:2}
    ec_g=${end_color:2:2}
    ec_b=${end_color:4:2}

    # debug
    #echo "sc_r = $sc_r"

    sc_rd=$((16#${sc_r}))
    sc_gd=$((16#${sc_g}))
    sc_bd=$((16#${sc_b}))
    ec_rd=$((16#${ec_r}))
    ec_gd=$((16#${ec_g}))
    ec_bd=$((16#${ec_b}))
    #echo "s = ${sc_rd} ${sc_gd} ${sc_bd}" >> /tmp/newapi
    #echo "e = ${ec_rd} ${ec_gd} ${ec_bd}" >> /tmp/newapi
    #echo "percent = ${percent}" >> /tmp/newapi

    if [[ "$sc_rd" -ge "$ec_rd" ]] ; then
        diff_rd=$(( sc_rd-ec_rd ))
        p_rd=$(( diff_rd*percent/100 ))
        n_rd=$(( sc_rd-p_rd ))
    else
        diff_rd=$(( ec_rd-sc_rd ))
        p_rd=$(( diff_rd*percent/100 ))
        n_rd=$(( sc_rd+p_rd ))
    fi
    #echo "r = ${diff_rd} ${p_rd} ${n_rd}" >> /tmp/newapi
    if [[ "$sc_gd" -ge "$ec_gd" ]] ; then
        diff_gd=$(( sc_gd-ec_gd ))
        p_gd=$(( diff_gd*percent/100 ))
        n_gd=$(( sc_gd-p_gd ))
    else
        diff_gd=$(( ec_gd-sc_gd ))
        p_gd=$(( diff_gd*percent/100 ))
        n_gd=$(( sc_gd+p_gd ))
    fi
    #echo "g = ${diff_gd} ${p_gd} ${n_gd}" >> /tmp/newapi
    if [[ "$sc_bd" -ge "$ec_bd" ]] ; then
        diff_bd=$(( sc_bd-ec_bd ))
        p_bd=$(( diff_bd*percent/100 ))
        n_bd=$(( sc_bd-p_bd ))
    else
        diff_bd=$(( ec_bd-sc_bd ))
        p_bd=$(( diff_bd*percent/100 ))
        n_bd=$(( sc_bd+p_bd ))
    fi
    #echo "b = ${diff_bd} ${p_bd} ${n_bd}" >> /tmp/newapi

    # 242-54=188
    # 18800/83=

    printf -v n_rh '%x' ${n_rd}
    printf -v n_gh '%x' ${n_gd}
    printf -v n_bh '%x\n' ${n_bd}
    lr=${#n_rh}
    if [[ "$lr" -eq 1 ]] ; then
        n_rh="0${n_rh}"
    fi
    lg=${#n_gh}
    if [[ "$lg" -eq 1 ]] ; then
        n_gh="0${n_gh}"
    fi
    lb=${#n_bh}
    if [[ "$lb" -eq 2 ]] ; then
        n_bh="0${n_bh}"
    fi
    #echo "lengths = ${n_rd},${n_rh}($lr) ${n_gd},${n_gh}($lg) ${n_bd},${n_bh}($lb)" >> /tmp/newapi
    percent_color="${n_rh}${n_gh}${n_bh}"
    echo "${percent_color}"
}
