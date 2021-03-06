# A sample config file for a server

# The server name, this value will be used by mctl to call the server
SERVER_NAME=survival

# The server base directory path
SERVER_PATH=/srv/mc/survival

# The server executable name
SERVER_FILE="server.jar"

# The command the server is to be started with
# If you have a custom script like start.sh just put the absolute path of the script here
SERVER_START_COMMAND="/usr/bin/java -Xms2G -Xmx8G -jar ${SERVER_FILE} nogui"

#The name of the tmux session for the console output this HAS TO BE UNIQUE or else the progam will not work
TMUX_SESSION_NAME="survival"

#The user running the minecraft process
MINECRAFT_USER="minecraft"