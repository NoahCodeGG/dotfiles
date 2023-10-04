#!/bin/zsh

# Install Xcode cli tools
echo "Installing commandline tools..."
xcode-select --Install

# Install Brew
echo "Installing Brew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# brew
echo "Installing Brew Formulae..."
# Brew Taps
brew tap homebrew/cask-fonts # nerdfonts
brew tap FelixKratz/formulae # sketchybar
brew tap koekeishiya/formulae # yabai, skhd

# Brew Formulae
brew install neovim
brew install yabai
brew install skhd
brew install tree
brew install jq
brew install gh
brew install switchaudio-osx
brew install btop
brew install sketchybar
brew install git
brew install dooit
brew install trash
brew install bat
brew install dust
brew install fd
brew install lsd
brew install grep
brew install gping
brew install mas
brew install nvim

# Brew Cask
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask arc
brew install --cask raycast
brew install --cask alacritty
brew install --cask motrix
brew install --cask visual-studio-code
brew install --cask easydict
brew install --cask spotify
brew install --cask jetbrains-toolbox
brew install --cask orbstack
brew install --cask notion
brew install --cask iina

# Mac App Store Apps
echo "Installing Mac App Store Apps..."
mas install 497799835 #Xcode

# zinit
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

# gvm
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

# NvChad
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim

# Copying and checking out configuration files
echo "Planting Configuration Files..."
[ ! -d "$HOME/dotfiles" ] && git clone --bare git@github.com:NoahCodeGG/dotfiles.git $HOME/dotfiles
git --git-dir=$HOME/dotfiles/ --work-tree=$HOME checkout master

source $HOME/.zshrc
source $HOME/.gvm/scripts/gvm

# macOS Settings
echo "Changing macOS defaults..."
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.spaces spans-displays -bool false
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock "mru-spaces" -bool "false"
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write com.apple.LaunchServices LSQuarantine -bool false
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write NSGlobalDomain _HIHideMenuBar -bool true
defaults write com.apple.screencapture location -string "$HOME/Downloads"
defaults write com.apple.screencapture disable-shadow -bool true
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.finder DisableAllAnimations -bool true
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
defaults write com.apple.Finder AppleShowAllFiles -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder ShowStatusBar -bool false
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool YES
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Start Services
echo "Starting Services (grant permissions)..."
brew services start sketchybar
yabai --start-service
skhd --start-service

csrutil status
echo "Do not forget to disable SIP"

echo "Add sudoer manually:\n '$(whoami) ALL = (root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | awk "{print \$1;}") $(which yabai) --load-sa' to '/private/etc/sudoers.d/yabai'"
echo "Installation complete...Restart."
