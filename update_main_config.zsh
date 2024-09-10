#!/bin/bash


NO_FORMAT="\033[0m"
C_RED="\033[38;5;9m"
C_YELLOW="\033[38;5;11m"

path_to_config_manager="$( dirname -- "$( readlink -f -- "$0"; )"; )"
working_dir="$(pwd)"

source=$1
destination=$2


#check too many arguments
if [[ $# -gt 1 ]]; then
  echo -e "${C_RED}Error: too many arguments${NO_FORMAT}"
  exit 1
fi

#check if source path is provided
if [[ $# -ne 1 ]]; then
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

if [[ ! -e "${path_to_config_manager}/main_config/.obsidian/" ]]; then
  rm -rf "${path_to_config_manager}/main_config/.obsidian"
fi

cp -r "$1/.obsidian" "${path_to_config_manager}/main_config/.obsidian"
rm "/Users/saxophonin/Personal/programming/obsidian_config_manager/main_config/.obsidian/workspace.json"
touch "/Users/saxophonin/Personal/programming/obsidian_config_manager/main_config/.obsidian/workspace.json"


#manage git for main_config
cd "${path_to_config_manager}"
git reset
git add main_config/.obsidian
git commit -m "update main_config at $(date) from $1"

echo "Do you want to push the changes to the remote repository? (y/n)"
read answer
if [[ $answer == "y" ]]; then
  git push origin main
fi
