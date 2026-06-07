# Network Latency and Packet Loss Simulation

This project demonstrates how network impairments—specifically latency and packet loss—affect TCP traffic, resulting in duplicate acknowledgments and packet retransmissions.

## Simulation Setup

To replicate the network issue, I used the following tools and configurations:

1. **Network Emulator (Clumsy):**
   * Turned on Lag to give the network some intentional delay.
   * Turned on Drop to simulate those annoying packet losses.
     
2. **Traffic Generation:**
   * Ran a continuous ping in the Command Prompt to generate constant network traffic:
     ```cmd
     ping 1.1.1.1 -t
     ```
3. **Packet Capture:**
   * Used Wireshark to capture the traffic and saved the results in a `.pcapng` file.

![Packet Loss Simulation](./packet_loss.png)

---

## Analysis & Findings

When I looked at the Wireshark capture, the logs were practically screaming with **TCP Dup Ack** and **TCP Retransmission** flags. Here’s what was actually happening behind the scenes:

### 1. TCP Dup Ack (Duplicate Acknowledgment)
* **The Lowdown:** This happens when the receiver gets packets out of order (thanks to *Clumsy* dropping or delaying them).
* **What it looks like:** The receiver keeps reminding the sender, *"Hey, I'm missing something!"* by repeatedly asking for the last successful in-order packet it actually received.

### 2. TCP Retransmission
* **The Lowdown:** This is the sender realizing, *"Oops, looks like that packet didn't make it."*
* **What it looks like:** Once the sender gets hit with multiple **Dup Acks** (Fast Retransmit) or a **Timeout** (RTO), it resends the missing packet to make sure no data gets left behind. 

![Captured packet](./tcp.analysis.flags.png)

---

## Want to check out the capture?
If you want to dive into the data yourself, just open the `.pcapng` file in Wireshark and use these display filters:
* To spot the duplicate ACKs: `tcp.analysis.duplicate_ack`
* To spot the retransmissions: `tcp.analysis.retransmission`
