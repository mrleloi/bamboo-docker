FROM openjdk:11-bullseye

LABEL maintainer="ledinhloi1997@gmail.com" version="8.7.1"

ARG ATLASSIAN_PRODUCTION=atlassian-bamboo
ARG APP_NAME=bamboo
ARG APP_VERSION=9.2.8
ARG AGENT_VERSION=1.3.3
ARG MYSQL_DRIVER_VERSION=8.0.22

ENV BAMBOO_HOME=/var/bamboo \
    BAMBOO_INSTALL=/opt/bamboo \
    JVM_MINIMUM_MEMORY=1g \
    JVM_MAXIMUM_MEMORY=3g \
    JVM_CODE_CACHE_ARGS='-XX:InitialCodeCacheSize=1g -XX:ReservedCodeCacheSize=2g' \
    AGENT_PATH=/var/agent \
    AGENT_FILENAME=atlassian-agent.jar \
    LIB_PATH=/bamboo/WEB-INF/lib

ENV JAVA_OPTS="-javaagent:${AGENT_PATH}/${AGENT_FILENAME} ${JAVA_OPTS}"

RUN mkdir -p ${BAMBOO_INSTALL} ${BAMBOO_HOME} ${AGENT_PATH} ${BAMBOO_INSTALL}${LIB_PATH} \
&& curl -o ${AGENT_PATH}/${AGENT_FILENAME}  https://github.com/haxqer/confluence/releases/download/v${AGENT_VERSION}/atlassian-agent.jar -L \
&& curl -o /tmp/atlassian.tar.gz https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-${APP_NAME}-${APP_VERSION}.tar.gz -L \
&& tar xzf /tmp/atlassian.tar.gz -C /opt/bamboo/ --strip-components 1 \
&& rm -f /tmp/atlassian.tar.gz \
&& curl -o ${BAMBOO_INSTALL}/lib/mysql-connector-java-${MYSQL_DRIVER_VERSION}.jar https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_DRIVER_VERSION}/mysql-connector-java-${MYSQL_DRIVER_VERSION}.jar -L \
&& cp ${BAMBOO_INSTALL}/lib/mysql-connector-java-${MYSQL_DRIVER_VERSION}.jar ${BAMBOO_INSTALL}${LIB_PATH}/mysql-connector-java-${MYSQL_DRIVER_VERSION}.jar \
&& echo "bamboo.home = ${BAMBOO_HOME}" > ${BAMBOO_INSTALL}/${ATLASSIAN_PRODUCTION}/WEB-INF/classes/bamboo-init.properties

WORKDIR $BAMBOO_INSTALL
EXPOSE 8085

ENTRYPOINT ["/opt/bamboo/bin/start-bamboo.sh", "-fg"]
