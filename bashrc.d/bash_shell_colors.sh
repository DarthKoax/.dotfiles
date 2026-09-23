#!/usr/bin/env bash
# ==============================================================================
# 1. RAW COLORS (Perfect for echo, printf, and scripts)
# ==============================================================================
export COLOR_RESET=$'\033[0m'
export COLOR_BOLD=$'\033[1m'

export COLOR_BLACK=$'\033[30m'
export COLOR_RED=$'\033[31m'
export COLOR_GREEN=$'\033[32m'
export COLOR_YELLOW=$'\033[33m'
export COLOR_BLUE=$'\033[34m'
export COLOR_MAGENTA=$'\033[35m'
export COLOR_CYAN=$'\033[36m'
export COLOR_WHITE=$'\033[37m'

export COLOR_BRIGHT_BLACK=$'\033[90m'
export COLOR_BRIGHT_RED=$'\033[91m'
export COLOR_BRIGHT_GREEN=$'\033[92m'
export COLOR_BRIGHT_YELLOW=$'\033[93m'
export COLOR_BRIGHT_BLUE=$'\033[94m'
export COLOR_BRIGHT_MAGENTA=$'\033[95m'
export COLOR_BRIGHT_CYAN=$'\033[96m'
export COLOR_BRIGHT_WHITE=$'\033[97m'

# ==============================================================================
# 2. PROMPT COLORS (Use these ONLY inside your PS1 prompt configuration)
# ==============================================================================
export PROMPT_RESET="\[${COLOR_RESET}\]"
export PROMPT_BOLD="\[${COLOR_BOLD}\]"

export PROMPT_BLACK="\[${COLOR_BLACK}\]"
export PROMPT_RED="\[${COLOR_RED}\]"
export PROMPT_GREEN="\[${COLOR_GREEN}\]"
export PROMPT_YELLOW="\[${COLOR_YELLOW}\]"
export PROMPT_BLUE="\[${COLOR_BLUE}\]"
export PROMPT_MAGENTA="\[${COLOR_MAGENTA}\]"
export PROMPT_CYAN="\[${COLOR_CYAN}\]"
export PROMPT_WHITE="\[${COLOR_WHITE}\]"

export PROMPT_BRIGHT_BLACK="\[${COLOR_BRIGHT_BLACK}\]"
export PROMPT_BRIGHT_RED="\[${COLOR_BRIGHT_RED}\]"
export PROMPT_BRIGHT_GREEN="\[${COLOR_BRIGHT_GREEN}\]"
export PROMPT_BRIGHT_YELLOW="\[${COLOR_BRIGHT_YELLOW}\]"
export PROMPT_BRIGHT_BLUE="\[${COLOR_BRIGHT_BLUE}\]"
export PROMPT_BRIGHT_MAGENTA="\[${COLOR_BRIGHT_MAGENTA}\]"
export PROMPT_BRIGHT_CYAN="\[${COLOR_BRIGHT_CYAN}\]"
export PROMPT_BRIGHT_WHITE="\[${COLOR_BRIGHT_WHITE}\]"