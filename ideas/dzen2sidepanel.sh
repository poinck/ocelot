# XXX   dont do this at home
# (echo " ^fg(#ffffff)blubb" ; echo " joa" ; . gits/ocelot/bin/ocelotbar ; echo "$obar" ; sleep 10) | dzen2 -l 36 -h 21 -ta l -w 75 -fn "monospace:size=9" -e 'onstart=uncollapse'

# (echo " ^fg(#ffffff)$(date '+%a %H:%M')" ; echo "^pa(;-2) $(date '+%d. %b')" ; echo "^fg(#e0a1ff)^r(75x30)^fg(#75507B)^ib(1)^pa(4)^r(67x22)^pa(8)^fg(#ffffff)GLSA !!!" ; . gits/ocelot/bin/ocelotbar ; echo "$obar" ; sleep 100) | dzen2 -l 25 -h 30 -ta l -w 75 -fn "monospace:bold:size=9" -e 'onstart=uncollapse'

(
    echo "^pa(0;4) ^fg(#ffffff)$(date '+%a,') ^fg()$(date '+W%-W')"
    echo " ^fg(#ffffff)$(date '+%-H:%M')"
    echo "^pa(0;4) $(date '+%-d. %b')"
    echo "^pa(;10)^fg(#e0a1ff)^r(75x8)^fg(#75507B)^ib(1)^pa(4;14)^r(67x4)"
    echo "^fg(#e0a1ff)^r(75x16)^fg(#75507B)^ib(1)^pa(4)^r(67x16)^pa(8;2)^fg(#ffffff)GLSA: 4"
    echo "^fg(#e0a1ff)^r(75x16)^fg(#75507B)^ib(1)^pa(4)^r(67x16)^pa(8;2)^fg(#ffffff)affected"
    echo "^pa(;0)^fg(#e0a1ff)^r(75x8)^fg(#75507B)^ib(1)^pa(4;0)^r(67x4)"
    echo " 1··"
    echo " 2···"
    echo " 3···"
    echo " ^fg(#ffffff)4···"
    echo " 5··"
    echo " 6···"
    echo " 7··"
    echo " 10··"
    echo " 19···"
    echo " 20·"
    sleep 42
) | dzen2 -l 48 -h 16 -ta l -w 75 -fn "monospace:bold:size=9" -e 'onstart=uncollapse' -bg "#0f0f0f"

