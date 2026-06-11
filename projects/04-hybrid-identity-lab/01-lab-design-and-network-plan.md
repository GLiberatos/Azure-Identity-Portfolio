# Hybrid Identity Lab Design and Network Plan

## Purpose

This document defines the lab design and network plan for the Hybrid Identity Lab.

The purpose is to document the virtualization platform, server naming, Active Directory domain name, NetBIOS domain name, IP addressing, DNS configuration, and initial validation evidence before deeper Active Directory and hybrid identity configuration.

## What This File Teaches

This file introduces the foundation pieces that Active Directory depends on:

- VM name vs Windows hostname
- AD DNS domain name vs NetBIOS domain name
- Static IP addressing for a domain controller
- DNS requirements for Active Directory
- Why domain clients should use the domain controller for DNS
- Why `.local` works internally but requires planning before Microsoft Entra ID synchronization
- How to validate local name registration with command-line tools
- How to troubleshoot a DNS health warning with `dcdiag`

## Relationship to Prior Work

Project 03 documented the Microsoft 365 tenant baseline from the cloud administration side.

Project 04 now moves into the on-premises identity side by building and validating the Active Directory foundation that will later connect to Microsoft Entra ID.

## Review Scope

### In Scope

- Virtualization platform
- Domain controller VM name
- Windows hostname
- Active Directory domain name
- NetBIOS domain name
- IP address plan
- DNS configuration
- Default gateway
- Basic name validation
- Basic network validation
- DNS forwarder validation
- DNS health validation
- Hybrid identity namespace planning

### Out of Scope

- Installing Active Directory Domain Services
- Promoting the domain controller
- Creating organizational units
- Creating users and groups
- Configuring Group Policy
- Installing Microsoft Entra Connect
- Configuring Microsoft Entra Cloud Sync
- Synchronizing users to Microsoft Entra ID

## Lab Summary

| Item | Value |
|---|---|
| Project | Project 04 — Hybrid Identity Lab |
| Primary Lab Platform | VMware Workstation |
| Additional Platforms | VMware ESXi 8, Azure VM |
| Domain Controller VM Name | AZConnect |
| Domain Controller Hostname | EntraConnectDC |
| Server OS | Windows Server 2022 |
| Active Directory Domain Name | iron.local |
| NetBIOS Domain Name | IRON |
| Microsoft 365 / Entra Tenant Domain | Sanitized `.onmicrosoft.com` tenant domain |
| Domain Controller IP Address | 192.168.50.90 |
| Subnet Mask | 255.255.255.0 |
| CIDR | /24 |
| Network Address | 192.168.50.0 |
| Default Gateway | 192.168.50.1 |
| DNS Server on Domain Controller | 127.0.0.1 |
| Alternate DNS Server on Domain Controller | 192.168.50.90 |
| Recommended DNS for Domain Clients | 192.168.50.90 |
| DNS Forwarder | 192.168.50.1 |

## Naming Plan

| Name Type | Value | Purpose |
|---|---|---|
| VM Name | AZConnect | Name shown in VMware Workstation inventory |
| Windows Hostname | EntraConnectDC | Name used by Windows, DNS, and Active Directory |
| AD DNS Domain Name | iron.local | Internal Active Directory domain name |
| NetBIOS Domain Name | IRON | Short legacy domain name used by Windows domain logon and NetBIOS registration |
| Cloud Tenant Domain | Sanitized `.onmicrosoft.com` domain | Microsoft 365 / Entra ID tenant namespace |

## VM Name vs Windows Hostname

The VM name and Windows hostname are different.

The VM name is used by the virtualization platform.

The Windows hostname is used by the operating system, DNS, Active Directory, and domain services.

In this lab:

```text
VM name: AZConnect
Windows hostname: EntraConnectDC
```

## AD Domain Name vs NetBIOS Name

The Active Directory DNS domain name is:

```text
iron.local
```

The NetBIOS domain name is:

```text
IRON
```

Modern domain logon can use UPN format:

```text
user@iron.local
```

Legacy domain logon can use NetBIOS format:

```text
IRON\user
```

Both naming formats are important to understand when supporting Windows authentication, domain joins, older applications, and hybrid identity environments.

## Domain Name Consideration

The internal Active Directory domain for this lab is:

```text
iron.local
```

This is acceptable for an internal lab environment.

However, `.local` is not a routable public DNS namespace.

For Microsoft Entra ID and Microsoft 365 synchronization planning, users may need an alternate UPN suffix that matches a verified or tenant-supported cloud sign-in domain.

The real tenant domain is not published in this repository and is documented only as a sanitized `.onmicrosoft.com` tenant domain.

This will be handled later during Microsoft Entra Connect or Microsoft Entra Cloud Sync planning.

## Network Plan

| Network Setting | Value |
|---|---|
| Domain Controller IP Address | 192.168.50.90 |
| Subnet Mask | 255.255.255.0 |
| CIDR | /24 |
| Network Address | 192.168.50.0 |
| Default Gateway | 192.168.50.1 |
| DNS Server on DC | 127.0.0.1 |
| Alternate DNS Server on DC | 192.168.50.90 |
| Router DNS / Forwarder | 192.168.50.1 |

