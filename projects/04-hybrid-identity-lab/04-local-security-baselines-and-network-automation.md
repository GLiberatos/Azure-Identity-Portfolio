# Project 04 — Module 04: Local Security Baselines & Network Automation

## 🎯 Purpose

This module covers the migration of core network allocation services from hypervisor control to an authoritative Windows Server architecture, alongside the implementation of a standard corporate endpoint hardening model. It automates client network configurations and establishes consistent account lockout safety policies across all domain-joined client workstations before syncing parameters with cloud services.

---

## 🧠 What This Lab Teaches

* Authoritative Network Provisioning: Deploying and configuring a centralized Windows DHCP server to manage IP allocation bounds, gateway routing, and internal name resolution paths.
* Endpoint Policy Governance: Constructing custom Group Policy Objects (GPOs) to apply uniform local operating system account security limits across corporate endpoints.
* Directory Path Remediation: Navigating Active Directory structural path mechanics to overcome Group Policy application blocks caused by default generic system containers.

---

## 🛑 Before You Start

* Lab Environment State: The root Domain Controller (`EntraConnectDC`) is fully operational within the isolated `iron.local` forest.
* Network Infrastructure State: A fresh Windows 11 client machine (`Workstation1`) has been provisioned on the identical hypervisor NAT network segment (`VMnet8`).
* Execution Privileges: Logged into the infrastructure systems as an active member of the `Domain Admins` group.

---

## 🖱️ GUI Build Steps

### Step 1: Mitigate Subnet Conflict Scopes

1. On the physical host machine, launch the VMware Virtual Network Editor application with elevated Administrative privileges.
2. Select the designated virtual network switch slot assigned to the lab space (VMnet8).
3. Clear the selection checkbox for "Use local DHCP service to distribute IP address to VMs".
4. Click Apply and click OK to commit changes to the hypervisor service.
   * *What this setting does:* Disables the hypervisor's native DHCP broadcast responder on this network segment.
   * *Why we choose it:* Eliminates the risk of a network race condition between the hypervisor and our domain server, ensuring client requests only receive answers from our authoritative controller.

### Step 2: Deploy and Authorize the Server DHCP Role

1. Log into `EntraConnectDC`, access the Server Manager dashboard, and click Add roles and features.
2. Advance through the wizard steps to the Server Roles selection sheet and check the box for DHCP Server (approving all required management sub-components).
3. Complete the installation sequence.
4. Locate the top status pane, click the yellow warning notification flag, and select Complete DHCP configuration.
5. In the Post-Deployment Configuration Wizard, click Next, choose Use the following user's credentials (ensuring your Domain Admin account is active), and click Commit to perform infrastructure authorization. Click Close.

### Step 3: Configure the Authoritative IPv4 DHCP Scope

1. Open Server Manager, click Tools in the top-right menu block, and select DHCP (`dhcpmgmt.msc`).
2. In the left navigation pane, expand your domain server node (`EntraConnectDC.iron.local`).
3. Right-click the IPv4 folder node and select New Scope to initialize the setup wizard. Click Next.
4. Input the following configuration definitions throughout the parameter wizard steps:
   * Name: `LAB-IPv4-Scope`
   * Start IP Address: `10.0.50.100`
   * End IP Address: `10.0.50.200`
   * Subnet Mask: `255.255.255.0`
5. Click Next past the exclusion boundaries and lease time frames until the Configure DHCP Options panel appears. Select Yes, I want to configure these options now, and click Next.
6. Configure the authoritative options matching the corporate baseline network layout:
   * Option 003 (Router / Default Gateway): Type `10.0.50.2` into the address field, click Add, and click Next.
   * Option 006 (DNS Servers): Verify the Parent Domain text box displays `iron.local`. Add `10.0.50.90` to the IP list, click Add, and click Next.
7. Select Yes, I want to activate this scope now, click Next, and click Finish.

