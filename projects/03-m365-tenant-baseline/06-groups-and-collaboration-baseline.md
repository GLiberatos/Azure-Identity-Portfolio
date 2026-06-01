# Microsoft 365 Groups and Collaboration Baseline

## Purpose

This document captures the Microsoft 365 groups and collaboration baseline for the Microsoft 365 Tenant Baseline project.

The purpose is to understand Microsoft 365 collaboration objects, group types, ownership, membership, shared mailbox visibility, and collaboration governance risks before deeper Exchange Online, SharePoint Online, Teams, Purview, security, automation, or agent governance work.

## Why Groups and Collaboration Objects Matter

Microsoft 365 groups and collaboration objects affect how users communicate, collaborate, access resources, and manage shared workspaces.

Different group types serve different purposes.

A groups and collaboration review helps answer:

* Which group types exist in the tenant?
* How many Microsoft 365 groups exist?
* How many distribution lists exist?
* Are mail-enabled security groups present?
* Are shared mailboxes present?
* Are owners and members visible?
* Are collaboration objects governed consistently?
* What risks exist around group sprawl, ownership, access, and lifecycle?
* How could groups affect future SharePoint, Teams, Exchange, Purview, Copilot, or agent governance?

## Relationship to Prior Work

Project 02 documented the Microsoft Entra ID group baseline from an identity perspective.

Project 03 has already documented:

* Microsoft 365 tenant context
* Microsoft 365 admin center navigation
* Users and licenses
* Domains and organization profile
* Microsoft 365 admin roles

This file builds on that work by reviewing Microsoft 365 groups and collaboration objects from an operations and workload governance perspective.

This does not repeat the full Project 02 Entra group baseline. Instead, it focuses on Microsoft 365 collaboration impact, group ownership, shared mailbox visibility, and future governance considerations.

## Review Scope

### In Scope

* Active teams and groups
* Microsoft 365 groups
* Distribution lists
* Mail-enabled security groups
* Security groups from the Microsoft 365 admin center view
* Shared mailboxes
* Deleted groups, if visible
* Group ownership and membership visibility
* Collaboration governance risks
* Agent / Copilot governance impact
* Future PowerShell, Exchange Online PowerShell, and Microsoft Graph reporting opportunities

### Out of Scope

* Creating new groups
* Deleting groups
* Changing group owners
* Changing group members
* Changing email addresses
* Changing privacy settings
* Creating shared mailboxes
* Assigning mailbox permissions
* Configuring Teams policies
* Configuring SharePoint sharing
* Configuring Purview, DLP, or retention
* Configuring Copilot or agents

## Group and Collaboration Summary

| Object Type | Count / Status | Notes |
|---|---:|---|
| Total group objects visible across reviewed group views | 27 | Includes Teams/Microsoft 365 groups, distribution lists, and security groups |
| Teams and Microsoft 365 groups | 5 | Collaboration groups visible in the Microsoft 365 admin center |
| Microsoft 365 groups | 5 | Same reviewed area as Teams and Microsoft 365 groups |
| Distribution lists | 1 | Email distribution object observed |
| Security groups | 21 | Security groups visible from the Microsoft 365 admin center |
| Mail-enabled security groups | 1 | Mail-enabled security group observed within the security groups view |
| Shared mailboxes | 0 | No shared mailboxes observed |
| Deleted groups | 0 | No deleted groups observed |
| Teams-connected groups | 2 | Two groups showed Teams connection/status |
| Groups without owners | 0 observed | No ownerless groups were observed during review |
| Naming concerns | None obvious | Existing naming is acceptable for the lab environment |

## Review Process

The review was performed using the Microsoft 365 admin center.

Areas reviewed:

* Teams & groups > Active teams & groups
* Microsoft 365 groups
* Distribution lists
* Mail-enabled security groups
* Security groups
* Shared mailboxes
* Deleted groups, if visible
* Group owners and members, if safely reviewed

No group or mailbox configuration changes were made.

## Evidence Summary

