export QT_QPA_PLATFORMTHEME="qt5ct"
export EDITOR=/usr/bin/vim
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
# fix "xdg-open fork-bomb" export your preferred browser from here
export BROWSER=/usr/bin/firefox

for i in /sys/class/hwmon/hwmon*/temp*_input; do
    if [ "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*}))" = "coretemp: Core 0" ]; then
        export HWMON_PATH="$i"
    fi
done

export LANG=en_US.UTF-8
export LC_ADDRESS=en_US.UTF-8
export LC_IDENTIFICATION=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_NAME=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TELEPHONE=en_US.UTF-8
export LC_TIME=en_GB.UTF-8
export LC_PAPER=en_GB.UTF-8
export LC_MEASUREMENT=en_GB.UTF-8

export URXVT_PERL_LIB=$HOME/.config/urxvt/ext/
