#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
ORANGE='\033[38;5;208m'
MAGENTA='\033[38;5;165m'
TEAL='\033[38;5;51m'
NC='\033[0m'

spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c] " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

display_header() {
    clear
    echo -e "${CYAN}"
    echo "          _______  "
    echo "         /       / "
    echo "___     /   ____/   "
    echo ":   :  /   /:       "
    echo " :   :/___/  :      "
    echo "  :       :   :     "
    echo "   :_______:   :    StarsXTools v4.0"
    echo "           /   /    Owner:  JianCode"
    echo "          /   /     Premium: false"
    echo "          :  /      TELEGRAM @ JianCode"
    echo "           :/       "
    echo "+"
    echo "████████████████████████████████████████"
    echo "██████████████─────────────█████████████"
    echo "███████████───────────────────██████████"
    echo "█████████───────────────────────████████"
    echo "███████─────██─────────────██─────██████"
    echo "██████─────████───────────████─────█████"
    echo "█████─────██████─────────█████──────████"
    echo "████──────██████────────███████──────███"
    echo "███──────██████████████████████──────███"
    echo "███──────███─────███████─────███──────██"
    echo "██───────█─────█───███───█─────█──────██"
    echo "██──────██─────█────█────█─────██─────██"
    echo "██──────█──────█────█────█─────██─────██"
    echo "███─────██─────█────█────█─────██─────██"
    echo "███─▄▄▄▄███────█───███───█────███▄▄▄▄─██"
    echo "████─▄▄▄▄████────███████────████▄▄▄▄─███"
    echo "████─▄▄▄▄▄▄███████████████████▄▄▄▄▄▄─███"
    echo "█████─────────█████████████─────────████"
    echo "██████─────────────███─────────────█████"
    echo "███████────────────███────────────██████"
    echo "█████████──────────███──────────████████"
    echo "███████████───────█████───────██████████"
    echo "██████████████────█████────█████████████"
    echo "████████████████████████████████████████"
    echo -e "${NC}"
    echo -e "${PURPLE}              AI CHAT TERMINAL v4.0${NC}"
    echo
    
    echo -e "${BLUE}────────────────────────────────────────────────────────────────${NC}"
    echo -e "${BLUE}│ ${GREEN}◉ ${WHITE}System: Ubuntu 22.04 LTS x86_64                          ${BLUE}│${NC}"
    echo -e "${BLUE}│ ${GREEN}◉ ${WHITE}CPU: AMD Ryzen 7 5800X (16) @ 3.800GHz                   ${BLUE}│${NC}"
    echo -e "${BLUE}│ ${GREEN}◉ ${WHITE}Memory: 15888MiB / 32061MiB                              ${BLUE}│${NC}"
    echo -e "${BLUE}│ ${GREEN}◉ ${WHITE}Uptime: 2 hours, 35 minutes                              ${BLUE}│${NC}"
    echo -e "${BLUE}────────────────────────────────────────────────────────────────${NC}"
    echo
}

