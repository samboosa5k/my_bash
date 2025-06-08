#!/bin/bash

# Network
alias lan="sudo arp-scan --interface=eno1 --localnet"
# fix lan ips so I only see the IP, not the inteface name, or any other columsn'
# current it prunts the IP, MAC, and interface name
# I want to see only the IP
alias lan_ips="sudo arp-scan --interface=eno1 --localnet | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}'"
alias portscan="sudo nmap -sT -p- 192.168.1.126"
alias connect="$CFG_DIR/system/nmcli_connect.sh"
alias mancron="$CFG_DIR/system/manage_cron_jobs.sh"

# log addition of mancron
echo "mancron aliases loaded $happy"

# Packages
alias dnf="sudo dnf"
alias dnfi="dnf list installed"
alias dnfs="dnf search"
alias gli="dnf grouplist installed"
alias gl="dnf grouplist"

# Maintenance
alias leaves="package-cleanup --leaves"
alias orphans="package-cleanup --orphans"
alias unused="rpmconf -a"
alias cleanconfig="rpmconf -c"
alias reaper="rpmreaper"
alias clean_kernels="dnf repoquery --installonly --latest-limit=-2 -q | xargs sudo dnf remove"

# Troubleshooting
alias sysd="systemd"
alias sysblame="systemd blame"
alias syscrit="systemd-analyze critical-chain"
alias systime="systemd-analyze critical-chain"

# Success message
echo "System aliases loaded $happy"
