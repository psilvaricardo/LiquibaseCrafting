
FROM liquibase/liquibase

COPY changelog/changelog.xml /liquibase/

USER root

RUN curl -o /usr/local/bin/wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && \
    chmod +x /usr/local/bin/wait-for-it.sh

COPY liquibase-entrypoint.sh /liquibase-entrypoint.sh

RUN chmod +x /liquibase-entrypoint.sh
USER liquibase

