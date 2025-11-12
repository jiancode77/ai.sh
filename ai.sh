#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

progress_bar() {
    local duration=$1
    printf "${CYAN}["
    for ((i=0; i<duration; i++)); do
        printf "▇"
        sleep 0.1
    done
    printf "]${NC}\n"
}

display_header() {
    clear
    echo -e "${BLUE}"
    echo "    █████╗ ██╗     ██████╗ ██╗  ██╗"
    echo "   ██╔══██╗██║     ██╔══██╗██║  ██║"
    echo "   ███████║██║     ██████╔╝███████║"
    echo "   ██╔══██║██║     ██╔═══╝ ██╔══██║"
    echo "   ██║  ██║███████╗██║     ██║  ██║"
    echo "   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝  ╚═╝"
    echo -e "${NC}"
    echo -e "${PURPLE}          AI CHAT TERMINAL v3.0${NC}"
    echo
    
    echo -e "${YELLOW}┌────────────────────────────────────────────────────────────┐${NC}"
    echo -e "${YELLOW}│ ${GREEN}  System: ${WHITE}Ubuntu 22.04 LTS x86_64${NC}"
    echo -e "${YELLOW}│ ${GREEN}  CPU: ${WHITE}AMD Ryzen 7 5800X (16) @ 3.800GHz${NC}"
    echo -e "${YELLOW}│ ${GREEN}  Memory: ${WHITE}15888MiB / 32061MiB${NC}"
    echo -e "${YELLOW}│ ${GREEN}  Uptime: ${WHITE}2 hours, 35 minutes${NC}"
    echo -e "${YELLOW}└────────────────────────────────────────────────────────────┘${NC}"
    echo
}

show_models() {
    echo -e "${PURPLE}  AI MODEL SELECTION:${NC}"
    echo -e "${CYAN}┌───┬─────────────────┬────────────────────────────────────┐${NC}"
    echo -e "${CYAN}│ ${GREEN}1${CYAN} │ ${WHITE}  GPT-4o${CYAN}        │ ${YELLOW}OpenAI Latest Model${CYAN}               │${NC}"
    echo -e "${CYAN}│ ${GREEN}2${CYAN} │ ${WHITE}  GPT-5${CYAN}         │ ${YELLOW}Next Generation GPT${CYAN}              │${NC}"
    echo -e "${CYAN}│ ${GREEN}3${CYAN} │ ${WHITE}  Gemini${CYAN}       │ ${YELLOW}Google AI Assistant${CYAN}              │${NC}"
    echo -e "${CYAN}│ ${GREEN}4${CYAN} │ ${WHITE}  DeepSeek${CYAN}      │ ${YELLOW}DeepSeek Coder${CYAN}                   │${NC}"
    echo -e "${CYAN}│ ${GREEN}5${CYAN} │ ${WHITE}  Claude${CYAN}        │ ${YELLOW}Anthropic AI${CYAN}                     │${NC}"
    echo -e "${CYAN}│ ${GREEN}6${CYAN} │ ${WHITE}  Groq${CYAN}          │ ${YELLOW}Groq AI Model${CYAN}                    │${NC}"
    echo -e "${CYAN}│ ${GREEN}7${CYAN} │ ${WHITE}  Felo${CYAN}          │ ${YELLOW}Search Assistant${CYAN}                 │${NC}"
    echo -e "${CYAN}├───┼─────────────────┼────────────────────────────────────┤${NC}"
    echo -e "${CYAN}│ ${RED}0${CYAN} │ ${RED}  Exit${CYAN}           │ ${RED}Exit Terminal${CYAN}                    │${NC}"
    echo -e "${CYAN}│ ${RED}9${CYAN} │ ${RED}  Clear${CYAN}          │ ${RED}Clear Screen${CYAN}                     │${NC}"
    echo -e "${CYAN}└───┴─────────────────┴────────────────────────────────────┘${NC}"
    echo
}

call_gpt4o() {
    local question=$1
    local encoded=$(echo "$question" | sed 's/ /%20/g')
    response=$(curl -s "https://piereeapi.vercel.app/ai/gpt4o?prompt=$encoded")
    echo "$response" | grep -o '"result":"[^"]*' | sed 's/"result":"//'
}

