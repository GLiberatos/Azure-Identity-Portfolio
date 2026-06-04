# Microsoft 365 PowerShell and Graph Reporting

## Purpose

This document captures the Microsoft 365 PowerShell and Microsoft Graph reporting baseline for the Microsoft 365 Tenant Baseline project.

The purpose is to validate selected Microsoft 365 portal findings through read-only automation, export tenant inventory data, understand Microsoft Graph PowerShell basics, and prepare repeatable reporting evidence for users, licenses, groups, roles, and usage reports.

## Why PowerShell and Microsoft Graph Matter

PowerShell and Microsoft Graph allow administrators to query Microsoft 365 data in a repeatable way.

Instead of relying only on portal screenshots, administrators can use automation to:

- Validate portal findings
- Export tenant inventory
- Review users and licenses
- Review groups and collaboration objects
- Review role assignments
- Export usage reports
- Create repeatable evidence
- Support troubleshooting
- Build future dashboards or reports
- Reduce manual review effort

This project uses read-only Microsoft Graph PowerShell commands to support the Microsoft 365 tenant baseline.

## Ground-Up Concepts

### PowerShell

PowerShell is a command-line shell and scripting language used for administration and automation.

### Cmdlet

A cmdlet is a PowerShell command that usually follows a Verb-Noun format, such as `Get-MgUser` or `Connect-MgGraph`.

### Module

A module is a package of PowerShell commands. This lab uses the `Microsoft.Graph` module.

### Microsoft Graph

Microsoft Graph is the API layer used to access Microsoft cloud data and services such as users, groups, licenses, reports, and directory roles.

### Scope

A scope is a permission requested when connecting to Microsoft Graph. This lab uses read-only scopes.

### Pipeline

The pipeline passes output from one command into another command.

### CSV Export

CSV exports allow PowerShell output to be saved as report evidence.

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
- Organization settings

This file builds on that work by validating selected findings through automation.

## Review Scope

### In Scope

- PowerShell version review
- Microsoft Graph PowerShell module installation
- Microsoft Graph connection
- Read-only delegated Graph scopes
- Tenant organization export
- Subscribed SKU export
- User export
- Group export
- Directory role export
- Directory role member export
- Microsoft 365 usage report export
- Basic CSV validation
- Public documentation safety
- Future automation opportunities

### Out of Scope

- Creating users
- Deleting users
- Modifying users
- Assigning licenses
- Removing licenses
- Creating groups
- Deleting groups
- Changing group membership
- Assigning roles
- Removing roles
- Changing organization settings
- Changing report privacy settings
- Configuring Copilot
- Configuring agents
- Creating scheduled automation
- Creating app-only authentication

## PowerShell and Graph Summary

| Item | Status | Notes |
|---|---|---|
| PowerShell version reviewed | Completed | PowerShell environment was used for Microsoft Graph reporting |
| Microsoft.Graph module installed | Yes | Microsoft Graph PowerShell module was available for use |
| Connected to Microsoft Graph | Yes | Connected successfully with read-only Graph scopes |
| Graph scopes reviewed | Yes | Read-only Graph scopes were used for reporting |
| Reports folder created | Yes | Reports folder was created for CSV exports |
| Scripts folder created | Yes | Scripts folder was created for future automation |
| Organization report exported | Yes | `m365-organization-summary.csv` exported with 1 row |
| Subscribed SKU report exported | Yes | `m365-subscribed-skus.csv` exported with 2 rows |
| Users report exported | Yes | `m365-users.csv` exported with 72 rows |
| Groups report exported | Yes | `m365-groups.csv` exported with 27 rows |
| Directory roles report exported | Yes | `m365-directory-roles.csv` exported with 13 rows |
| Directory role members report exported | Yes | `m365-directory-role-members.csv` exported with 9 rows |
| Active user detail report exported | Yes | `m365-active-user-detail-d30.csv` exported with 11 rows |
| Teams activity report exported | Yes | `m365-teams-user-activity-d30.csv` exported with 10 rows |
| Raw sensitive reports committed | No | Raw CSV exports should not be committed to the public repository |

