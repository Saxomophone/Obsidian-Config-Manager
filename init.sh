#!/bin/bash

NO_FORMAT="\033[0m"
C_RED="\033[38;5;9m"
C_YELLOW="\033[38;5;11m"

function clean() {
  rm -rf ~/.config/obsidian_config_manager/
  exit $1
}


trap "clean 1" SIGINT # clean up if user exits with ctrl-c

# if ~/.config/obsidian_config_manager does not exist, create it
if [[ ! -e ~/.config/obsidian_config_manager ]]; then
  mkdir -p ~/.config/obsidian_config_manager/main_config
elif [[  -e ~/.config/obsidian_config_manager/main_config ]]; then
  echo -e "${C_YELLOW}~/.config/obsidian_config_manager already exists${NO_FORMAT}"
  echo -e "If you want to update the main_config, run the update_main_config.zsh script"  # NOTE: change update_main_config.zsh to whatever command is later
  exit 1
fi

echo -e "Where do you want to pull the main_config from? (Github: g, Local: l)"
read source

if [[ $source == "g" ]]; then
  echo -e "Enter the github url of the main_config"
  read github_url
  git clone $github_url ~/.config/obsidian_config_manager/main_config || (echo -e "${C_RED}Error: invalid github url${NO_FORMAT}" && clean 1)
elif [[ $source == "l" ]]; then
  echo -e "Enter the path to the main_config"
  read -e path
  mkdir -p ~/.config/obsidian_config_manager/main_config/.obsidian
  cp -r "$path" ~/.config/obsidian_config_manager/main_config/.obsidian/ || (echo -e "${C_RED}Error: invalid path${NO_FORMAT}" && clean 1)
else
  echo -e "${C_RED}Error: invalid source${NO_FORMAT}"
  clean 1
fi