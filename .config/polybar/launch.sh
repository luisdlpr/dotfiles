#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar mybar 2>&1 | tee -a /tmp/polybar1.log & disown

echo "polybar launched..."