### Step 4: Engineer the Corporate Account Lockout GPO

1. On `EntraConnectDC`, press `Win + R`, type `gpmc.msc`, and press Enter to open the Group Policy Management Console.
2. Expand the forest and domain folders, right-click the Group Policy Objects container, and select New.
3. Name the object `LAB-Sec-AccountLockout-Policy` and click OK.
4. Right-click the new policy object and choose Edit to launch the Group Policy Management Editor.
5. In the left tree layout, navigate down through the following security folder branches:
   `Computer Configuration \ Policies \ Windows Settings \ Security Settings \ Account Policies \ Account Lockout Policy`
6. Double-click each of the following rule lines in the details panel to apply and enforce corporate security targets:
   * Account lockout threshold: Type `5` invalid logon attempts and click OK.
   * Account lockout duration: Set to `10` minutes and click OK.
   * Reset account lockout counter after: Set to `10` minutes and click OK.
7. Close the policy editor window.
8. In the main Group Policy Management window, right-click your custom corporate root Corp Organizational Unit (OU) folder, select Link an Existing GPO..., highlight `LAB-Sec-AccountLockout-Policy`, and click OK.

### Step 5: Execute Client Domain Join and Object Relocation

1. Log into your standalone Windows 11 Client machine (`Workstation1`).
2. Right-click the Start menu, select Run, type `sysdm.cpl`, and hit Enter to access System Properties.
3. Click the Change... button, select the Domain radio option, type `iron.local` into the text box, and click OK.
4. Authenticate using your domain administrator credentials when prompted by the Windows Security alert window.
5. Click OK on the welcome dialog window and approve the required system restart request.
6. Switch back to your Domain Controller (`EntraConnectDC`) and launch Active Directory Users and Computers (`dsa.msc`).
7. Click the default built-in Computers folder container. Right-click the newly registered `Workstation1` computer object and choose Move....
8. Navigate down through the directory tree selection box, expand `LAB` -> `Corp` -> `Computers`, highlight the target sub-OU folder named Workstations, and click OK.

---

## 💻 Command Prompt Steps

Verify address baseline updates and group policy status on the client machine by executing these verification tasks inside an administrative Command Prompt session on `Workstation1`:

```cmd
ipconfig /all
```

* What this command proves: Confirms that the end-user machine has correctly dropped hypervisor IP routing bounds and successfully leased its configuration options directly from our authoritative domain DHCP server.

```cmd
gpresult /r
```

* What this command proves: Queries the local security subsystem descriptor list, validating that our custom GPO container has successfully transferred down to the workstation endpoint.

```cmd
net accounts
```

* What this command proves: Interrogates the active local operating system SAM database configuration to guarantee that the account lockout policies are live and enforced on the machine.

---

## 📜 PowerShell Steps

Force an immediate, manual baseline policy synchronization check from the client computer by running this command block within an administrative PowerShell console on `Workstation1`:

```powershell
# Force client machine evaluation of pending active directory policy changes
gpupdate /force
```

### Why this command matters:

* `gpupdate /force` bypasses standard background operating system application timers, forcing the machine to immediately pull down and execute newly inherited configuration changes from the domain controller database.

---

## 🔍 Validation

### Expected Directory Configuration

| Metric / Target Object | Expected State | Verification Method |
| :--- | :--- | :--- |
| Authoritative DHCP Server | Leased Client IP lists match domain origin `10.0.50.90` | Check DHCP server lease pools or execute client `ipconfig` |
| Subnet Route Exit Path | Option 003 Gateway address matches `10.0.50.2` | Inspect network interface details under client `ipconfig /all` |
| Security Policy Delivery | `LAB-Sec-AccountLockout-Policy` applied successfully | Review Computer Settings output inside client `gpresult /r` |
| Local Security Guardrails | Lockout threshold displays an active count value of `5` | Run the administrative `net accounts` console application check |

