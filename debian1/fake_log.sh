#!/bin/bash

# Log file location
LOG_FILE="/fake_log.log"

# Infinite loop to write a fake log message every second
while true; do
    # Generate a random number between 1 and 1000
    RANDOM_NUMBER=$((RANDOM % 1000 + 1))

    # Generate a fake log message with timestamp and random number
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Fake log message - Random number: $RANDOM_NUMBER" >> "$LOG_FILE"

    # Wait for 1 second
    sleep 5
done
