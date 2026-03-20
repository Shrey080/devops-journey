#!/bin/bash

# ══════════════════════════════════
#   MASTER MONITOR — Shreyansh DevOps
#   Combines: System Health + Website Monitor
# ══════════════════════════════════

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Sites to monitor
SITES=(
    "https://google.com"
    "https://github.com"
    "https://example.com"
    "https://amazon.com"
)

# ── FUNCTIONS ──

divider() {
    echo "══════════════════════════════════"
}

header() {
    divider
    echo -e "  ${BLUE}$1${NC}"
    divider
}

check_system() {
    header "🖥️  SYSTEM HEALTH"
    echo ""

    # CPU
    CPU=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | tr -d '%')
    CPU_INT=${CPU%.*}
    if [ "$CPU_INT" -gt 80 ]; then
        echo -e "💻 CPU      : ${RED}${CPU}% ⚠️  HIGH${NC}"
    else
        echo -e "💻 CPU      : ${GREEN}${CPU}% ✅${NC}"
    fi

    # RAM
    MEM=$(vm_stat | grep "Pages active" | awk '{print $3}' | tr -d '.')
    MEM_GB=$(echo "scale=1; $MEM * 4096 / 1024 / 1024 / 1024" | bc)
    echo -e "🧠 RAM      : ${GREEN}${MEM_GB} GB${NC}"

    # Disk
    DISK_PCT=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
    DISK_USED=$(df -h / | tail -1 | awk '{print $3}')
    DISK_TOTAL=$(df -h / | tail -1 | awk '{print $2}')
    if [ "$DISK_PCT" -gt 80 ]; then
        echo -e "💾 Disk     : ${RED}${DISK_USED}/${DISK_TOTAL} ⚠️  HIGH${NC}"
    else
        echo -e "💾 Disk     : ${GREEN}${DISK_USED}/${DISK_TOTAL} ✅${NC}"
    fi

    # Uptime
    UPTIME=$(uptime | awk '{print $3, $4}' | tr -d ',')
    echo -e "⏱️  Uptime   : ${GREEN}${UPTIME}${NC}"
    echo ""
}

check_websites() {
    header "🌐  WEBSITE STATUS"
    echo ""
    local UP=0
    local DOWN=0

    for SITE in "${SITES[@]}"; do
        STATUS=$(curl -s -o /dev/null -w "%{http_code}" --max-time 5 "$SITE")
        if [ "$STATUS" -eq 200 ] || [ "$STATUS" -eq 301 ] || [ "$STATUS" -eq 302 ]; then
            echo -e "  ✅ ${GREEN}$SITE${NC} → $STATUS"
            UP=$((UP + 1))
        else
            echo -e "  ❌ ${RED}$SITE${NC} → UNREACHABLE"
            DOWN=$((DOWN + 1))
        fi
    done

    echo ""
    echo -e "  📊 ${GREEN}$UP UP${NC} | ${RED}$DOWN DOWN${NC}"
    echo ""
}

save_report() {
    REPORT=~/devops/notes/master_$(date +%Y%m%d_%H%M%S).txt
    echo "Master Monitor Report - $(date)" > $REPORT
    echo "CPU: $CPU% | RAM: ${MEM_GB}GB | Disk: ${DISK_USED}/${DISK_TOTAL}" >> $REPORT
    echo "Sites checked: ${#SITES[@]}" >> $REPORT
    echo -e "📁 Report saved: ${YELLOW}$REPORT${NC}"
}

# ── MAIN ──
clear
echo ""
echo -e "${BLUE}  🚀 MASTER MONITOR v1.0 — $(date)${NC}"
echo ""
check_system
check_websites
save_report
divider
echo -e "  ${GREEN}All checks complete!${NC}"
divider
echo ""
