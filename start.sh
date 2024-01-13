#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status.

# Generate SSH host keys if not present and start SSH service
ssh-keygen -A
service ssh start

# Setup SSH if the SSH_PUBLIC_KEY variable is provided
if [ -n "$SSH_PUBLIC_KEY" ]; then
    echo "Setting up SSH access..."
    mkdir -p /root/.ssh
    echo "$SSH_PUBLIC_KEY" > /root/.ssh/authorized_keys
    chmod 700 /root/.ssh
    chmod 600 /root/.ssh/authorized_keys
    echo "SSH setup complete."
fi

# Activate the virtual environment
source /root/Fooocus/fooocus_env/bin/activate

# Start the Fooocus server
echo "Starting Fooocus server..."
exec python /root/Fooocus/entry_with_update.py --listen
