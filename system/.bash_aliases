#!/bin/bash

# Network
alias lan="sudo arp-scan --interface=eno1 --localnet"
alias portscan="sudo nmap -sT -p- 192.168.1.126"

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
alias systemctl="sudo systemctl"
alias sysd="systemd"
alias sysblame="systemd blame"
alias syscrit="systemd-analyze critical-chain"
alias systime="systemd-analyze critical-chain"

# Success message
echo "System aliases loaded $happy"
