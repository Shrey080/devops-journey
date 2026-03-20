#!/bin/bash

# ── FUNCTIONS ──

# Function 1 — simple greeting
greet() {
    echo "Hello $1! Welcome to DevOps!"
}

# Function 2 — check if a site is up
check_site() {
    local SITE=$1
    local STATUS=$(curl -s -o /dev/null -w "%{http_code}" --max-time 5 "$SITE")
    if [ "$STATUS" -eq 200 ] || [ "$STATUS" -eq 301 ]; then
        echo "✅ $SITE is UP ($STATUS)"
    else
        echo "❌ $SITE is DOWN ($STATUS)"
    fi
}

# Function 3 — print a divider line
divider() {
    echo "=============================="
}

# ── CALL THE FUNCTIONS ──
divider
greet "Shreyansh"
divider
check_site "https://google.com"
check_site "https://github.com"
divider
