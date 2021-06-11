#!/bin/sh

readonly PATRONI_SCOPE=${PATRONI_SCOPE:-batman}
PATRONI_NAMESPACE=${PATRONI_NAMESPACE:-/service}
readonly PATRONI_NAMESPACE=${PATRONI_NAMESPACE%/}
readonly DOCKER_IP=$(hostname --ip-address)

# Patroni settings
export PATRONI_SCOPE
export PATRONI_NAMESPACE
export PATRONI_NAME="${PATRONI_NAME:-$(hostname)}"

# REST API settings
export PATRONI_RESTAPI_CONNECT_ADDRESS=$DOCKER_IP:8008
export PATRONI_RESTAPI_LISTEN=0.0.0.0:8008

# PostgreSQL settings
export PATRONI_POSTGRESQL_CONNECT_ADDRESS=$DOCKER_IP:5432
export PATRONI_POSTGRESQL_LISTEN=0.0.0.0:5432
export PATRONI_REPLICATION_USERNAME="${PATRONI_REPLICATION_USERNAME:-replicator}"
export PATRONI_REPLICATION_PASSWORD="${PATRONI_REPLICATION_PASSWORD:-replicate}"
export PATRONI_SUPERUSER_USERNAME="${PATRONI_SUPERUSER_USERNAME:-postgres}"
export PATRONI_SUPERUSER_PASSWORD="${PATRONI_SUPERUSER_PASSWORD:-postgres}"
export PATRONI_REWIND_USERNAME="${PATRONI_REWIND_USERNAME:-postgres}"
export PATRONI_REWIND_PASSWORD="${PATRONI_REWIND_PASSWORD:-postgres}"
export PATRONI_POSTGRESQL_DATA_DIR=/app/postgresql/data
export PATRONI_POSTGRESQL_PGPASS=/tmp/pgpass0

echo "HOSTNAME:                           $PATRONI_NAME"
echo "DOCKER_IP:                          $DOCKER_IP"
echo "PATRONI_RESTAPI_CONNECT_ADDRESS:    $PATRONI_RESTAPI_CONNECT_ADDRESS"
echo "PATRONI_POSTGRESQL_CONNECT_ADDRESS: $PATRONI_POSTGRESQL_CONNECT_ADDRESS"
echo "PATRONI_POSTGRESQL_DATA_DIR:        $PATRONI_POSTGRESQL_DATA_DIR"
echo "PATRONI_ETCD3_HOSTS:                $PATRONI_ETCD3_HOSTS"
echo "PATRONI_SCOPE:                      $PATRONI_SCOPE"
echo "PATRONI_NAMESPACE:                  $PATRONI_NAMESPACE"

echo Starting Patroni
exec python3 -m patroni patroni.yml
