# slackbuild-tpm2-tss
Slackware build script for tpm2-tss libraries, required by tpm2-tools

## Application description
tpm2-tss is source code implementing the Trusted Computing Group's (TCG) TPM2 Software Stack

Homepage: https://github.com/tpm2-software/tpm2-tss/

## Docker Based Build Instructions

The following instructions show how to build this package using the included Dockerfile.

Docker needs to be installed and running before running the make command.

The final artifact will be copied to a new ./pkgs directory

```bash
# Clone the git repo
git clone https://github.com/greycubesgav/slackbuild-tpm2-tss
cd slackbuild-tpm2-tss
make docker-artifact-build
# Slackware package will be created in ./pkgs
```

## Manual Build Instructions Under Slackware

The following instructs show how to build the package locally under Slackware.

Note: cryptsetup is needed to build

```bash
# Clone the git repo
git clone https://github.com/greycubesgav/slackbuild-tpm2-tss
cd slackbuild-tpm2-tss
# Grab the url from the .info file and download it
wget $(sed -n 's/DOWNLOAD="\(.*\)"/\1/p' *.info)
./tpm2-tss.SlackBuild
# Slackware package will be created in /tmp
```

## Install Instructions

Once the package is built, it can be installed with

```bash
upgradepkg --install-new --reinstall ./pkgs/tpm2-tss-*.tgz
```