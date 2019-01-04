#!/bin/sh

echo "Setting up your Mac ..."

# Install requirements
xcode-select --install

# Check for Homebrew and install if we don't have it.
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with Brewfile
brew tap homebrew/bundle
brew bundle

# Install Oh-My-Zsh & custom aliases

ZSH=~/.oh-my-zsh

if [ -d "$ZSH" ]; then
  e_warning "Oh My Zsh is already installed. Skipping.."
else
  e_header "Installing Oh My Zsh..."
  curl -L http://install.ohmyz.sh | sh

  ## To install ZSH themes & aliases
  e_header "Copying ZSH themes & aliases..."
  e_note "Check .aliases file for more details."
  cp oh-my-zsh/aliases ~/.aliases                                        ## Copy aliases
  cp oh-my-zsh/zshrc ~/.zshrc                                            ## Copy zshrc configs
  cp oh-my-zsh/dracula.zsh-theme ~/.oh-my-zsh/themes/dracula.zsh-theme   ## Copy custom dracula theme
  cp oh-my-zsh/z.sh ~/z.sh                                               ## Copy z.sh autocompletion file
  git clone https://github.com/peterhurford/git-it-on.zsh ~/.oh-my-zsh/custom/plugins/git-it-on ## Copy git it on utilities plugin
fi

# Set macOS preferences
# This reloads the shell, that's why we run it last.
source .macos

