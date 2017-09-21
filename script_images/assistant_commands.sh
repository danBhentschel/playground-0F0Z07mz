alias go_away='
source /scripts/color.sh
set +m
killall assistant.sh
set -m
touch /home/techio/.assistant_away
colorecho " ==> Bye! <=="'

alias do_it=''

if [ ! -e /home/techio/.assistant_away ]; then
    /scripts/assistant.sh /scripts/$cmd_list 2>/dev/null &
fi
