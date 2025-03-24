#!/bin/bash

# Navigate to dbt project directory
cd ~/heart-attack-prediction/dbt

# Log file setup
LOG_FILE="dbt_log_$(date '+%Y-%m-%d_%H-%M-%S').txt"

# Run dbt compile
echo "Compiling dbt models..."
dbt compile > $LOG_FILE 2>&1
if [ $? -eq 0 ]; then
    echo "dbt compile successful."
else
    echo "dbt compile failed. Check $LOG_FILE for details."
    exit 1
fi

# Run dbt build (validates models and dependencies)
echo "Building dbt models..."
dbt build --target dev >> $LOG_FILE 2>&1
if [ $? -eq 0 ]; then
    echo "dbt build successful."
else
    echo "dbt build failed. Check $LOG_FILE for details."
    exit 1
fi

# Run dbt run (executes transformations)
echo "Running dbt transformations..."
dbt run --target dev >> $LOG_FILE 2>&1
if [ $? -eq 0 ]; then
    echo "dbt run completed successfully!"
else
    echo "dbt run failed. Check $LOG_FILE for details."
    exit 1
fi
