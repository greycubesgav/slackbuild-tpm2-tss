FROM vbatts/slackware:15.0

USER root
ENV USER=root


RUN echo y | slackpkg update

RUN echo y | slackpkg install lzlib

RUN echo y | slackpkg install \
      autoconf \
      autoconf-archive \
      automake \
      binutils \
      kernel-headers \
      pkg-tools \
      glibc \
      automake \
      autoconf \
      m4 \
      gcc \
      g++ \
      meson \
      ninja \
      ar \
      flex \
      pkg-config \
      cmake \
      libarchive \
      lz4 \
      libxml2 \
      nghttp2 \
      brotli \
      cyrus-sasl \
      jansson \
      elfutils \
      guile \
      gc \
      cryptsetup \
      curl \
      python3 \
      zlib \
      socat \
      linuxdoc-tools \
      keyutils \
      openssl \
      libxslt \
      openldap \
      libnsl \
      lvm2 \
      eudev \
      json-c  \
      make \
      libffi \
      libidn2 \
      libssh2 \
      ca-certificates

RUN echo y | slackpkg install \
      libgcrypt \
      libgpg-error \
      dcron \
      udisks2

RUN echo y | slackpkg install \
      openssh

# Set the SlackBuild tag
ENV TAG='_GG'
ENV BUILD='GG'

# Cryptsetup build
WORKDIR /root
RUN echo y | slackpkg install lvm2 \
 popt \
 pkg-config \
 json-c \
 libssh2 \
 libssh \
 argon2 \
 flex \
 libgpg-error \
 libgcrypt

RUN mkdir cryptsetup
WORKDIR /root/cryptsetup
RUN wget --no-check-certificate 'https://mirrors.slackware.com/slackware/slackware64-current/source/a/cryptsetup/cryptsetup-2.7.1.tar.xz'
RUN wget --no-check-certificate 'https://mirrors.slackware.com/slackware/slackware64-current/source/a/cryptsetup/cryptsetup.SlackBuild'
RUN chmod +x cryptsetup.SlackBuild
RUN ./cryptsetup.SlackBuild
RUN installpkg /tmp/cryptsetup-2.7.1-x86_64-GG.txz

# Make and Install tpm2-tss libraries
COPY src/tpm2-tss-4.0.1.tar.gz /root/tpm2-tss/
COPY tpm2-tss.SlackBuild /root/tpm2-tss/
COPY slack-desc /root/tpm2-tss/
COPY tpm2-tss.info /root/tpm2-tss/
WORKDIR /root/tpm2-tss/
RUN ls -l
RUN ./tpm2-tss.SlackBuild
RUN installpkg "/tmp/tpm2-tss-4.0.1-x86_64-$BUILD$TAG.tgz"

CMD ["/bin/bash","-l"]
