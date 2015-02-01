
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo apt-get install -y wireshark traceroute tcpreplay

# Set preference for ipv4 because who really needs ipv6 anyway? >.<
sudo sed -i s/'#precedence\ ::ffff:0:0\/96  100$'/precedence\ ::ffff:0:0\\/96\ \ 100/ /etc/gai.conf
