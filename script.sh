#!/bin/bash

# System Health Monitor - logs CPU, memory, disk, and uptime stats

LOG_FILE="system_health.log"
DATE=$(date "+%Y-%m-%d %H:%M:%S")

# Thresholds for warning
CPU_THRESHOLD=80
MEM_THRESHOLD=85
DISK_THRESHOLD=90

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Gather Stats 
cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d'.' -f1)
cpu_usage=$((100 - cpu_idle))

mem_total=$(free -m | awk '/^Mem:/ {print $2}')
mem_used=$(free -m | awk '/^Mem:/ {print $3}')
mem_pct=$(awk "BEGIN {printf \"%.0f\", ($mem_used/$mem_total)*100}")

disk_used=$(df -h / | awk 'NR==2 {print $3}')
disk_total=$(df -h / | awk 'NR==2 {print $2}')
disk_pct=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

uptime_info=$(uptime -p)

# Display valeus
echo "=============================="
echo " System Health Monitor"
echo " $DATE"
echo "=============================="

# CPU
[ "$cpu_usage" -ge "$CPU_THRESHOLD" ] && COLOR=$RED || COLOR=$GREEN
echo -e " CPU Usage  : ${COLOR}${cpu_usage}%${NC}"

# Memory
[ "$mem_pct" -ge "$MEM_THRESHOLD" ] && COLOR=$RED || COLOR=$GREEN
echo -e " Memory     : ${COLOR}${mem_used}MB / ${mem_total}MB (${mem_pct}%)${NC}"

# Disk
[ "$disk_pct" -ge "$DISK_THRESHOLD" ] && COLOR=$RED || COLOR=$GREEN
echo -e " Disk (/)   : ${COLOR}${disk_used} / ${disk_total} (${disk_pct}%)${NC}"

# Uptime
echo " Uptime     : $uptime_info"
echo "=============================="

# --- Log to file ---
echo "[$DATE] CPU: ${cpu_usage}% | MEM: ${mem_pct}% | DISK: ${disk_pct}% | $uptime_info" >> "$LOG_FILE"
echo " Logged to $LOG_FILE"
