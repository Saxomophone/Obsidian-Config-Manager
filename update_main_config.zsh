#!/bin/bash

NO_FORMAT="\033[0m"
C_RED="\033[38;5;9m"
C_YELLOW="\033[38;5;11m"


source=$1
destination=$2


#check too many arguments
if [[ $# -gt 1 ]]; then
  echo -e "${C_RED}Error: too many arguments${NO_FORMAT}"
  exit 1
fi

#check if source path is provided
if [[ $# -ne ]] 1; then
  echo -e "${C_RED}Error: source path is required${NO_FORMAT}"
  exit 1
fi


#check source path is valid
check_dir_path() {
  path=$1
  name=$2
  if [[ ! -e $path ]]; then
    echo -e "${C_RED}Error: $name does not exist${NO_FORMAT}"
    exit 1
  elif [[ ! -d $path ]]; then
    echo -e "${C_RED}Error: $name is not a directory${NO_FORMAT}"
    exit 1
  fi
}

check_dir_path "$1" "source"


if [[ ! -e "$1/.obsidian" ]]; then
  echo -e "${C_RED}Error: source directory does not contain .obsidian folder${NO_FORMAT}"
  exit 1
fi


rm -rf "/Users/saxophonin/Personal/programming/obsidian_config_manager/main_config/.obsidian"
cp -r "$1/.obsidian" "/Users/saxophonin/Personal/programming/obsidian_config_manager/main_config"
rm "/Users/saxophonin/Personal/programming/obsidian_config_manager/main_config/.obsidian/workspace.json"
touch "/Users/saxophonin/Personal/programming/obsidian_config_manager/main_config/.obsidian/workspace.json"