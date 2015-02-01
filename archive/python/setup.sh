sudo apt-get install -y python-dev
sudo apt-get install -y python-pip
sudo pip install --upgrade pip
sudo pip install --upgrade setuptools
sudo pip install --upgrade virtualenv
sudo pip install --upgrade virtualenvwrapper
sudo pip install --upgrade ipython

sudo pip install --upgrade pep8
sudo pip install --upgrade pyflakes
sudo pip install --upgrade pylint

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Link to the python init script
if [ ! -h ~/.pythonrc ]
then
  ln -s $DIR/pythonrc ~/.pythonrc
fi

# Link to the python environment script
if [ ! -h ~/.pythonenv ]
then
  ln -s $DIR/pythonenv ~/.pythonenv
fi

# setup virtualenv
mkdir -p ~/.virtualenvs
export WORKON_HOME=$HOME/.virtualenvs
if [ -f /usr/local/bin/virtualenvwrapper.sh ]
then
  source /usr/local/bin/virtualenvwrapper.sh
fi

mkdir -p ~/git/mathyourlife
if [ -d ~/git/mathyourlife/notebooks ]
then
  cd ~/git/mathyourlife/notebooks && git pull origin master && cd -
else
  git clone git@github.com:MathYourLife/notebooks.git ~/git/mathyourlife/notebooks
fi

if [ ! -h ~/bin/ipython ]
then
  ln -s $DIR/bin/ipython ~/bin/ipython
fi
if [ ! -h ~/bin/nbstripout ]
then
  ln -s $DIR/bin/nbstripout ~/bin/nbstripout
fi


if [ ! -f /usr/local/bin/pygtk-codegen-2.0 ]
then
  wget -O - "http://pypi.python.org/packages/source/P/PyGTK/pygtk-2.24.0.tar.bz2" | tar xjf - -C ~/tmp
  cd ~/tmp/pygtk-2.24.0
  ./configure
  make
  sudo make install
  cd ~
  rm -rf ~/tmp/pygtk-2.24.0
fi

HAS_KEY=$(sudo apt-key list | grep -c 'fkrull-deadsnakes')

if [ "$HAS_KEY" == "0" ]
then
  sudo add-apt-repository ppa:fkrull/deadsnakes
  sudo apt-get update
  sudo apt-get install -y python2.6 python2.6-dev
fi


