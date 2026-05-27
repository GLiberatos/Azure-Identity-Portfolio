# Microsoft 365 Admin Roles Review

## Purpose

This document captures the Microsoft 365 admin roles baseline for the Microsoft 365 Tenant Baseline project.

The purpose is to understand Microsoft 365 administrative role assignments, workload administrator roles, least privilege considerations, and privileged access risk before deeper Microsoft 365, Exchange Online, SharePoint Online, Teams, Intune, Purview, security, automation, or agent governance work.

## Why Admin Roles Matter

Admin roles determine who can manage Microsoft 365 services, users, licenses, groups, domains, service health, reports, workload admin centers, security settings, compliance settings, and emerging Copilot / agent governance areas.

A Microsoft 365 admin roles review helps answer:

- Which admin roles are assigned?
- Which accounts have privileged access?
- Are workload-specific roles being used?
- Are Global Administrator assignments limited?
- Are roles aligned with least privilege?
- Are support, billing, license, and reporting roles separated?
- Which roles should be reviewed later with PIM?
- Which roles may affect Copilot and agent governance?

## Relationship to Prior Work

Project 02 documented the Microsoft Entra ID tenant baseline, including privileged role observations from an identity perspective.

Project 03 has already documented:

- Microsoft 365 tenant context
- Microsoft 365 admin center navigation
- Users and licenses
- Domains and organization profile

This file builds on that work by reviewing Microsoft 365 administrative roles from an operations and workload ownership perspective.

This does not repeat the full Project 02 Entra role baseline. Instead, it focuses on Microsoft 365 administration, service ownership, least privilege, and future PIM opportunities.

## Review Scope

### In Scope

- Microsoft 365 admin roles
- Global Administrator assignment count
- Workload-specific admin roles
- Support and helpdesk roles
- Billing and license roles
- Reporting roles
- Role separation
- Least privilege considerations
- Agent / Copilot governance role awareness
- Future PIM opportunities
- Future PowerShell / Microsoft Graph reporting opportunities

### Out of Scope

- Assigning roles
- Removing roles
- Editing role memberships
- Creating custom roles
- Configuring PIM
- Configuring Conditional Access
- Changing admin account strategy
- Configuring Copilot or agents
- Changing security or compliance roles

## Admin Role Summary

| Role / Role Area | Count / Status | Notes |
|---|---|---|
| Global Administrator | 1 | Highest privilege tenant role; one assigned admin observed |
| Exchange Administrator | 0 observed | Role visible but no assignment observed during review |
| SharePoint Administrator | 0 observed | Role visible but no assignment observed during review |
| Teams Administrator | 0 observed | Role visible but no assignment observed during review |
| User Administrator | 0 observed | Role visible but no assignment observed during review |
| Helpdesk Administrator | 0 observed | Role visible but no assignment observed during review |
| License Administrator | 0 observed | Role visible but no assignment observed during review |
| Billing Administrator | 0 observed | Role visible but no assignment observed during review |
| Reports Reader | 1 | One assignment observed |
| Service Support Administrator | 0 observed | Role visible but no assignment observed during review |
| Security Administrator | 1 | One assignment observed |
| Global Reader | 0 observed | Role visible but no assignment observed during review |
| Agent / Copilot-related role impact | Reviewed | AI Administrator and AI Reader roles were visible during review |
| Power Platform role impact | Reviewed | Power Platform Administrator role was visible during review |
| Compliance role impact | Reviewed | Compliance Administrator and Compliance Data Administrator roles were visible during review |
| Security role impact | Reviewed | Cloud App Security Administrator, Security Administrator, Security Operator, and Security Reader roles were visible during review |

## Review Process

The review was performed using the Microsoft 365 admin center.

Areas reviewed:

- Roles
- Role assignments
- Global Administrator
- Workload-specific admin roles
- Support-related admin roles
- Billing and license roles
- Reporting roles
- Security-related roles
- Agent / Copilot governance role awareness

No role assignments were changed.

## Screenshot Evidence

| Screenshot | Purpose |
|---|---|
| 12-global-admin-role-m365-sanitized.png | Shows one assigned Global Administrator |
| 13-admin-roles-overview-sanitized.png | Shows Microsoft 365 role assignments area, role categories, and available admin roles |

## Screenshot Privacy Notes

Do not expose:

- Admin account names
- User principal names
- Email addresses
- Tenant domain
- Tenant ID
- Object IDs
- Personal identifiers
- Service account names if sensitive

## Initial Findings

