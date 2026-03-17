#!/bin/bash

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "=============================="
echo "   SYSTEM HEALTH REPORT"
echo "   $(date)"
echo "=============================="
echo ""

# CPU Usage
CPU=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | tr -d '%')
echo -e "💻 CPU Usage     : ${GREEN}${CPU}%${NC}"

# Memory
MEM_USED=$(vm_stat | grep "Pages active" | awk '{print $3}' | tr -d '.')
MEM_USED_GB=$(echo "scale=1; $MEM_USED * 4096 / 1024 / 1024 / 1024" | bc)
echo -e "🧠 RAM Used      : ${GREEN}${MEM_USED_GB} GB${NC}"

# Disk
DISK_USED=$(df -h / | tail -1 | awk '{print $3}')
DISK_TOTAL=$(df -h / | tail -1 | awk '{print $2}')
DISK_AVAIL=$(df -h / | tail -1 | awk '{print $4}')
echo -e "💾 Disk Used     : ${GREEN}${DISK_USED} / ${DISK_TOTAL} (${DISK_AVAIL} free)${NC}"

# Running Processes
PROCS=$(ps aux | wc -l)
echo -e "⚙️  Running Apps  : ${GREEN}${PROCS}${NC}"

# Uptime
UPTIME=$(uptime | awk '{print $3, $4}' | tr -d ',')
echo -e "⏱️  Uptime        : ${GREEN}${UPTIME}${NC}"

# Network
ping -c 1 google.com &> /dev/null
if [ $? -eq 0 ]; then
    echo -e "🌐 Network       : ${GREEN}Connected ✅${NC}"
else
    echo -e "🌐 Network       : ${RED}Disconnected ❌${NC}"
fi

echo ""
echo "=============================="
echo -e "${GREEN}Health check complete! ${NC}"
echo "=============================="


REPORT=~/devops/notes/health_$(date +%Y%m%d_%H%M%S).txt
echo "Health check ran at $(date)" > $REPORT
echo "CPU: ${CPU}% | Disk Used: ${DISK_USED}/${DISK_TOTAL} | Uptime: ${UPTIME}" >> $REPORT
echo "Report saved to: $REPORT"
