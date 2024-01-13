# Use the official Nvidia CUDA image as a parent image
FROM nvidia/cuda:12.2.0-base-ubuntu22.04

# Set environment variables to non-interactive (this prevents some prompts)
ENV DEBIAN_FRONTEND=noninteractive

# Install Python 3.10, and other necessary system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    aria2 \
    libgl1 \
    libglib2.0-0 \
    wget \
    vim \
    git \
    git-lfs \
    rsync \
    python3.10 \
    python3.10-venv \
    python3-pip \
    python-is-python3 \
    unzip \
    openssh-server \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /root

# Clone the Fooocus repository into the root's home directory
RUN git clone https://github.com/lllyasviel/Fooocus.git && \
    cd Fooocus && \
    python3.10 -m venv fooocus_env && \
    . fooocus_env/bin/activate && \
    pip install -r requirements_versions.txt

# Expose the SSH port
EXPOSE 22

# Expose the port for Fooocus
EXPOSE 7865

COPY --chmod=755 start.sh /start.sh

ENTRYPOINT ["/start.sh"]
