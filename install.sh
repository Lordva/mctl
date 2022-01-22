#!/bin/bash

PKG="mctl"
GIT_URL="https://github.com/lordva/mctl"
INSTALL_DIR="/usr/local/mctl"

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
    chmod -R 755 ${INSTALL_DIR}/servers
    chmod 755 ${INSTALL_DIR}/mctl
    echo "Adding Mctl to PATH"
    sudo ln -sf ${INSTALL_DIR}/mctl /usr/local/bin/mctl
  fi
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

echo -e "[ - ] Cheking for requirements..."
check_requirements
install

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
