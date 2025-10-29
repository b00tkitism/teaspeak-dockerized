FROM debian:bullseye-slim

WORKDIR /opt/teaspeak

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl tar ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Download and extract TeaSpeak
ADD https://github.com/b00tkitism/teaspeak-dockerized/raw/refs/heads/main/teaspeak2.tar.gz ./teaspeak.tar.gz
RUN tar --strip-components=1 -xzf teaspeak.tar.gz && \
    rm teaspeak.tar.gz

# Add your config
COPY config.yml ./
COPY protocol_key.txt ./

EXPOSE 9987/udp

RUN mkdir -p /opt/teaspeak/db
CMD ["./TeaSpeakServer"]

