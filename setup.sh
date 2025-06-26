#!/bin/bash

bat cache --build

sudo groupadd clipboard
sudo usermod -aG clipboard ahsan

(crontab -l 2>/dev/null; echo "0 3 * * 0 cliphist optimize --compact") | crontab -

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm --depth 1
chmod 700 ~/.tmux && chmod 600 ~/.tmux.conf
tmux source-file ~/.tmux.conf
