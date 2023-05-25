FROM node:18-bullseye AS Builder
WORKDIR /opt/cronicle

COPY version .
CMD VERSION=$(cat version) wget -O package.tar.gz "https://api.github.com/repos/jhuckaby/Cronicle/tarball/${VERSION}"

COPY package.tar.gz /tmp/
RUN tar zxvf /tmp/package.tar.gz -C /tmp/ && \
    mv /tmp/jhuckaby-Cronicle-*/* . && \
    rm -rf /tmp/* && \
    npm install
COPY ./patches /tmp/patches
RUN patch -p3 < /tmp/patches/engine.patch lib/engine.js
COPY docker-entrypoint.js ./bin/


FROM node:18-alpine
RUN apk add procps curl
COPY --from=builder /opt/cronicle/ /opt/cronicle/
WORKDIR /opt/cronicle
ENV CRONICLE_foreground=1
ENV CRONICLE_echo=1
ENV CRONICLE_color=1
ENV debug_level=1
ENV HOSTNAME=main
RUN node bin/build.js dist && bin/control.sh setup
CMD ["node", "bin/docker-entrypoint.js"]
