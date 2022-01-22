## Introduction

**Mctl** is a CLI that allow you to control a Minecraft server running on linux, Mctl allows you to start, stop or restart the server but also allows you to display and send a command to the console.

it is designed as a replacement for the usual UNIT files used to handle Minecraft instances.
mctl currently only support a single Minecraft server but will in the future be compatible with multiple Minecraft instances.

## Installation

Installing Mctl is very easy, just run:
```bash
sh -c "$(curl -fsSL https://raw.github.com/lordva/mctl/master/tools/install.sh)"
```

to install Mctl from source you first need to clone the repo:

```bash
git clone https://github.com/lordva/mctl
cd mclt
```
then execute the script :
```bash
bash mctl.sh
```

## Usage

this chapter describe the expected behaviour of mctl:
