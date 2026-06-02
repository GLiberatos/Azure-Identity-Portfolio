# Microsoft 365 Reports and Usage Baseline

## Purpose

This document captures the Microsoft 365 reports and usage baseline for the Microsoft 365 Tenant Baseline project.

The purpose is to understand Microsoft 365 reporting visibility, usage trends, adoption signals, report privacy settings, and future reporting automation opportunities before deeper Microsoft 365, Exchange Online, SharePoint Online, Teams, Intune, Purview, security, automation, or agent governance work.

## Why Reports and Usage Matter

Microsoft 365 reports help administrators understand how users are using Microsoft 365 services.

Reports can support:

* License review
* Adoption tracking
* Service usage analysis
* Cleanup planning
* Support readiness
* Collaboration governance
* Security and compliance awareness
* Copilot and agent readiness planning
* Automation and executive reporting

A reports and usage review helps answer:

* Which reports are available?
* Which Microsoft 365 services show usage data?
* Are reports anonymized or user-identifiable?
* Are export options available?
* What reports can support license or adoption decisions?
* What reports should later be automated with Microsoft Graph?
* How can reports support Copilot and agent governance?

## Relationship to Prior Work

Project 03 has already documented:

* Microsoft 365 tenant context
* Microsoft 365 admin center navigation
* Users and licenses
* Domains and organization profile
* Microsoft 365 admin roles
* Microsoft 365 groups and collaboration objects
* Service health and Message center

This file builds on that work by reviewing Microsoft 365 usage visibility and reporting readiness.

This does not repeat the users, licenses, or groups baseline. Instead, it focuses on reporting visibility, usage signals, adoption tracking, and future automation.

## Review Scope

### In Scope

* Microsoft 365 Reports > Usage
* Available report categories
* Active users report
* Service-specific usage reports
* Report date ranges
* Export visibility
* Report privacy/anonymization setting review
* Copilot-related reports, if visible
* Operational reporting value
* Future Microsoft Graph reporting opportunities

### Out of Scope

* Changing report privacy settings
* Publishing user-level activity data
* Exporting unsanitized user activity reports
* Configuring Power BI usage analytics
* Building dashboards
* Configuring Copilot
* Configuring agents
* Configuring Purview audit or retention

## Reports and Usage Summary

| Report / Usage Area | Count / Status | Notes |
|---|---|---|
| Reports area visible | Yes | Reviewed from Microsoft 365 admin center |
| Usage dashboard visible | Yes | Reports > Usage dashboard was visible |
| Active users report | Yes | Active users report was visible with report privacy concealment applied |
| Email activity report | Yes | Exchange email activity report was visible |
| OneDrive usage report | Yes | OneDrive usage report was visible |
| SharePoint usage report | Yes | SharePoint report category was visible |
| Teams usage report | Yes | Microsoft Teams usage report was visible |
| Microsoft 365 Apps usage report | Yes | Microsoft 365 Apps usage report was visible, but no usage data was available in the reviewed view |
| Copilot report | Yes | Copilot readiness, usage, and agents report areas were visible |
| Report date ranges | 7, 30, 90, 180 days | Date range options were visible |
| Export option | Yes | Export options were visible in multiple report views |
| Reports privacy setting | Names concealed/anonymized | User, group, and site names were concealed in reports |
| Admin action needed | No immediate action observed | Reporting should continue to be reviewed for adoption, licensing, Copilot readiness, and governance |

## Evidence Summary

Screenshots were reviewed during the lab, but this file does not rely heavily on screenshots because usage reports may expose user, group, site, or activity information.

The key evidence for this section is the recorded Microsoft 365 admin center reporting inventory:

| Evidence Area | Observed Result |
|---|---|
| Reports area visible | Yes |
| Usage dashboard visible | Yes |
| Available report categories | Microsoft 365 Copilot, Exchange, Forms, Microsoft 365 Apps, Microsoft Browser, Microsoft Teams, Microsoft Teams apps, OneDrive, Project, SharePoint, Visio, Viva Engage, and Viva Learning |
| Date ranges visible | 7, 30, 90, and 180 days |
| Export option | Visible in multiple report views |
| Reports privacy setting | User, group, and site names concealed |
| Active users report | Visible |
| Email activity report | Visible |
| OneDrive usage report | Visible |
| Teams usage report | Visible |
| Microsoft 365 Apps usage report | Visible, but no data available in reviewed view |
| Copilot readiness report | Visible |
| Copilot usage report | Visible |
| Copilot agents report | Visible |
| Copilot enabled users | 0 |
| Copilot active users | 0 |
| Copilot active agent users | 0 |
| Copilot total prompts submitted | 0 |
| Copilot active agents | 0 |

