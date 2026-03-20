#!/bin/bash

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Websites to monitor
SITES=(
    "https://google.com"
    "https://github.com"
    "https://example.com"
    "https://amazon.com"
)

UP=0
DOWN=0

echo "=============================="
echo "   WEBSITE MONITOR REPORT"
echo "   $(date)"
echo "=============================="
echo ""

for SITE in "${SITES[@]}"; do
    START=$(date +%s%N)
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" --max-time 5 "$SITE")
    END=$(date +%s%N)
    TIME=$(( (END - START) / 1000000 ))ms

    if [ "$STATUS" -eq 200 ] || [ "$STATUS" -eq 301 ] || [ "$STATUS" -eq 302 ]; then
        echo -e "✅ ${GREEN}$SITE${NC} → $STATUS OK (${TIME})"
        UP=$((UP + 1))
    else
        echo -e "❌ ${RED}$SITE${NC} → UNREACHABLE! (Status: $STATUS)"
        DOWN=$((DOWN + 1))
    fi
done

echo ""
echo "=============================="
echo -e "📊 ${GREEN}$UP sites UP${NC} | ${RED}$DOWN sites DOWN${NC}"
echo "=============================="

# Save report
REPORT=~/devops/notes/webmonitor_$(date +%Y%m%d_%H%M%S).txt
echo "Web Monitor Report - $(date)" > $REPORT
echo "UP: $UP | DOWN: $DOWN" >> $REPORT
for SITE in "${SITES[@]}"; do
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" --max-time 5 "$SITE")
    echo "$SITE → $STATUS" >> $REPORT
done
echo "Report saved to: $REPORT"
