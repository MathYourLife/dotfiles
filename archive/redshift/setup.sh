
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

HAS_KEY=$(sudo apt-key list | grep -c 'jonls-redshift-ppa.gpg')
if [ "$HAS_KEY" == "0" ]
then
  sudo apt-add-repository ppa:jonls/redshift-ppa
  sudo apt-get update
  sudo apt-get install -y redshift
fi

# Link to the git repo version
if [ ! -h ~/.config/redshift.conf ]
then
  ln -s $DIR/redshift.conf ~/.config/redshift.conf
fi

