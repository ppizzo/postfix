#!/bin/bash
#
# Environment variables used in this script, all mandatory:
#
#  - POSTFIX_DOMAIN
#  - POSTFIX_RELAY_HOST
#  - POSTFIX_RELAY_PORT
#  - POSTFIX_RELAY_USERNAME
#  - POSTFIX_RELAY_PASSWORD
#
########################################################################

# Check environment variables
if [[ -z $POSTFIX_DOMAIN || -z $POSTFIX_RELAY_HOST || -z $POSTFIX_RELAY_PORT || -z $POSTFIX_RELAY_USERNAME || -z $POSTFIX_RELAY_PASSWORD ]]; then
    echo "Required environment variables not set. Exiting." >&2
    sleep 2 # to avoid quick respawn of the container in case of errors
    exit 1
fi

# Create password file
echo "Creating password file"
echo "[${POSTFIX_RELAY_HOST}]:${POSTFIX_RELAY_PORT} ${POSTFIX_RELAY_USERNAME}:${POSTFIX_RELAY_PASSWORD}" >/etc/postfix/sasl_passwd
postmap /etc/postfix/sasl_passwd

# Create configuration
echo "Creating configuration"
cat main.cf.template |envsubst '$POSTFIX_DOMAIN:$POSTFIX_RELAY_HOST:$POSTFIX_RELAY_PORT:$POSTFIX_RELAY_USERNAME:$POSTFIX_RELAY_PASSWORD' >main.cf

# Start Postfix
echo "Starting Postfix"
exec postfix -v start-fg
