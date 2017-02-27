#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

XINITRC_FILE=~/.xinitrc
if [ ! -e $XINITRC_FILE ]; then
	echo "Initializing Xinit configuration"
	ln -s $DIR/xinitrc $XINITRC_FILE
	echo "Xinit configured"
	echo
else
	echo "Xinit configuration already exists"
	echo "If you really want to link it re/move original $XINITRC_FILE"
	echo
fi

GPG_AGENT_FILE=~/.gnupg/gpg-agent.conf
if [ ! -e $GPG_AGENT_FILE ]; then
	echo "Initializing GPG Agent configuration"
	ln -s $DIR/gnupg/gpg-agent.conf $GPG_AGENT_FILE
	echo "GPG Agent configured"
	echo
else
	echo "GPG Agent configuration already exists"
	echo "If you really want to link it re/move original $GPG_AGENT_FILE"
	echo
fi

if ! systemctl --user is-enabled gpg-agent.socket >& /dev/null; then
	systemctl --user enable gpg-agent.socket
fi

if ! systemctl --user is-enabled gpg-agent-ssh.socket >& /dev/null; then
	systemctl --user enable gpg-agent-ssh.socket
fi

if ! systemctl --user is-enabled gpg-agent-browser.socket >& /dev/null; then
	systemctl --user enable gpg-agent-browser.socket
fi

# TODO detect which pinentry is configured in gpg-agent.conf?
if ! ls -la /usr/bin/pinentry | grep pinentry-qt >& /dev/null; then
	sudo ln -s -f /usr/bin/pinentry-qt /usr/bin/pinentry
fi

PAM_ENVIRONMENT_FILE=~/.pam_environment
if [ ! -e $PAM_ENVIRONMENT_FILE ]; then
	echo "Initializing PAM Environment configuration"
	ln -s $DIR/pam_environment $PAM_ENVIRONMENT_FILE
	echo "PAM Environment configured"
	echo
else
	echo "PAM Environment configuration already exists"
	echo "If you really want to link it re/move original $PAM_ENVIRONMENT_FILE"
	echo
fi

ZLOGIN_FILE=~/.zlogin
if [ ! -e $ZLOGIN_FILE ]; then
	echo "Initializing ZShell login configuration"
	ln -s $DIR/zlogin $ZLOGIN_FILE
	echo "ZShell login configured"
	echo
else
	echo "ZShell login configuration already exists"
	echo "If you really want to link it re/move original $ZLOGIN_FILE"
	echo
fi

ZPLUG_DIR=~/.zplug
if [ ! -d $ZPLUG_DIR ]; then
	echo "Cloning the ZPlug manager"
	git clone https://github.com/zplug/zplug $ZPLUG_DIR
	echo "ZPlug manager cloned"
	echo
else
	echo "ZPlug manager seems to be already installed"
	echo "If you want to reinstall it re/move $ZPLUG_DIR directory"
	echo
fi

ZSHRC_FILE=~/.zshrc
if [ ! -e $ZSHRC_FILE ]; then
	echo "Initializing ZShell configuration"
	ln -s $DIR/zshrc $ZSHRC_FILE
	echo "ZShell configured"
	echo
else
	echo "ZShell configuration already exists"
	echo "If you really want to link it re/move original $ZSHRC_FILE"
	echo
fi

POLYBAR_DIR=~/.config/polybar
if [ ! -d $POLYBAR_DIR ]; then
	echo "Initializing Polybar configuration"
	ln -s $DIR/config/polybar/config $POLYBAR_DIR/config
	echo "Polybar configured"
	echo
fi

# TODO solve root's .zshrc more elegantly
ROOT_ZSHRC_FILE=/root/.zshrc
if sudo ls $ROOT_ZSHRC_FILE >& /dev/null; then
	echo "ZShell configuration for root already exists"
	echo "If you really want to link it re/move original $ROOT_ZSHRC_FILE"
	echo
else
	echo "Initializing ZShell configuration for root"
	sudo ln -s $DIR/zshrc $ROOT_ZSHRC_FILE
	echo "ZShell for root configured"
	echo
fi

