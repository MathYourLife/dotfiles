
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

FILE=/etc/apt/sources.list.d/google-chrome.list
if [ ! -f $FILE -o "$(grep -c chrome $FILE)" == "0" ]
then
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
  sudo apt-get update
fi

sudo apt-get install -y google-chrome-stable

