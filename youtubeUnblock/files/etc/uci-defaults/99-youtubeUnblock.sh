#!/bin/sh
[[ ! "$(uci -q get youtubeUnblock.youtubeUnblock)" == "" ]] && exit 0
touch /etc/config/youtubeUnblock
uci batch << EOI
set youtubeUnblock.youtubeUnblock='youtubeUnblock'
set youtubeUnblock.youtubeUnblock.frag='tcp'
set youtubeUnblock.youtubeUnblock.frag_sni_reverse='1'
set youtubeUnblock.youtubeUnblock.frag_middle_sni='1'
set youtubeUnblock.youtubeUnblock.frag_sni_pos='1'
set youtubeUnblock.youtubeUnblock.fk_winsize='0'
set youtubeUnblock.youtubeUnblock.seg2delay='0'
set youtubeUnblock.youtubeUnblock.packet_mark='32768'
set youtubeUnblock.youtubeUnblock.fake_sni='1'
set youtubeUnblock.youtubeUnblock.faking_strategy='pastseq'
set youtubeUnblock.youtubeUnblock.fake_sni_seq_len='1'
add_list youtubeUnblock.youtubeUnblock.sni_domains='googlevideo.com'
add_list youtubeUnblock.youtubeUnblock.sni_domains='ggpht.com'
add_list youtubeUnblock.youtubeUnblock.sni_domains='ytimg.com'
add_list youtubeUnblock.youtubeUnblock.sni_domains='youtube.com'
add_list youtubeUnblock.youtubeUnblock.sni_domains='play.google.com'
add_list youtubeUnblock.youtubeUnblock.sni_domains='youtu.be'
add_list youtubeUnblock.youtubeUnblock.sni_domains='googleapis.com'
add_list youtubeUnblock.youtubeUnblock.sni_domains='googleusercontent.com'
add_list youtubeUnblock.youtubeUnblock.sni_domains='gstatic.com'
add_list youtubeUnblock.youtubeUnblock.sni_domains='l.google.com'
EOI
uci commit
/etc/init.d/firewall restart &>/dev/null
exit 0
