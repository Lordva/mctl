#!/bin/bash

PKG="mctl"
GIT_URL="https://github.com/lordva/mctl"
INSTALL_DIR="/opt/mctl"

RESET="\033[0m"         # Normal color
RED="\033[0;31m"        # Errors
GREEN="\033[0;32m"      # Sucess
BOLD="\033[1;01m"

install(){
  echo "[ - ] INSTALLING MCTL FROM GIT:"
  if [ -e "${INSTALL_DIR}" ]; then
    echo "${PKG} is already installed"
    echo "Updating ${PKG} from git"
    command git --git-dir="${INSTALL_DIR}/.git" fetch || echo >&2 "Failed to fetch" ; exit 1
    command git --git-dir="${INSTALL_DIR}/.git" reset || echo >&2 "failed to reset" ; exit 1
  else
    echo "[ - ]Dowloading ${PKG} from git to ${INSTALL_DIR}"
    command git clone ${GIT_URL} ${INSTALL_DIR} || echo >&2 "[${RED}✕${RESET}]Failed to clone";
    echo "Setting permissions..."
    sudo chmod -R 755 ${INSTALL_DIR}/servers
    sudo chmod 755 ${INSTALL_DIR}/mctl
    echo "Adding Mctl to PATH"
    sudo ln -sf ${INSTALL_DIR}/mctl /usr/local/bin/mctl
  fi
}

# Uninstall script will not delete any files to prevent exploit of the rm -rf command and will just move mctl to a .old folder
uninstall(){
  if [ ! -e "${INSTALL_DIR}" ]; then
    echo "Error: Mctl is not installed"
    exit 1
  fi
  echo "Confirm you want to UNINSTALL Mctl [y/n]: "
  read -r -p "> " input
  case $input in
    y | yes | Y | YES ) echo "Uninstalling Mctl";;
    * ) echo "Abort." & exit 0
  esac
  echo "Removing files in ${INSTALL_DIR}"
  command sudo mv ${INSTALL_DIR} /opt/.old || echo >&2 "Failed to move ${INSTALL_DIR} to /opt/.old"
  command sudo unlink /usr/local/bin/mctl || echo >&2 "Failed to remove softlink at /usr/local/bin/mctl"
}

check_requirements(){
  echo "- Cheking for Git:"
  if ! git --version 2>&1 > /dev/null; then
    echo >&2 "Failed to install, git is needed for installation"
    exit 1
  fi
  echo "OK"
  echo "- Checking for TMUX:"
  if ! tmux -V 2>&1 > /dev/null; then
    echo >&2 -e "[${RED}✕${RESET}]Error tmux is needed for mctl to work"
    exit 1
  fi
  echo  "OK"
  echo -e"[${GREEN}✔${RESET}] Requirements are installed"
}

if [ $1 = "-r" || $1 = "--remove" ]]; then
  uninstall
  exit 0
fi

if [ $1 = "-h" || $1 = "--help" ]; then
  echo "usage: bash install.sh [option]"
  echo ""
  echo "options:"
  echo "-h --help         Display this message"
  echo "-r --remove       Uninstall mctl"
  echo ""
  echo "run install.sh to INSTALL mctl."
  echo "run install.sh --remove to UNINSTALL mctl"
  exit 0
fi

echo "[ - ] Cheking for requirements..."
check_requirements
#install

if [ -f "${INSTALL_DIR}/mctl" ]; then
  echo
  echo "[${GREEN}✔]Done!${RESET}"
  exit 0
else
  echo >&2
  echo >&2 "Error on installation, ${INSTALL_DIR}/mctl not found"
  echo >&2
  exit 1
fi
