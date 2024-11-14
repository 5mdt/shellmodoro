# Shellmodoro - A Pomodoro Timer Script

Shellmodoro is a simple Pomodoro timer script written in `sh` (Bash-compatible). It allows you to focus on tasks by setting a timer for work intervals (Pomodoros) and automatically reminds you when it's time to take a break. It works on both macOS and Linux, using native notification utilities for notifications and the terminal bell when no notification utility is available.

## Features

- Set a Pomodoro timer with a default duration of 25 minutes (customizable).
- Logs completed Pomodoro sessions with timestamps and notes.
- Supports notifications via `dunst`, `notify-send`, or `osascript`.
- Rings the terminal bell when no notification utility is found.
- View and manage your Pomodoro log.

## Installation

1. Clone the repository or download the script to your local machine.

   ```bash
   git clone https://github.com/your-username/shellmodoro.git
   ```

2. Make the script executable:

   ```bash
   chmod +x shellmodoro.sh
   ```

## Usage

### Start a Pomodoro Session

Run the script with an optional duration (in minutes) and notes.

```bash
./shellmodoro.sh [duration in minutes] [notes]
```

If no duration is provided, it defaults to 25 minutes.

**Example 1**: Start a 30-minute Pomodoro with notes:

```bash
./shellmodoro.sh 30 "Worked on project documentation"
```

**Example 2**: Start the default 25-minute Pomodoro without notes:

```bash
./shellmodoro.sh
```

### View the Pomodoro Log

To see a log of your past Pomodoro sessions, use the `-l` or `--log` option:

```bash
./shellmodoro.sh -l
```

### Show Help

To display the help message, use the `-h` or `--help` option:

```bash
./shellmodoro.sh -h
```

### Show Version

To see the script version, use the `-v` or `--version` option:

```bash
./shellmodoro.sh -v
```

## Notification Utilities

The script automatically sends notifications using one of the following utilities:

- **Dunst** (Linux)
- **notify-send** (Linux, fallback if Dunst is not available)
- **osascript** (macOS)

If no notification utility is found, the script will ring the terminal bell instead.

## Configuration

- **Default Duration**: The default Pomodoro duration is set to 25 minutes. You can override this by specifying a duration in minutes when running the script.

- **Log File**: The log of completed Pomodoros is saved in a file located at `$HOME/pomodoro_log.txt`.

## Example Output

After starting a Pomodoro session, the script will notify you that the timer has started and will log your session once completed:

```text
Pomodoro Started: Focus for 25 minutes!
Pomodoro Complete: Take a break!
```

After completion, the log file will contain an entry like:

```text
2024-11-14T12:30:00UTC - Completed 25-minute Pomodoro. Notes: Worked on project documentation
```

## License

This project is licensed under the AGPL v3 License - see the [LICENSE](LICENSE) file for details.

## Contribution

Feel free to fork this repository, make improvements, and submit pull requests. If you have any feature requests or bug reports, please open an issue.
