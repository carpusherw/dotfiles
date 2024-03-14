#!/usr/bin/env bash

echo 'Installing dotfiles...'

mv ~/.zshrc ~/.zshrc.bak
cp .zshrc ~/.zshrc
source ~/.zshrc
