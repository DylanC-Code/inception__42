FROM debian:11-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    gnupg \
    git \
    bash \
    sudo \
    build-essential \
    python3 \
    python3-pip \
    make \
    g++ \
    gcc \
    libc6-dev \
    libstdc++6 \
    libx11-dev \
    libxkbfile-dev \
    libsecret-1-dev \
    pkg-config \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libxss1 \
    libasound2 \
    libxshmfence-dev \
    libxtst6 \
    libxrandr2 \
    libgbm-dev \
    xauth \
    x11-utils \
    unzip \
    procps \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get update && apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

RUN npm install -g code-server@4.22.1 --unsafe-perm


COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8443

ENTRYPOINT [ "/entrypoint.sh" ]
