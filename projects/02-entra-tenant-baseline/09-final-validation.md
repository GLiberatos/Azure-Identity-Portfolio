# Project 02 Final Validation

## Purpose

This document validates that Project 02 — Entra Tenant Baseline has been completed and documented.

The goal of this validation is to confirm that the tenant baseline was reviewed, documented, and prepared for future identity security projects.

## Validation Checklist

| Validation Item | Status | Notes |
|---|---|---|
| Project README created | Complete | Main project overview documented |
| Tenant baseline inventory created | Complete | Hybrid identity environment documented |
| Tenant overview reviewed | Complete | Tenant context and sync state documented |
| User inventory reviewed | Complete | Cloud-only, synced, and guest users documented |
| Group inventory reviewed | Complete | Group types and counts documented |
| Administrative roles reviewed | Complete | Privileged role baseline documented |
| Tenant settings reviewed | Complete | User, group, guest, cross-tenant, and device settings reviewed |
| Identity administration model documented | Complete | Source-of-authority and enterprise design notes documented |
| Security and risk findings documented | Complete | Strengths, risks, and improvement backlog documented |
| Screenshots captured | Complete | Screenshots added to project screenshots folder |
| Screenshots sanitized | Complete | Sensitive tenant and identity information removed or hidden |
| Lessons learned documented | Complete | Lessons learned added across project files |
| Future improvement backlog documented | Complete | Future project dependencies identified |

## Files Validated

| File / Folder | Status |
|---|---|
| README.md | Complete |
| 01-tenant-baseline-inventory.md | Complete |
| 02-tenant-overview.md | Complete |
| 03-user-inventory.md | Complete |
| 04-group-inventory.md | Complete |
| 05-role-baseline.md | Complete |
| 06-tenant-settings-review.md | Complete |
| 07-identity-administration-model.md | Complete |
| 08-security-risk-findings.md | Complete |
| screenshots/ | Complete |

## Screenshot Validation

The following screenshot evidence was captured and sanitized:

| Screenshot | Status |
|---|---|
| 01-tenant-overview-sanitized.png | Complete |
| 02-directory-sync-status-sanitized.png | Complete |
| 03-users-all-overview-sanitized.png | Complete |
| 04-users-synced-filter-sanitized.png | Complete |
| 05-users-cloud-only-filter-sanitized.png | Complete |
| 06-groups-all-overview-sanitized.png | Complete |
| 07-groups-security-filter-sanitized.png | Complete |
| 08-groups-m365-filter-sanitized.png | Complete |
| 09-groups-synced-filter-sanitized.png | Complete |
| 10-roles-admins-overview-sanitized.png | Complete |
| 11-global-admin-role-sanitized.png | Complete |
| 13-user-settings-sanitized.png | Complete |
| 14-group-settings-sanitized.png | Complete |
| 15-external-collaboration-settings-sanitized.png | Complete |
| 16-cross-tenant-access-settings-sanitized.png | Complete |
| 17-devices-overview-sanitized.png | Complete |

## Key Findings Summary

| Area | Finding |
|---|---|
| Tenant type | Microsoft 365 E5 Developer tenant |
| Identity model | Hybrid identity |
| Directory sync | Enabled |
| Authentication method | Password Hash Sync |
| Total users | 72 |
| Synced users | 69 |
| Cloud-only users | 3 |
| Guest users | 1 observed |
| Total groups | 26 |
| Security groups | 20 |
| Microsoft 365 groups | 5 |
| Synced groups | 16 |
| Cloud-only groups | 10 |
| Dynamic groups | 1 |
| Global Administrators | 1 active assignment observed |
| Devices | 2 devices observed |
| Entra ID license | Microsoft Entra ID P2 |

## Project Outcome

Project 02 successfully established a Microsoft Entra tenant baseline.

The project documented:

- Tenant context
- Hybrid identity model
- Directory synchronization state
- User inventory
- Group inventory
- Administrative role baseline
- Tenant-wide identity settings
- Identity administration model
- Security and risk findings
- Future improvement backlog

## What This Project Enables

This baseline prepares for future projects including:

- Conditional Access
- MFA
- Privileged Identity Management
- Identity Governance
- Intune / endpoint management
- Microsoft 365 administration
- Security monitoring
- Microsoft Graph automation
- Compliance mapping

## Final Lessons Learned

- A tenant baseline should be completed before implementing security controls.
- Hybrid identity requires clear source-of-authority documentation.
- User, group, and role inventory helps identify risk before making changes.
- Tenant-wide settings affect users, groups, guests, devices, and applications.
- Security findings should be documented before remediation.
- Future projects should build on the baseline instead of making isolated changes.

## Final Status

Project 02 is ready to close after README status updates are completed.