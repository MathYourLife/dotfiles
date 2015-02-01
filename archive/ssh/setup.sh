
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir -p ~/.ssh
chmod 700 ~/.ssh
touch ~/.ssh/known_hosts
chmod 600 ~/.ssh/known_hosts
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

cp $DIR/config ~/.ssh/config
chmod 600 ~/.ssh/config
