#!/bin/bash
# This script initializes the SSH server and starts the Fooocus server.

set -e  # Exit immediately if a command exits with a non-zero status.

# Generate SSH host keys and start SSH service
ssh-keygen -A
service ssh start

# Setup SSH access if an SSH public key is provided
if [ -n "$SSH_PUBLIC_KEY" ]; then
    echo "Setting up SSH access..."
    mkdir -p /root/.ssh
    echo "$SSH_PUBLIC_KEY" > /root/.ssh/authorized_keys
    chmod 700 /root/.ssh
    chmod 600 /root/.ssh/authorized_keys
    echo "SSH setup complete."
fi

# Activate the Fooocus Python virtual environment
source /root/Fooocus/fooocus_env/bin/activate

# Start the Fooocus server
echo "Starting Fooocus server..."
exec python /root/Fooocus/entry_with_update.py --listen