## DNS Design

DNS is required for Active Directory.

Domain controllers register DNS records that allow domain-joined computers to locate:

- Domain controllers
- Kerberos services
- LDAP services
- Global catalog services
- Domain resources

On the domain controller, DNS is configured to use:

```text
127.0.0.1
192.168.50.90
```

Domain clients should use the domain controller IP address for DNS:

```text
192.168.50.90
```

Using an external DNS server directly on a domain-joined client can prevent the client from locating the domain controller.

The router DNS address `192.168.50.1` is used as a DNS forwarder inside the DNS Server role for external name resolution.

## Current Validation Evidence

The following command was used to validate the Windows hostname:

```cmd
hostname
```

Observed result:

```text
EntraConnectDC
```

The following command was used to validate IP and DNS configuration:

```cmd
ipconfig /all
```

Key observed values:

| Setting | Observed Value |
|---|---|
| Host Name | EntraConnectDC |
| Primary DNS Suffix | Iron.local |
| Node Type | Hybrid |
| DHCP Enabled | No |
| IPv4 Address | 192.168.50.90 |
| Subnet Mask | 255.255.255.0 |
| Default Gateway | 192.168.50.1 |
| DNS Servers | 127.0.0.1, 192.168.50.90 |
| NetBIOS over TCP/IP | Enabled |

The following command was used to validate local NetBIOS name registration:

```cmd
nbtstat -n
```

Observed output:

```text
Ethernet0:
Node IpAddress: [192.168.50.90] Scope Id: []

                NetBIOS Local Name Table

       Name               Type         Status
    ---------------------------------------------
    ENTRACONNECTDC <00>  UNIQUE      Registered
    IRON           <00>  GROUP       Registered
    IRON           <1C>  GROUP       Registered
    ENTRACONNECTDC <20>  UNIQUE      Registered
    IRON           <1B>  UNIQUE      Registered
```

## NetBIOS Output Explanation

| Entry | Meaning |
|---|---|
| `ENTRACONNECTDC <00> UNIQUE` | The Windows hostname is registered |
| `IRON <00> GROUP` | The NetBIOS domain name is registered |
| `IRON <1C> GROUP` | Domain controller-related NetBIOS registration |
| `ENTRACONNECTDC <20> UNIQUE` | Server service registration |
| `IRON <1B> UNIQUE` | Domain-related master browser registration |

## Validation Results

| Validation Check | Result | Status |
|---|---|---|
| Hostname validation | `EntraConnectDC` returned by `hostname` | Passed |
| Primary DNS suffix | `Iron.local` shown in `ipconfig /all` | Passed |
| Static IP address | `192.168.50.90` configured | Passed |
| Subnet mask | `255.255.255.0` configured | Passed |
| Default gateway | `192.168.50.1` configured | Passed |
| DNS server on DC | `127.0.0.1` configured | Passed |
| Alternate DNS server | `192.168.50.90` configured | Passed |
| Domain DNS lookup | `iron.local` resolves to `192.168.50.90` | Passed |
| Gateway connectivity | Ping to `192.168.50.1` successful with `0%` loss | Passed |
| Domain controller IP connectivity | Ping to `192.168.50.90` successful with `0%` loss | Passed |
| DNS health check | `dcdiag /test:dns /v` passed after DNS registration and Netlogon restart | Passed |

## DNS Forwarder Review

DNS forwarders were reviewed on the domain controller.

The router DNS forwarder is configured as:

```text
192.168.50.1
```

An unexpected DNS forwarder was previously observed:

```text
192.168.124.90
```

That address was not part of the current `192.168.50.0/24` lab subnet and was removed from DNS forwarders.

The final DNS forwarder configuration uses the lab router DNS address for external name resolution, while the domain controller continues to use AD-integrated DNS for domain services.

## DNS Health Check

The command `dcdiag /test:dns /v` was used to validate DNS health.

The first DNS health check returned a warning related to DNS RPC connectivity.

Follow-up remediation steps were performed:

```cmd
ipconfig /registerdns
net stop netlogon
net start netlogon
```

After registering DNS records and restarting Netlogon, `dcdiag /test:dns /v` passed.

Validated results included:

| DNS Validation Item | Result |
|---|---|
| DNS service running | Passed |
| DC is a DNS server | Passed |
| DNS servers on NIC | `127.0.0.1` and `192.168.50.90` valid |
| DNS forwarder | `192.168.50.1` valid |
| Delegation test | Passed |
| Dynamic update test | Passed |
| Records registration test | Passed |
| Final DNS summary | `PASS PASS PASS PASS PASS PASS n/a` |

## Initial Findings

