#!/bin/bash
THRESHOLD=50.0
LOG_FILE="/tmp/cleanup_actions.log"
REMOTE_LOG_SERVER="http://central-logs.local/api/report"

echo "Starting System Cleanup: $(date)" | tee -a $LOG_FILE

echo "--- Current Top 5 Memory Consumers ---"
ps aux --sort=-%mem | awk 'NR<=6 {print $1, $2, $3, $4, $11}' | column -t

BAD_PIDS=$(ps aux | awk -v limit="$THRESHOLD" '$4 > limit {print $2}')

if [ -z "$BAD_PIDS" ]; then
    echo "No processes found consuming more than $THRESHOLD% RAM." | tee -a $LOG_FILE
else
    for PID in $BAD_PIDS; do
 
        PNAME=$(ps -p $PID -o comm=)
        
        echo "ALERT: PID $PID ($PNAME) is using > $THRESHOLD% RAM. Killing now..." | tee -a $LOG_FILE
        
        kill -9 $PID
        
        logger "DEVOPS_CLEANUP: Killed $PNAME (PID: $PID) for high RAM usage."
        
        curl -X POST -d "server=$(hostname)&pid=$PID&status=killed" $REMOTE_LOG_SERVER
    done
fi

echo "Cleanup Task Completed: $(date)" | tee -a $LOG_FILE