#!/bin/bash

# =====================================
# Swap Space Creation Script
# Student Name: [Your Name]
# Roll Number:  [Your Roll Number]
# =====================================

# 1. Define the swap file path and size (1 GB)
SWAP_FILE="/swapfile"
SWAP_SIZE="1G"

echo "Creating a ${SWAP_SIZE} swap file at ${SWAP_FILE}..."

# 2. Allocate space for the swap file
sudo fallocate -l $SWAP_SIZE $SWAP_FILE || sudo dd if=/dev/zero of=$SWAP_FILE bs=1M count=1024 status=progress

# 3. Set strict read/write permissions for root security
sudo chmod 600 $SWAP_FILE

# 4. Set up the file as Linux swap space
sudo mkswap $SWAP_FILE

# 5. Enable the swap file immediately
sudo swapon $SWAP_FILE

# 6. Make the swap persistent across reboots by updating /etc/fstab
if ! grep -q "$SWAP_FILE" /etc/fstab; then
    echo "$SWAP_FILE none swap defaults 0 0" | sudo tee -a /etc/fstab
fi

# 7. Verify swap creation
echo "Swap space successfully created and enabled:"
sudo swapon --show
free -h
