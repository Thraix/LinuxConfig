#/bin/bash

dir=$PWD
cd ~
mkdir GitRepos
cd GitRepos

# Basic programs 

echo Installing basic programs

sudo apt install feh vim vim-gtk vlc steam -y
mkdir ~/.vim
mkdir ~/.vim/backup
mkdir ~/.vim/swp
mkdir ~/.vim/undo
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# i3-gaps
echo Installing i3-gaps
sudo apt install i3 libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 libxcb-xrm-dev automake -y
git clone https://www.github.com/Airblader/i3 i3-gaps

cd i3-gaps
autoreconf --force --install
rm -rf build
mkdir -p build && cd build
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install
cd ../..


# polybar
echo Installing polybar
sudo apt install clang cmake cmake-data pkg-config libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libpulse-dev i3-wm libjsoncpp-dev libnl-genl-3-dev yad xdotool -y

git clone --recursive https://github.com/jaagr/polybar
mkdir polybar/build
cd polybar/build
cmake -DCMAKE_C_COMPILER="clang" -DCMAKE_CXX_COMPILER="clang++" ..
sudo make install
cd ../..

# Rofi
echo Installing Rofi
sudo apt install rofi -y

# zsh
echo Installing zsh
sudo apt install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s $(which zsh)

# compton
echo Installing Compton
sudo apt install compton -y

# base16
echo Installing base16
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

sh ~/.config/base16-shell/scripts/base16-material-palenight.sh

# i3lock-fancy
echo Installing i3lock-fancy
git clone https://github.com/meskarune/i3lock-fancy.git

cd i3lock-fancy
sudo make install
cd ..


# install configs and scripts
echo Installing configs and scripts
cd $dir
mkdir ~/.oh-my-zsh
mkdir ~/.oh-my-zsh/themes
cp -r configs/* ~/.config/
cp -r scripts/* /usr/bin/
cp -r rcs/.*rc ~/
cp -r Wallpaper/* ~/Pictures/
cp -r themes/thraix.zsh-theme ~/.oh-my-zsh/themes/