Screenshots were reviewed during the lab, but this file does not rely heavily on screenshots because the portal views did not add significant value beyond the observed counts.

The key evidence for this section is the recorded Microsoft 365 admin center inventory:

| Evidence Area | Observed Result |
|---|---:|
| Teams and Microsoft 365 groups | 5 |
| Distribution lists | 1 |
| Security groups | 21 |
| Mail-enabled security groups | 1 |
| Shared mailboxes | 0 |
| Deleted groups | 0 |
| Teams-connected groups | 2 |
| Groups without owners observed | 0 |

Future automation using Microsoft Graph PowerShell and Exchange Online PowerShell should be used to validate and export this inventory.

## Screenshot Privacy Notes

Do not expose:

* Group email addresses
* Tenant domain
* Owner names
* Member names
* User principal names
* Personal email addresses
* Private group names if sensitive
* Object IDs
* Mailbox addresses
* Service account names if sensitive

## Initial Findings

- The Microsoft 365 admin center groups and collaboration areas were reviewed.
- 5 Teams and Microsoft 365 groups were observed.
- 1 distribution list was observed.
- 21 security groups were observed.
- 1 mail-enabled security group was observed within the security groups view.
- 0 shared mailboxes were observed.
- 0 deleted groups were observed.
- 2 Teams-connected groups were observed.
- No groups without owners were observed during this review.
- No obvious naming issues were identified.
- No group owners, members, mailbox permissions, or group settings were changed during this review.

## Collaboration and Group Risk Observations

- The tenant contains multiple group types, which means group purpose and ownership should be clearly documented.
- Microsoft 365 groups can affect collaboration across Teams, SharePoint, Outlook, Planner, and related Microsoft 365 services.
- Teams-connected groups should be reviewed carefully because they may provide access to Teams conversations, files, and SharePoint-backed content.
- Distribution lists should be reviewed for ownership, sender restrictions, and external sender behavior in future Exchange Online work.
- Security groups should be reviewed for access-control purpose and source of authority.
- The observed mail-enabled security group should be reviewed later from both access-control and Exchange administration perspectives.
- No shared mailboxes were observed, which is acceptable in a lab tenant, but shared mailbox governance should be reviewed in future Exchange Online work.
- No deleted groups were observed, which indicates no current deleted Microsoft 365 group recovery items were visible during review.
- No ownerless groups were observed, which is positive because ownerless groups can create lifecycle and accountability risk.
- Group ownership, membership, and lifecycle should be validated later with Microsoft Graph PowerShell and Exchange Online PowerShell.
- Group governance is important for future Copilot and agent governance because group membership may affect access to Teams, SharePoint, files, mail-enabled objects, and collaboration data.

## Agent / Copilot Governance Impact

Microsoft 365 group governance is important for future Copilot and agent governance.

As Microsoft 365 Copilot, Copilot Studio, SharePoint agents, and other agent-based workflows become more common, group ownership and membership can influence who has access to collaboration spaces and underlying content.

Important future considerations include:

* Which groups provide access to SharePoint sites?
* Which groups are connected to Teams?
* Which groups contain sensitive business users or data owners?
* Are group owners responsible for reviewing membership?
* Are inactive or unmanaged groups creating oversharing risk?
* Are shared mailboxes used for sensitive business workflows?
* Are distribution lists managed by appropriate owners?
* Are groups reviewed before enabling broader Copilot or agent scenarios?

This file does not configure Copilot or agents, but it identifies Microsoft 365 groups and collaboration objects as future agent governance dependencies.

## Enterprise Considerations

In an enterprise environment, Microsoft 365 groups and collaboration objects should be governed intentionally.

Important considerations include:

* Who can create Microsoft 365 groups?
* Who can create distribution lists?
* Who owns shared mailboxes?
* Are group owners assigned and accountable?
* Are naming standards enforced?
* Are inactive groups reviewed?
* Are guest members reviewed?
* Are groups tied to Teams, SharePoint, Planner, or Exchange?
* Are shared mailbox permissions reviewed?
* Are lifecycle, expiration, and access reviews configured where appropriate?
* Are group changes monitored?
* Are PowerShell or Microsoft Graph reports used to validate group state?
* Are groups included in Copilot, agent, Purview, and DLP planning?

