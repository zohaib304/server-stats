# Server Stats Script

A lightweight Bash script to show quick server health information from the command line.

The script (`stats.sh`) prints:
- Current date/time
- Total CPU usage
- Memory usage (used, free, percentage)
- Root disk usage
- Top 5 processes by CPU
- Top 5 processes by memory

## File

- `stats.sh` — main script

## Requirements

- Bash shell
- Standard system tools (`top`, `awk`, `df`, `ps`, etc.)
- Supported OS:
  - Linux
  - macOS (Darwin)

## Usage

From the `server-stats` folder:

```bash
chmod +x stats.sh
./stats.sh
```

If executable permissions are already set, run only:

```bash
./stats.sh
```

## Example Output Sections

When you run the script, output includes sections like:

- `===== Server Stats =====`
- `Total CPU Usage: ...%`
- `Memory Usage:`
- `Disk Usage:`
- `Top 5 Processes by CPU:`
- `Top 5 Processes by Memory:`

## Notes

- CPU and memory calculations are OS-specific and handled separately for Linux and macOS.
- On macOS, memory is derived from `vm_stat` and `sysctl` values.
- Disk usage is reported for the root filesystem (`/`).

## Troubleshooting

- **Permission denied**: run `chmod +x stats.sh`
- **Command not found**: ensure required system tools are available in your PATH
- **Unexpected values**: run the script again after a few seconds; process and CPU values are point-in-time snapshots
