#!/bin/sh

# This script must be run as the superuser to work correctly.
# Also, you must change the permissions of this script to be executable, so before attempting to run it,
# run: 'chmod +x ./command_line_setup.sh' before trying to run this script.
# Be sure to run this script with the command 'sudo command_line_setup.sh'

if [!-d /usr/local]; then
    mkdir -p /usr/local;
fi

# Check to make sure that a bash profile does not already exist, and if not, create the files
if [!-f ~/.bash_profile] && [!-f ~/.profile]; then
	cat <<EOT >> ~/.bash_profile
	export PATH=/usr/local/sbin:/usr/local/bin:$PATH

	if [ -f ~/.bash_aliases ]; then
		. ~/.bash_aliases
	fi
EOT
else
	echo 'export PATH=/usr/local/sbin:/usr/local/bin:$PATH' >> ~/.bash_profile;
	echo 'A .bash_profile or .profile already existed, so aliases have not been created.'
fi

# Now we create ~/.bash_aliases if it doesn't already exist
if [!-f ~/.bash_aliases]; then
	cat <<EOT >> ~/.bash_aliases
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
		alias reld='source ~/.bash_profile'

		# Aliases for Typos
		alias gti='git'
		alias got='git'
		alias gut='git'
EOT
fi

# Ok, now let's reload the terminal with the current settings
if [ -f ~/.bash_profile ]; then
	source ~/.bash_profile
fi

# Now we run the homebrew installer

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Now we run brew doctor to make sure everything is working

brew doctor

# Now let's set the owner of the /usr/local directory and all subdirs so that we don't get install errors from npm etc.
chown -R `whoami` /usr/local

# Complete, notify user about next steps.
echo "Installation is complete."
echo "Command line setup is complete."
echo "To install new software, you can now run 'brew install name_of_software'"
echo "For example, to install the latest version of git, you'll run: 'brew install git'"
echo "To upgrade software, you can run 'brew upgrade' or 'brew upgrade name_of_software'"
echo "To find software that can be installed with homebrew, run 'brew search name_of_software_to_find'"
echo "To view software already installed with homebrew, run 'brew list'"



