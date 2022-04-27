#!/bin/bash
#
# Bootstrap script for setting up a new OSX machine
#
# This should be idempotent so it can be run multiple times.
#
# Some apps don't have a cask and so still need to be installed by hand. These
# include:
# - Postgres.app (http://postgresapp.com/)
#
# Reading:
# - https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
# - https://news.ycombinator.com/item?id=8402079
# - http://notes.jerzygangi.com/the-best-pgp-tutorial-for-mac-os-x-ever/

source config.env
source app-lists/app-mandatory.env

echo "Starting bootstrapping"

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
echo "Updating homebrew..."
brew update

# Install GNU core utilities (those that come with OS X are outdated)
echo "Installing GNU core utilities..."
brew tap homebrew/dupes
brew install coreutils
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-indent --with-default-names
brew install gnu-which --with-default-names
brew install gnu-grep --with-default-names
brew install dos2unix

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
echo "Installing GNU findutils..."
brew install findutils

# Install Bash 4
echo "Installing last bash version..."
brew install bash

PACKAGES=(
    git
    markdown
    vim
    wget
    watch
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

echo "Installing cask..."
brew install caskroom/cask/brew-cask

echo "To see all available casks in the online repository run this command: brew search --cask"

echo "Installing mandatory cask apps..."
# $APP_MANDATORY list is loaded from app-lists/app-mandatory.env file imported with source command at the start of this script
brew cask install ${APP_MANDATORY[@]}

echo "Installing fonts..."
brew tap caskroom/fonts
FONTS=(
    font-roboto
)
brew cask install ${FONTS[@]}

echo "Installing custom E-Motion fonts..."
sudo cp $EXTERNAL_CONFIG_PATH/fonts/*.otf /Library/Fonts

#echo "List all installed fonts..."
#system_profiler SPFontsDataType

echo "Git global configuration..."
git config --global user.email $GIT_EMAIL
git config --global user.name $GIT_USERNAME
git config --list

# NVM, NodeJS installation (see https://github.com/nvm-sh/nvm and check here for latest version)
echo "Installing nvm (Node Version Manager) and latest version of NodeJS"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash

echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> ~/.bash_profile

echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> ~/.zshrc

echo "NVM version is: "
nvm --version

echo "Installing NodeJS latest version"
#nvm install node
nvm install --lts

#nvm use node
nvm use --lts

echo "NodeJS version: "
node --version

echo "npm version: "
npm --version

#echo "Configuring OSX..."

echo export PATH="/usr/local/bin:${PATH}" >> ~/.bash_profile && source ~/.bash_profile
echo export PATH="/usr/local/bin:${PATH}" >> ~/.zshrc && source ~/.zshrc

echo "Bootstrapping complete"


