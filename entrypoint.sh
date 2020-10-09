#!/bin/bash

# Talend Remote Engine Docker entrypoint
# Updates config files if Remote Engine isn't paired yet

set -e

# Assume successful pairing if config already contains the specified preauthorized key
if ! grep -q "${TALEND_RE_KEY}" /opt/talend/remote-engine/etc/preauthorized.key.cfg; then
    # File doesn't contain preauthorized key
    sed -i "s|pairing\.service\.url.*|pairing.service.url=https://pair.${TALEND_RE_REGION}.cloud.talend.com|" /opt/talend/remote-engine/etc/org.talend.ipaas.rt.pairing.client.cfg
    sed -i "s|remote\.engine\.pre\.authorized\.key.*|remote.engine.pre.authorized.key = ${TALEND_RE_KEY}|" /opt/talend/remote-engine/etc/preauthorized.key.cfg
    sed -i "s|remote\.engine\.name.*|remote.engine.name = ${TALEND_RE_NAME}|" /opt/talend/remote-engine/etc/preauthorized.key.cfg
    sed -i "s|remote\.engine\.description.*|remote.engine.description = ${TALEND_RE_DESC}|" /opt/talend/remote-engine/etc/preauthorized.key.cfg
fi

exec "$@"