call_groq() {
    local question=$1
    local encoded=$(echo "$question" | sed 's/ /%20/g')
    response=$(curl -s "https://piereeapi.vercel.app/ai/groq?text=$encoded&model=gpt-5")
    echo "$response" | grep -o '"text":"[^"]*' | sed 's/"text":"//'
}

call_deepseek() {
    local question=$1
    local encoded=$(echo "$question" | sed 's/ /%20/g')
    response=$(curl -s "https://piereeapi.vercel.app/ai/deepseek?text=$encoded&model=depsekk-v2")
    echo "$response" | grep -o '"response":"[^"]*' | sed 's/"response":"//'
}

call_felo() {
    local question=$1
    local encoded=$(echo "$question" | sed 's/ /%20/g')
    response=$(curl -s "https://piereeapi.vercel.app/ai/felo?query=$encoded")
    echo "$response" | grep -o '"answer":"[^"]*' | sed 's/"answer":"//' | sed 's/\\n/ /g'
}

chat_with_ai() {
    local model=$1
    local model_name=$2
    
    echo -e "${GREEN}  Selected: ${WHITE}$model_name${NC}"
    echo -e "${YELLOW}  Type 'back' to return to menu${NC}"
    echo -e "${CYAN}────────────────────────────────────────────────────────────${NC}"
    
    while true; do
        echo -e "${BLUE}"
        read -p "  You: " question
        echo -e "${NC}"
        
        if [[ "$question" == "back" ]]; then
            echo -e "${YELLOW}  Returning to model selection...${NC}"
            break
        fi
        
        if [[ -z "$question" ]]; then
            echo -e "${RED}  Question cannot be empty!${NC}"
            continue
        fi
        
        echo -e "${CYAN}  Processing request...${NC}"
        progress_bar 12
        
        case $model in
            "gpt4o")
                response=$(call_gpt4o "$question")
                ;;
            "groq")
                response=$(call_groq "$question")
                ;;
            "deepseek")
                response=$(call_deepseek "$question")
                ;;
            "felo")
                response=$(call_felo "$question")
                ;;
            *)
                response="Model not implemented yet"
                ;;
        esac
        
        if [[ -n "$response" ]]; then
            echo -e "${GREEN}  $model_name: ${WHITE}$response${NC}"
        else
            echo -e "${RED}  Failed to get response${NC}"
        fi
        
        echo -e "${CYAN}────────────────────────────────────────────────────────────${NC}"
    done
}

main() {
    if ! command -v curl &> /dev/null; then
        echo -e "${RED}  curl is not installed!${NC}"
        echo -e "${YELLOW}  Install with: pkg install curl${NC}"
        exit 1
    fi
    
    if ! command -v node &> /dev/null; then
        echo -e "${YELLOW}  Node.js not found, using curl method${NC}"
    fi
    
    while true; do
        display_header
        show_models
        
        echo -e "${BLUE}"
        read -p "  Select option (0-9): " choice
        echo -e "${NC}"
        
        case $choice in
            1)
                chat_with_ai "gpt4o" "GPT-4o"
                ;;
            2)
                chat_with_ai "groq" "GPT-5 via Groq"
                ;;
            3)
                echo -e "${YELLOW}  Gemini coming soon...${NC}"
                sleep 2
                ;;
            4)
                chat_with_ai "deepseek" "DeepSeek AI"
                ;;
            5)
                echo -e "${YELLOW}  Claude coming soon...${NC}"
                sleep 2
                ;;
            6)
                chat_with_ai "groq" "Groq AI"
                ;;
            7)
                chat_with_ai "felo" "Felo Search"
                ;;
            9)
                display_header
                ;;
            0)
                echo -e "${GREEN}  Thank you for using AI Chat Terminal${NC}"
                echo -e "${YELLOW}  Goodbye!${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}  Invalid selection! Choose 0-9${NC}"
                sleep 2
                ;;
        esac
    done
}

main
