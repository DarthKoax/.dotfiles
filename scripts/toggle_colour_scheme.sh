#!/bin/bash
# Check the current color scheme
if tmux show-window-option | grep -q 'synchronize-panes on'; then
	tmux set-option -g status-style fg=colour136,bg=colour076 # sets the default status line colors

	# Define the window status colors
	#https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
	tmux set-window-option -g window-status-style fg=colour138,bg=colour057 # default window status
	tmux set-window-option -g window-status-current-style fg=colour118,bg=colour054 # current window status
	tmux set-window-option -g window-status-activity-style fg=colour138,bg=colour226 # window with activity

	# Define the pane border colors
	tmux set-option -g pane-border-style fg=colour235,bg=colour226
	tmux set-option -g pane-active-border-style fg=colour51,bg=colour106

else
        tmux set-option -g status-style fg=colour136,bg=black # sets the default status line colors
        # Define the window status colors
        #https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
        tmux set-window-option -g window-status-style fg=colour138,bg=default # default window status
        tmux set-window-option -g window-status-current-style fg=colour118,bg=default # current window status
        tmux set-window-option -g window-status-activity-style fg=colour138,bg=default # window with activity

	# Define the pane border colors
	tmux set-option -g pane-border-style fg=colour235,bg=default
	tmux set-option -g pane-active-border-style fg=colour51,bg=default
fi
