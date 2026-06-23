# Project 04 — Module 02: Windows Server Domain Controller Build

## 🎯 Purpose
This module covers the execution, promotion, and health validation of the root Domain Controller (`EntraConnectDC`) for the `iron.local` forest. This establishes the local on-premises directory infrastructure that will serve as the Source of Authority (SoA) before configuring synchronization into Microsoft Entra ID.

---

## 🧠 What This Lab Teaches
* Directory Services Role Deployment: Installing core binary files for Active Directory Domain Services (AD DS) and DNS Server simultaneously.
* Forest Infrastructure Architecture: Promoting a standalone server to a root forest container while selecting functional levels and directory components like the Global Catalog (GC).
* Enterprise Directory Diagnostics: Interpreting advanced command-line outputs from industry-standard utility tools to verify directory stability.

---

## 🛑 Before You Start
* Network Stability Checked: The VM network adapter is configured for NAT mode with a locked static IP of `10.0.50.90` and gateway of `10.0.50.2`.
* DNS Baseline Verification: The loopback configuration (`127.0.0.1`) is active on the network card, ensuring the server points to itself for local lookup.
* Identity Scope: Target root domain path designated as `iron.local`.

---

## 🖱️ GUI Build Steps

### Step 1: Install the Active Directory Binaries via Server Manager
1. Launch Server Manager and click Add roles and features.
2. Select Role-based or feature-based installation and choose `EntraConnectDC` from the server pool.
3. Check the box for Active Directory Domain Services. A pop-up window will appear; click Add Features to include the required management consoles and PowerShell modules.
4. Check the box for DNS Server and accept the matching management additions.
5. Click Next through the Features, AD DS, and DNS info screens, then click Install. Wait for the binary installation to finish.

### Step 2: Promote the Server to a Forest Root Domain Controller
1. Click the Notification Flag (Warning Icon) at the top right of Server Manager and select Promote this server to a domain controller.
2. On the Deployment Configuration page, select Add a new forest and enter the root domain name:
   * Root domain name: `iron.local`
3. On the Domain Controller Options page, configure these settings:
   * Forest functional level: `Windows Server 2016`
   * Domain functional level: `Windows Server 2016`
   * *Why this option?* Microsoft did not introduce new functional levels in Windows Server 2019 or 2022. Selecting 2016 unlocks all modern directory schema features while maintaining native compatibility.
   * Ensure Domain Name System (DNS) server and Global Catalog (GC) are both checked.
   * Enter a secure Directory Services Restore Mode (DSRM) password and store it safely.
4. Click Next through the DNS Delegation page (ignore the warning, as this is a new root forest zone that is not sub-delegated from a public parent domain).
5. Verify the NetBIOS domain name automatically sets to `IRON`.
6. Leave the Database, Log files, and SYSVOL paths at their production defaults (`C:\Windows\NTDS` and `C:\Windows\SYSVOL`).
7. Click Next to review selections, ensure the pre-requisite checks pass cleanly, and click Install. The server will automatically reboot to construct the database.

---

## 💻 Command Prompt Steps
Log into the server using the new domain administrator account (`IRON\Administrator`) and run these validation commands to check your workspace health:

### Force Domain Controller Discovery Lookup

```cmd
nltest /dsgetdc:iron.local
```

* What this proves: Forces the operating system to query DNS and actively locate the operational Domain Controller for the `iron.local` zone, validating network discovery paths, site bindings, and directory status flags.

### Run Comprehensive Active Directory Diagnostics

```cmd
dcdiag /q
```

* What this proves: Runs the full suite of Microsoft directory health checks in "Quiet" mode. This means it hides passing metrics and only returns text if a critical service component (like SYSVOL share replication or database indexing) fails.

---

## 📜 PowerShell Steps
Open an administrative PowerShell prompt on the newly promoted server to verify the structural forest layers:

```powershell
Get-ADForest -Identity "iron.local" | Select-Object Name, RootDomain, ForestMode
```

* What this does: Queries the Active Directory schema database to confirm that the forest container has loaded successfully and is operating under the expected Windows Server 2016 functional mode.

