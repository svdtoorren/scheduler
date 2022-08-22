#!/bin/bash

if [ -z "$SCHEDULER_ENVIRONMENT" ]; then
   echo "SCHEDULER_ENVIRONMENT not set, assuming Development"
   SCHEDULER_ENVIRONMENT="Development"
fi

# Select the crontab file based on the environment
CRON_FILE="/usr/scheduler/jobs/crontab.$SCHEDULER_ENVIRONMENT"

echo "Loading crontab file: $CRON_FILE"

# Remove commented-out lines
grep -v '^#' $CRON_FILE

# Load the crontab file
crontab $CRON_FILE

echo "Starting cron..."

# Ensure jobs are executables
find . -type f -iname "*.sh" -exec chmod +x {} \; \
    && \
    find . -type f -iname "*.py" -exec chmod +x {} \;
    
# Start cron
crond -f
