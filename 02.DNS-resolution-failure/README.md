## Lab 2: DNS Resolution Failure Simulation

### Objective
Analyze network behavior and packet retransmissions when a client machine is configured with an unresponsive or down DNS server.

### How to Reproduce
1. Change Windows 11 IPv4 DNS settings manually to a non-existent local IP (e.g., `10.0.0.99`).
2. Flush the local Windows DNS cache using `ipconfig /flushdns` via Command Prompt.
3. Open Wireshark, start capturing on the active interface, and apply the display filter: `dns`.
4. Trigger a lookup in the terminal using: `nslookup testing12345.com`.
5. Stop the Wireshark capture and immediately restore Windows DNS settings to **Automatic (DHCP)**. Save the capture as `dns_failure.pcapng`.

### Wireshark Analysis Findings
- **Unanswered Queries:** Wireshark records outgoing `Standard query` UDP packets directed to port 53 of the dead IP address.
- **Timeout Behavior:** The capture shows a lack of incoming `Standard query response` packets, resulting in the operating system timing out the request after multiple unacknowledged retries.