show_models() {
    echo -e "${PURPLE}────────────────────────────────────────────────────────────────${NC}"
    echo -e "${PURPLE}│                    AI MODEL SELECTION                    │${NC}"
    echo -e "${PURPLE}────────────────────────────────────────────────────────────────${NC}"
    echo -e "${PURPLE}│ ${GREEN}1${PURPLE} │ ${CYAN}◈ GPT-4o ${PURPLE}         │ ${YELLOW}OpenAI Latest Model                  ${PURPLE}│${NC}"
    echo -e "${PURPLE}│ ${GREEN}2${PURPLE} │ ${CYAN}◈ GPT-5 ${PURPLE}          │ ${YELLOW}Next Generation GPT                 ${PURPLE}│${NC}"
    echo -e "${PURPLE}│ ${GREEN}3${PURPLE} │ ${CYAN}◈ Gemini ${PURPLE}         │ ${YELLOW}Google AI Assistant                 ${PURPLE}│${NC}"
    echo -e "${PURPLE}│ ${GREEN}4${PURPLE} │ ${CYAN}◈ DeepSeek ${PURPLE}       │ ${YELLOW}DeepSeek Coder                      ${PURPLE}│${NC}"
    echo -e "${PURPLE}│ ${GREEN}5${PURPLE} │ ${CYAN}◈ Claude ${PURPLE}         │ ${YELLOW}Anthropic AI                        ${PURPLE}│${NC}"
    echo -e "${PURPLE}│ ${GREEN}6${PURPLE} │ ${CYAN}◈ Groq ${PURPLE}           │ ${YELLOW}Groq AI Model                       ${PURPLE}│${NC}"
    echo -e "${PURPLE}│ ${GREEN}7${PURPLE} │ ${CYAN}◈ Felo ${PURPLE}           │ ${YELLOW}Search Assistant                    ${PURPLE}│${NC}"
    echo -e "${PURPLE}│                                                        │${NC}"
    echo -e "${PURPLE}│ ${RED}0${PURPLE} │ ${RED}◉ Exit ${PURPLE}           │ ${RED}Exit Terminal                       ${PURPLE}│${NC}"
    echo -e "${PURPLE}│ ${RED}9${PURPLE} │ ${RED}◉ Clear ${PURPLE}          │ ${RED}Clear Screen                        ${PURPLE}│${NC}"
    echo -e "${PURPLE}────────────────────────────────────────────────────────────────${NC}"
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
    
    echo -e "${GREEN}◉ Selected: ${WHITE}$model_name${NC}"
    echo -e "${YELLOW}◉ Type 'back' to return to menu${NC}"
    echo -e "${PURPLE}────────────────────────────────────────────────────────────────${NC}"
    
    while true; do
        echo -e "${CYAN}"
        read -p "◉ You: " question
        echo -e "${NC}"
        
        if [[ "$question" == "back" ]]; then
            echo -e "${YELLOW}◉ Returning to model selection...${NC}"
            break
        fi
        
        if [[ -z "$question" ]]; then
            echo -e "${RED}◉ Question cannot be empty!${NC}"
            continue
        fi
        
        echo -e "${BLUE}◉ Processing request...${NC}"
        
        (
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
            
            printf "\r\033[K"
            if [[ -n "$response" ]]; then
                echo -e "${TEAL}◉ $model_name: ${WHITE}$response${NC}"
            else
                echo -e "${RED}◉ Failed to get response${NC}"
            fi
            
            echo -e "${PURPLE}────────────────────────────────────────────────────────────────${NC}"
        ) &
        
        local pid=$!
        spinner $pid
        wait $pid
    done
}

main() {
    if ! command -v curl &> /dev/null; then
        echo -e "${RED}◉ curl is not installed!${NC}"
        echo -e "${YELLOW}◉ Install with: pkg install curl${NC}"
        exit 1
    fi
    
    while true; do
        display_header
        show_models
        
        echo -e "${CYAN}"
        read -p "◉ Select option (0-9): " choice
        echo -e "${NC}"
        
        case $choice in
            1)
                chat_with_ai "gpt4o" "GPT-4o"
                ;;
            2)
                chat_with_ai "groq" "GPT-5 via Groq"
                ;;
            3)
                echo -e "${YELLOW}◉ Gemini coming soon...${NC}"
                sleep 2
                ;;
            4)
                chat_with_ai "deepseek" "DeepSeek AI"
                ;;
            5)
                echo -e "${YELLOW}◉ Claude coming soon...${NC}"
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
                echo -e "${GREEN}◉ Thank you for using AI Chat Terminal${NC}"
                echo -e "${PURPLE}◉ Goodbye!${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}◉ Invalid selection! Choose 0-9${NC}"
                sleep 2
                ;;
        esac
    done
}

main