Future automation using Microsoft Graph reports APIs should be used to validate and export reporting data.

## Screenshot Privacy Notes

Do not expose:

* User names
* Group names
* Site names
* User principal names
* Email addresses
* Tenant domain
* User activity details
* Site URLs
* Private business usage patterns
* Unsanitized CSV exports

## Initial Findings

- Microsoft 365 Reports > Usage was reviewed from the Microsoft 365 admin center.
- The usage dashboard was visible.
- Report date ranges for 7, 30, 90, and 180 days were visible.
- Export options were visible in multiple report areas.
- Available report categories included Microsoft 365 Copilot, Exchange, Forms, Microsoft 365 Apps, Microsoft Browser, Microsoft Teams, Microsoft Teams apps, OneDrive, Project, SharePoint, Visio, Viva Engage, and Viva Learning.
- Active users reporting was visible.
- Email activity reporting was visible.
- OneDrive usage reporting was visible.
- Teams usage reporting was visible.
- Microsoft 365 Apps usage reporting was visible, but the reviewed usage view showed no report data.
- OneDrive usage showed limited activity, including 2 total accounts and 0 active accounts in the reviewed view.
- Teams usage reporting showed limited activity, including 1 private team and 0 active private teams in the reviewed view.
- Report privacy settings were reviewed.
- User, group, and site names were concealed in reports.
- Microsoft 365 Copilot reporting was visible.
- Copilot readiness, usage, and agents tabs were visible.
- Copilot readiness showed 0 total prerequisite licenses and 0 users on an eligible update channel.
- Copilot usage showed 0 enabled users, 0 active users, 0 active agent users, 0 total prompts submitted, and 0 average prompts submitted per user.
- Copilot agents reporting showed 0 active agents.
- No report exports were saved as part of this review.
- No report privacy settings were intentionally changed as part of this review.

## Reports and Usage Risk Observations

- Microsoft 365 usage reports provide useful adoption and activity visibility, but report data should be handled carefully because it can expose user, group, site, and service usage patterns.
- Concealing user, group, and site names supports privacy, but it can limit troubleshooting detail when administrators need to investigate specific user or site activity.
- Report exports should be protected because exported CSV files may contain sensitive operational or user activity data.
- Low usage in a developer tenant is expected, but in production it could indicate poor adoption, unused licenses, inactive users, or incomplete onboarding.
- Microsoft 365 Apps usage showing no data may be expected in a lab tenant, but in production it should be reviewed to confirm whether users are actually using assigned services.
- Teams and OneDrive usage should be reviewed before broader collaboration, SharePoint, Purview, Copilot, or agent governance work.
- Copilot readiness and usage reports should be reviewed before enabling or expanding Copilot because licensing, app usage, update channels, and user activity can affect readiness.
- Copilot agents reporting should be included in future AI governance reviews because agents introduce lifecycle, ownership, usage, and data access considerations.
- Reporting ownership should be clearly defined in production so usage, adoption, licensing, security, and governance reports are reviewed regularly.
- Future automation with Microsoft Graph should be used to validate portal observations and create repeatable reporting evidence.

## Agent / Copilot Governance Impact

Microsoft 365 reports can support future Copilot and agent governance.

As Microsoft 365 Copilot, Copilot Studio, SharePoint agents, and agent-based workflows become more common, reporting helps administrators understand usage, adoption, readiness, and potential data exposure areas.

Important future considerations include:

* Are Copilot readiness or usage reports available?
* Are users actively using services that may provide data context for Copilot or agents?
* Are Teams, SharePoint, and OneDrive usage patterns understood before enabling AI-driven features?
* Are reports anonymized or user-identifiable?
* Can reports help identify adoption gaps or unused licenses?
* Can Graph exports support repeatable Copilot readiness reviews?
* Are reporting responsibilities assigned to the correct admins?

