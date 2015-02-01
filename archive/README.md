#dotfiles

Setup a host

## Initial Setup

```bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install git
git clone https://github.com/MathYourLife/dotfiles.git
cd dotfiles
```

## Setup Everything

```bash
find . -type f -name 'setup.sh' -exec /bin/bash {} \;
```
