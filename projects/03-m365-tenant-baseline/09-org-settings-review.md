# Microsoft 365 Organization Settings Review

## Purpose

This document captures the Microsoft 365 organization settings baseline for the Microsoft 365 Tenant Baseline project.

The purpose is to understand tenant-wide organization settings, service settings, integrated apps visibility, report privacy settings, and Copilot / agent-related governance awareness before deeper Microsoft 365, Exchange Online, SharePoint Online, Teams, Intune, Purview, security, automation, Power Platform, or agent governance work.

## Why Organization Settings Matter

Microsoft 365 organization settings can affect tenant-wide behavior across multiple workloads.

Some settings affect reporting, privacy, apps, integrated apps, collaboration, user experience, service availability, and Microsoft-driven feature exposure.

An organization settings review helps answer:

- Which tenant-wide settings are visible?
- Which service settings are available?
- Which settings may affect multiple workloads?
- Are report privacy settings configured?
- Are integrated apps visible?
- Are Copilot or agent-related settings visible?
- Which settings require change control before modification?
- Which settings should be reviewed later through automation or deeper workload projects?

## Relationship to Prior Work

Project 03 has already documented:

- Microsoft 365 tenant context
- Microsoft 365 admin center navigation
- Users and licenses
- Domains and organization profile
- Microsoft 365 admin roles
- Microsoft 365 groups and collaboration objects
- Service health and Message center
- Reports and usage baseline

This file builds on that work by reviewing Microsoft 365 tenant-wide settings and service settings.

This does not repeat the domains, organization profile, reports, or admin role reviews. Instead, it focuses on organization settings as a tenant-wide governance surface.

## Review Scope

### In Scope

- Settings > Org settings
- Organization profile visibility
- Services settings visibility
- Reports service setting confirmation
- Integrated apps visibility
- Security and privacy settings visibility, if present
- Copilot and agent-related setting awareness
- Tenant-wide risk-sensitive setting awareness
- Future PowerShell / Microsoft Graph opportunities

### Out of Scope

- Changing organization profile information
- Changing release preferences
- Changing report privacy settings
- Enabling or disabling services
- Deploying integrated apps
- Removing integrated apps
- Approving or blocking apps
- Configuring Copilot
- Configuring agents
- Configuring Power Platform
- Configuring Purview, DLP, or retention
- Configuring Teams, SharePoint, Exchange, or Intune service policies

## Organization Settings Summary

| Setting Area | Count / Status | Notes |
|---|---|---|
| Org settings visible | Yes | Reviewed from Microsoft 365 admin center |
| Organization profile visible | Yes | Organization profile tab was visible |
| Services tab visible | Yes | Tenant-wide service settings area was visible |
| Approximate service settings visible | 40 | Services tab showed 40 items |
| Organization profile settings visible | 10 | Organization profile tab showed 10 items |
| Security & privacy settings visible | 12 | Security & privacy tab showed 12 items |
| Reports service setting visible | Yes | Reports setting was visible and reviewed |
| Reports names concealed/anonymized | Yes | User, group, and site names were concealed in reports |
| Teams-related setting visible | Yes | Developer Portal for Teams was visible in Services |
| SharePoint / OneDrive-related setting visible | No | Not observed in the Services tab during this review |
| Copilot-related setting visible | No | Not observed in the Services tab during this review |
| Integrated apps visible | Yes | Reviewed separately from Settings > Integrated apps |
| Deployed apps visible | Yes | 2 deployed apps were visible |
| Available apps visible | Yes | 1,358 available apps were visible |
| Agent-related visibility | Yes | Agent banner, Manage agents option, and agent-filtered app results were visible |
| Security & privacy visible | Yes | Security & privacy settings area was visible |
| Admin action needed | Review required | No immediate change was made, but several settings should be reviewed before production use |

## Review Process

The review was performed using the Microsoft 365 admin center.

Areas reviewed:

- Settings > Org settings
- Organization profile
- Services
- Reports service setting
- Settings > Integrated apps
- Security and privacy area, if visible
- Copilot and agent-related settings, if visible

No organization settings, service settings, app settings, report privacy settings, Copilot settings, or agent settings were changed.

## Evidence Summary

Screenshots were reviewed during the lab, but this file does not rely heavily on screenshots because organization settings can expose tenant-specific configuration details.

The key evidence for this section is the recorded Microsoft 365 admin center organization settings inventory:

| Evidence Area | Observed Result |
|---|---|
| Org settings visible | Yes |
| Services settings visible | Yes, 40 items |
| Organization profile visible | Yes, 10 items |
| Security & privacy visible | Yes, 12 items |
| Reports setting visibility | Yes |
| Reports privacy setting | User, group, and site names concealed |
| Release preferences | Standard release for everyone |
| Microsoft 365 Groups settings | Visible |
| User owned apps and services settings | Visible |
| Viva Insights settings | Visible |
| Microsoft Forms settings | Visible |
| Bookings settings | Visible |
| Sway settings | Visible |
| Integrated apps visibility | Yes |
| Deployed apps | 2 visible deployed apps |
| Available apps | 1,358 visible available apps |
| Agent-related visibility | Yes, agent banner and agent-filtered app results were visible |
| Agent-filtered available apps | 20 visible items |
| SharePoint / OneDrive service setting | Not observed in Services tab |
| Microsoft 365 Copilot service setting | Not observed in Services tab |
| Apps / Integrated apps under Services tab | Not observed in Services tab; Integrated apps was reviewed separately |