### What Failure Looks Like

* Symptom: Running `net accounts` on the client workstation reveals that the account lockout threshold value remains completely empty or is set to unconfigured (`N/A`).
* Root Cause: The target client computer object has been left sitting in the default, built-in `CN=Computers` container folder. Because generic containers lack the directory structure schema needed to hold policy link targets, the machine remains blind to custom corporate OUs.

---

## 🛠️ Troubleshooting

| Issue | Possible Cause | How to Validate | Fix |
| :--- | :--- | :--- | :--- |
| Workstation join wizard returns a path error stating domain controller cannot be located | Client is query-routing requests to external network addresses | Run `ipconfig /all` on the client and verify the active DNS Server field addresses | Access network adapter configuration properties, locate IPv4, and change preferred DNS to look directly at the static server IP `10.0.50.90`. |
| Custom lockout baselines do not execute or apply to the target Domain Controller system | Policy inheritance scope blocks non-nested target layers | Run `gpresult /r /v` on the domain controller to audit active applied policy trees | Domain Controller computers live in a dedicated default OU branch. To modify user password/lockout policies domain-wide, apply modifications inside GPOs linked at the domain root level. |

---

## 🔒 Security and Governance Notes

* DHCP Server Authorization Enforcement: Active Directory leverages the authorization model to prevent unauthorized rogue DHCP engines from operating on production subnets. Unmanaged servers that lack explicit directory clearance are systematically shut down by the operating system to prevent address spoofing and traffic redirection attacks.
* Link Restrictions and Perimeter Hardening: Group Policy links must always target the lowest appropriate container path inside your directory tree. Linking account lockout GPOs to our corporate workload OUs ensures our critical production server segments remain completely distinct from standard user device footprints, reducing internal lateral movement risks.

---

## 📝 Documentation Evidence

```cmd
C:\Users\entraconnect>ipconfig /all

Windows IP Configuration
   Host Name . . . . . . . . . . . . : Workstation1
   Primary Dns Suffix  . . . . . . . : Iron.local

Ethernet adapter Ethernet0:
   IPv4 Address. . . . . . . . . . . : 10.0.50.128(Preferred)
   Subnet Mask . . . . . . . . . . . : 255.255.255.0
   Default Gateway . . . . . . . . . : 10.0.50.2
   DHCP Server . . . . . . . . . . . : 10.0.50.90
   DNS Servers . . . . . . . . . . . : 10.0.50.90

C:\Windows\System32>net accounts
Force user logoff how long after time expires?:      Never
Minimum password age (days):                         0
Maximum password age (days):                         42
Minimum password length:                             7
Length of password history maintained:               24
Lockout threshold:                                   5
Lockout duration (minutes):                          10
Lockout observation window (minutes):                10
Computer role:                                       WORKSTATION
The command completed successfully.
```

---

## 🎓 Lessons Learned

* Subnet Authority Consolidation: Running dual DHCP allocation endpoints on a single broadcast subnet triggers unpredictable connection drops due to race conditions. Network integrity relies on isolating address distribution duties to a single authoritative server node.
* Container Inheritance Limitations: Generic directory nodes (such as `CN=Computers` or `CN=Users`) behave differently than true Organizational Units (OUs). They cannot process direct Group Policy object mappings, requiring system administrators to establish structured corporate OU branches to deploy baseline defenses.

---

## 🗣️ Interview Talking Points

> "When building out core enterprise network baselines, I systematically avoid leaving newly registered client machines inside the default `CN=Computers` folder container. Because default containers cannot process Group Policy object link parameters, endpoints left there will remain completely exposed and fail to inherit required corporate defense benchmarks. Instead, I deploy an automated, Active Directory-authorized Windows DHCP service to deploy targeted routing profiles across our subnet footprint, while utilizing a structured, nested Organizational Unit layer to guarantee our security update pathways deploy perfectly to the local endpoint operating systems."