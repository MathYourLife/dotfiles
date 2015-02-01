sudo apt-get install -y tor

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

HAS_KEY=$(sudo apt-key list | grep -c 'upubuntu-com-tor64.gpg')

if [ "$HAS_KEY" == "0" ]
then
  sudo add-apt-repository ppa:upubuntu-com/tor64
  sudo sed -i s/saucy/raring/ /etc/apt/sources.list.d/upubuntu-com-tor64-saucy.list
  sudo apt-get update
  sudo apt-get install -y tor-browser
  sudo chown $USER -Rv /usr/bin/tor-browser/Data/Tor
fi
