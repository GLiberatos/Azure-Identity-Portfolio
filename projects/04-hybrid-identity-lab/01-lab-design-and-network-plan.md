# Project 04 — Module 01: Lab Design and Network Plan

## 🎯 Purpose

This module establishes the foundational network architecture and identity routing design for a secure, isolated hybrid identity lab.

By architecting an isolated virtual network, the local Active Directory Domain Services (AD DS) environment can communicate with the internet to sync with Microsoft Entra ID without causing routing conflicts with the physical host network.

---

## 🧠 What This Lab Teaches

- 🌐 Hypervisor Network Virtualization: Configuring custom Network Address Translation (NAT) subnets within VMware.
- 🔢 Hybrid Subnet Planning: Preventing overlapping IP space conflicts between home and lab networks.
- 🆔 Identity Routing Design: Evaluating the impact of non-routable top-level domains, such as `.local`, on cloud synchronization and planning alternative User Principal Name (UPN) suffixes.

---

## 🛑 Before You Start

- 💻 Hypervisor Platform: VMware Workstation or VMware ESXi 8 installed on the host machine.
- 🗺️ Host Network Awareness: Identified the physical local subnet, such as `192.168.50.0/24`, to ensure the lab subnet does not overlap.
- ☁️ Cloud Tenant Suffix: Access to the Microsoft Entra ID tenant domain prefix, `xkdk1.onmicrosoft.com`.

---

## 🖱️ GUI Build Steps

### Step 1: Configure the VMware Virtual Network Editor

1. Open the Virtual Network Editor on your host machine with Administrator privileges.
2. Select the NAT network adapter, typically VMnet8.
3. Under Subnet IP, change the range to match the isolated enterprise block:

| Setting | Value |
| :--- | :--- |
| Subnet IP | `10.0.50.0` |
| Subnet Mask | `255.255.255.0` |

4. Click NAT Settings to modify the virtual gateway:

| Setting | Value |
| :--- | :--- |
| Gateway IP | `10.0.50.2` |

> 💡 Why this option?
> In VMware NAT, `.1` is reserved for the host machine's virtual interface, and `.2` functions as the virtual router gateway providing internet access.

5. Click Apply.
6. Click OK.

### Step 2: Adjust Virtual Machine Hardware Network Settings

1. Right-click the `EntraConnectDC` virtual machine.
2. Select Settings.
3. Navigate to the Network Adapter hardware component.
4. Change the network connection type from Bridged to NAT.

> 💡 Why this option?
> Bridged mode exposes the VM directly to the home broadcast domain. NAT mode isolates the AD DS traffic inside the hypervisor while using the host's IP address to source-translate internet traffic.

---

## 💻 Command Prompt Steps

Run these validation commands on the guest operating system, `EntraConnectDC`, to confirm baseline network functionality.

### Validate Hostname

```cmd
hostname
```

* What this proves: This confirms that the system identifies itself by the designated server name: `EntraConnectDC`.

### Validate IP Configuration

```cmd
ipconfig /all
```

* What this proves: This validates that the guest operating system interface has acquired or been assigned an IP address within the `10.0.50.x` subnet.

### Validate Internet and DNS Resolution

```cmd
ping google.com
```

* What this proves: This confirms that the virtual NAT gateway, `10.0.50.2`, is routing traffic to the public internet and that basic DNS resolution is operational.

---

## 📜 PowerShell Steps

Run this command on the host machine to confirm that the virtual VMnet8 network interface has updated its binding to the new gateway architecture.

```powershell
Get-NetIPAddress -InterfaceAlias "*VMnet8*" -AddressFamily IPv4 | Select-Object IPAddress, InterfaceAlias
```

* Why it matters: This confirms the host side of the virtual bridge is using `10.0.50.1`, allowing clear communication into the lab environment for management or testing.

---

## 🔍 Validation

### Expected Routing Configuration

| Metric | Expected Value | Verification Method |
| :--- | :--- | :--- |
| Lab IP subnet | `10.0.50.0/24` | `ipconfig /all` on guest |
| Default gateway | `10.0.50.2` | `ipconfig /all` on guest |
| Host VMnet8 IP | `10.0.50.1` | `ipconfig` on host |
| WAN reachability | Successful reply | `ping 8.8.8.8` on guest |

### What Failure Looks Like

| Symptom | Possible Root Cause |
| :--- | :--- |
| `ping google.com` fails with `Ping request could not find host` | The guest OS may be pointing to `10.0.50.1` as the gateway instead of `10.0.50.2`, or the host's Virtual Network Editor did not apply the NAT settings correctly. |

---

## 🛠️ Troubleshooting

| Issue | Possible Cause | How to Validate | Fix |
| :--- | :--- | :--- | :--- |
| No internet inside VM | Gateway mismatch | Check the default gateway using `ipconfig` | Change the guest IP properties to point to `10.0.50.2` |
| IP conflict on host | Overlapping subnet chosen | Run `ipconfig` on the host to check physical Wi-Fi/Ethernet networks | Change the VMware NAT subnet to a non-overlapping space, such as `172.16.50.0/24` |

---

## 🔒 Security and Governance Notes

### Network Isolation
Running local domain infrastructure directly on residential or production networks introduces security risks, including unmanaged DNS conflict risks and exposed SMB ports. NAT or host-only configurations enforce stricter sandboxing by keeping lab traffic isolated from the main physical network.

### UPN Design Debt
Using `.local` or other non-routable suffixes creates identity debt. In production, matching the on-premises UPN suffix to a verified public custom domain avoids relying on default cloud fallback routing.

---

## 📝 Documentation Evidence

```cmd
C:\Users\EntraConnect>ipconfig /all

Windows IP Configuration

   Host Name . . . . . . . . . . . . : EntraConnectDC
   Primary Dns Suffix  . . . . . . . : Iron.local

Ethernet adapter Ethernet0:

   IPv4 Address. . . . . . . . . . . : 10.0.50.90(Preferred)
   Subnet Mask . . . . . . . . . . . : 255.255.255.0
   Default Gateway . . . . . . . . . : 10.0.50.2
   DNS Servers . . . . . . . . . . . : 127.0.0.1
                                       10.0.50.90
```

---

## 🎓 Lessons Learned

- 🧭 The role of the NAT gateway: VMware maps the default gateway for virtual environments to `.2`, which differs from standard home networks where `.1` is typically the router.
- ☁️ Cloud identity matching: Entra ID requires valid public top-level domain verification. Therefore, `xkdk1.onmicrosoft.com` must be deployed as an alternative UPN suffix locally to support clean user matching.

---

## 🗣️ Interview Talking Points

> "When building hybrid identity labs or planning cloud migrations, I avoid network overlap by deploying dedicated, isolated subnets using NAT environments. I am also aware that legacy environments frequently utilize non-routable `.local` internal domains. To remediate this for Microsoft Entra ID sync readiness, I configure an alternative UPN suffix within Active Directory Domains and Trusts that aligns with the corporate verified domain, ensuring a seamless user sign-in experience post-synchronization."