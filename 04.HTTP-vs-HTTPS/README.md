HTTP vs. HTTPS (Clear Text Data Leak)

### Scenario Overview
For this last scenario, I wanted to see first-hand why everyone keeps insisting on using HTTPS everywhere. I simulated a mock login request over a regular HTTP connection to see if I could "sniff" my own password using Wireshark, and then compared it to an encrypted HTTPS connection.

---

### Simulation Steps
1. I fired up Wireshark and started capturing traffic on my Wi-Fi interface.
2. Since most of the web is already encrypted, I used an API testing tool called **httpbun.com** to send a mock login payload over a plain, unencrypted HTTP link using `curl`:
   ```cmd
   curl -X POST -d "user=TESTADMIN&pass=TESTPASSWORD" http://httpbun.com/post

![Simulating HTTP](./http_connection.png)
   
3. To see the difference, I ran the exact same command right after, but changed the URL to the secure version: `https://httpbun.com/post`
4. I stopped the capture to check out what Wireshark recorded.

---

### Wireshark Analysis & Filters
To track down my credentials, I filtered out the packet noise using:
* `http.request.method == "POST"` (to find my HTTP login attempt)
* `tls` (to look at the secure HTTPS traffic)

**What I learned from the PCAP:**
* **HTTP is a massive data leak risk:** After applying the `http.request.method == "POST"` filter, I selected the specific packet where the destination port was **80** (the standard port for unencrypted HTTP traffic). I right-clicked it, went to **Follow > TCP Stream**, and it opened up a new window.

![HTTP TCP Stream](./http_tpc_stream.png)

Right then and there, you can clearly see the unencrypted username and password (`user=PinoyAdmin&pass=Bagsik1234`) in plain text! It really opened my eyes to how easy it is for someone to harvest data if you're browsing on a public Wi-Fi network without encryption.

![Unencrypted HTTP logins](./unencxrypted_pass.png)



* **HTTPS completely saves the day:** When I looked at the HTTPS traffic under the TLS filter, everything was neatly wrapped up as "Application Data" over port 443. Trying to read that stream gave me nothing but unreadable, garbled characters. The password remained completely safe and secure during transit.
