function toggle_color_scheme(){
#!/bin/bash
# Check the current color scheme
if tmux show-window-option | grep -q 'synchronize-panes on'; then
	tmux set-option -g status-style fg=colour136,bg=yellow # sets the default status line colors

	# Define the window status colors
	#https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
	tmux set-window-option -g window-status-style fg=colour138,bg=default # default window status
	tmux set-window-option -g window-status-current-style fg=colour118,bg=default # current window status
	tmux set-window-option -g window-status-activity-style fg=colour138,bg=default # window with activity
else
        tmux set-option -g status-style fg=colour136,bg=black # sets the default status line colors

        # Define the window status colors
        #https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
        tmux set-window-option -g window-status-style fg=colour138,bg=default # default window status
        tmux set-window-option -g window-status-current-style fg=colour118,bg=default # current window status
        tmux set-window-option -g window-status-activity-style fg=colour138,bg=default # window with activity

fi
}
