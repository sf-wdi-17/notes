#!/bin/sh

# This script must be run as the superuser to work correctly. 
# Also, you must change the permissions of this script to be executable, so before attempting to run it,
# run: 'chmod +x ./command_line_setup.sh' before trying to run this script.
# Be sure to run this script with the command 'sudo command_line_setup.sh'

ROOTLEVEL=''
HOMEDIR=$HOME

if [ ! -d $ROOTLEVEL/usr/local ]; then
	echo "Creating /usr/local dir"
    mkdir -p $ROOTLEVEL/usr/local;
fi

if [ ! -d $HOMEDIR ]; then
	echo "Creating home directory"
	mkdir -p $HOMEDIR;
fi

# Now we create $HOMEDIR/.bash_aliases if it doesn't already exist
if [ ! -f $HOMEDIR/.bash_aliases ]; then
	touch $HOMEDIR/.bash_aliases
	cat <<EOT >> $HOMEDIR/.bash_aliases
		# ls aliases
		alias ll='ls -l'
		alias la='ls -A'
		alias lla='ls -lA'
		alias l='ls -CF'
		alias llc='ls -CFl'

		# grep aliases
		alias grep='grep --color=auto'
		alias fgrep='fgrep --color=auto'
		alias egrep='egrep --color=auto'

		# Process commands
		alias pgrep='ps -ax | grep'

		# git standard aliases
		alias gs='git st'
		alias gss='git status'
		alias ga='git add'
		alias gb='git branch'
		alias gc='git commit'
		alias gd='git diff'
		alias go='git checkout'
		alias gk='gitk --all&'

		# Shortcut to Reload Bash Profile
		alias reld='source $HOMEDIR/.bash_profile'

		# Aliases for Typos
		alias gti='git'
		alias got='git'
		alias gut='git'
EOT
fi

# Set up the correct path pattern
PATH=$ROOTLEVEL/usr/local/sbin:$ROOTLEVEL/usr/local/bin:$PATH

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4
brew install bash

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep

PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH

echo "Homebrew installation is complete."


# Now create the bash profile with the correct path in there

# Check to make sure that a bash profile does not already exist, and if not, create the files
touch $HOMEDIR/.bash_profile
cat <<EOT >> $HOMEDIR/.bash_profile
	export PATH=$PATH:'$PATH'

	if [ -f $HOMEDIR/.bash_aliases ]; then
		. $HOMEDIR/.bash_aliases
	fi
EOT

# Ok, now let's reload the terminal with the current settings
if [ -f $HOMEDIR/.bash_profile ]; then
	source $HOMEDIR/.bash_profile
fi

echo "Bash profile setup is complete and command line setup has been reloaded."


# Now let's set the owner of the /usr/local directory and all subdirs so that we don't get install errors from npm etc.
chown -R `whoami` $ROOTLEVEL/usr/local

echo "Owner of /usr/local directory has been changed successfully."

echo "Cleaning up homebrew installations"
brew cleanup

# Complete, notify user about next steps.
echo "About homebrew:"
echo "To install new software, you can now run 'brew install name_of_software'"
echo "For example, to install the latest version of git, you'll run: 'brew install git'"
echo "To upgrade software, you can run 'brew upgrade' or 'brew upgrade name_of_software'"
echo "To find software that can be installed with homebrew, run 'brew search name_of_software_to_find'"
echo "To view software already installed with homebrew, run 'brew list'"



