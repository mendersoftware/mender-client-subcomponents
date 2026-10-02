# Creates a container which acts as a bare bones non-VM based Mender Client
# installation, for use in tests and as Virtual Device for evaluation

ARG XX_VERSION=1.9.0

# Sources of the components. To skip the cloning, pass --build-context
# sources=<dir> where <dir> contains the mender, mender-connect and
# mender-configure-module checkouts. Don't pass the checkouts themselves:
# mender's own .dockerignore would then apply and make its version -dirty.
FROM --platform=$BUILDPLATFORM alpine:3.24 AS clone
RUN apk add --no-cache git

ARG MENDER_CLIENT_REV=master
WORKDIR /src/mender
RUN git init -q && git remote add origin https://github.com/mendersoftware/mender
RUN git fetch --depth 1 origin $MENDER_CLIENT_REV:refs/rev && git checkout -q FETCH_HEAD || \
    (git fetch origin && git checkout -q -f $MENDER_CLIENT_REV)
RUN git submodule update --init --depth 1

ARG MENDER_CONNECT_REV=master
WORKDIR /src/mender-connect
RUN git init -q && git remote add origin https://github.com/mendersoftware/mender-connect
RUN git fetch --depth 1 origin $MENDER_CONNECT_REV:refs/rev && git checkout -q FETCH_HEAD || \
    (git fetch origin && git checkout -q -f $MENDER_CONNECT_REV)

ARG MENDER_CONFIGURE_REV=master
WORKDIR /src/mender-configure-module
RUN git init -q && git remote add origin https://github.com/mendersoftware/mender-configure-module
RUN git fetch --depth 1 origin $MENDER_CONFIGURE_REV:refs/rev && git checkout -q FETCH_HEAD || \
    (git fetch origin && git checkout -q -f $MENDER_CONFIGURE_REV)

FROM scratch AS sources
COPY --from=clone /src /

# The build stages run on the build platform and cross-compile for the target
# platform. Compiling under QEMU emulation is slow, and the Go build can hang.
# The xx-* helpers install target packages and set up the cross-compilers, see
# https://github.com/tonistiigi/xx
FROM --platform=$BUILDPLATFORM tonistiigi/xx:${XX_VERSION} AS xx

FROM --platform=$BUILDPLATFORM ubuntu:24.04 AS build-base
COPY --from=xx / /
ARG TARGETPLATFORM

# Build mender repository, which is heaviest part
FROM build-base AS build-mender

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y make git jq cmake pkgconf
RUN xx-apt-get install -y gcc g++ libssl-dev liblmdb++-dev libboost-dev libboost-log-dev \
    libarchive-dev libdbus-1-dev

COPY --from=sources /mender /src/mender
WORKDIR /src/mender
RUN mkdir --parents /mender-install/etc/mender
RUN TRIPLE=$(xx-info triple) && \
    PKG_CONFIG=$TRIPLE-pkg-config cmake -D CMAKE_INSTALL_PREFIX:PATH=/usr -D BUILD_TESTS=OFF \
        -D CMAKE_SYSTEM_NAME=Linux -D CMAKE_SYSTEM_PROCESSOR=$(xx-info march) \
        -D CMAKE_C_COMPILER=$TRIPLE-gcc -D CMAKE_CXX_COMPILER=$TRIPLE-g++ -S .
RUN DESTDIR=/mender-install make --jobs=$(nproc --all) install
RUN jq ".ServerCertificate=\"/usr/share/doc/mender-auth/examples/demo.crt\" | .ServerURL=\"https://docker.mender.io/\"" \
    < examples/mender.conf.demo > /mender-install/etc/mender/mender.conf
RUN mkdir --parents /mender-install/var/lib/mender && echo device_type=generic-x86_64 > /mender-install/var/lib/mender/device_type

# Build mender-connect and mender-configure, and generate the bootstrap Artifact
FROM build-base AS build-other

