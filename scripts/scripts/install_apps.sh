# Modify file to run as executable
# chmod +x install_apps.sh

# Install pip and core languages
sudo apt update && sudo apt install -y python3 python3-pip nodejs npm

# Install GNU Stow 
sudo apt install stow

# Configure python3 path
PYTHON3_PATH=$(which python3)
if [[ ! $PATH =~ "/usr/bin" ]]; then
  # Choose the appropriate shell configuration file
  if [[ $SHELL == "/bin/bash" ]]; then
    CONFIG_FILE="$HOME/.bashrc"
  elif [[ $SHELL == "/bin/zsh" ]]; then
    CONFIG_FILE="$HOME/.zshrc"
  else
    echo "Unsupported shell. Please add /usr/bin to the PATH manually."
    exit 1
  fi
  # Add /usr/bin to the PATH
  echo 'alias python=python3' >> "$CONFIG_FILE"
  echo 'export PATH="/usr/bin:$PATH"' >> "$CONFIG_FILE"

  # Reload the shell configuration
  source "$CONFIG_FILE"
fi
echo "Python 3 is installed at $PYTHON3_PATH"
echo "Current PATH: $PATH"


# SNAP
sudo snap install 1password spotify

# Install VS Code
wget -O code.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
sudo dpkg -i code.deb

# Install Signal
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | sudo tee /etc/apt/sources.list.d/signal-xenial.list
sudo apt update && sudo apt install -y signal-desktop
#sudo snap install signal-desktop

# Install Discord
wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo dpkg -i discord.deb
sudo apt install -f -y

# Install Slack
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.19.2-amd64.deb
sudo dpkg -i slack-desktop-*.deb
sudo apt install -f -y

# Install 1Password
# sudo snap install 1password

# Install NordVPN
#wget https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
#sudo dpkg -i nordvpn-release_1.0.0_all.deb
#sudo apt-get update && sudo apt-get install nordvpn -y
#curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh | bash -s -- -y

# Install Spotify
# sudo snap install spotify

# Install Obsidian
wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.1.16/obsidian_1.1.16_amd64.deb
sudo dpkg -i obsidian_1.1.16_amd64.deb
sudo apt install -f -y

# Install Brave
sudo apt install curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install -y brave-browser
#check brave://gpu for hardware acceleration status and driver issues

# Install Fastmail
# create shortcut & open as window from browser, or just use tbird

# Install VS Code
# sudo snap install code

# Install Shell_GPT
pip install shell-gpt==0.9.0

# Install i3-wm
sudo apt update && sudo apt install -y i3 i3-wm i3status i3lock dmenu

# Update to i3-wm 4.22
/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2023.02.18_all.deb keyring.deb SHA256:a511ac5f10cd811f8a4ca44d665f2fa1add7a9f09bef238cdfad8461f5239cc4
sudo apt install ./keyring.deb
echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
sudo apt update
sudo apt install i3

# Install alacritty terminal emulator
#sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
#curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
#git clone https://github.com/alacritty/alacritty.git
#cd alacritty
#cargo build --release
#sudo cp target/release/alacritty /usr/local/bin


# Install picom v10.2 compositor
sudo apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl-dev libegl-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson
wget https://github.com/yshui/picom/archive/refs/tags/v10.2.tar.gz
tar -xvf v10.2.tar.gz
cd picom-10.2
sudo apt install asciidoc
sudo apt install meson
sudo apt install ninja-build
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install

# Install htop
sudo apt install htop
