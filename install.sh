#!/bin/bash

PKG="mctl"
GIT_URL="https://github.com/lordva/mctl"
INSTALL_DIR="/usr/local/mctl"

install(){
  if [ -e "${INSTALL_DIR}" ]; then
    echo "${PKG} is already installed"
    echo "Updating ${PKG} from git"
    command git --git-dir="${INSTALL_DIR}/.git" fetch || echo >&2 "Failed to fetch" ; exit 1
    command git --git-dir="${INSTALL_DIR}/.git" reset || echo >&2 "failed to reset" ; exit 1
  else
    echo "Dowloading ${PKG} from git to ${INSTALL_DIR}"
    command git clone ${GIT_URL} ${INSTALL_DIR} || echo >&2 "Failed to clone"; exit 1
    chmod -R 755 ${INSTALL_DIR}/servers 
    chmod 755 ${INSTALL_DIR}/mctl
    sudo ln -sf ${INSTALL_DIR}/mctl /usr/local/bin/mctl
  fi
}

if git --version; then
  install;
else
  echo >&2 "Failed to install, git is needed for installation"
fi

if [ -f "${INSTALL_DIR}/mctl" ]; then
  echo
  echo "Done!"
  exit 0
else
  echo >&2
  echo >&2 "Error on installation, ${INSTALL_DIR}/mctl not found"
  echo >&2
  exit 1
fi
