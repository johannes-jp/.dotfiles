#file locations
write_directory="$HOME/.dotfiles/Sources/"
pip="pip-package-list"
apt="apt-package-list"
node="node-package-list"


#### collect manually installed apt packages ####
comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/installer-status.gz | sed -n 's/^Package: //p' | sort -u) > "$write_directory$apt"
####


#### collect top-level pip packages ####
#check if pip and pipdeptree are installed
package_exists () {
	type "$1" &> /dev/null ;
}
if ! package_exists pip ; then
	echo "Pip is not installed. Install with 'sudo apt install -y python3 python3-pip'"
else
	if ! pip freeze | grep -q 'pipdeptree' ; then
		echo "Pipdeptree does not exist. Install with 'pip install pipdeptree'"
else
# write list to file
	pipdeptree --warn silence | grep -P '^\w+' > "$write_directory$pip"
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

	
