FROM postgres:13.3

# Install pip
RUN apt-get update && \
    apt-get install -y python3-pip git

# Install psycopg2 patroni
RUN pip3 install psycopg2-binary==2.8.6 && \
    pip3 install "git+https://github.com/zalando/patroni.git@v2.0.2#egg=patroni[etcd]"

WORKDIR /app

# Add PG13 tools to path
RUN PATH=$PATH:/usr/lib/postgresql/13/bin

# Make postgres user the owner of the app directory
RUN chown -R postgres: /app

USER postgres

# Create data directories with correct permissions for postgres
RUN mkdir postgresql && \
    mkdir postgresql/data && \
    chmod -R 700 postgresql

COPY patroni.yml patroni.yml
COPY entrypoint.sh entrypoint.sh

ENTRYPOINT ["/bin/sh", "entrypoint.sh"]
