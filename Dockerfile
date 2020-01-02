FROM ubuntu:eoan

ENV URL "https://mega.nz/linux/MEGAsync/xUbuntu_19.10/amd64/megacmd_1.1.0_amd64.deb"

RUN set -xe && \
    apt update && apt install -y curl && \
    curl -sSL "$URL" -o /tmp/megacmd.deb && \
    apt install -y /tmp/megacmd.deb && \
    rm -rf /tmp/* && \
    apt remove -y curl

ENTRYPOINT ["mega-cmd"]
