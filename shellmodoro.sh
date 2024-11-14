#!/usr/bin/env sh

# Default duration (25 minutes in seconds)
DEFAULT_DURATION=$((25 * 60))
# Log file location
LOG_FILE="$HOME/pomodoro_log.txt"
# Version of the script
VERSION="1.0.1"

# Get the current timestamp in RFC3339 format with timezone
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%S%Z")

# Variable to track if no notification utility is found
no_notification_utility=false

# Function to display help information
show_help() {
  printf "Shellmodoro - A Pomodoro timer script for macOS and Linux\n"
  printf "\n"
  printf "\033[1;31m   ___\033[1;32mv\033[1;31m___\033[0m\n"
  printf "\033[1;31m  / \033[1;33m    /\033[1;31m \\ \033[0m\n"
  printf "\033[1;31m /  \033[1;33m   /  \033[0m\033[1;31m \\ \n"
  printf "\033[1;31m|   \033[1;33m  ----\033[0m\033[1;31m  |\n"
  printf "\033[1;31m \\ \033[1;31m       \033[0m\033[1;31m /\n"
  printf "\033[1;31m  \\_______/\033[0m\n"
  printf "\n"
  printf "Usage: ./shellmodoro.sh [options] [duration in minutes] [notes]\n"
  printf "\n"
  printf "Options:\n"
  printf "  -h, --help             Show this help message and exit.\n"
  printf "  -l, --log              Show the log of previous Pomodoro sessions.\n"
  printf "  -v, --version          Show the version of the script.\n"
  printf "\n"
  printf "Arguments:\n"
  printf "  duration in minutes    Optional. Set a custom Pomodoro duration (default is 25 minutes).\n"
  printf "  notes                  Optional. Any notes or comments you want to log for this Pomodoro session.\n"
  printf "\n"
  printf "Example:\n"
  printf "  ./shellmodoro.sh 30 \"Worked on project documentation\"\n"
  printf "\n"
  printf "This will start a 30-minute Pomodoro timer and log the session with a timestamp and provided notes.\n"
  printf "\n"
  printf "===========================================\n"
  printf "\n"
  printf "Created by 5mdt team https://github.com/5mdt/shellmodoro\n"
  printf "\n"
}

# Function to show the Pomodoro log
show_log() {
  if [ -f "$LOG_FILE" ]; then
    printf "Pomodoro Log:\n"
    cat "$LOG_FILE"
  else
    printf "No log entries found. Start a Pomodoro session to create the log.\n"
  fi
}

# Function to show the version of the script
show_version() {
  printf "Shellmodoro version %s\n" "$VERSION"
}

# Function to send notifications based on the OS and availability of the notification utilities
send_notification() {
  title=$1
  message=$2

  # Check if Dunst is available on Linux
  if command -v dunstify >/dev/null 2>&1; then
    dunstify "$title" "$message"
  # Check if notify-send is available on Linux (fallback if Dunst is not found)
  elif command -v notify-send >/dev/null 2>&1; then
    notify-send "$title" "$message"
  # Check if osascript is available on macOS
  elif command -v osascript >/dev/null 2>&1; then
    osascript -e "display notification \"$message\" with title \"$title\""
  else
    # If no notification utility is found, set the flag to true
    no_notification_utility=true
    printf "No suitable notification utility found.\n"
  fi
  printf "%s %s\n" "$title" "$message"
}

# Function to ring the terminal bell
ring_bell() {
  if [ "$no_notification_utility" = true ]; then
    printf "\a"  # ASCII Bell
  fi
}

# Parse arguments for help, log display, or version
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  show_help
  exit 0
elif [ "$1" = "-l" ] || [ "$1" = "--log" ]; then
  show_log
  exit 0
elif [ "$1" = "-v" ] || [ "$1" = "--version" ]; then
  show_version
  exit 0
fi

# Set default duration and parse the duration argument if provided
if [ -n "$1" ] && [ "$1" != "-l" ] && [ "$1" != "--log" ] && [ "$1" != "-v" ] && [ "$1" != "--version" ]; then
  DURATION=$(( $1 * 60 ))  # Convert minutes to seconds
  shift  # Remove the first argument (duration)
else
  DURATION=$DEFAULT_DURATION  # Default to 25 minutes if no argument is provided
fi

DURATION_MINUTES=$(( DURATION / 60 ))  # For notifications in minutes
EXTRA_INFO="$@"  # Remaining arguments as notes

# Notify the user that the Pomodoro timer is starting
send_notification "Pomodoro Started" "Focus for $DURATION_MINUTES minutes!"

# Start the timer (countdown)
sleep $DURATION

# Notify the user that the Pomodoro session is complete
send_notification "Pomodoro Complete" "Take a break!"

# Ring the terminal bell if no notification utility was found
ring_bell

# Log the Pomodoro session with timestamp and any additional notes
printf "%s - Completed %d-minute Pomodoro. Notes: %s\n" "$TIMESTAMP" "$DURATION_MINUTES" "$EXTRA_INFO" >> "$LOG_FILE"