## Commands Used

Commands will be documented after validation.

## Exported Reports

| Report File | Exported | Row Count | Purpose |
|---|---|---:|---|
| `m365-organization-summary.csv` | Yes | 1 | Tenant organization data |
| `m365-subscribed-skus.csv` | Yes | 2 | License SKU data |
| `m365-users.csv` | Yes | 72 | User inventory |
| `m365-groups.csv` | Yes | 27 | Group inventory |
| `m365-directory-roles.csv` | Yes | 13 | Directory roles |
| `m365-directory-role-members.csv` | Yes | 9 | Directory role membership |
| `m365-active-user-detail-d30.csv` | Yes | 11 | Microsoft 365 active user detail |
| `m365-teams-user-activity-d30.csv` | Yes | 10 | Teams activity detail |

## Initial Findings

- Microsoft Graph PowerShell was used to validate selected Microsoft 365 tenant baseline findings.
- The Microsoft Graph connection was successful.
- Read-only Graph permissions were used for reporting.
- Reports and scripts folders were created for local automation evidence.
- Organization information was exported successfully and returned 1 row.
- Subscribed SKU information was exported successfully and returned 2 rows.
- User inventory was exported successfully and returned 72 rows.
- Group inventory was exported successfully and returned 27 rows.
- Directory roles were exported successfully and returned 13 rows.
- Directory role members were exported successfully and returned 9 rows.
- Microsoft 365 active user detail was exported successfully and returned 11 rows.
- Microsoft Teams user activity detail was exported successfully and returned 10 rows.
- The user export row count matched the 72 active users documented earlier in the users and licenses review.
- The group export row count matched the 27 group objects documented in the groups and collaboration baseline.
- The subscribed SKU export row count matched the 2 product/license items documented earlier in the users and licenses review.
- Raw CSV exports may contain sensitive tenant, user, group, role, or usage data and should not be committed to the public repository.

## Validation Notes

- The `m365-users.csv` export returned 72 rows, matching the 72 active users documented in the Microsoft 365 users and licenses review.
- The `m365-groups.csv` export returned 27 rows, matching the 27 group objects documented in the Microsoft 365 groups and collaboration baseline.
- The `m365-subscribed-skus.csv` export returned 2 rows, supporting the license/product inventory reviewed earlier in the project.
- The `m365-directory-roles.csv` export returned 13 rows, supporting the admin roles review.
- The `m365-directory-role-members.csv` export returned 9 rows, providing automation-based role membership evidence.
- The `m365-active-user-detail-d30.csv` export returned 11 rows, supporting the Microsoft 365 reports and usage baseline.
- The `m365-teams-user-activity-d30.csv` export returned 10 rows, supporting Teams usage reporting validation.
- The organization summary export returned 1 row, which is expected for a single Microsoft 365 tenant.
- Exported CSV files should be treated as local evidence unless sanitized.
- Row counts can be safely documented publicly when they do not expose names, IDs, UPNs, or private tenant data.

## Troubleshooting Notes

- The initial reporting run did not confirm the user and Teams activity exports, so those reports were rerun and verified.
- The user export initially included many extra Graph properties, so future user exports should use `Select-Object` to limit the output to required fields.
- Some Microsoft Graph reports may return no data or limited data in a developer tenant because user activity is low.
- Some reports may be affected by Microsoft 365 report privacy settings.
- If a Graph command fails, common causes include missing scopes, missing admin consent, unavailable report data, typo in the cmdlet name, or using a module version that does not include the expected command.
- If a report export creates a file but the row count is zero, that may mean the command worked but the tenant does not have activity for that report period.
- Raw report exports should be excluded from Git commits unless they are sanitized.

## Security and Privacy Notes

