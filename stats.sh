#!/bin/bash

echo "===== Server Stats ====="
echo "Date: $(date)"
echo

OS=$(uname)

#################################
# CPU USAGE
#################################
if [ "$OS" = "Linux" ]; then
    cpu=$(top -bn1 | awk '/Cpu\(s\)/ {print 100 - $8}')
elif [ "$OS" = "Darwin" ]; then
    cpu=$(top -l 1 | awk '/CPU usage/ {print $3 + $5}')
fi

echo "Total CPU Usage: $cpu%"
echo

#################################
# MEMORY USAGE
#################################
if [ "$OS" = "Linux" ]; then
    total=$(free -m | awk '/Mem:/ {print $2}')
    used=$(free -m | awk '/Mem:/ {print $3}')
    free=$(free -m | awk '/Mem:/ {print $4}')
elif [ "$OS" = "Darwin" ]; then
    total=$(($(sysctl -n hw.memsize) / 1024 / 1024))
    free_pages=$(vm_stat | awk '/Pages free/ {gsub("\\.",""); print $3}')
    inactive_pages=$(vm_stat | awk '/Pages inactive/ {gsub("\\.",""); print $3}')
    page_size=$(sysctl -n hw.pagesize)
    free=$(( (free_pages + inactive_pages) * page_size / 1024 / 1024 ))
    used=$((total - free))
fi

mem_percent=$(awk "BEGIN {printf \"%.2f\", ($used/$total)*100}")

echo "Memory Usage:"
echo "Used: ${used}MB"
echo "Free: ${free}MB"
echo "Usage: ${mem_percent}%"
echo

#################################
# DISK USAGE
#################################
disk=$(df -h / | awk 'NR==2 {print $3 " used / " $4 " free (" $5 " used)"}')

echo "Disk Usage:"
echo "$disk"
echo

#################################
# TOP CPU PROCESSES
#################################
echo "Top 5 Processes by CPU:"
if [ "$OS" = "Linux" ]; then
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
else
    ps -Ao pid,comm,%cpu | sort -k3 -nr | head -n 6
fi

echo

#################################
# TOP MEMORY PROCESSES
#################################
echo "Top 5 Processes by Memory:"
if [ "$OS" = "Linux" ]; then
    ps -eo pid,comm,%mem --sort=-%mem | head -n 6
else
    ps -Ao pid,comm,%mem | sort -k3 -nr | head -n 6
fi