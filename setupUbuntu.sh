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

# Spotify key
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
echo deb http://repository.spotify.com stable non-free | tee /etc/apt/sources.list.d/spotify.list

# Teamspeak repository
add-apt-repository ppa:materieller/teamspeak3
apt update


# Basic programs 

echo Installing basic programs

apt install vim vlc spotify-client teamspeak3-client steam -y
mkdir ~/.vim/backup
mkdir ~/.vim/swp
mkdir ~/.vim/undo

wget https://discordapp.com/api/download?platform=linux&format=deb -o discord.deb
dpkg -i discord.deb
wget https://updates.getmailspring.com/download?platform=linuxDeb -o mailspring.deb
dpkg -i mailspring.deb

# i3-gaps
echo Installing i3-gaps
apt install i3 libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 libxcb-xrm-dev automake -y

# polybar
echo Installing polybar
apt install cmake cmake-data pkg-config libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python-xcbgen xcb-proto libxcb-image0-dev libxcb-wemh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libpulse-dev i3-wm libjsoncpp-dev libnl-gen1-3-dev -y

git clone --recursive https://github.com/jaagr/polybar
mkdir polybar/build
cd polybar/build
cmake -DCMAKE_C_COMPILER="clang" -DCMAKE_CXX_COMPILER="clang++"..
make install
cd ../..

# Rofi
echo Installing Rofi
apt install rofi -y

# zsh
echo Installing zsh
apt install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# compton
echo Installing Compton
apt install compton -y

# base16
echo Installing base16
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

~/.config/base16-shell/scripts/base16-material-palenight.sh

# i3lock-fancy
echo Installing i3lock-fancy
git clone https://github.com/meskarune/i3lock-fancy.git

cd i3lock-fancy
make install
cd ..


# install configs and scripts
echo Installing configs and scripts
cd $dir
cp -r configs/ ~/.config/
cp -r scripts/ /usr/bin/
cp -r rcs/ ~/
cp -r Wallpaper/ ~/Pictures/
cp -r themes/thraix.zsh-theme ~/.oh-my-zsh/themes/
