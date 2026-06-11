# Project 04 — Hybrid Identity Lab

## Project Overview

This project documents the buildout of a hybrid identity lab using Windows Server Active Directory Domain Services and Microsoft Entra ID.

The goal is to build hands-on experience with on-premises identity infrastructure and understand how traditional Active Directory connects to modern cloud identity.

## Business Problem

Many organizations still use Active Directory Domain Services as the primary identity source for users, groups, computers, and authentication.

Cloud administrators often need to understand how on-premises identity connects to Microsoft Entra ID before working with Conditional Access, Microsoft 365, Intune, Exchange Online, SharePoint, Teams, Defender, Sentinel, Purview, or Copilot governance.

Without hybrid identity knowledge, administrators may not fully understand:

- Where user accounts are created
- Which system is the source of authority
- Why some cloud attributes are locked
- How password hash synchronization works
- How group and user changes flow to Microsoft Entra ID
- Why DNS is critical to Active Directory
- How domain controllers support authentication
- How synchronization failures are identified and fixed

## Project Objective

The objective of this project is to build and document a small hybrid identity lab.

This project will include:

- Windows Server VM preparation
- Active Directory Domain Services installation
- Domain controller promotion
- DNS validation
- Forest and domain creation
- Organizational unit design
- User and group creation
- Group Policy basics
- Hybrid identity planning
- Microsoft Entra Connect or Microsoft Entra Cloud Sync review
- Source-of-authority validation
- Sync validation and troubleshooting

## Skills Demonstrated

This project demonstrates hands-on hybrid identity skills, including:

- Windows Server administration
- Active Directory Domain Services deployment
- Domain controller configuration
- DNS validation
- Forest and domain planning
- OU structure design
- User and group administration
- Group Policy fundamentals
- Hybrid identity architecture
- Microsoft Entra ID synchronization planning
- PowerShell-based validation
- Troubleshooting identity synchronization issues

## Environment

| Component | Details |
|---|---|
| Primary Virtualization Platform | VMware Workstation |
| Additional Virtualization Platforms | VMware ESXi 8, Azure VM |
| Server OS | Windows Server 2022 |
| Directory Service | Active Directory Domain Services |
| Cloud Identity Platform | Microsoft Entra ID |
| Tenant | Microsoft 365 E5 Developer tenant |
| Entra Tenant Domain | Sanitized `.onmicrosoft.com` tenant domain |
| Sync Technology | Microsoft Entra Connect Sync or Microsoft Entra Cloud Sync |
| Repository | Azure-Identity-Portfolio |

## Lab Design

| Component | Planned Value |
|---|---|
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
| Default Gateway | 192.168.50.1 |
| DNS Server on Domain Controller | 127.0.0.1 |
| Recommended DNS for Domain Clients | 192.168.50.90 |
| Test Users | To be created |
| Test Groups | To be created |
| Test OUs | To be created |

## Domain Name Note

The internal Active Directory domain for this lab is `iron.local`.

This is acceptable for an internal lab environment, but `.local` is not a routable public DNS namespace.

For Microsoft Entra ID and Microsoft 365 synchronization planning, users may need an alternate UPN suffix that matches a verified or tenant-supported cloud sign-in domain.

The real tenant domain is not published in this repository and is documented only as a sanitized `.onmicrosoft.com` tenant domain.

## Project Files

| File / Folder | Purpose |
|---|---|
| README.md | Main project overview |
| 01-lab-design-and-network-plan.md | Documents lab topology, naming, IP plan, and domain design |
| 02-windows-server-domain-controller-build.md | Documents Windows Server setup, AD DS installation, and domain controller promotion |
| 03-active-directory-structure.md | Documents OUs, users, groups, and base directory structure |
| 04-group-policy-basics.md | Documents basic Group Policy creation and validation |
| 05-entra-connect-planning.md | Documents hybrid identity sync planning and prerequisites |
| 06-hybrid-identity-sync-validation.md | Documents sync validation and troubleshooting |
| scripts/ | Stores PowerShell commands and validation scripts |
| evidence/ | Stores text-based validation evidence only when needed |

## Current Status

| Item | Status |
|---|---|
| Project folder created | Complete |
| Project README created | Complete |
| Lab design completed | Complete |
| Windows Server VM prepared | Complete |
| AD DS installed | Planned |
| Domain controller promoted | Planned |
| DNS validated | Complete |
| OUs created | Planned |
| Users and groups created | Planned |
| Group Policy basics reviewed | Planned |
| Hybrid identity sync planned | Planned |
| Sync validation completed | Planned |
| Troubleshooting documented | Planned |

## Documentation Standards

This project will prioritize commands, configuration notes, validation output, and troubleshooting steps.

Screenshots will only be used when necessary to prove a setting, result, or error.

Do not expose:

- Tenant ID
- Public IP addresses
- Passwords
- Secrets
- Recovery keys
- Private object IDs
- Personal email addresses
- Unsanitized user principal names
- Sensitive admin account names

## Next Steps

The next step is to document the Windows Server domain controller build.

This includes reviewing the Windows Server configuration, Active Directory Domain Services role installation, domain controller promotion, DNS validation, and post-promotion health checks.
