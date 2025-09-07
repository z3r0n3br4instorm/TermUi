#!/bin/bash

SESSION="zrn_session"

# Kill if already running
tmux kill-session -t $SESSION 2>/dev/null

# Start new tmux session in detached mode
tmux new-session -d -s $SESSION

# Split window: top half will be tty-clock
tmux split-window -v -t $SESSION

# Split top pane vertically (left clock, right htop)
tmux split-window -h -t $SESSION:0.0

# Send tty-clock command to left-top pane
tmux send-keys -t $SESSION:0.0 'peaclock' C-m

tmux send-keys -t $SESSION:0.2 'launch' C-m

# Send htop to right-top pane
tmux send-keys -t $SESSION:0.1 'sudo gotop' C-m

# Bottom pane will remain a bash shell
# (already there after session start)

# Attach to session
tmux attach-session -t $SESSION


