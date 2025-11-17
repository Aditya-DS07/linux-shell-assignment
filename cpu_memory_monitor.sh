#!/bin/bash

# Script Name: monitor.sh
# Usage: ./monitor.sh [interval_seconds] [duration_minutes]

DEFAULT_INTERVAL=5
DEFAULT_DURATION=1  # Keep this short for testing

INTERVAL=${1:-$DEFAULT_INTERVAL}
DURATION=${2:-$DEFAULT_DURATION}

LOG_FILE="$HOME/system_monitor.log"

# Calculate how many times to loop
TOTAL_CHECKS=$(( (DURATION * 60) / INTERVAL ))

echo "Starting Monitoring..."
echo "Log file: $LOG_FILE"
echo "Duration: $DURATION min | Interval: $INTERVAL sec"

# Create Log Header
echo "--- System Monitor Log Started: $(date) ---" > "$LOG_FILE"

COUNT=0
while [ $COUNT -lt $TOTAL_CHECKS ]; do
    COUNT=$((COUNT + 1))
    
    # Get Data
    TIMESTAMP=$(date "+%H:%M:%S")
    # Extract CPU idle time and subtract from 100 to get Usage
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
    # Extract Memory usage percentage
    MEM_USAGE=$(free -m | grep Mem | awk '{printf "%.2f", $3/$2 * 100}')
    
    # Display and Log
    LOG_ENTRY="[$COUNT/$TOTAL_CHECKS] Time: $TIMESTAMP | CPU: ${CPU_USAGE}% | Mem: ${MEM_USAGE}%"
    echo "$LOG_ENTRY"
    echo "$LOG_ENTRY" >> "$LOG_FILE"
    
    sleep "$INTERVAL"
done

echo "Monitoring Complete." >> "$LOG_FILE"
echo "Done."