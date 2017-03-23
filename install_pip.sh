wget https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user
python get-pip.py --user --force
rm get-pip.py

mkdir -p $HOME/.config/pip
ln -s $PWD/pip.conf $HOME/.config/pip/

pip3 install setuptools --upgrade --user
pip install setuptools --upgrade --user