Future automation using Microsoft Graph should be used where supported to validate settings, app visibility, and governance-related configuration.

## Screenshot Privacy Notes

Do not expose:

- Tenant domain
- Tenant ID
- Admin account
- Organization address
- Technical contacts
- Private app names if sensitive
- Internal service configuration
- Security-sensitive settings
- User, group, or site names
- Private organization details

## Initial Findings

- Microsoft 365 Org settings was reviewed from the Microsoft 365 admin center.
- The Services tab was visible and showed 40 items.
- The Organization profile tab was visible and showed 10 items.
- The Security & privacy tab was visible and showed 12 items.
- Organization information was visible, including default domain, tenant ID, technical contact, and preferred language fields.
- Release preferences were reviewed and showed Standard release for everyone.
- Reports settings were reviewed.
- Report privacy was configured to conceal user, group, and site names in reports.
- Microsoft 365 usage analytics for Power BI was visible but not enabled.
- Microsoft 365 Groups settings were reviewed.
- Guest-related Microsoft 365 Groups settings were visible.
- The tenant allowed group owners to add people outside the organization to Microsoft 365 Groups as guests.
- The tenant allowed guest group members to access group content.
- The ownerless groups email prompt option was visible but not enabled.
- User owned apps and services settings were reviewed.
- Office Store access was enabled.
- Users were allowed to start trials on behalf of the organization.
- Auto-claim licenses was visible but not enabled.
- Microsoft Viva Insights settings were visible.
- Microsoft Forms settings were visible, including external sharing and phishing protection options.
- Microsoft Bookings settings were visible.
- Microsoft Sway settings were visible, including sharing and content source settings.
- Developer Portal for Teams was visible in the Services tab.
- SharePoint / OneDrive-specific service settings were not observed in the Services tab during this review.
- Microsoft 365 Copilot-specific service settings were not observed in the Services tab during this review.
- Apps and Integrated apps were not observed inside the Services tab; Integrated apps was reviewed separately from Settings > Integrated apps.
- Integrated apps was visible.
- Deployed apps were visible, with 2 deployed apps shown.
- Available apps were visible, with 1,358 available apps shown.
- Agent-related visibility was present in Integrated apps.
- The Integrated apps page displayed a banner stating that agents can be viewed and managed from Agents > All agents.
- A Manage agents option was visible.
- Filtering available apps by “agent” showed 20 visible items.
- Several agent-related available apps showed availability for all users in the organization to install.
- No organization settings, service settings, integrated app settings, Copilot settings, or agent settings were intentionally changed during this review.

## Organization Settings Risk Observations

- Organization settings include tenant-wide controls that can affect many users and workloads, so changes should be reviewed through change management.
- Report privacy settings are important because they control whether user, group, and site names are visible or concealed in usage reports.
- Concealing user, group, and site names supports privacy, but it may reduce troubleshooting detail when admins need to investigate specific activity.
- Microsoft 365 Groups guest settings are risk-sensitive because they affect whether external users can be added to groups and access group content.
- Ownerless group settings should be reviewed because groups without owners can create lifecycle, access review, and accountability issues.
- User owned apps and services settings are risk-sensitive because allowing users to access the Office Store or start trials can introduce governance, licensing, support, and app-sprawl concerns.
- Auto-claim licensing should be reviewed carefully before enabling because it can affect license assignment behavior.
- Forms external sharing settings should be reviewed because forms can collect responses and may expose collaboration or data-sharing risk.
- Forms phishing protection is important because forms can be abused to collect sensitive information.
- Bookings settings should be reviewed because Bookings can expose scheduling pages, customer interaction options, staff information, SMS notifications, and customer data collection behavior.
- Sway sharing and external content source settings should be reviewed because they can affect content sharing and external media usage.
- Integrated apps require governance because users may be able to install apps that affect Outlook, Teams, Microsoft 365 apps, or business workflows.
- Agent-related app visibility is important because agents introduce new governance needs around ownership, access, app availability, lifecycle, and data exposure.
- Security & privacy settings such as baseline security mode, Customer Lockbox, idle session timeout, Graph Data Connect applications, password expiration policy, privileged access, and self-service password reset should be reviewed carefully before any changes.
- Integrated apps and agent availability should be reviewed with admin roles, security, compliance, Power Platform, and Copilot governance in mind.
- In production, organization settings should have assigned ownership, documented decisions, change approval, and periodic review.

