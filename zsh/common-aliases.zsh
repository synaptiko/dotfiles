alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F -h'
alias ll='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F -hl'
alias la='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F -hlA'
alias lt='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F -hlt'
alias ltag='ls -t | ag'

alias grep='grep --color=tty -d skip'

alias df='df -h'

alias agjs='ag -p .ignore --js -Q'
alias agscss='ag -p .ignore --sass -Q'

alias l='gtk-launch'

up() {
	if pacman -Qs reflector >& /dev/null; then
		read -k "UPDATE_MIRRORS?:: Update Pacman mirror list? [Y/n] "
		if [ $UPDATE_MIRRORS != $'\n' ]; then
			printf "\n"
		fi
	else
		UPDATE_MIRRORS="n"
	fi

	if pacman -Qs yaourt >& /dev/null; then
		USE_YAOURT="y"
		read -k "UPDATE_AUR?:: Update AUR packages? [Y/n] "
		if [ $UPDATE_AUR != $'\n' ]; then
			printf "\n"
		fi

		if [ $UPDATE_AUR != "n" ]; then
			read -k "UPDATE_DEVEL?:: Update git/svn… packages? [Y/n] "
			if [ $UPDATE_DEVEL != $'\n' ]; then
				printf "\n"
			fi
		fi
	elif pacman -Qs packer >& /dev/null; then
		USE_YAOURT="n"
		read -k "UPDATE_AUR?:: Update AUR packages? [Y/n] "
		if [ $UPDATE_AUR != $'\n' ]; then
			printf "\n"
		fi
	else
		UPDATE_AUR="n"
	fi

	if [ $UPDATE_MIRRORS != "n" ]; then
		echo "sudo systemctl start reflector"
		sudo systemctl start reflector
	fi

	if [ $UPDATE_AUR != "n" ]; then
		if [ $USE_YAOURT = "y" ]; then
			if [ $UPDATE_DEVEL != "n" ]; then
				echo "yaourt -Syua --devel"
				yaourt -Syua --devel
			else
				echo "yaourt -Syua"
				yaourt -Syua
			fi
		else
			echo "packer -Syu"
			packer -Syu
		fi
	else
		echo "sudo pacman -Syu"
		sudo pacman -Syu
	fi
}