## PowerShell, Microsoft Graph, and Exchange Online Opportunities

Future reporting can improve group and collaboration object visibility.

Possible future automation tasks:

| Task                                   | Tooling                                         |
| -------------------------------------- | ----------------------------------------------- |
| Export Microsoft 365 groups            | Microsoft Graph PowerShell                      |
| Export group owners                    | Microsoft Graph PowerShell                      |
| Export group members                   | Microsoft Graph PowerShell                      |
| Export distribution groups             | Exchange Online PowerShell                      |
| Export mail-enabled security groups    | Exchange Online PowerShell                      |
| Export shared mailboxes                | Exchange Online PowerShell                      |
| Identify groups without owners         | Microsoft Graph PowerShell                      |
| Identify inactive or stale groups      | Microsoft Graph / reports                       |
| Compare portal counts to script output | PowerShell / Microsoft Graph                    |
| Generate group governance report       | PowerShell / Graph / Exchange Online PowerShell |

## Framework Mapping

| Framework / Concept    | Related Control           | How This Review Supports It                                             |
| ---------------------- | ------------------------- | ----------------------------------------------------------------------- |
| Operational Excellence | Collaboration inventory   | Documents group and shared mailbox state before deeper workload changes |
| Governance             | Ownership and lifecycle   | Supports naming, ownership, expiration, and cleanup planning            |
| Least Privilege        | Group membership review   | Helps ensure access follows business need                               |
| Security               | Access boundaries         | Identifies group-based access and collaboration exposure                |
| Compliance Readiness   | Evidence and auditability | Supports future access reviews, retention, and audit readiness          |
| Agent Governance       | Data access control       | Prepares for Copilot and agent access governance                        |
| Automation             | Group reporting           | Prepares for repeatable reporting with Graph and PowerShell             |

## Reflection Questions

- What is the difference between a Microsoft 365 group, a distribution list, a security group, a mail-enabled security group, and a shared mailbox?
- Which group type is most directly tied to Teams and SharePoint collaboration?
- Why is group ownership important in an enterprise environment?
- Why can group sprawl become a security or governance problem?
- Why should shared mailboxes be reviewed separately from regular user mailboxes?
- How can Microsoft 365 groups affect future Copilot or agent governance?
- What group data should be exported later with Microsoft Graph or PowerShell?
- Which group risks should be reviewed before enabling broader collaboration or AI features?
- What information should be sanitized before publishing group screenshots?
- How does this file build on Project 02 instead of repeating it?
- Why should Teams-connected groups be reviewed before enabling broader Copilot or agent scenarios?
- Why is a mail-enabled security group different from a standard security group?
- Why should distribution lists be reviewed again during the Exchange Online project?
- Why is Microsoft Graph better than screenshots for validating group inventory?
- What would be the risk if a Microsoft 365 group had no owner?

## Lessons Learned

- Microsoft 365 groups and collaboration objects should be reviewed separately from the Entra ID group baseline.
- Microsoft 365 groups, distribution lists, security groups, mail-enabled security groups, and shared mailboxes serve different purposes.
- Teams-connected Microsoft 365 groups can create collaboration spaces that include Teams and SharePoint-backed content.
- Distribution lists are primarily email distribution objects, while security groups are typically used for access control.
- Mail-enabled security groups can support both email distribution and access-control scenarios.
- Shared mailboxes should be reviewed separately because they are Exchange mailbox objects used by multiple users.
- Group ownership matters because owners are responsible for membership, access, and lifecycle decisions.
- Group governance becomes more important in Copilot and agent scenarios because group membership and SharePoint/Teams access can affect what data users and agents may reach.
- Future automation with Microsoft Graph PowerShell and Exchange Online PowerShell should be used to validate group inventory, owners, members, and mailbox-related objects.