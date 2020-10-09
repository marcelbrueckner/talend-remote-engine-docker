# Talend Remote Engine in Docker

:warning: **This repository has just been quickly hacked together as a proof of concept and is not officially supported by [Talend, Inc.](https://github.com/Talend)**

This repository contains a basic `Dockerfile` to show how a remote engine can be run in Docker. In order to build this image, you have to log in to the [Talend Portal](https://portal.eu.cloud.talend.com/) and download the *Archive for Linux (tar.gz)* in the desired version into the `remote-engine/` subfolder.

```bash
# When setting the version, make sure the exact string is contained in the Talend Remote Engine archive's name
# Usually the archive name resembles to "Talend-RemoteEngine-V<X>.<Y>.<Z>-<BUILD_NUMBER>.tar.gz"
export TALEND_RE_VERSION="2.9.1"
docker build -t marcelbrueckner/talend-remote-engine:${TALEND_RE_VERSION} --build-arg TALEND_RE_VERSION=${TALEND_RE_VERSION} .
```

Start a container from your newly built image. Simply place your environment variables in a dedicated file (see `example.env` in this repository). Don't forget to persist the Engine's configuration to be able to connect on a container restart.

```bash
docker run -d --env-file .env --volume "remote-engine-data:/opt/talend/remote-engine/etc" marcelbrueckner/talend-remote-engine:${TALEND_RE_VERSION}
```

Alternatively export the values to your environment and pass them along.

```bash
export TALEND_RE_KEY="<Your super secret pairing key>"
export TALEND_RE_NAME="<Name of your Remote Engine>"
export TALEND_RE_DESC="<Some descriptive words>"
# One of eu, us, ap, us-west
export TALEND_RE_REGION=eu
docker run -d --env TALEND_RE_KEY --env TALEND_RE_NAME --env TALEND_RE_DESC --env TALEND_RE_REGION --volume "remote-engine-data:/opt/talend/remote-engine/etc" marcelbrueckner/talend-remote-engine:${TALEND_RE_VERSION}
```
