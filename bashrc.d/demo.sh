#!/usr/bin/env bash
# Terminal Capability Demo Script
function demo_terminal_capabilities() {
    echo -e "\033[1m--- Terminal Style Test ---\033[0m"
    echo -e "Normal Text"
    echo -e "\033[1mBold Text\033[0m"
    echo -e "\033[3mItalic Text\033[0m"
    echo -e "\033[4mUnderlined Text\033[0m"
    echo -e "\033[7mReversed Text\033[0m"
    echo -e "\033[9mStrikethrough Text\033[0m"
    echo

    echo -e "\033[1m--- Standard 8 Colors ---\033[0m"
    for i in {30..37}; do
        echo -ne "\033[${i}m  Color $i  \033[0m"
    done
    echo
    for i in {90..97}; do
        echo -ne "\033[${i}m  Color $i  \033[0m"
    done
    echo
    echo

    echo -e "\033[1m--- 256 Color Palette (Subset) ---\033[0m"
    for i in {0..15}; do
        echo -ne "\033[48;5;${i}m  \033[0m"
    done
    echo
    for i in {16..231}; do
        echo -ne "\033[48;5;${i}m \033[0m"
        if [ $(((i - 15) % 36)) -eq 0 ]; then echo; fi
    done
    echo

    echo -e "\033[1m--- Box Drawing & Unicode ---\033[0m"
    echo "┌──────────────────┐"
    echo "│  TUI Multiplexer │"
    echo "├──────────────────┤"
    echo "│  Status: Active  │"
    echo "└──────────────────┘"
    echo "Symbols: ♥ ★ ☎ ⚙ ⚡"
    echo

    echo -e "\033[1;32mDemo Complete!\033[0m"
}

#!/usr/bin/env bash

# Spinner Demo Script

function demo_spinner() {
    # Define the animation frames
    # local spin='|/-\'
    local spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    # local spin='⠁⠂⠄⡀⢀⠠⠐⠈'
    # local spin='←↖↑↗→↘↓↙'
    # local spin='▉▊▋▌▍▎▏▎▍▌▋▊▉'
    local delay=0.1
    local i=0

    echo -n "Performing background task... "

    # Hide the cursor for a cleaner look
    tput civis

    # Run for 20 frames (or replace with your actual process logic)
    for j in {1..20}; do
        # Print the current frame
        printf "\b${spin:$i:1}"

        # Update index and loop through frames
        i=$(((i + 1) % 4))

        # Wait for the delay
        sleep $delay
    done

    # Reset to normal
    printf "\bDone!\n"

    # Show the cursor again
    tput cnorm
}
