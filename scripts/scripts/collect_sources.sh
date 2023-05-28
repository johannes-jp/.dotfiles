#!/bin/bash

#file locations
write_directory="$HOME/.dotfiles/Sources/"
pip="pip-package.list"
aptpkg="apt-package.list"
aptsrc="apt-source.list"
aptsrc_manual="apt-source-manual.list"
snap="snap-package.list"
node="node-package.list"


#### other functions ####
#check if a package/command exists
package_exists () {
	type "$1" &> /dev/null ;
}
####


#### apt ####
# Check if user has read permission for installer file
installer_status_file="/var/log/installer/installer-status.gz"
# Check if file exists for user
if ! [ -e "$installer_status_file" ]; then
  # Check if file exists for super user 
  if ! sudo test -e "$installer_status_file"; then
    echo "File '$installer_status_file' does not exist"
  else
  # Sudo add read permission
    if ! sudo test -r "$installer_status_file"; then
      sudo chmod +r "$installer_status_file"
      echo "Read permission added for file '$installer_status_file' (with sudo)."
    fi
  fi
fi
# Remove list of installer packages from manual packages
installer_packages=$(gzip -dc "$installer_status_file" | sed -n 's/^Package: //p' | sort -u)
comm -23 <(apt-mark showmanual | sort -u) <(echo "$installer_packages") > "$write_directory$aptpkg"

## sources ##
#automatic sources
cat /etc/apt/sources.list > "$write_directory$aptsrc"
#manually added sources
ls /etc/apt/sources.list.d > "$write_directory$aptsrc_manual"
####









#### collect snap packages ####
snap list | awk 'NR>1 {print }' > "$write_directory$snap"
####


#### collect top-level pip packages ####
#check if pip is installed
if ! package_exists pip ; then
	echo "Pip is not installed. Install with 'sudo apt install -y python3 python3-pip'"
else
	#check if pipdeptree is installed
	if ! pip freeze | grep -q 'pipdeptree' ; then
		echo "Pipdeptree does not exist. Install with 'pip install pipdeptree'"
	else
	# write list to file
	pipdeptree --warn silence | grep -P '^\w+' > "$write_directory$pip"
	fi
fi
####


#### collect globally installed node packages ####
#check if npm is installed
if ! package_exists npm ; then
	echo "Npm is not installed. Install with 'sudo apt install -y nodejs npm'"
else
#write list to file
	npm list -g --depth=0 | grep -v /npm@ > "$write_directory$node"
fi
####
