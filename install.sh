#!/bin/sh
trap cleanup INT

set -e

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

function cleanup() {
  println "Exiting..."
  exit 1
}

function println() {
  printf "\n%s\n" "$1"
}

mkdir -p "$HOME/Development"

function install_dotfiles() {
  for file in "$parent_path/".*; do
    if [ "$file" == "$parent_path/." ]; then
      continue
    fi

    if [ "$file" == "$parent_path/.." ]; then
      continue
    fi

    if [ "$file" == "$parent_path/.git" ]; then
      continue
    fi

    local sym_file_name="$( basename $file )" 
    local sym="$parent_path/$sym_file_name"

    if [ ! -e $sym ]; then
      # file doesn't already exist
      ln -s "$file" "$sym"
    fi

    while true; do
      read -p "$sym already exists. Do you want to overwrite it? " yn
       case $yn in
         [Yy]* ) ln -sf "$file" "$sym"; break;;
         [Nn]* ) break;;
         * ) echo "Please answer yes or no.";;
       esac
    done
  done
}

println "Installing dotfiles..."
install_dotfiles

exit 0
