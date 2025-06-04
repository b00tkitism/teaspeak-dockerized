FROM debian:bullseye-slim

WORKDIR /opt/teaspeak

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl tar ca-certificates iptables iproute2 wireguard wireguard-tools && \
    rm -rf /var/lib/apt/lists/*

# Download and extract TeaSpeak
ADD https://repo.teaspeak.de/server/linux/amd64_stable/TeaSpeak-1.5.6.tar.gz ./teaspeak.tar.gz
RUN tar xzvf teaspeak.tar.gz && \
    rm teaspeak.tar.gz

# Add your config
COPY config.yml ./
COPY protocol_key.txt ./
COPY wg.conf /etc/wireguard/wg0.conf

EXPOSE 51820/udp
EXPOSE 9987/udp

CMD ["sh", "-c", "wg-quick up wg0 && ./TeaSpeakServer"]

