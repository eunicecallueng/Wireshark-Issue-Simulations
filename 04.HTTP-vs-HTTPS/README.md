HTTP vs. HTTPS (Clear Text Data Leak)

### Scenario Overview
For this last scenario, I wanted to see first-hand why everyone keeps insisting on using HTTPS everywhere. I simulated a mock login request over a regular HTTP connection to see if I could "sniff" my own password using Wireshark, and then compared it to an encrypted HTTPS connection.

---

### Simulation Steps
1. I fired up Wireshark and started capturing traffic on my Wi-Fi interface.
2. Since most of the web is already encrypted, I used an API testing tool called **httpbun.com** to send a mock login payload over a plain, unencrypted HTTP link using `curl`:
   ```cmd
   curl -X POST -d "user=TESTADMIN&pass=TESTPASSWORD" http://httpbun.com/post
3. To see the difference, I ran the exact same command right after, but changed the URL to the secure version: https://httpbun.com/post
4. I stopped the capture to check out what Wireshark recorded.

---

### Wireshark Analysis & Filters
To track down my credentials, I filtered the packet noise using:

http.request.method == "POST" (to find my HTTP login attempt)

*tls (to look at the secure HTTPS traffic)

What I learned from the PCAP:

HTTP is a massive data leak risk: When I found my HTTP POST packet, I right-clicked it and selected Follow > TCP Stream. Right there on the screen, my exact login credentials (user=PinoyAdmin&pass=Bagsik1234) were visible in plain text! It made me realize that if I were on public Wi-Fi, anyone running a packet sniffer could easily harvest that data.

HTTPS completely saves the day: When I looked at the HTTPS traffic under the TLS filter, everything was wrapped up as "Application Data." Trying to read the stream gave me nothing but unreadable, garbled characters. The password was completely safe and secure in transit.
