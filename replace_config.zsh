#!/bin/bash

NO_FORMAT="\033[0m"
C_RED="\033[38;5;9m"
C_YELLOW="\033[38;5;11m"


source=$1
destination=$2

#check if source and destination paths are provided
if [[ $# < 2 ]]; then
  echo -e "${C_RED}Error: source and destination paths are required${NO_FORMAT}"
  exit 1
elif [[ $# > 2 ]]; then
  echo -e "${C_RED}Error: too many arguments${NO_FORMAT}"
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
check_dir_path "$2" "destination"

if [[ ! -e "$1/.obsidian" ]]; then
  echo -e "${C_RED}Error: source directory does not contain .obsidian folder${NO_FORMAT}"
  exit 1
fi

if [[ ! -e "$2/.obsidian" ]]; then
  echo -e "${C_YELLOW}Creating .obsidian folder in destination directory${NO_FORMAT}"
  mkdir "$2/.obsidian"
fi

rm -rf "$2/.obsidian"
cp -r "$1/.obsidian" "$2"
rm "$2/.obsidian/workspace.json"
touch "$2/.obsidian/workspace.json"