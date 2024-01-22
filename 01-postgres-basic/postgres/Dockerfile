FROM postgres

ENV POSTGRES_USER testuser
ENV POSTGRES_PASSWORD docker
ENV POSTGRES_DB testing

COPY user.sql /docker-entrypoint-initdb.d/
