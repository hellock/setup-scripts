sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim

if [ -d $HOME/.config ]; then
    mkdir $HOME/.config
fi
NVIM_CFG_DIR=$HOME/.config/nvim
BUNDLE_DIR=$NVIM_CFG_DIR/bundle
mkdir $NVIM_CFG_DIR
ln -s init.vim $NVIM_CFG_DIR
mkdir $BUNDLE_DIR
cd $BUNDLE_DIR
git clone git@github.com:VundleVim/Vundle.vim.git
nvim -c VundleUpdate -c quitall
cd $BUNDLE_DIR/YouCompleteMe
python3 ./install.py --clang-completer