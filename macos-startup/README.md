# MacOS Startup

## From Start to code in (few) minutes

This readme will guide you in the *light* startup and configuration process of your MacOS: the process is set in order to be the fastest and the most automated way possible (at the moment).

The process will drive you through the following main steps:

1. Initialise bootstrap configuration
2. Automatically install mandatory tools and applications (from repositories, like homebrew and casks) to be used in a specific projects

## 1. Initialise bootstrap configuration

Follow this steps:


Open `config.env` file and set exported constants following these instructions:
   1. *GIT_EMAIL* is the email used for the git global account, the one used in the remote repository
   2. *GIT_USERNAME* is the name to show and use in git commands, the one used in the remote repository

## 2. Install homebrew and run basic light bootstrap command
<div id="2-install-homebrew"></div>

Open Terminal and run this command to install homebrew:

	sudo /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	

(Probably not needed) Open a Terminal at the root path of this repository (`macos-startup` folder) and run the following command to give execution permission to the main script file:

	chmod 765 bootstrap.sh

Run the batch script with the following command: this will install the main mandatory applications and it will configure the main OS settings:

	./bootstrap.sh
