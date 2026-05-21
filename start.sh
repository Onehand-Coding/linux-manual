#!/bin/bash
# Linux Manual dev server launcher
# Usage: ./start.sh start | stop

cd "$(dirname "$0")" || exit 1

case "$1" in
    start)
        echo "Killing any existing server on port 3000..."
        # Most reliable way to kill Next.js dev server
        kill $(lsof -t -i:3000) 2>/dev/null || true
        pkill -f "next dev" 2>/dev/null || true
        sleep 1

        echo "Starting dev server..."
        npm run dev &>/dev/null &

        sleep 5
        echo "Opening http://localhost:3000 in Brave..."
        exo-open http://localhost:3000 >/dev/null 2>&1 &
        ;;
    
    stop)
        echo "Stopping dev server..."
        kill $(lsof -t -i:3000) 2>/dev/null || true
        pkill -f "next dev" 2>/dev/null || true
        echo "Dev server stopped."
        ;;
    
    *)
        echo "Usage: $0 start | stop"
        exit 1
        ;;
esac
