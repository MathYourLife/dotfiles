sudo apt-get install -y xfce4-goodies

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo apt-get install -y wmctrl  # window management

DEST=~/.config/xfce4/xfconf/xfce-perchannel-xml/
for FILE in `ls $DIR/xfce-perchannel-xml`
do
  # Remove a static bashrc
  if [ -f $DEST/$FILE -a ! -h $DEST/$FILE ]
  then
    rm $DEST/$FILE
  fi

  # Link to the git repo version
  if [ ! -h $DEST/$FILE ]
  then
    ln -s $DIR/xfce-perchannel-xml/$FILE $DEST/$FILE
  fi
done

rm -rf ~/.config/xfce4/panel/launcher-*

DEST=~/.config/xfce4/terminal/
for FILE in `ls $DIR/terminal`
do
  # Remove a static bashrc
  if [ -f $DEST/$FILE -a ! -h $DEST/$FILE ]
  then
    rm $DEST/$FILE
  fi

  # Link to the git repo version
  if [ ! -h $DEST/$FILE ]
  then
    ln -s $DIR/terminal/$FILE $DEST/$FILE
  fi
done
