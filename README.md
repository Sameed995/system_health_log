# System Health Monitor

A lightweight Bash script that reports CPU, memory, disk, and uptime stats in a color-coded terminal display and appends a timestamped entry to a log file.

## Usage

```bash
chmod +x system_health.sh
./system_health.sh
```

## Sample Output

```
==============================
 System Health Monitor
 2026-05-28 14:32:10
==============================
 CPU Usage  : 23%
 Memory     : 1024MB / 8192MB (12%)
 Disk (/)   : 45G / 200G (22%)
 Uptime     : up 3 hours, 12 minutes
==============================
 Logged to system_health.log
```

Metrics exceeding their thresholds are highlighted in **red**; values within safe limits appear in **green**.

## Thresholds

| Metric | Warning Threshold |
|--------|------------------|
| CPU    | ≥ 80%            |
| Memory | ≥ 85%            |
| Disk   | ≥ 90%            |

## Log File

Each run appends a single line to `system_health.log` in the same directory:

```
[2026-05-28 14:32:10] CPU: 23% | MEM: 12% | DISK: 22% | up 3 hours, 12 minutes
```

## Requirements

- Bash 4+
- Standard Linux utilities: `top`, `free`, `df`, `uptime`, `awk`

## Configuration

Edit the variables at the top of the script to adjust thresholds or the log file path:

```bash
LOG_FILE="system_health.log"
CPU_THRESHOLD=80
MEM_THRESHOLD=85
DISK_THRESHOLD=90
```

## Automating with Cron

To run every 5 minutes and keep a continuous log:

```bash
*/5 * * * * /path/to/system_health.sh
```