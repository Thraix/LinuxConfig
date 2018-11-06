#/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

set -e
dir = $PWD
cd ~
mkdir GitRepos
cd GitRepos

# Basic programs 
apt install vim vlc -y
mkdir ~/.vim/backup
mkdir ~/.vim/swp
mkdir ~/.vim/undo

# i3-gaps
apt install i3 libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 libxcb-xrm-dev automake -y

# polybar
apt install cmake cmake-data pkg-config libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python-xcbgen xcb-proto libxcb-image0-dev libxcb-wemh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libpulse-dev i3-wm libjsoncpp-dev libnl-gen1-3-dev -y

git clone --recursive https://github.com/jaagr/polybar
mkdir polybar/build
cd polybar/build
cmake -DCMAKE_C_COMPILER="clang" -DCMAKE_CXX_COMPILER="clang++"..
make install
cd ../..

# Rofi
apt install rofi -y

# zsh
apt install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# compton
apt install compton -y

# base16
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

~/.config/base16-shell/scripts/base16-material-palenight.sh

# i3lock-fancy
git clone https://github.com/meskarune/i3lock-fancy.git

cd i3lock-fancy
sudo make install
cd ..


# install configs and scripts
cd $dir
cp -rf configs/ ~/.config/
cp -rf scripts/ /usr/bin/
cp -rf rcs/ ~/
cp -rf Wallpaper/ ~/Pictures/
cp -rf themes/thraix.zsh-theme ~/.oh-my-zsh/themes/
