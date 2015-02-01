sudo apt-get install -y xubuntu-restricted-extras shutter dia recordmydesktop

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


HAS_DVD=$(dpkg --get-selections | grep -cP 'libdvdcss2\s*install')
if [ "$HAS_DVD" == "0" ]
then
  sudo /usr/share/doc/libdvdread4/install-css.sh
fi


