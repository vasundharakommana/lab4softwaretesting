#!/usr/bin/env bash
# wait-for-it.sh
# Use this script to wait for a service to become available before starting another service.

# Usage:
# ./wait-for-it.sh <host> <port> -- <command> <args>

TIMEOUT=30
WAIT_HOSTS=$1
WAIT_PORT=$2
shift 2

# Ensure the given host and port are reachable before executing the command
until nc -z $WAIT_HOSTS $WAIT_PORT; do
  echo "Waiting for $WAIT_HOSTS:$WAIT_PORT..."
  sleep 1
done

echo "$WAIT_HOSTS:$WAIT_PORT is now available!"
exec "$@"
