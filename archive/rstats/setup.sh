
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -h ~/.Rprofile ]
then
  ln -s $DIR/Rprofile ~/.Rprofile
fi

if [ ! -h ~/.renv ]
then
  ln -s $DIR/renv ~/.renv
fi

HAS_KEY=$(sudo apt-key list | grep -c 'Michael Rutter <marutter@gmail.com>')

if [ "$HAS_KEY" == "0" ]
then
  gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
  gpg -a --export E084DAB9 | sudo apt-key add -
fi

HAS_SOURCE=$(grep -c cran.ma.imperial.ac.uk /etc/apt/sources.list)

if [ "$HAS_SOURCE" == "0" ]
then
  echo "deb http://cran.ma.imperial.ac.uk/bin/linux/ubuntu precise/" | sudo tee -a /etc/apt/sources.list
  sudo apt-get update
fi

sudo apt-get install -y r-base r-base-dev
sudo apt-get install -y libcurl4-gnutls-dev

mkdir -p ~/rstats/packages

R -f $DIR/r_packages.R

HAS_RSTUDIO=$(dpkg --get-selections | grep -cP 'rstudio\s*install')

if [ "$HAS_RSTUDIO" == "0" ]
then
  #sudo apt-get -y install gdebi-core libapparmor1 # apparmor1 Required only for Ubuntu, not Debian
  wget -P ~/tmp http://download1.rstudio.org/rstudio-0.98.501-amd64.deb
  sudo gdebi ~/tmp/rstudio-0.98.501-amd64.deb
  #sudo rstudio-server verify-installation
fi