- The hybrid identity lab will use VMware Workstation as the primary platform.
- ESXi 8 and Azure VM are also available as lab platforms.
- The domain controller VM name is `AZConnect`.
- The Windows hostname is `EntraConnectDC`.
- The internal Active Directory domain is `iron.local`.
- The NetBIOS domain name is `IRON`.
- The domain controller is using static IP address `192.168.50.90`.
- The lab network is `192.168.50.0/24`.
- The default gateway is `192.168.50.1`.
- DNS resolution for `iron.local` successfully returns `192.168.50.90`.
- Gateway connectivity to `192.168.50.1` is successful.
- Local domain controller IP connectivity to `192.168.50.90` is successful.
- The domain controller NIC DNS configuration was updated to use `127.0.0.1` and `192.168.50.90`, keeping DNS resolution aligned to the domain controller.
- The router DNS address `192.168.50.1` is configured as a DNS Server forwarder for external name resolution.
- An unexpected DNS forwarder, `192.168.124.90`, was identified and removed because it was not part of the current lab subnet.
- DNS records were re-registered using `ipconfig /registerdns`.
- The Netlogon service was restarted to refresh domain controller DNS registration.
- `dcdiag /test:dns /v` passed after DNS remediation.
- The `.local` AD domain works for the internal lab, but UPN suffix planning will be required before Microsoft Entra ID synchronization.

## Validation Commands

The following commands can be used to validate the current server and network configuration.

### Validate hostname

```cmd
hostname
```

### Validate IP and DNS configuration

```cmd
ipconfig /all
```

### Validate NetBIOS registration

```cmd
nbtstat -n
```

### Validate domain DNS lookup

```cmd
nslookup iron.local
```

### Validate gateway connectivity

```cmd
ping 192.168.50.1
```

### Validate domain controller IP connectivity

```cmd
ping 192.168.50.90
```

### Validate DNS health

```cmd
dcdiag /test:dns /v
```

## Troubleshooting Notes

| Issue | Possible Cause | Validation |
|---|---|---|
| Client cannot join domain | Client DNS is not pointing to the domain controller | Check client DNS settings |
| Domain name does not resolve | DNS zone or DC DNS registration issue | Run `nslookup iron.local` |
| Server name does not resolve | DNS record missing or incorrect | Run `nslookup EntraConnectDC` |
| Gateway unreachable | Network adapter, VLAN, NAT, or virtual switch issue | Run `ping 192.168.50.1` |
| Wrong hostname shown | Windows hostname not renamed correctly | Run `hostname` |
| Wrong domain shown | Domain join or promotion issue | Run `systeminfo` or check domain properties |
| Domain controller has router listed as secondary NIC DNS | Router DNS may not understand AD DS records | Use the DC itself for DNS and configure router DNS as a DNS Server forwarder |
| Unexpected DNS forwarder appears | Old lab network, previous IP configuration, or accidental entry | Confirm the subnet and remove if not required |
| `dcdiag /test:dns` shows DNS RPC warning | DNS records or Netlogon registration may need refresh | Run `ipconfig /registerdns`, restart Netlogon, then re-run `dcdiag /test:dns /v` |

## What This Builds Toward

This lab design prepares for:

- Active Directory Domain Services installation
- Domain controller promotion
- DNS validation
- OU creation
- User and group creation
- Group Policy basics
- Microsoft Entra Connect planning
- Source-of-authority validation
- Hybrid identity synchronization
- Sync troubleshooting

## PowerShell and Command-Line Opportunities

| Task | Tool |
|---|---|
| Validate hostname | `hostname` |
| Validate IP configuration | `ipconfig /all` |
| Validate DNS lookup | `nslookup` |
| Validate connectivity | `ping` |
| Validate NetBIOS registration | `nbtstat -n` |
| Validate domain controller health | `dcdiag` |
| Validate DNS health | `dcdiag /test:dns` |
| Validate AD replication | `repadmin` |
| Manage AD users and groups | Active Directory PowerShell module |

## Technical Recall Questions

- What is the difference between a VM name and a Windows hostname?
- What is the difference between an AD DNS domain name and a NetBIOS domain name?
- Why does Active Directory depend on DNS?
- Why should domain clients use the domain controller as DNS?
- What does `nbtstat -n` show?
- Why can `.local` create issues for Microsoft Entra ID synchronization?
- What is a UPN suffix?
- What is source of authority in hybrid identity?
- Why should network settings be validated before installing or troubleshooting AD DS?
- What does `dcdiag /test:dns` validate?
- Why can restarting Netlogon refresh domain controller DNS records?

## Lessons Learned

- Hybrid identity requires a working on-premises identity foundation before synchronization is configured.
- VM names, Windows hostnames, AD DNS names, and NetBIOS names serve different purposes.
- DNS is a core dependency for Active Directory.
- Domain clients should use the domain controller for DNS resolution.
- Router DNS can still be useful as a DNS forwarder, but it should not replace AD DNS for domain services.
- A `.local` AD domain can work internally, but Microsoft Entra ID synchronization requires planning for user sign-in names and verified tenant domains.
- `dcdiag /test:dns /v` provides deeper DNS health validation than basic name resolution alone.
- Re-registering DNS records and restarting Netlogon can refresh domain controller DNS registration.
- Command-line validation helps confirm server identity, network configuration, DNS health, and domain name registration before deeper configuration begins.