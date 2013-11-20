# Setup Dev environment
# Ask for the administrator password upfront
: <<'END'
# tell the script to setup aliases in bash_profile
make_aliases=FALSE;

echo "This script needs Administrator privileges to edit some files in the /etc directory.";
sudo -v
# Keep-alive: update existing `sudo` time stamp until `install.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# check for homebrew
echo $'\n'"Checking homebrew..."
which -s brew
if [[ $? != 0 ]] ; then
  # install homebrew if not installed
  ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
else
  # update homebrew
  brew update
fi
# check for git
which -s git || brew install git

# setup aliases
if [[ $make_aliases == TRUE ]] ; then
  echo $'\n'"Setting up aliases..."
  # check if bash_profile exists, if not, create file
  if [[ ! -f ~/.bash_profile ]] ; then
    touch ~/.bash_profile
  fi
  # add alises to bash_profile
  echo $'\n'"# apache, php & mysql aliases"$'\n'"alias reapache=\"sudo apachectl restart\""$'\n'"alias hosts=\"mate /etc/hosts\""$'\n'"alias vhosts=\"mate /etc/apache2/extra/httpd-vhosts.conf\""$'\n'"alias phpini=\"mate /etc/php.ini\""$'\n'"alias apachecnf=\"mate /etc/apache2/httpd.conf\""$'\n'"alias dns-cache=\"dscacheutil -flushcache\"" | sudo tee -a ~/.bash_profile
fi

# check for php version
echo $'\n'"Checking PHP version and location..."
echo "location: $(which php)"
echo "$(php --version)"

# backup apache config file
echo $'\n'"Backing up Apache config file..."
sudo cp /etc/apache2/httpd.conf /etc/apache2/httpd.conf.bak
# activate php
echo $'\n'"Activating PHP on Apache..."
apachecnf=$(sudo sed -e 's/#LoadModule php5_module libexec\/apache2\/libphp5.so/LoadModule php5_module libexec\/apache2\/libphp5.so/' /etc/apache2/httpd.conf)
# enable virtual hosts
echo $'\n'"Activating virtual hosts..."
apachecnf=$(sudo sed -e "s/#Include \/private\/etc\/apache2\/extra\/httpd-vhosts.conf/Include \/private\/etc\/apache2\/extra\/httpd-vhosts.conf/" <<< "$apachecnf")
# create new file
echo "$apachecnf" | sudo tee /etc/apache2/httpd.conf.tmp > /dev/null
sudo mv /etc/apache2/httpd.conf.tmp /etc/apache2/httpd.conf
END
# Ask for virtual host name 
read -p 'Enter your vhost name (e.g. www or username.local): ' virtualHost
virtualHost=$(echo $virtualHost | tr '[:upper:]' '[:lower:]')
virtualHost=$(sed "s/[^a-z.|0-9\-]//g;" <<< $virtualHost)
echo "Your virtual Host name is: "$virtualHost

# check for directory to use as root
if [[ -d "$HOME/Sites" ]] ; then
  rootDir="$HOME/Sites"
elif [[ -d "$HOME/WebSites" ]] ; then
  rootDir="$HOME/WebSites"
elif [[ -d "$HOME/Projects" ]]; then
  rootDir="$HOME/Projects"
else
  read -p 'Enter a name for your web root containing all websites: ' rootFolder
  mkdir -p "$HOME/$rootFolder"
  rootDir="$HOME/$rootFolder"
fi
echo "Your web root is: "$rootDir

# write virtual hosts file
echo $'\n'"<VirtualHost *:80>"$'\n\t'"DocumentRoot \"/Library/WebServer/Documents\""$'\n'"</VirtualHost>"$'\n'"<VirtualHost *:80>"$'\n\t'"DocumentRoot \"$rootDir\""$'\n\t'"ServerName $virtualHost"$'\n\t'"ErrorLog \"/private/var/log/apache2/$virtualHost-error_log\""$'\n\t'"CustomLog \"/private/var/log/apache2/$virtualHost-access_log\" common"$'\n\n\t'"<Directory \"$rootDir\">"$'\n\t\t'"AllowOverride All"$'\n\t\t'"Order allow,deny"$'\n\t\t'"Allow from all"$'\n\t'"</Directory>"$'\n'"</VirtualHost>" | sudo tee -a /etc/apache2/extra/httpd-vhosts.conf

## etc/hosts

# timeout sudo
# sudo -k