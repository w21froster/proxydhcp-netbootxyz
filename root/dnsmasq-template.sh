#!/bin/sh
set -e

TEMPLATE_FILE="/etc/dnsmasq.conf.template"
CONFIG_FILE="/etc/dnsmasq.conf"

# Auto‑detect IP if not provided
if [ -z "$PROXYDHCP_SERVER_IP" ]; then
    echo "[dnsmasq-template] PROXYDHCP_SERVER_IP not set, attempting auto-detection..."
    # Use the IP used to reach the internet (via default route)
    DEFAULT_IP=$(ip route get 1 | grep -o 'src [0-9.]*' | cut -d' ' -f2)
    if [ -n "$DEFAULT_IP" ]; then
        PROXYDHCP_SERVER_IP="$DEFAULT_IP"
        echo "[dnsmasq-template] Auto-detected proxyDHCP server IP: ${PROXYDHCP_SERVER_IP}"
    else
        echo "[dnsmasq-template] Error: Could not auto-detect IP address. Please set PROXYDHCP_SERVER_IP."
        exit 1
    fi
else
    echo "[dnsmasq-template] Using provided proxyDHCP server IP: ${PROXYDHCP_SERVER_IP}"
fi

export PROXYDHCP_SERVER_IP

# Substitute only the PROXYDHCP_SERVER_IP variable and write the config
envsubst '${PROXYDHCP_SERVER_IP}' < "${TEMPLATE_FILE}" > "${CONFIG_FILE}"
