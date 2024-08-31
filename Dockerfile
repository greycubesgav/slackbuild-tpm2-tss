FROM greycubesgav/slackware-docker-base:latest AS builder

# Set our prepended build artifact tag and build dir
ENV TAG='_GG'

#--------------------------------------------------------------
# Cryptsetup Install
#--------------------------------------------------------------
# We need a version of cryptsetup to builf tpm2-tss against
# Here we pull a specific version from the official repository
ARG CRYPTSETUP_VERSION=cryptsetup-2.7.1.tar.xz
WORKDIR /root/cryptsetup
RUN wget --no-check-certificate "https://mirrors.edge.kernel.org/pub/linux/utils/cryptsetup/v2.7/${CRYPTSETUP_VERSION}"
RUN wget --no-check-certificate 'https://mirrors.slackware.com/slackware/slackware64-current/source/a/cryptsetup/cryptsetup.SlackBuild' \
 'https://mirrors.slackware.com/slackware/slackware64-current/source/a/cryptsetup/slack-desc'
RUN chmod +x cryptsetup.SlackBuild && ./cryptsetup.SlackBuild
RUN installpkg /tmp/cryptsetup-*.txz

#--------------------------------------------------------------
# BuilD Slackware Package
#--------------------------------------------------------------
# Copy over the build files
COPY LICENSE *.info *.SlackBuild README slack-desc /root/build/

# Grab the source and check the md5
WORKDIR /root/build/
RUN wget --no-check-certificate $(sed -n 's/DOWNLOAD="\(.*\)"/\1/p' *.info)
RUN export pkgname=$(grep 'DOWNLOAD=' *.info| sed 's|.*/||;s|"||g') \
&& export pkgmd5sum=$(sed -n 's/MD5SUM="\(.*\)"/\1/p' *.info) \
&& echo "$pkgmd5sum  $pkgname" > "${pkgname}.md5" \
&& md5sum -c "${pkgname}.md5"

# Build the package
RUN ./*.SlackBuild

#ENTRYPOINT [ "bash" ]

# Create a clean image with only the artifact
FROM scratch AS artifact
COPY --from=builder /tmp/tpm2*.tgz .
