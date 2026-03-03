# proxydhcp-netbootxyz

**A wrapper around the [netbootxyz docker image](https://github.com/netbootxyz/docker-netbootxyz) that runs in proxyDHCP mode.**  
PXE boot netboot.xyz without touching your existing DHCP server – the container listens alongside it and only supplies boot information.

---

## Quick Start

```bash
docker run -d \
  --name=proxydhcp-netbootxyz \
  --network host \
  -v /path/to/tftp/menus:/config/menus \   # optional, for persistent menus
  ghcr.io/netbootxyz/proxydhcp-netbootxyz
```

> **Why `--network host`?**  
> ProxyDHCP needs direct access to the network interface to listen for DHCP requests.

That's it! Your PXE clients will now see the netboot.xyz menu without any changes to your DHCP server configuration.

---

## What's included?

This container is the original netbootxyz image, but with **proxyDHCP preconfigured**. You get:

- TFTP server (port 69) serving boot files
- ProxyDHCP that responds to PXE clients with the correct boot file and server IP
- Web UI at `http://<your-host-ip>:3000` for managing menus and assets
- HTTP asset hosting on port 80 (map to host port if desired, e.g. `-p 8080:80`)

All other features (persistent volumes, environment variables, user/group IDs) work exactly as documented in the [original repository](https://github.com/netbootxyz/docker-netbootxyz).

---

## Next Steps

- **Persist assets** – add `-v /path/to/assets:/assets` to cache downloaded ISOs.
- **Customize** – see the [original repo](https://github.com/netbootxyz/docker-netbootxyz) for volume mounts, environment variables, and advanced configuration.
- **Documentation** – full netboot.xyz docs: [netboot.xyz/docs](https://netboot.xyz/docs/)

---

*This is a lightweight wrapper around the official netbootxyz Docker image – all credit to the netboot.xyz team. For issues, feature requests, or contributions, please refer to the [main repository](https://github.com/netbootxyz/docker-netbootxyz).*