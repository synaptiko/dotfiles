alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F -h'
alias ll='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F -hl'
alias la='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F -hlA'
alias lt='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F -hlt'
alias ltag='ls -t | ag'

alias grep='grep --color=tty -d skip'

alias df='df -h'

alias agjs='ag -p .ignore --js -Q'
alias agscss='ag -p .ignore --sass -Q'

up() {
	if pacman -Qs reflector >& /dev/null; then
		printf "Update Pacman mirror list? [y/N]: "
		if read -q; then
			sudo systemctl start reflector
		fi
	fi

	if pacman -Qs packer >& /dev/null; then
		packer -Syu
	elif pacman -Qs yaourt >& /dev/null; then
		sudo pacman -Syu

		printf "Update also AUR packages? [y/N]: "
		if read -q; then
			printf "Update also git/svn etc. packages? [y/N]: "
			if read -q; then
				yaourt -Syua --devel
			else
				yaourt -Syua
			fi
		fi
	else
		sudo pacman -Syu
	fi
	printf "Install? [y/N]: "
	if read -q; then
}
