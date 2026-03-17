


#!/bin/bash
echo "=============="
echo " SYSTEM INFO - $(date)"
echo "=============="
echo ""
echo "user : $(whoami)"
echo " folder : $(pwd)"
echo " Machine :$(hostname) "
echo " uptime : $(uptime | awk '{print $3, $4}' | tr -d ',')"
echo ""
echo "=============="
echo "Disk & Memory"
echo "============="
echo ""
df -h /
echo ""
echo "scripts complted"
