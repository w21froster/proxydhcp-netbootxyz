#!/bin/sh
set -e

TEMPLATE_FILE="/etc/dnsmasq.conf.template"
CONFIG_FILE="/etc/dnsmasq.conf"

# Validate required environment variables
if [ -z "$PROXYDHCP_SERVER_IP" ]; then
    echo "[dnsmasq-template] ERROR: PROXYDHCP_SERVER_IP environment variable is not set."
    echo "[dnsmasq-template] Please set it to the IP address of this server (e.g., -e PROXYDHCP_SERVER_IP=192.168.1.100)"
    exit 1
fi

if [ -z "$PROXYDHCP_SUBNET" ]; then
    echo "[dnsmasq-template] ERROR: PROXYDHCP_SUBNET environment variable is not set."
    echo "[dnsmasq-template] Please set it to your network subnet (e.g., -e PROXYDHCP_SUBNET=192.168.1.0)"
    exit 1
fi

echo "[dnsmasq-template] Using proxyDHCP server IP: ${PROXYDHCP_SERVER_IP}"
echo "[dnsmasq-template] Using proxyDHCP subnet: ${PROXYDHCP_SUBNET}"

export PROXYDHCP_SERVER_IP
export PROXYDHCP_SUBNET

# Substitute variables and write the config
envsubst '${PROXYDHCP_SERVER_IP} ${PROXYDHCP_SUBNET}' < "${TEMPLATE_FILE}" > "${CONFIG_FILE}"

echo "[dnsmasq-template] Configuration generated successfully"