This file does not configure Copilot or agents, but it identifies Microsoft 365 reports as a future input for Copilot and agent governance.

## Enterprise Considerations

In an enterprise environment, Microsoft 365 reports should be reviewed regularly and used carefully.

Important considerations include:

* Who reviews Microsoft 365 usage reports?
* Who can access user-level reporting?
* Are reports anonymized by default?
* Are report exports protected?
* Are usage reports used for license optimization?
* Are low-usage services reviewed before renewals?
* Are adoption trends reviewed for Teams, SharePoint, OneDrive, Exchange, and Microsoft 365 Apps?
* Are Copilot readiness and usage reports reviewed before AI rollout?
* Are exported reports stored securely?
* Are reports used to support governance, security, compliance, and operations?

## PowerShell and Microsoft Graph Opportunities

Future reporting can improve Microsoft 365 usage visibility and repeatability.

Possible future automation tasks:

| Task                                                    | Tooling                                       |
| ------------------------------------------------------- | --------------------------------------------- |
| Export Microsoft 365 active user detail                 | Microsoft Graph reports API                   |
| Export email activity reports                           | Microsoft Graph reports API                   |
| Export OneDrive usage reports                           | Microsoft Graph reports API                   |
| Export SharePoint site usage reports                    | Microsoft Graph reports API                   |
| Export Teams usage reports                              | Microsoft Graph reports API                   |
| Export Microsoft 365 Apps usage reports                 | Microsoft Graph reports API                   |
| Export Copilot readiness or usage reports, if available | Microsoft Graph / Microsoft 365 admin reports |
| Generate usage summary report                           | PowerShell / Microsoft Graph                  |
| Compare portal counts to exported reports               | PowerShell / Microsoft Graph                  |

## Framework Mapping

| Framework / Concept    | Related Control             | How This Review Supports It                                      |
| ---------------------- | --------------------------- | ---------------------------------------------------------------- |
| Operational Excellence | Usage visibility            | Documents Microsoft 365 usage and reporting capabilities         |
| Governance             | Report ownership            | Supports regular review of adoption, activity, and service usage |
| Security               | Data visibility             | Identifies sensitive report access and export considerations     |
| Compliance Readiness   | Evidence and auditability   | Supports reporting evidence and controlled export handling       |
| Cost Management        | License and service usage   | Supports license optimization and unused service review          |
| Agent Governance       | Copilot readiness and usage | Prepares for AI and agent adoption reporting                     |
| Automation             | Graph reporting             | Prepares for repeatable reporting through Microsoft Graph        |

## Reflection Questions

* What is the purpose of Microsoft 365 usage reports?
* How can usage reports help with license optimization?
* Why should active users, service usage, and license assignment be reviewed together?
* What is the difference between a report dashboard and an exported report?
* Why do report privacy and anonymization settings matter?
* How can reports help identify low adoption or unused services?
* Which Microsoft 365 workloads should be reviewed through reports before deeper governance work?
* Why are SharePoint, OneDrive, and Teams reports important for Copilot and agent readiness?
* What Microsoft Graph report exports would be useful for repeatable reporting?
* How would you explain Microsoft 365 usage reporting to a hiring manager?
* How does this file build on the users/licenses and groups/collaboration files?

## Lessons Learned

- Microsoft 365 usage reports help administrators understand adoption, activity, and service usage across the tenant.
- Reports can support license optimization by showing whether assigned services are actually being used.
- Active users, service usage, and license assignments should be reviewed together to understand whether users are properly licensed and actively using Microsoft 365 services.
- Report privacy settings affect whether user, group, and site names are visible or concealed in reports.
- Exported reports can be useful for analysis, but they must be protected because they may contain sensitive usage data.
- Teams, SharePoint, and OneDrive usage reports are important for collaboration governance and future Copilot or agent readiness.
- Microsoft 365 Copilot reporting can show readiness, usage, and agent-related visibility when available.
- In this tenant, Copilot usage and active agent counts were 0, which is expected when Copilot licensing and agent usage are not active.
- Microsoft Graph reports APIs can make reporting repeatable and reduce reliance on screenshots.
- Reports should be part of enterprise operations, governance, adoption review, and future automation planning.