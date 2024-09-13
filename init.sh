#!/bin/bash

NO_FORMAT="\033[0m"
C_RED="\033[38;5;9m"
C_YELLOW="\033[38;5;11m"
C_GREEN="\033[38;5;10m"

function clean() {
  rm -rf ~/.config/obsidian_config_manager/
  exit $1
}


trap "clean 1" SIGINT # clean up if user exits with ctrl-c

# if ~/.config/obsidian_config_manager does not exist, create it
if [[ ! -e ~/.config/obsidian_config_manager ]]; then
  mkdir -p ~/.config/obsidian_config_manager/main_config/.obsidian/
elif [[  -e ~/.config/obsidian_config_manager/main_config ]]; then
  echo -e "${C_YELLOW}~/.config/obsidian_config_manager already exists${NO_FORMAT}"
  echo -e "If you want to update the main_config, run the update_main_config.zsh script"  # NOTE: change update_main_config.zsh to whatever command is later
  read -p "Do you want to overwrite the main_config? (y/n) " -r
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf ~/.config/obsidian_config_manager/main_config
    mkdir -p ~/.config/obsidian_config_manager/main_config/.obsidian/    # if the user wants to overwrite the main_config, delete the old one and create a new one
    echo -e "\n\n"
  else
    exit 0 # not an error, just exiting. also shoudln't clean
  fi
fi


while true; do
  echo -e "Where do you want to pull the main_config from? (Github: g, Local: l, Leave Blank: b)"
  read source

  case $source in
    g)
      echo -e "Enter the github url of the main_config .osbidian folder"
      read github_url
      git clone $github_url ~/.config/obsidian_config_manager/main_config/.obsidian/ > /dev/null 2>&1 || { echo -e "${C_RED}Error: invalid github url${NO_FORMAT}"; clean 1; }
      echo -e "${C_GREEN}Successfully pulled main config from github${NO_FORMAT}"
      break
      ;;


    l)
      read -ep "Enter the path to the main_config: " path
      abs_path=$(realpath $path)
      cp -R "$abs_path/." "/Users/saxophonin/.config/obsidian_config_manager/main_config/.obsidian/" || { echo -e "${C_RED}Error: invalid path${NO_FORMAT}"; clean 1; }
      break
      ;;


    b)
      sleep 0.5
      echo -e "\n${C_YELLOW}Warning: you will not be able to pull from the main config until you set it up${NO_FORMAT}"
      read -p "Do you want to continue? (y/n) " -r
      echo
      if [[ $REPLY =~ ^[Yy]$ ]]; then
        break
      else
        clean 1
      fi
      ;;


    *)
      echo -e "${C_RED}Error: invalid source${NO_FORMAT}"
      clean 1
      ;;
  esac
done 



# clean 1 # remove this line when the script is complete