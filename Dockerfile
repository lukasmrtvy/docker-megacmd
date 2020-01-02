FROM ubuntu:eoan

ENV MEGA_URL "https://mega.nz/linux/MEGAsync/xUbuntu_19.10/amd64/megacmd_1.1.0_amd64.deb"
ENV S6_URL "https://github.com/just-containers/s6-overlay/releases/download/v1.22.1.0/s6-overlay-amd64.tar.gz"

RUN set -xe && \
    mkdir -p /app && \
    useradd -u 911 -U -d /app -s /bin/false abc && \
    usermod -G users abc && \
    apt update && apt install -y curl && \
    curl -sSL "$S6_URL" -o /tmp/s6-overlay-amd64.tar.gz && \
    curl -sSL "$MEGA_URL" -o /tmp/megacmd.deb && \
    apt install -y /tmp/megacmd.deb && \
    tar xzf /tmp/s6-overlay-amd64.tar.gz -C / --exclude="./bin" && \
    tar xzf /tmp/s6-overlay-amd64.tar.gz -C /usr ./bin && \
    apt remove -y curl && \
    apt-get clean && \
    rm -rf /tmp/* var/lib/apt/lists/* /var/tmp/*

COPY root/ /

ENTRYPOINT ["/init"]
