#!/bin/zsh

autoload colors
colors

#check if source and destination paths are provided
if [[ $# < 2 ]]; then
  echo $fg[red]"Error: source and destination paths are required"$reset_color
  exit 1
elif [[ $# > 2 ]]; then
  echo $fg[red]"Error: too many arguments"$reset_color
  exit 1
fi


#check source path is valid
check_dir_path() {
  path=$1
  name=$2
  if [[ ! -e $path ]]; then
    echo $fg[red]"Error: invalid path for $name"$reset_color
    exit 1
  elif [[ ! -d $path ]]; then
    echo $fg[red]"Error: $name is not a directory"$reset_color
    exit 1
  fi
}

check_dir_path "$1" "source"
check_dir_path "$2" "destination"


