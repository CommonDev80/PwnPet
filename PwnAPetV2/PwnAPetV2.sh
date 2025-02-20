#!/bin/bash

# Import the functions for the program
source PwnAPet_FunctionsV2.sh
source PwnAPet_VariablesV2.sh

# Have I been ran before?
clear
if [ -f "$Check_File" ]; then
	Check_Installed_Programs
	main_program
else
	touch "$Check_File"
	Check_Installed_Programs
	First_Run
	main_program
fi
