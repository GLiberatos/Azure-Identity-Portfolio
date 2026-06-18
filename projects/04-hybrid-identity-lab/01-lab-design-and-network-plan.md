# Project 04 — Module 01: Lab Design and Network Plan

## Purpose

This module establishes and validates the foundational network and naming design for the hybrid identity lab.

Before introducing identity synchronization or cloud services, the environment must have deterministic DNS, IP addressing, and domain controller discovery.

Hybrid identity failures almost always trace back to DNS or network misconfiguration. This module ensures the foundation is correct before moving forward.

---

## What This Lab Teaches

- Why domain controllers must use static IP addresses
- How Active Directory depends on DNS SRV records
- Why clients must use domain controller DNS, not router DNS
- What `.local` domains are used for and their cloud limitations
- How to validate DNS health using command-line tools
- How to prove a domain controller is advertising correctly

---

## Before You Start

- Windows Server 2022 is installed and running.
- Server is already promoted to a Domain Controller.
- Active Directory domain exists: `<domain>.local`.
- You are logged in as a Domain Administrator.
- Network adapter is connected through VMware NAT or Host-only networking.
- No Entra Connect or Cloud Sync components are installed.

> This module focuses on **design validation**, not installation.

---

## Lab Design Overview

| Component | Value |
| --- | --- |
| Server Hostname | `EntraConnectDC` |
| AD DNS Domain | `<domain>.local` |
| Forest | `<domain>.local` |
| Static IP Address | `10.0.50.90` |
| Subnet Mask | `255.255.255.0` |
| Default Gateway | `10.0.50.2` |
| DNS Servers | `127.0.0.1`, `10.0.50.90` |
| DNS Forwarder | Router / NAT Gateway |
| Virtual Platform | VMware Workstation |
| Client DNS Requirement | Domain Controller IP only |

---

## Why These Design Choices Matter

### Why Domain Controllers Use Static IPs

Active Directory publishes domain controller locations using DNS records.

If a domain controller's IP address changes:

- Clients cannot authenticate.
- Kerberos ticketing fails.
- Group Policy fails.
- Hybrid identity synchronization breaks.

Static IPs are mandatory for domain controllers.

---

### Why Clients Must Use Domain Controller DNS

Active Directory DNS contains:

- SRV records for LDAP, Kerberos, and Global Catalog.
- AD-integrated zones.
- Secure dynamic updates.

Router or ISP DNS servers do not contain these records and will break authentication.

---

### Why `.local` Domains Are Still Used

`.local` domains are common in on-premises labs and legacy environments.

Limitations:

- Cannot be verified in Microsoft Entra ID.
- Cannot be used directly for cloud UPNs.
- Requires alternate UPN suffixes for hybrid identity.

This lab intentionally uses `.local` to demonstrate real-world hybrid remediation.

---

## Command Prompt Validation

All commands below are executed on `EntraConnectDC`.

---

### Validate Hostname

#### Command

```cmd
hostname
```

#### What This Proves

- Confirms the server identity.
- Confirms the domain controller is using the expected hostname.
- Reinforces that renaming after AD DS installation is discouraged.

#### Expected Result

```text
EntraConnectDC
```

---

### Validate IP Configuration

#### Command

```cmd
ipconfig /all
```

#### What This Proves

- Static IP is configured.
- DNS is pointing to the domain controller.
- No external DNS servers are in use.

#### Expected Results

```text
DHCP Enabled . . . . . . . . . . . : No
IPv4 Address. . . . . . . . . . . : 10.0.50.90
DNS Servers . . . . . . . . . . . : 127.0.0.1
                                    10.0.50.90
```

---

### Validate Active Directory DNS Zone

#### Command

```cmd
nslookup <domain>.local
```

#### What This Proves

- AD DNS zone exists.
- Domain controller is authoritative.

#### Expected Result

```text
Name:    <domain>.local
Address: 10.0.50.90
```

---

### Validate Domain Controller SRV Records

> This is a critical validation step.

#### Command

```cmd
nslookup -type=SRV _ldap._tcp.dc._msdcs.<domain>.local
```

#### What This Proves

- LDAP service records are registered.
- Domain Controller Locator works.
- Authentication and domain joins can succeed.

#### Expected Result

```text
_ldap._tcp.dc._msdcs.<domain>.local SRV service location:
    port           = 389
    svr hostname   = EntraConnectDC.<domain>.local
```

---

### Validate Domain Controller Discovery

#### Command

```cmd
nltest /dsgetdc:<domain>.local
```

#### What This Proves

- Secure channel is functional.
- Domain controller roles are advertising correctly.

#### Expected Result

```text
DC: \\EntraConnectDC.<domain>.local
Address: \\10.0.50.90
The command completed successfully
```

---

### Validate DNS Health

#### Command

```cmd
dcdiag /test:dns /v
```

#### What This Proves

- DNS zones are healthy.
- SRV records are registered.
- Dynamic updates are working.
- Forwarders are functional.

#### Expected Result

```text
......................... <domain>.local passed test DNS
```

---

## Validation Summary

| Check | Result |
| --- | --- |
| Static IP | ✅ |
| DC DNS self-reference | ✅ |
| AD DNS zone | ✅ |
| SRV records | ✅ |
| DC locator | ✅ |
| DNS diagnostics | ✅ |

This environment meets all prerequisites for hybrid identity.

---

## Troubleshooting

| Issue | Possible Cause | How to Validate | Fix |
| --- | --- | --- | --- |
| Domain join fails | Client using router DNS | `ipconfig /all` | Set client DNS to DC IP. |
| SRV records missing | DNS or NetLogon stopped | `nslookup -type=SRV` | Restart DNS and NetLogon. |
| Authentication delays | Incorrect forwarders | `dcdiag /test:dns` | Fix DNS forwarders. |

---

## Security and Governance Notes

- DNS is the backbone of Active Directory authentication.
- Hybrid identity depends on DNS correctness more than cloud configuration.
- Forwarders should be limited to trusted resolvers.
- Domain controllers should never rely on external DNS for AD lookups.

---

## Documentation Evidence

The following sanitized evidence can be captured for documentation:

```text
nslookup <domain>.local → 10.0.50.90
SRV records present under _msdcs.<domain>.local
dcdiag DNS tests passed
```

---

## Lessons Learned

- Active Directory authentication is DNS-driven.
- SRV records are more critical than A records.
- Hybrid identity failures usually start with DNS misconfiguration.
- Validation must occur before cloud synchronization.
