# Dockerfile for Fooocus server using Nvidia CUDA and Python 3.10 on Ubuntu 22.04
FROM nvidia/cuda:12.2.0-base-ubuntu22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
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

WORKDIR /root

# Clone and set up the Fooocus project
RUN git clone https://github.com/lllyasviel/Fooocus.git && \
    cd Fooocus && \
    python3.10 -m venv fooocus_env && \
    . fooocus_env/bin/activate && \
    pip install -r requirements_versions.txt

# Expose ports for SSH and Fooocus
EXPOSE 22 7865

COPY --chmod=755 start.sh /start.sh
ENTRYPOINT ["/start.sh"]
