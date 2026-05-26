# Project 03 — Microsoft 365 Tenant Baseline

## Project Overview

This project documents the baseline configuration and operational state of a Microsoft 365 tenant.

The goal is to understand the Microsoft 365 tenant before performing deeper configuration in Exchange Online, SharePoint Online, OneDrive, Teams, Intune, Purview, security monitoring, or automation.

This project focuses on Microsoft 365 tenant administration from an enterprise operations perspective.

## Business Problem

Organizations need a clear understanding of their Microsoft 365 tenant before making administrative, security, collaboration, or compliance changes.

Without a Microsoft 365 tenant baseline, administrators may not be able to clearly answer:

- What licenses are available?
- Which users are licensed?
- Which admin roles are assigned?
- Which domains are configured?
- What Microsoft 365 services are active?
- Are there service health issues?
- What changes are coming from Microsoft?
- What reports are available?
- Which settings may create risk?
- Which admin centers are used for deeper workload management?

A tenant baseline helps reduce operational risk before making changes to Exchange, SharePoint, OneDrive, Teams, Intune, Purview, or security settings.

## Project Objective

The objective of this project is to document the current Microsoft 365 tenant baseline.

This project will review and document:

- Microsoft 365 admin center navigation
- Tenant overview
- Users and license assignments
- Products and license availability
- Domains and organization profile
- Microsoft 365 admin roles
- Groups and collaboration baseline
- Service health
- Message center
- Reports and usage baseline
- Organization settings
- Linked admin centers
- Security and risk findings
- Enterprise administration model
- PowerShell / Microsoft Graph reporting opportunities
- Future improvement backlog

## Skills Demonstrated

This project demonstrates Microsoft 365 administration fundamentals, including:

- Microsoft 365 admin center navigation
- Tenant operations review
- User and license review
- Admin role review
- Domain and organization profile review
- Service health monitoring
- Message center awareness
- Reports and usage review
- Tenant-wide settings review
- Enterprise administration planning
- Security and risk identification
- Public documentation safety

## Environment

| Component | Details |
|---|---|
| Platform | Microsoft 365 |
| Tenant Type | Microsoft 365 E5 Developer tenant |
| Identity Platform | Microsoft Entra ID |
| Domain Type | Default `.onmicrosoft.com` developer tenant domain |
| Admin Center | Microsoft 365 admin center |
| Related Identity Project | Project 02 — Entra Tenant Baseline |
| Lab Type | Microsoft 365 tenant operations baseline |
| Repository | Azure-Identity-Portfolio |

## Enterprise Scenario

In this scenario, a systems engineer or Microsoft 365 administrator is reviewing an existing Microsoft 365 tenant before making changes.

The administrator needs to understand:

- Tenant structure
- User and license state
- Administrative roles
- Service health
- Microsoft change notifications
- Usage reporting
- Tenant-wide settings
- Operational risks
- Future workload dependencies

This mirrors a real-world onboarding or tenant assessment task.

## Project Scope

### In Scope

- Microsoft 365 admin center review
- Tenant overview documentation
- Users and licenses review
- Products and subscriptions review
- Domains and organization profile review
- Admin roles review
- Groups and collaboration baseline
- Service health review
- Message center review
- Reports overview
- Organization settings review
- Security and risk findings
- Enterprise administration model
- PowerShell / Microsoft Graph reporting opportunities
- Sanitized screenshots

### Out of Scope for Project 03

The following areas will be reviewed only at a high level and will be handled in deeper future projects:

- Exchange Online mail flow configuration
- SharePoint Online and OneDrive governance configuration
- Teams policy configuration
- Intune / endpoint management configuration
- Purview compliance configuration
- Conditional Access policy creation
- Privileged Identity Management configuration
- Identity Governance configuration
- Sentinel / Defender security monitoring configuration
- Power Platform Admin Center configuration

## Project Files

| File / Folder | Purpose |
|---|---|
| README.md | Main project overview |
| 01-m365-tenant-overview.md | Documents Microsoft 365 tenant overview and admin center context |
| 02-admin-center-navigation.md | Documents Microsoft 365 admin center navigation and major sections |
| 03-users-and-licenses-review.md | Documents users, licensing, and product assignment baseline |
| 04-domains-and-organization-profile.md | Documents domains and organization profile baseline |
| 05-admin-roles-review.md | Documents Microsoft 365 admin roles and role separation |
| 06-groups-and-collaboration-baseline.md | Documents Microsoft 365 groups and collaboration baseline |
| 07-service-health-and-message-center.md | Documents service health and Microsoft change notifications |
| 08-reports-and-usage-baseline.md | Documents reports and usage visibility |
| 09-org-settings-review.md | Documents Microsoft 365 organization settings |
| 10-powershell-graph-reporting.md | Documents PowerShell and Microsoft Graph reporting opportunities |
| 11-security-risk-findings.md | Documents risks, findings, and future improvement backlog |
| 12-enterprise-administration-model.md | Documents enterprise Microsoft 365 administration model |
| 13-final-validation.md | Documents final validation and project completion checklist |
| screenshots/ | Stores sanitized screenshots for documentation |
| reports/ | Stores exported reports if PowerShell / Graph reporting is used |

## Current Status

| Item | Status |
|---|---|
| Project folder created | Complete |
| Project README created | Complete |
| Microsoft 365 admin center reviewed | Complete |
| Tenant overview documented | Complete |
| Admin center navigation documented | Complete |
| Users and licenses reviewed | Complete |
| Domains and organization profile reviewed | Planned |
| Admin roles reviewed | Planned |
| Groups and collaboration reviewed | Planned |
| Service health and message center reviewed | Planned |
| Reports and usage reviewed | Planned |
| Organization settings reviewed | Planned |
| PowerShell / Graph reporting reviewed | Planned |
| Security and risk findings documented | Planned |
| Enterprise administration model documented | Planned |
| Final validation completed | Planned |

## Documentation Standards

All screenshots must be sanitized before being published.

Do not expose:

- Tenant ID
- Full tenant domain
- User principal names
- Personal email addresses
- Billing account information
- Payment details
- Object IDs
- Application IDs
- Admin account names if sensitive
- Private identifiers

## Project Approach

This project will follow a deep enterprise-style review process.

Each area will include:

- What was reviewed
- Why it matters
- What was observed
- What screenshots were captured
- What risks were identified
- What should be reviewed in a production environment
- What can be automated later with PowerShell or Microsoft Graph

## Integration Notes

Microsoft 365 tenant administration connects to several future portfolio areas:

| Area | Related Future Project |
|---|---|
| Microsoft Entra ID | Project 02 — Entra Tenant Baseline |
| Intune / Endpoint Management | Project 06 |
| Exchange Online / Outlook | Project 07 |
| SharePoint / OneDrive / SAM | Project 08 |
| Conditional Access | Project 05 |
| Privileged Identity Management | Project 09 |
| Identity Governance | Project 10 |
| PowerShell / Microsoft Graph Automation | Project 12 |
| Security Monitoring / Sentinel | Project 13 |
| Purview / Compliance | Project 14 |
| Power Platform Admin Center | Project 16 |

## Next Steps

The next step is to review Microsoft 365 domains and organization profile settings.

This will document the tenant domain baseline, default domain context, organization profile, release preferences, and related enterprise considerations.