ENV DEBIAN_FRONTEND=noninteractive
# qemu-user is never run. It only satisfies libglib2.0-dev's "python3 | qemu-user"
# dependency, which would otherwise install python3 for the target and run it.
RUN apt-get update && apt-get install -y --no-install-recommends make git golang pkgconf qemu-user \
    ca-certificates curl jq
RUN xx-apt-get install -y --no-install-recommends gcc libc6-dev liblzma-dev libglib2.0-dev

# mender-connect ---------------------------------------------------------------

COPY --from=sources /mender-connect /src/mender-connect
WORKDIR /src/mender-connect

RUN mkdir --parents /mender-install/etc/mender
RUN xx-go --wrap && CGO_ENABLED=1 make prefix=/mender-install install
RUN jq ".User=\"root\"" \
    < examples/mender-connect.conf > /mender-install/etc/mender/mender-connect.conf

# mender-configure -------------------------------------------------------------

COPY --from=sources /mender-configure-module /src/mender-configure-module
WORKDIR /src/mender-configure-module

RUN make DESTDIR=/mender-install install

# bootstrap Artifact -----------------------------------------------------------

RUN curl --fail --silent --show-error --location \
        https://downloads.mender.io/repos/debian/gpg > /etc/apt/trusted.gpg.d/mender.asc && \
    echo "deb [arch=$(dpkg --print-architecture)] https://downloads.mender.io/repos/workstation-tools ubuntu/$(. /etc/lsb-release && echo $DISTRIB_CODENAME)/stable main" > \
        /etc/apt/sources.list.d/mender.list && \
    apt-get update && apt-get install -y mender-artifact
RUN mender-artifact write bootstrap-artifact \
        --artifact-name original \
        --device-type generic-x86_64 \
        --provides "rootfs-image.version:original" \
        --output-path /bootstrap.mender

# Final image to run the Virtual Device from
FROM ubuntu:24.04
ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir --parents /run/dbus && apt-get update && apt-get install -y --no-install-recommends \
    liblzma5 dbus openssh-server sudo liblmdb0 libarchive13 libboost-log1.83.0 iproute2 jq \
    libglib2.0-0 ca-certificates systemd

# Set no password
RUN sed -ie 's/^root:[^:]*:/root::/' /etc/shadow
RUN sed -ie 's/^UsePAM/#UsePam/' /etc/ssh/sshd_config
RUN echo 'PermitEmptyPasswords yes\n\
PermitRootLogin yes\n\
Port 22\n\
Port 8822\n' >> /etc/ssh/sshd_config

# Install Mender Client
COPY --from=build-mender /mender-install/usr/ /usr/
COPY --from=build-mender /mender-install/etc/ /etc/
COPY --from=build-mender /mender-install/lib/ /lib/
COPY --from=build-mender /mender-install/var/ /var/
COPY --from=build-other /mender-install/usr/ /usr/
COPY --from=build-other /mender-install/etc/ /etc/
COPY --from=build-other /mender-install/lib/ /lib/
COPY --from=build-other /bootstrap.mender /var/lib/mender/bootstrap.mender

# Install the demo server certificate(s). See:
# https://github.com/mendersoftware/meta-mender/blob/master/meta-mender-core/recipes-mender/mender-server-certificate/mender-server-certificate.bb
COPY --from=build-mender /src/mender/support/demo.crt /server.crt
RUN \
    mkdir /usr/local/share/ca-certificates/mender                              ;\
    certnum=1                                                                  ;\
    while read LINE; do                                                         \
        if [ -z "$cert" ] || echo "$LINE" | fgrep -q 'BEGIN CERTIFICATE'; then  \
            cert=/usr/local/share/ca-certificates/mender/server-$certnum.crt   ;\
            rm -f $cert                                                        ;\
            touch $cert                                                        ;\
            chmod 0444 $cert                                                   ;\
            certnum=$(expr $certnum + 1)                                       ;\
        fi                                                                     ;\
        echo "$LINE" >> $cert                                                  ;\
    done < /server.crt                                                         ;\
    rm /server.crt
RUN update-ca-certificates

COPY entrypoint.sh /
CMD [ "/entrypoint.sh" ]