## Agent / Copilot Governance Impact

Microsoft 365 organization settings are important for future Copilot and agent governance.

As Copilot, Copilot Studio, SharePoint agents, and Microsoft 365 agents become more common, administrators need visibility into settings that may affect:

- App deployment
- Integrated apps
- Agent availability
- Report visibility
- User experience
- Service availability
- Admin ownership
- Data exposure
- Change management

Important future considerations include:

- Are Copilot-related settings visible in the tenant?
- Are integrated apps governed intentionally?
- Who can approve, block, or deploy apps?
- Are agents visible or manageable from the Microsoft 365 admin center?
- Are AI Admin and Global Reader role responsibilities understood?
- Are report privacy settings aligned with Copilot and agent adoption reporting?
- Are Power Platform and Copilot Studio governance controls planned?

This file does not configure Copilot or agents, but it identifies organization settings as a future governance dependency for Copilot and agent adoption.

## Enterprise Considerations

In an enterprise environment, Microsoft 365 organization settings should be reviewed carefully before changes are made.

Important considerations include:

- Who owns tenant-wide Microsoft 365 settings?
- Who approves organization setting changes?
- Which settings affect all users?
- Which settings affect specific services?
- Are service setting changes tested before rollout?
- Are report privacy settings aligned with legal, privacy, and operational needs?
- Are integrated apps governed?
- Are app approvals documented?
- Are Copilot and agent settings reviewed before broad adoption?
- Are setting changes tracked through change management?
- Are PowerShell or Graph exports used where available?

## PowerShell and Microsoft Graph Opportunities

Future reporting can improve organization settings visibility and repeatability.

Possible future automation tasks:

| Task | Tooling |
|---|---|
| Export organization information | Microsoft Graph PowerShell |
| Export verified domains | Microsoft Graph PowerShell |
| Export subscribed services | Microsoft Graph PowerShell |
| Export integrated app inventory, where supported | Microsoft Graph / Microsoft 365 admin APIs |
| Export report settings, where supported | Microsoft Graph / admin center validation |
| Export Copilot or agent settings, where supported | Microsoft Graph / admin center validation |
| Compare portal findings to automated reports | PowerShell / Microsoft Graph |
| Generate organization settings review report | PowerShell / Microsoft Graph |

## Framework Mapping

| Framework / Concept | Related Control | How This Review Supports It |
|---|---|---|
| Operational Excellence | Tenant-wide setting awareness | Documents where organization settings are reviewed |
| Governance | Change control | Supports controlled review of tenant-wide settings |
| Security | Risk-sensitive settings | Identifies settings that may affect access, apps, and privacy |
| Compliance Readiness | Evidence and review | Supports review of privacy and service configuration |
| Change Management | Service settings | Helps avoid unplanned tenant-wide impact |
| Agent Governance | App and agent controls | Prepares for Copilot and agent governance planning |
| Automation | Settings reporting | Prepares for repeatable validation through Graph and PowerShell |

## Reflection Questions

- What is the purpose of Microsoft 365 organization settings?
- Why should tenant-wide settings be reviewed before deeper workload configuration?
- What is the difference between organization profile settings and service settings?
- Why can changing a service setting affect multiple users or workloads?
- Why should report privacy settings be reviewed as part of organization settings?
- Why are integrated apps important for app and agent governance?
- How do organization settings connect to Copilot and agent governance?
- What types of organization settings should require change control?
- What organization settings should be validated later with PowerShell or Microsoft Graph?
- How would you explain Microsoft 365 org settings to a hiring manager?
- How does this file build on the reports, admin roles, and tenant overview files?

## Lessons Learned

- Microsoft 365 organization settings provide a tenant-wide view of service, security, privacy, and organization profile settings.
- Org settings should be reviewed carefully because some settings can affect all users or multiple Microsoft 365 workloads.
- Organization profile settings include tenant identity and release preference information, but those details should not be repeatedly documented in every file.
- Service settings expose important workload-level controls for features such as reports, Microsoft 365 Groups, Forms, Bookings, Sway, Viva Insights, and user owned apps.
- Security & privacy settings contain risk-sensitive controls that may affect authentication, privileged access, support data access, Graph data access, and user self-service.
- Report privacy settings connect organization settings to reporting, privacy, troubleshooting, and governance.
- Integrated apps is a separate Microsoft 365 admin center area and should not be confused with the Services tab.
- Integrated apps can expose deployed apps, available apps, blocked apps, requested apps, and agent-related app visibility.
- Agent visibility in Integrated apps confirms that app and agent governance must be included in future Microsoft 365 administration work.
- User-owned apps, trials, guest access, Forms sharing, Bookings, and Sway sharing are examples of settings that may be acceptable in a lab tenant but require stronger review in production.
- Organization settings should be reviewed together with admin roles, reports, groups, security, compliance, Power Platform, Copilot, and agent governance.
- Future automation with Microsoft Graph and PowerShell should be used where possible to validate and document organization settings repeatedly.