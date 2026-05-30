#!/bin/bash

# Prompts
PROMPT_SELECTION="Select a device to connect to: "
PROMPT_ERROR="Invalid selection. Please try again: "

# Connect to nmcli devices
function nmcli_connect() {
    local device_nr
    local device_name
    local user_confirmed
    local devices
    local headings

    headings=$(nmcli d status | head -n 1)
    devices=$(nmcli d status | tail -n +2)

    if [ -z "$devices" ]; then
        echo "No devices found."
        return 1
    fi

    # Print the headings
    log_equals_box "$headings"

    # Print the devices output with each row prefixed with a number
    log_dash_box "$(echo "$devices" | awk '{print NR-1 " " $0}')"

    # Prompt the user to select a device
    echo -n "$PROMPT_SELECTION"
    read -r device_nr

    local num_devices
    num_devices=$(echo "$devices" | wc -l)

    # Check if the input is a number and within range
    while ! [[ "$device_nr" =~ ^[0-9]+$ ]] || [ "$device_nr" -ge "$num_devices" ]; do
        echo -n "$PROMPT_ERROR"
        read -r device_nr
    done

    # Get the device name from the list of devices based on the row number
    device_name=$(echo "$devices" | awk -v device_nr="$device_nr" 'NR==device_nr+1 {print $1}')

    # Confirm the connection
    echo "Connect to $device_name? (y/n)"
    read -r user_confirmed

    if [[ ! "$user_confirmed" =~ ^[Yy] ]]; then
        echo "Connection aborted"
        return 1
    fi

    # Connect to the selected device
    nmcli d connect "$device_name"
    return 0
}

alias nmcli_connect=nmcli_connect
nmcli_connect