```powershell
Get-ADDomainController -Identity "EntraConnectDC" | Select-Object Name, IPAddress, IsGlobalCatalog, IsPrimaryDomainController
```

* What this does: Validates that `EntraConnectDC` holds the core operations master placement, confirms its static IP mapping, and verifies its status as a Global Catalog server.

---

## 🔍 Validation

### Expected Baseline Post-Deployment
| Metric / Check | Expected Operational Result | Verification Method |
| :--- | :--- | :--- |
| Domain DC Verification | Successful return showing status flags (`PDC`, `GC`, `LDAP`) | `nltest /dsgetdc:iron.local` |
| Quiet Diagnostic Run | Completely blank output (Zero errors reported) | `dcdiag /q` |
| Forest Mode Alignment | Mode shows `WindowsServer2016` | `Get-ADForest` via PowerShell |
| Core Directory Roles | Active directory database listens at `10.0.50.90` | `Get-ADDomainController` |

### What Failure Looks Like
* Symptom: `nltest` returns an error stating "Status = 1355 (0x54B) ERROR_NO_SUCH_DOMAIN".
* Root Cause: The network adapter's DNS server was reset during the reboot or is pointing out to an external public internet router instead of pointing directly to the server's local loopback IP address.

---

## 🛠️ Troubleshooting

| Issue | Possible Cause | How to Validate | Fix |
| :--- | :--- | :--- | :--- |
| AD DS Installation Fails on Pre-requisites | Missing static IP configuration | Run `ipconfig` to see if DHCP is active | Cancel wizard, configure static IP properties on network card, and restart promotion |
| DNS Delegation Warning on Promotion Page | Parent zone mismatch | Appears natively when using internal extensions like `.local` | This is expected behavior for an isolated root lab environment; click through to bypass safely |

---

## 🔒 Security & Governance Notes
* DSRM Password Protection: The Directory Services Restore Mode password bypasses normal domain access controls if the database becomes corrupted. In an enterprise environment, this credential must be decoupled from standard domain admin passwords and locked inside an encrypted vault.
* Global Catalog Availability: In multi-site setups, missing Global Catalog configurations slow down authentication pathways. Marking the initial root DC as a GC ensures that local authorization processing stays optimal from day one.

---

## 📝 Documentation Evidence

```cmd
PS C:\Windows\system32> nltest /dsgetdc:iron.local
           DC: \\EntraConnectDC.Iron.local
      Address: \\10.0.50.90
     Dom Guid: 5bed29e8-86ac-41b1-a6d4-f7a8a86c85f4
     Dom Name: Iron.local
  Forest Name: Iron.local
 Dc Site Name: Default-First-Site-Name
Our Site Name: Default-First-Site-Name
        Flags: PDC GC DS LDAP KDC TIMESERV GTIMESERV WRITABLE DNS_DC DNS_DOMAIN DNS_FOREST CLOSE_SITE FULL_SECRET WS DS_8 DS_9 DS_10 KEYLIST
The command completed successfully

PS C:\Windows\system32> dcdiag /q
PS C:\Windows\system32>
```

---

## 🎓 Lessons Learned
* Interpreting Quiet Mode Outputs: In systems engineering, an empty response from a quiet query (`dcdiag /q`) is the ideal outcome, confirming that all background replication paths and services are working perfectly.
* Functional Level Limits: Windows Server 2016 remains the top functional ceiling for Active Directory architectures deployed on Windows Server 2022 environments, meaning no additional forest-level updates are needed during configuration.

---

## 🗣️ Interview Talking Points
> "When building out hybrid directories, I focus heavily on ensuring the underlying on-premises engine is completely healthy before linking it to the cloud. In my lab environment, I stood up a Windows Server 2022 instance, promoted it to a new forest root for `iron.local` using a Windows Server 2016 functional baseline, and validated the build using advanced command-line utilities. By running commands like `nltest /dsgetdc` and inspecting the environment with a quiet `dcdiag` test run, I verified that core infrastructure components like Global Catalog indexing and DNS SRV registration were functional without errors before moving toward cloud integration."

---

## 💾 Commit Message

```text
feat: complete project 04 module 02 windows server domain controller build
```