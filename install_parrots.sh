#!/bin/bash
PARROTS_HOME=${PARROTS_HOME:-$HOME/projects/parrots}
echo "PARROTS_HOME is set as $PARROTS_HOME"

mkdir -p $PARROTS_HOME
cd $PARROTS_HOME

if [ ! -d "$PARROTS_HOME/parrots.man" ]; then
    git clone git@github.com:ParrotsDL/parrots.man.git
    cd parrots.man
    PARROTS_HOME=$PARROTS_HOME ./parrots-deps.sh
    echo -e "\nexport PARROTS_HOME=$PARROTS_HOME" >> $HOME/.profile
    echo "source \$PARROTS_HOME/parrots/scripts/env.sh" >> $HOME/.profile
else
    cd parrots.man
    git pull origin master
fi

pip install -r requirements.txt --user --upgrade
bash parrots-deps.sh
PARROTS_HOME=$PARROTS_HOME ./paman update
PARROTS_HOME=$PARROTS_HOME GTEST_ROOT=$PARROTS_HOME/gtest ./paman build
PARROTS_HOME=$PARROTS_HOME GTEST_ROOT=$PARROTS_HOME/gtest \
LD_LIBRARY_PATH=$PARROTS_HOME/parrots/build:$PARROTS_HOME/PPL2/lib:$LD_LIBRARY_PATH ./paman test

if [ ! -f $HOME/.parrots/env.yaml ]; then
	$PARROTS_HOME/parrots/tools/parrots env init
fi

echo "Installation done, please run \"source ~/.profile\" or restart the terminal 
      if this is the first time to install parrots."
