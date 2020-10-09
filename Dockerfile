FROM azul/zulu-openjdk:11

ARG TALEND_RE_VERSION

ADD remote-engine/Talend-RemoteEngine-V${TALEND_RE_VERSION}-*.tar.gz /opt/talend/
RUN mv /opt/talend/Talend-RemoteEngine-V${TALEND_RE_VERSION} /opt/talend/remote-engine/
COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/opt/talend/remote-engine/bin/trun", "server"]
