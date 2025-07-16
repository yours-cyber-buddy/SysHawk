**# 🦅 SysHawk – Windows Threat Detection Tool (CLI)**



\*\*SysHawk\*\* is a simple and powerful PowerShell-based threat analysis tool for Windows systems. It helps detect \*\*suspicious processes\*\*, \*\*malicious services\*\*, \*\*invalid autoruns\*\*, and \*\*unusual TCP connections\*\* — all from a clean command-line interface.



🧠 Built with core Windows security techniques in mind, SysHawk gives system admins, forensic analysts, and cybersecurity enthusiasts an easy way to spot potential threats without complex setups.







**## ✨ Key Features**



✅ Scan running processes and highlight suspicious activity  

✅ Detect suspicious Windows services (like fake svchost.exe, etc.)  

✅ List autorun entries pointing to missing or weird files  

✅ Show unusual TCP connections (external remote IPs)







**## 📁 Folder Structure**



SysHawk/

│

├── SysHawk.ps1 # Main CLI launcher

├── SysHawk.psm1 # Imports all modules

├── README.md # You're reading it :)

├── Modules/

│ ├── ProcessScanner.psm1

│ ├── ServiceScanner.psm1

│ ├── AutorunScanner.psm1

│ └── TCPScanner.psm1







**## 🚀 How to Run**



> 🛑 You \*\*must run PowerShell as Administrator\*\* for full results!



1\. Open PowerShell as Administrator  



2\. Go to the SysHawk folder:

&nbsp; powershell:  cd "Full\\Path\\To\\SysHawk"  # Replace with the actual path on your system



3\. Start the tool:

.\\SysHawk.ps1



4\. Choose an option from the menu:

\[1] Scan Processes

\[2] Scan Services

\[3] Scan Autoruns

\[4] Scan TCP Connections

\[5] Run Full System Scan

\[0] Exit





**##🖥️ Sample Output**



=== SysHawk Threat Analysis Tool ===



Enter option number: 2



\[+] Scanning Services...

\[!] Suspicious service detected: svch0st

&nbsp;   Path: C:\\Users\\Public\\svch0st.exe

&nbsp;   Status: Running

&nbsp;   Description: Unsigned, Unknown Origin





**##📦 Requirements**



🪟 Windows 10 or newer



⚙️ PowerShell 5.1 or later



👨‍💻 Administrator access (to read system-level data)





**##💡 Why Use SysHawk?**



* No third-party tools required



* Fully portable – just PowerShell scripts



* Great for quick system investigations



* Ideal for learners building security intuition





🙋‍♂️ Author

* Created by: Yours Cyber Buddy.
* If you like this tool, ⭐️ star the repo and share it with others!





🛡️ Note

* SysHawk does not remove malware. It's a manual analysis tool designed to assist detection and triage. Use alongside antivirus and forensic tools for full coverage.























