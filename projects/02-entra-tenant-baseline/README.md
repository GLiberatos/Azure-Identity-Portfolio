# Project 02 — Entra Tenant Baseline

## Project Overview

This project documents the baseline configuration of a Microsoft Entra ID tenant used for identity and access management labs.

The goal is to understand the current tenant structure before making configuration changes.

This includes reviewing users, groups, roles, directory synchronization, identity source, and administrative structure.

## Business Problem

Organizations need a clear understanding of their identity environment before implementing access controls, security policies, automation, or governance.

Without a tenant baseline, it can be difficult to answer basic identity questions such as:

- Which users are cloud-only?
- Which users are synced from on-premises Active Directory?
- Which groups exist?
- Which admin roles are assigned?
- Which accounts are privileged?
- What is the source of authority for identities?
- What tenant configuration should be documented before changes are made?

A clear tenant baseline helps reduce risk before implementing security controls such as Conditional Access, MFA, Privileged Identity Management, and Identity Governance.

## Project Objective

The objective of this project is to document the current Microsoft Entra ID tenant baseline.

This project will document:

- Tenant overview
- Domain type
- Identity types
- Cloud-only users
- Synced users
- Group types
- Administrative roles
- Directory sync status
- Source-of-authority notes
- Screenshot documentation standards
- Future baseline improvements

## Skills Demonstrated

This project demonstrates identity administration fundamentals, including:

- Microsoft Entra admin center navigation
- Tenant baseline documentation
- User inventory review
- Group inventory review
- Role and administrator review
- Hybrid identity awareness
- Source-of-authority understanding
- Public documentation safety

## Environment

| Component | Details |
|---|---|
| Identity Platform | Microsoft Entra ID |
| Tenant Type | Microsoft 365 E5 Developer tenant |
| Domain Type | Default `.onmicrosoft.com` developer tenant domain |
| On-Premises Directory | Active Directory Domain Services |
| Sync Tool | Microsoft Entra Connect / sync agent |
| Lab Type | Hybrid identity / Entra baseline |
| Repository | Azure-Identity-Portfolio |

## Project Scope

### In Scope

- Tenant baseline documentation
- User inventory review
- Group inventory review
- Admin role review
- Directory sync status review
- Source-of-authority notes
- Sanitized screenshots

### Out of Scope for Project 02

- Conditional Access policy creation
- Privileged Identity Management configuration
- Identity Governance configuration
- Intune / MDM configuration
- Microsoft 365 service administration
- Okta configuration
- Azure infrastructure deployment

## Project Files

| File / Folder | Purpose |
|---|---|
| README.md | Main project overview |
| 01-tenant-baseline-inventory.md | Documents the current Entra tenant baseline |
| 02-tenant-overview.md | Documents high-level tenant context and sync state |
| 03-user-inventory.md | Documents user inventory and identity types |
| 04-group-inventory.md | Documents group inventory and group types |
| 05-role-baseline.md | Documents administrative roles and privileged access baseline |
| 06-tenant-settings-review.md | Documents tenant-wide settings and identity security posture |
| 07-identity-administration-model.md | Documents identity administration model, source of authority, and enterprise design notes |
| 08-security-risk-findings.md | Documents security findings, risks, and future improvement backlog |
| 09-final-validation.md | Documents final validation and project completion checklist |
| screenshots/ | Stores sanitized screenshots for documentation |

## Current Status

| Item | Status |
|---|---|
| Project folder created | Complete |
| Project README created | Complete |
| Tenant baseline inventory documented | Complete |
| Tenant overview documented | Complete |
| User inventory documented | Complete |
| Group inventory documented | Complete |
| Role baseline documented | Complete |
| Tenant settings reviewed | Complete |
| Identity administration model documented | Complete |
| Security and risk findings documented | Complete |
| Final validation completed | Complete |
| Screenshots added | Complete |

## Project Completion Summary

Project 02 is complete.

This project established a Microsoft Entra tenant baseline by documenting:

- Tenant overview
- Hybrid identity model
- Directory synchronization
- Password Hash Sync
- User inventory
- Group inventory
- Administrative role baseline
- Tenant-wide identity settings
- Identity administration model
- Security and risk findings
- Future improvement backlog

## Next Steps

The next project will focus on the Microsoft 365 tenant baseline.

Project 03 will review Microsoft 365 admin center settings, users, licenses, service health, roles, and tenant administration fundamentals.