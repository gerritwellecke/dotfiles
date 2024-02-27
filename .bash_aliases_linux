do_update_function () {
    sudo bash -c "
    apt update; echo
    apt list --upgradable; echo
    apt upgrade; echo
    if [[ -f /var/run/reboot-required ]]; then
        echo -e \"\e[1;31mReboot required\e[0m\"
    fi
    "
}

alias update=do_update_function

# some ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# git
alias gss='git status'
alias gl='git log'
alias glo='git log --oneline --graph'
alias gloa='git log --oneline --graph --all'
alias gb='git branch'
alias gba='git branch --all'
alias gd='git difftool'
alias gdh='git difftool HEAD~'
alias gch='git checkout'

# easy python
alias va='source .venv/bin/activate'

# programms
alias r='ranger'

# directories
alias thesis='/home/gerrit/Documents/Master_Physics/MSc_Thesis/'
alias uni='/home/gerrit/Documents/Master_Physics/'
alias phd='/home/gerrit/Documents/PhD/'
alias math='/home/gerrit/Documents/Master_Physics/math/'
alias books='/home/gerrit/Documents/Master_Physics/textbooks/'
alias hiwi='/home/gerrit/Documents/Master_Physics/2022SoSe/Theory_II/'
alias papers='/home/gerrit/Documents/Master_Physics/Papers/'

alias church='/home/gerrit/Documents/Church'
alias eqp='/home/gerrit/Documents/Church/EQP'
alias electronics='/home/gerrit/Documents/Electronics'

# screen setup
# TODO make this pretty by using a smart shell script
alias scrhdmi='xrandr --output HDMI-A-0 --auto --above eDP'
alias scrbeamer='xrandr --output HDMI-A-0 --auto --same-as eDP'
alias scrmpi='xrandr --output DisplayPort-0 --auto --above eDP --output eDP --scale 2x2'
alias scrhdmioff='xrandr --output HDMI-A-0 --off'
alias scrmpioff='xrandr --output DisplayPort-0 --off'

# headphones
alias HT30='bluetoothctl connect 31:53:c1:e4:b5:88'
alias HT30off='bluetoothctl disconnect 31:53:c1:e4:b5:88'

# get weather report
alias weather='curl wttr.in'

# MPI specific
alias printmpi='lp -d d1050_ir5250_pcl_s2000_cups'
alias printmpioptions='lpoptions -p d1050_ir5250_pcl_s2000_cups'
