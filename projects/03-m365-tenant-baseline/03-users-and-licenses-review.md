# Microsoft 365 Users and Licenses Review

## Purpose

This document captures the Microsoft 365 users and licenses baseline for the Microsoft 365 Tenant Baseline project.

The purpose is to understand user licensing, product availability, and service access before deeper Microsoft 365 administration, Exchange, SharePoint, Teams, Intune, Purview, security, or automation work.

## Why Users and Licenses Matter

Microsoft 365 service access depends on user accounts, license assignments, and enabled service plans.

A user may exist in Microsoft Entra ID, but Microsoft 365 workloads such as Exchange Online, SharePoint Online, OneDrive, Teams, and Microsoft 365 Apps require the appropriate licenses and service plans.

A users and licenses review helps answer:

- How many users exist in the Microsoft 365 tenant?
- Which users are licensed?
- Which users are unlicensed?
- Which guest users exist?
- Which products are available?
- How many licenses are assigned?
- How many licenses are available?
- Are licenses being used intentionally?
- What licensing risks or cleanup opportunities exist?

## Relationship to Project 02

Project 02 documented the Microsoft Entra ID identity baseline.

That project reviewed:

- Total users
- Cloud-only users
- Synced users
- Guest users
- Identity source of authority
- Administrative roles
- Tenant-wide identity settings

Project 03 builds on that identity baseline by reviewing Microsoft 365 licensing and product access.

This file does not repeat the Entra identity baseline. Instead, it focuses on Microsoft 365 service access and license assignment.

## Review Scope

### In Scope

- Active users view
- Licensed users
- Unlicensed users
- Guest users from the Microsoft 365 admin center perspective
- Products and licenses
- Assigned license counts
- Available license counts
- Product/service plan awareness
- License-related risks
- Future PowerShell / Microsoft Graph reporting opportunities

### Out of Scope

- Changing license assignments
- Purchasing subscriptions
- Opening billing/payment details
- Modifying service plans
- Creating or deleting users
- Resetting passwords
- Deep Exchange, SharePoint, Teams, or Intune configuration

## User Licensing Summary

| Inventory Item | Count / Status | Notes |
|---|---|---|
| Total active users | 72 | Count from Microsoft 365 admin center |
| Licensed users | 10 | Users with assigned Microsoft 365 licenses |
| Unlicensed users | 62 | Users without assigned Microsoft 365 licenses |
| Guest users | 1 | External user visible from Microsoft 365 admin center |
| Admin users | To be reviewed later | Admin role review will be documented separately |
| Synced users | Previously documented | Project 02 documented synced users from Entra ID |
| Cloud-only users | Previously documented | Project 02 documented cloud-only users from Entra ID |

## Product and License Summary

| Product / Subscription | Total Licenses | Assigned Licenses | Available Licenses | Notes |
|---|---:|---:|---:|---|
| Microsoft 365 E5 Developer | 25 | 10 | 15 | Developer tenant license pool |
| Microsoft Power Automate Free | 10000 | 1 | 9999 | Free Power Automate license pool |

## Review Process

The review was performed using the Microsoft 365 admin center.

Areas reviewed:

- Users > Active users
- Licensed user visibility
- Unlicensed user visibility
- Guest user visibility
- Billing > Licenses
- Billing > Your products
- Test user license and apps view, if reviewed safely

No configuration changes were made.

## Screenshot Evidence

| Screenshot | Purpose |
|---|---|
| 01-active-users-overview-sanitized.png | Shows 72 active users |
| 02-licensed-users-filter-sanitized.png | Shows 10 licensed users |
| 03-unlicensed-users-filter-sanitized.png | Shows 62 unlicensed users |
| 05-licenses-overview-sanitized.png | Shows license availability and assignment counts |

## Screenshot Privacy Notes

Do not expose:

- User principal names
- Personal email addresses
- Full tenant domain
- Billing account information
- Payment information
- Invoice details
- Subscription identifiers
- Admin account names if sensitive
- Private identifiers

## Initial Findings

- The Microsoft 365 tenant contains 72 active users.
- 10 users currently have Microsoft 365 licenses assigned.
- 62 users are currently unlicensed.
- 1 guest user was observed from the Microsoft 365 admin center user view.
- Two license products were observed in the Microsoft 365 admin center.
- Microsoft 365 E5 Developer has 25 total licenses, with 10 assigned and 15 available.
- Microsoft Power Automate Free has 10000 total licenses, with 1 assigned and 9999 available.
- The licensed user count is much lower than the total active user count.
- This is expected in a lab/developer tenant if only selected users require Microsoft 365 services.
- No license assignments were changed during this review.

## License Risk Observations

- A large number of unlicensed users may be acceptable in a lab tenant, but in production this should be reviewed to confirm whether users are inactive, test-only, guest, service-related, or missing required licenses.
- Licensed users should be reviewed to confirm that licenses are assigned intentionally.
- Manual license assignment may not scale well in larger environments.
- Group-based licensing should be considered in larger environments where licensing needs to follow department, role, or lifecycle rules.
- Guest users should be reviewed separately because they usually do not require standard Microsoft 365 licenses unless a specific business need exists.
- Product and license counts should be reviewed regularly to avoid unused licenses, over-assignment, or service access gaps.

## Enterprise Considerations

In an enterprise environment, license management should be intentional and governed.

Important considerations include:

- Who is allowed to assign licenses?
- Which users require which licenses?
- Are licenses assigned manually or through groups?
- Are unused licenses reviewed?
- Are unlicensed users expected or accidental?
- Are service plans enabled only when needed?
- Are admin accounts licensed appropriately?
- Are guest accounts reviewed separately?
- Are license assignments documented for onboarding and offboarding?
- Can license reporting be automated?

## PowerShell and Microsoft Graph Opportunities

Future reporting can improve license visibility and repeatability.

Possible future automation tasks:

| Task | Tooling |
|---|---|
| Export subscribed SKUs | Microsoft Graph PowerShell |
| Export assigned license counts | Microsoft Graph PowerShell |
| Export licensed users | Microsoft Graph PowerShell |
| Export unlicensed users | Microsoft Graph PowerShell |
| Export guest users | Microsoft Graph PowerShell |
| Export user license details | Microsoft Graph PowerShell |
| Generate CSV license reports | PowerShell / Microsoft Graph |
| Compare portal counts to script output | PowerShell / Microsoft Graph |

## Framework Mapping

| Framework / Concept | Related Control | How This Review Supports It |
|---|---|---|
| Operational Excellence | License inventory | Documents service access and license availability |
| Governance | License assignment review | Supports intentional access and cost control |
| Least Privilege | Service plan review | Helps ensure users receive only needed services |
| Security | Guest and admin account awareness | Helps separate standard, guest, and admin access |
| Cost Management | License utilization | Supports future license cleanup and cost review |
| Automation | Graph reporting | Prepares for repeatable reporting |

## Lessons Learned

- Microsoft 365 users and licenses must be reviewed separately from the Entra ID identity baseline.
- A user can exist in the tenant without having access to Microsoft 365 workloads if no license is assigned.
- Licensed and unlicensed users should be reviewed to understand service access and onboarding state.
- Guest users should be tracked separately from member users.
- License assignment affects access to services such as Exchange Online, SharePoint Online, OneDrive, Teams, and Microsoft 365 Apps.
- Future PowerShell and Microsoft Graph reporting can make license inventory repeatable and easier to validate.