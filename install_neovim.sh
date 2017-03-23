command -v nvim > /dev/null || {
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt update
    sudo apt install neovim
}

NVIM_CFG_DIR=$HOME/.config/nvim
mkdir -p $NVIM_CFG_DIR
ln -s $PWD/conf/init.vim $NVIM_CFG_DIR

pip3 install neovim --user

BUNDLE_DIR=$NVIM_CFG_DIR/bundle
mkdir $BUNDLE_DIR
cd $BUNDLE_DIR
git clone git@github.com:VundleVim/Vundle.vim.git
nvim -c VundleUpdate -c quitall
cd $BUNDLE_DIR/YouCompleteMe
python3 ./install.py --clang-completer
