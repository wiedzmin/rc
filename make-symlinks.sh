#!/bin/sh

CURRENT_DIR=`pwd`
echo "Making symlinks to configs from ${CURRENT_DIR}..."

ln -svf $CURRENT_DIR/.Xresources $HOME/.Xresources
ln -svf $CURRENT_DIR/hgrc-linux $HOME/.hgrc
ln -svf $CURRENT_DIR/.tmux.conf $HOME/.tmux.conf
ln -svf $CURRENT_DIR/.xsession $HOME/.xsession
ln -svf $CURRENT_DIR/zsh/.zsh $HOME/.zsh
ln -svf $CURRENT_DIR/zsh/.zshrc $HOME/.zshrc
ln -svf $CURRENT_DIR/.xxkbrc $HOME/.xxkbrc
ln -svf $CURRENT_DIR/.vimperatorrc $HOME/.vimperatorrc
ln -svf $CURRENT_DIR/emacsclient.desktop $HOME/.local/share/applications
cat >> $HOME/.local/share/applications/mimeapps.list <<EOF
x-scheme-handler/org-protocol=emacsclient.desktop
EOF

sudo ln -svf $CURRENT_DIR/acpi /etc/acpi
sudo ln -svf $CURRENT_DIR/xorg.conf.d /etc/X11
sudo ln -svf $CURRENT_DIR/emacsclient.desktop /usr/share/applications