- The Microsoft 365 admin roles area was reviewed from the Microsoft 365 admin center.
- Role assignments were visible in the Microsoft 365 admin center.
- The role assignment area included Microsoft Entra ID, Exchange, Intune, and Billing role tabs.
- The role list included role names, descriptions, and categories.
- Export admin list functionality was visible.
- One Global Administrator assignment was observed.
- The Global Administrator account appeared to be a cloud-based account based on the visible admin name/domain context.
- No break-glass account was confirmed during this review.
- Reports Reader had one assignment observed.
- Security Administrator had one assignment observed.
- Exchange Administrator, SharePoint Administrator, Teams Administrator, User Administrator, Helpdesk Administrator, License Administrator, Billing Administrator, Service Support Administrator, and Global Reader were visible but no assignments were observed during this review.
- Agent and AI-related roles were visible, including AI Administrator and AI Reader.
- Power Platform Administrator was visible.
- Compliance-related roles were visible, including Compliance Administrator and Compliance Data Administrator.
- Security-related roles were visible, including Cloud App Security Administrator, Security Administrator, Security Operator, and Security Reader.
- No role assignments were changed during this review.

## Role Risk Observations

- One Global Administrator assignment is reasonable for a lab tenant, but production environments should have a documented emergency access strategy.
- No break-glass account was confirmed during this review, which should be addressed before enforcing Conditional Access or PIM controls.
- Several workload-specific roles were visible but not assigned, which may be acceptable in a lab tenant but should be reviewed in production for operational separation.
- Using Global Administrator for routine workload administration can violate least privilege.
- Reports Reader and Security Administrator assignments should be reviewed periodically to confirm they are still required.
- Missing workload-specific role assignments may indicate that one admin account is being used for too many responsibilities.
- Permanent privileged assignments should be reviewed later in the PIM project.
- Agent, AI, Power Platform, security, and compliance roles should be included in future governance planning because they may affect Copilot, agents, integrated apps, audit, data protection, and security visibility.
- Role changes should be monitored because privileged access changes can create security and compliance risk.

## Agent / Copilot Governance Impact

Microsoft 365 admin role strategy now affects more than traditional tenant administration.

As Microsoft 365 Copilot and agents become more common, role assignments may affect who can view, manage, approve, govern, or monitor agent-related capabilities.

Important future considerations include:

- Who can view agent inventory or agent metadata?
- Who can manage integrated apps?
- Who can administer Power Platform and Copilot Studio?
- Who can review audit and compliance data?
- Who can approve or block app and agent access?
- Who owns agent lifecycle governance?
- Which roles should have read-only visibility into agent activity?

This project does not configure Copilot or agents, but it identifies agent governance as a future role and access management consideration.

## Enterprise Considerations

In an enterprise environment, Microsoft 365 admin roles should be assigned intentionally and reviewed regularly.

Important considerations include:

- Keep Global Administrator assignments limited.
- Use workload-specific admin roles where possible.
- Separate daily user accounts from admin accounts.
- Use read-only roles for review and audit work.
- Use Helpdesk Administrator instead of Global Administrator for password reset support.
- Use License Administrator for license operations where appropriate.
- Use Exchange, SharePoint, and Teams admin roles for workload-specific administration.
- Review privileged role assignments periodically.
- Move standing privilege to PIM eligible assignments where possible.
- Monitor admin role changes.
- Document break-glass account strategy separately.
- Include Copilot and agent governance in future role planning.

## PowerShell and Microsoft Graph Opportunities

Future reporting can improve role assignment visibility and repeatability.

Possible future automation tasks:

| Task | Tooling |
|---|---|
| Export admin role assignments | Microsoft Graph PowerShell |
| Export Global Administrator members | Microsoft Graph PowerShell |
| Export workload admin role members | Microsoft Graph PowerShell |
| Identify users with privileged roles | Microsoft Graph PowerShell |
| Compare portal role counts to script output | PowerShell / Microsoft Graph |
| Generate admin role review report | PowerShell / Microsoft Graph |
| Monitor role changes | Microsoft Graph / audit logs |

## Framework Mapping

| Framework / Concept | Related Control | How This Review Supports It |
|---|---|---|
| Least Privilege | Role separation | Documents admin role assignments and workload-specific roles |
| Zero Trust | Verify explicitly | Supports stronger control over privileged access |
| Identity Governance | Access reviews | Prepares for future admin role reviews |
| Security | Privileged access management | Identifies privileged assignment risk |
| Operational Excellence | Admin ownership | Supports clear ownership of Microsoft 365 workloads |
| Compliance Readiness | Role evidence | Provides evidence for future access reviews and audits |
| Agent Governance | Role-based control | Prepares for future Copilot and agent access governance |

## Lessons Learned

- Microsoft 365 admin roles should be reviewed from an operational and workload ownership perspective.
- Microsoft 365 admin roles overlap with Microsoft Entra roles, but the Microsoft 365 admin center provides a useful operations-focused view.
- Global Administrator should not be used for routine workload administration when more specific roles are available.
- Workload-specific roles such as Exchange Administrator, SharePoint Administrator, Teams Administrator, License Administrator, and Helpdesk Administrator support least privilege.
- Reports Reader and Global Reader can support read-only review scenarios without granting full administrative control.
- Admin role planning should include future PIM, access reviews, audit logging, and break-glass account strategy.
- Agent and Copilot governance must be considered in modern Microsoft 365 role planning because AI-related roles and metadata visibility are becoming part of tenant administration.
- PowerShell and Microsoft Graph can make role assignment reporting repeatable and easier to validate.