- Graph reports may contain user names, user principal names, group names, site names, tenant identifiers, or activity details.
- Raw exports should be reviewed before being committed to a public repository.
- Sanitized summaries should be used for public documentation when reports contain sensitive data.
- Read-only scopes should be used unless a lab intentionally requires changes.
- Admin consent should be understood before approving Graph permissions.
- App-only authentication should be handled separately in a future automation project.

## Agent / Copilot Governance Impact

Microsoft Graph reporting supports future Copilot and agent governance by making tenant data easier to export, compare, and review.

Future Copilot and agent governance may require reporting on:

- Users
- Groups
- Licenses
- Roles
- App availability
- Agent visibility
- Usage reports
- SharePoint and Teams activity
- Report privacy settings
- Governance ownership

This file does not configure Copilot or agents, but it establishes the automation foundation needed for future AI and agent governance reporting.

## Enterprise Considerations

In an enterprise environment, PowerShell and Graph reporting should be repeatable, documented, secure, and reviewed.

Important considerations include:

- Who can run Graph reporting?
- Which scopes are approved?
- Where are exports stored?
- Are exports sanitized before sharing?
- Are reports scheduled or run manually?
- Are scripts version-controlled?
- Are app-only permissions approved for automation?
- Are logs retained for troubleshooting?
- Are Graph reports compared against portal findings?
- Are automation results used in governance reviews?

## PowerShell and Microsoft Graph Opportunities

Future automation can expand this lab into deeper reporting.

Possible future tasks:

| Task | Tooling |
|---|---|
| Build reusable reporting scripts | PowerShell |
| Add error handling | PowerShell |
| Add transcript logging | PowerShell |
| Export sanitized summaries | PowerShell |
| Compare portal and Graph counts | PowerShell / Graph |
| Schedule reports | Task Scheduler / Azure Automation |
| Use app-only authentication | Microsoft Graph app registration |
| Build dashboards | Power BI / CSV / Graph |
| Report Copilot and agent readiness | Microsoft Graph / Microsoft 365 reports |

## Framework Mapping

| Framework / Concept | Related Control | How This Review Supports It |
|---|---|---|
| Operational Excellence | Repeatable reporting | Moves tenant review from manual portal checks toward automation |
| Governance | Evidence collection | Supports controlled reporting and review evidence |
| Security | Least privilege reporting | Uses read-only scopes for data collection |
| Compliance Readiness | Report handling | Highlights sensitive export handling |
| Automation | Graph reporting | Establishes Microsoft Graph reporting foundation |
| Cost Management | License visibility | Supports license inventory and optimization |
| Agent Governance | Future reporting | Prepares for Copilot and agent reporting automation |

## Reflection Questions

- What problem does Microsoft Graph PowerShell solve in Microsoft 365 administration?
- What is the difference between using the portal and using Graph PowerShell?
- What is a PowerShell module?
- What is a cmdlet?
- What is a Graph scope?
- Why should read-only scopes be used first?
- Why should raw CSV exports be reviewed before being committed to GitHub?
- How can Graph reporting validate the users and licenses review?
- How can Graph reporting validate the groups and collaboration review?
- How can Graph reporting validate admin role findings?
- Why is automation important for enterprise Microsoft 365 operations?
- How would you explain Microsoft Graph PowerShell to a hiring manager?
- What parts of this lab could later become a reusable script?

## Lessons Learned

- Microsoft Graph PowerShell can validate Microsoft 365 portal findings with repeatable exports.
- PowerShell reporting is more useful than screenshots for validating users, groups, licenses, roles, and usage data.
- Read-only Graph scopes should be used first when building reporting automation.
- CSV exports make it possible to compare portal observations against automated results.
- Row counts are useful public documentation evidence when raw files contain sensitive data.
- Raw exports must be reviewed before being committed to GitHub.
- Graph reporting helps move the project from manual baseline documentation toward repeatable enterprise operations.
- Some reports may be limited in a developer tenant because there may not be enough real user activity.
- Automation should include validation steps such as checking exported files and row counts.
- Future work should convert one-off commands into reusable scripts with error handling, logging, and sanitized summary output.