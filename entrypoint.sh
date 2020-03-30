#!/bin/bash
set -e
rails ts-index
rails ts-start
# Remove a potentially pre-existing server.pid for Rails.
rm -f /SalesStore/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"