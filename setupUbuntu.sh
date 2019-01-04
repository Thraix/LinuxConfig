#/bin/bash

dir=$PWD
cd ~
mkdir GitRepos
cd GitRepos

# Basic programs 

echo Installing basic programs

cat packages.txt | xargs sudo apt install -y

mkdir ~/.vim
mkdir ~/.vim/backup
mkdir ~/.vim/swp
mkdir ~/.vim/undo
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# i3-gaps
echo Installing i3-gaps
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
git clone --recursive https://github.com/jaagr/polybar
mkdir polybar/build
cd polybar/build
cmake -DCMAKE_C_COMPILER="clang" -DCMAKE_CXX_COMPILER="clang++" ..
sudo make install
cd ../..

# zsh
echo Installing zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s $(which zsh)

# base16
echo Installing base16
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

sh ~/.config/base16-shell/scripts/base16-material-eighties.sh

# i3lock-fancy
echo Installing i3lock-fancy
git clone https://github.com/meskarune/i3lock-fancy.git

cd i3lock-fancy
sudo make install
cd ..

echo Installing Termite
git clone --recursive https://github.com/thestinger/termite.git
git clone https://github.com/thestinger/vte-ng.git

cd vte-ng && ./autogen.sh && make && sudo make install
cd ../termite && make && sudo make install
sudo ldconfig
sudo mkdir -p /lib/terminfo/x; sudo ln -s \
/usr/local/share/terminfo/x/xterm-termite \
/lib/terminfo/x/xterm-termite

sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/termite 60
cd ..

git clone git@github.com:chriskempson/base16-xresources.git
cat base16-xresources/xresources/base16-eighties.Xresources >> ~/.Xresources
xrdb -load ~/.Xresources

# install configs and scripts
echo Installing configs and scripts
cd $dir
mkdir ~/.oh-my-zsh
mkdir ~/.oh-my-zsh/themes
cp -r configs/* ~/.config/
sudo cp -r scripts/* /usr/bin/
cp -r rcs/.*rc ~/
cp -r Wallpaper/* ~/Pictures/
cp -r themes/thraix.zsh-theme ~/.oh-my-zsh/themes/
