#!/bin/bash

source PwnAPet_VariablesV2.sh

# Verify if proper program is installed
Check_Installed_Programs() {
	if ! command -v nmap &> /dev/null
	then
		echo "Nmap must be installed to run Would you like to install now? (y/n)"
		read answer
		if [ "$answer" != "${answer#[Yy]}" ] ; then
			sudo apt-get install nmap
		else
			echo "Please install nmap and try again"
			exit 1
		fi
	else
		echo "Nmap is Installed."
	fi
}

# First run
First_Run() {
	rand_face
	echo -e -n "\nWelcome to Pwn A Pet: \n\nPlease answer the following questions to setup your pet \nfor the first time. \nPlease tell me your name. \n\n$owner_name: "
	read owner_name
    update_variable "owner_name" "$owner_name"
	clear
	rand_face
	echo -e -n "\nIt's a pleasure to meet you $owner_name.\nNext and final question is what would you like to name your Pwn A Pet? \n\n$owner_name: "
	read pet_name
    update_variable "pet_name" "$pet_name"
}

# Function for main program
main_program() {
    rand_face
    pet_stats
    echo -e -n "\nPlease enter a command or type list for available commands.\n\n$owner_name: "
    read command
    if [ "$command" == "list" ]; then
        clear
        echo -e -n "Options List: \n\n   1. list \n   2. configure \n   3. chat \n   4. recon \n   5. exit \n\n"
        main_program 
    elif [ "$command" == "configure" ]; then
        clear
        configuration
    elif [ "$command" == "exit" ]; then
	    clear
    elif [ "$command" == "chat" ]; then
	    clear
        add_xp
	    rand_chat 
	    main_program
    elif [ "$command" == "recon" ]; then
	    clear
	    rand_face
	    echo -e -n "\nEnter a target ip address.\n\n$owner_name: "
	    read target_ip
        touch "Recon_Results"    
        echo -e -n "\n What type of scan would you like to perform? \n 1. quiet \n 2. loud \n\n$owner_name: " 
        read scan_type
        if [ "$scan_type" == "quiet" ]; then
            sudo nmap -sS -T1 "$target_ip" -oN Recon_Results
            echo -e -n "\n Scan Complete! Results saved to Recon_Results"
            sleep 2
            main_program
        elif [ "$scan_type" == "loud" ]; then
            nmap -T5 -A "$target_ip" -oN Recon_Results
            clear
            echo -e -n "\n Scan Complete! Results saved to Recon_Results"
            sleep 2
            main_program
        else
            echo -e -n "\n Invalid scan Type!"
            sleep 2
            clear
            nmap_scan_type
        fi
    else
        rand_face
        echo -e "\nInvalid option please try again."
        sleep 3
        clear
        main_program
    fi
}

# Function for adjusting names
configuration() {    
    rand_face
    echo -e -n "\nWould you like to adjust the Pet name?\n\n$owner_name: "
    read response
    if [ "$response" == "yes" ]; then
        rand_face
        echo -e -n "\nPlease enter a new name \n\n$owner_name: "
        read pet_name
        update_variable "pet_name" "$pet_name"
        clear
        main_program
    elif [ "$response" == "no" ]; then
	clear
	main_program
    else
        rand_face
        echo -e "\nInvalid option"
        sleep 2
        clear
        configuration
    fi
}

# Function for Random Face
rand_face() {
    local num=$((RANDOM % 5 + 1))
    case $num in
        1) face1 ;;
        2) face2 ;;
        3) face3 ;;
        4) face4 ;;
        5) face5 ;;
    esac
}

# Function for Face 1
face1() {
    echo -e -n "\n   (-_-)\n"
}

# Function for face 2
face2() {
    echo -e -n "\n   (+_+)\n"
}

# Function for face 3
face3() {
    echo -e -n "\n   (*_*)\n"
}

# Function for face 4
face4() {
    echo -e -n "\n   (O_O)\n"
}

# Function for face 5
face5() {
    echo -e -n "\n   (-.-)\n"
}

# Function displaying stats for pet (Waiting on age)
pet_stats() {
    echo -e "\nCurrent Stats: \nName: $pet_name \nLVL: $pet_lvl \nExp: $pet_experience "
}

# Random Chat Function
rand_chat() {
    local num=$((RANDOM % 3 + 1))
    case $num in
        1) chat1 ;;
        2) chat2 ;;
        3) chat3 ;;
    esac
}

# Function for chat 1
chat1() {
    rand_face
    echo -e -n "\n Reconnaissance, Weponization, Delivery, Exploitation,\n Installation, Command & Control, Actions On Objective\n Lockheed said it best!\n"
    sleep 3
    clear
}

# Function for chat 2
chat2() {
    rand_face
    echo -e -n "\n Coffee, Coffee, Coffee!\n"
    sleep 3
    clear
}

# Function for chat 3
chat3() {
    rand_face
    echo -e -n "\n Lets get to Hacking!\n"
    sleep 3
    clear
}

# Update Variable Change Name
update_variable() {
    sed -i "/^$1=/c\\$1=\"$2\"" "PwnAPet_VariablesV2.sh"
}

# Function to level up
level_up() {
    pet_experience=$((pet_experience - 100))
    pet_lvl=$((pet_lvl + 1))
    update_variable "pet_experience" "$pet_experience"
    update_variable "pet_lvl" "$pet_lvl"
    rand_face
    echo -e -n "\n Thanks $owner_name! I am now level $pet_lvl! \n"
    sleep 3
    clear
}

# Function for adding XP
add_xp() {
    pet_experience=$((pet_experience + 5))
    update_variable "pet_experience" "$pet_experience"

    if [ "$pet_experience" -ge 100 ]; then
        level_up
    fi
}