# TODO solve root's .zplug more elegantly
ROOT_ZPLUG_DIR=/root/.zplug
if [ ! -d $ROOT_ZPLUG_DIR ]; then
	echo "Cloning the ZPlug manager"
	sudo git clone https://github.com/zplug/zplug $ROOT_ZPLUG_DIR
	echo "ZPlug manager cloned"
	echo
else
	echo "ZPlug manager seems to be already installed"
	echo "If you want to reinstall it re/move $ROOT_ZPLUG_DIR directory"
	echo
fi

# TODO How to say NVIM running under root user to take config from my main user?
NVIM_DIR=~/.config/nvim
if [ ! -d $NVIM_DIR ]; then
	echo "Initializing Neovim configuration"
	mkdir -p $NVIM_DIR/{autoload,plugged}
	curl -sfLo $NVIM_DIR/autoload/plug.vim \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	ln -s $DIR/config/nvim/init.vim $NVIM_DIR/init.vim
	pip install --user neovim
	echo "Neovim configured"
	echo "Run \"nvim -c PlugInstall\" to install all plugins; warnings at the start can be ignored"
	echo
fi

FONTS_DIR=~/.local/share/fonts
FANTASQUE_DIR=$FONTS_DIR/FantasqueSansMono
if [[ ! -d $FONTS_DIR || ! -f $FONTS_DIR/FantasqueSansMono-Regular.otf ]]; then
	echo "Initializing fonts"
	mkdir -p $FONTS_DIR
	curl -sfLo $FONTS_DIR/FantasqueSansMono.zip \
		https://github.com/belluzj/fantasque-sans/releases/download/v1.7.0/FantasqueSansMono.zip
	mkdir $FANTASQUE_DIRFONTS_DIR
	unzip - $FONTS_DIR/FantasqueSansMono.zip -d $FANTASQUE_DIR
	mv $FANTASQUE_DIR/OTF/*.otf $FONTS_DIR
	rm -r $FANTASQUE_DIR
	rm $FONTS_DIR/FantasqueSansMono.zip
	fc-cache -f $FONTS_DIR
	echo "Font Fantasque Sans Mono installed"
	echo
fi

XFCE4_TERMINAL_FILE=~/.config/xfce4/terminal/terminalrc
if [ ! -e $XFCE4_TERMINAL_FILE ]; then
	echo "Initializing Xfce4 Terminal configuration"
	mkdir -p $( dirname $XFCE4_TERMINAL_FILE )
	ln -s $DIR/config/xfce4/terminal/terminalrc-dark $XFCE4_TERMINAL_FILE
	echo "Xfce4 Terminal configured"
	echo
else
	echo "Xfce4 Terminal configuration already exists"
	echo "If you really want to link it re/move original $XFCE4_TERMINAL_FILE"
	echo
fi

if pacman -Qs moc >& /dev/null; then
	MOC_DIR=~/.moc
	if [[ ! -d $MOC_DIR || ! -f $MOC_DIR/config ]]; then
		echo "Initializing MOC configuration"
		mkdir -p $MOC_DIR/themes
		ln -s $DIR/moc/config $MOC_DIR/config
		ln -s $DIR/moc/themes/jprokop_theme $MOC_DIR/themes/jprokop_theme
		echo "MOC configured"
		echo
	fi
else
	echo "MOC is not installed; ignoring its configuration"
	echo
fi

if pacman -Qs tmux >& /dev/null; then
	TMUX_CONF=~/.tmux.conf
	if [[ ! -f $TMUX_CONF ]]; then
		echo "Initializing Tmux configuration"
		ln -s $DIR/tmux.conf $TMUX_CONF
		echo "Tmux configured"
		echo
	fi
else
	echo "Tmux is not installed; ignoring its configuration"
	echo
fi

AVATAR_FILE=~/.face
if [[ ! -f $AVATAR_FILE ]]; then
	echo "Downloading avatar from Gravatar.com"
	EMAIL_HASH=$(echo -n jiri-prokop@synaptiko.cz | md5sum - | cut -d " " -f 1)
	wget --quiet -O jprokop.png http://www.gravatar.com/avatar/${EMAIL_HASH}.png?size=160
	sudo mv jprokop.png $AVATAR_FILE
	echo "Avatar installed"
	echo
fi
