HTTP vs. HTTPS (Clear Text Data Leak)

### Scenario Overview
For this last scenario, I wanted to see first-hand why everyone keeps insisting on using HTTPS everywhere. I simulated a mock login request over a regular HTTP connection to see if I could "sniff" my own password using Wireshark, and then compared it to an encrypted HTTPS connection. The results were honestly eye-opening!

### Simulation Steps
1. I fired up Wireshark and started capturing traffic on my Wi-Fi interface.
2. Since most of the web is already encrypted, I used an API testing tool called **httpbun.com** to send a mock login payload over a plain, unencrypted HTTP link using `curl`:
   ```cmd
   curl -X POST -d "user=PinoyAdmin&pass=Bagsik1234" [http://httpbun.com/post](http://httpbun.com/post)
