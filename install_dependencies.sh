sudo apt update
sudo apt install build-essential zsh git cmake python-dev python3-dev autojump htop wget curl vim unzip

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo "\nsource \$HOME/.profile" >> $HOME/.zshrc
