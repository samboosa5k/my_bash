#!/bin/bash

TABLE_HEADINGS="$(nmcli d status | grep -E "([A-Z]{2,}.+)")" # Get the headings
DEVICES="$(nmcli d status | grep -E "([a-z].+)")"            # Get the list of devices

# Prompts
PROMPT_SELECTION="Select a device to connect to: "
PROMPT_ERROR="Invalid selection. Please try again: "

# Connect to nmcli devices
function nmcli_connect() {
    local device_nr
    local device_name
    local user_confirmed

    # Print the first row of the table
    echo "$TABLE_HEADINGS"

    # Print the $DEVICES output with each row prefixed with a number
    echo "$DEVICES" | awk '{print NR-1 " " $0}'

    # Prompt the user to select a device
    echo -n "$PROMPT_SELECTION"
    read device_nr

    # Check if the input is a number
    while ! [[ $device_nr =~ ^[0-9]+$ ]]; do
        echo -n "$PROMPT_ERROR"
        read device_nr
    done

    # Check if the input is within the range of the devices
    while [ $device_nr -gt $(echo "$DEVICES" | wc -l) ]; do
        echo -n "$PROMPT_ERROR"
        read device_nr
    done

    # Get the device name from the list of devices based on the row number
    device_name=$(echo "$DEVICES" | awk -v device_nr="$device_nr" 'NR-1==device_nr {print $1}')

    # Confirm the connection
    echo "Connect to $device_name? (y/n)"
    read user_confirmed

    if [ "$user_confirmed" != "y" ]; then
        echo "Connection aborted"
        return 1
    fi

    # Connect to the selected device
    nmcli d connect $device_name
    return 0
}

alias nmcli_connect=nmcli_connect
nmcli_connect
