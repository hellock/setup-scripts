PARROTS_HOME=${PARROTS_HOME:-$HOME/projects/parrots}

mkdir -p $PARROTS_HOME
cd $PARROTS_HOME

if [ ! -d "$PARROTS_HOME/parrots.man" ]; then
    git clone git@github.com:ParrotsDL/parrots.man.git
    export PARROTS_HOME=$PARROTS_HOME
    echo "export PARROTS_HOME=$PARROTS_HOME" >> $HOME/.profile
    echo "export GTEST_ROOT=\$PARROTS_HOME/gtest" >> $HOME/.profile
fi

cd $PARROTS_HOME/parrots.man
pip install -r requirements.txt --user --upgrade
bash parrots-deps.sh 
./paman update
PARROTS_HOME=$PARROTS_HOME GTEST_ROOT=$PARROTS_HOME/gtest ./paman build
PARROTS_HOME=$PARROTS_HOME GTEST_ROOT=$PARROTS_HOME/gtest \
LD_LIBRARY_PATH=$PARROTS_HOME/parrots/build:$PARROTS_HOME/PPL2/lib:$LD_LIBRARY_PATH ./paman test

echo "export PATH=\$PARROTS_HOME/parrots/tools:\$PATH" >> $HOME/.profile
echo "export LD_LIBRARY_PATH=\$PARROTS_HOME/parrots/build:\$PARROTS_HOME/PPL2/lib:\$LD_LIBRARY_PATH" >> $HOME/.profile
echo "Installation done, please run `source ~/.profile` or restart the terminal."