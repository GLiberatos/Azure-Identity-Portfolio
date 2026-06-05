# Microsoft 365 Security and Risk Findings

## Purpose

This document captures the Microsoft 365 security and risk findings identified during the Microsoft 365 Tenant Baseline project.

The purpose is to summarize observed risks, validate key findings through portal review and Microsoft Graph PowerShell exports, and create a prioritized improvement backlog for future Microsoft 365, Entra ID, Exchange Online, SharePoint Online, Teams, Intune, Purview, Defender, Sentinel, Copilot, agent governance, and automation work.

## Why Security and Risk Findings Matter

A Microsoft 365 tenant baseline should not only document what exists.

It should also identify what may create operational, security, governance, compliance, or support risk.

Security and risk findings help answer:

- Which findings require future review?
- Which risks affect users, licenses, roles, groups, apps, reports, or collaboration?
- Which risks affect future Copilot or agent adoption?
- Which findings should become future projects?
- Which findings can be validated with PowerShell or Microsoft Graph?
- Which findings should be prioritized first?

## Relationship to Prior Work

Project 03 has already documented:

- Microsoft 365 tenant overview
- Microsoft 365 admin center navigation
- Users and licenses
- Domains and organization profile
- Admin roles
- Groups and collaboration
- Service health and Message center
- Reports and usage
- Organization settings
- PowerShell and Microsoft Graph reporting

This file builds on that work by consolidating the key security, governance, and operational findings into a single risk-focused summary.

## Review Scope

### In Scope

- User and license risks
- Admin role risks
- Group and collaboration risks
- Guest access considerations
- Service health and Message center operational risks
- Reports and usage privacy considerations
- Organization settings risks
- Integrated apps and agent visibility risks
- PowerShell / Graph export handling risks
- Future improvement backlog

### Out of Scope

- Changing tenant settings
- Removing users
- Assigning or removing licenses
- Changing admin roles
- Changing group settings
- Blocking apps
- Configuring Copilot
- Configuring agents
- Configuring Conditional Access
- Configuring Intune
- Configuring Defender or Sentinel
- Implementing remediation

## Risk Summary

| Risk Area | Observation | Risk Level | Recommended Next Step |
|---|---|---|---|
| License hygiene | 72 active users, 10 licensed users, and 62 unlicensed users were observed | Medium | Review unlicensed users for cleanup, onboarding, or license assignment requirements |
| Privileged access | Global Administrator, Reports Reader, and Security Administrator assignments were observed | Medium | Review privileged roles periodically and plan future PIM implementation |
| Break-glass planning | No break-glass account was confirmed during admin role review | Medium | Define and document emergency access strategy before enforcing stronger access controls |
| Groups and collaboration | 27 group objects were validated, including Teams/Microsoft 365 groups, distribution lists, security groups, and mail-enabled security groups | Medium | Review group ownership, lifecycle, guest access, and collaboration governance |
| Guest collaboration | Guest-related Microsoft 365 Groups settings were visible, and guest group access was allowed | Medium | Review external collaboration strategy before broader Teams, SharePoint, Copilot, or agent adoption |
| User-owned apps and trials | Office Store access and user trial capabilities were enabled | Medium | Review app governance, trial controls, licensing impact, and support ownership |
| Integrated apps and agents | Integrated apps showed deployed apps, available apps, and agent-related visibility | Medium | Review app and agent governance, approval workflow, and lifecycle ownership |
| Reports privacy | User, group, and site names were concealed in reports | Low | Document privacy posture and understand troubleshooting tradeoffs |
| Service health and change management | Active service health issues and a large Message center queue were observed | Medium | Define ownership for service health review, Message center triage, and user communications |
| Raw report handling | Graph CSV exports were generated locally and excluded from GitHub | Low | Keep raw exports local and publish only sanitized summaries |

## PowerShell Validation Summary

| Validation Item | Result |
|---|---:|
| Users export row count | To be documented |
| Groups export row count | To be documented |
| Subscribed SKU export row count | To be documented |
| Directory roles export row count | To be documented |
| Directory role members export row count | To be documented |
| Active user detail export row count | To be documented |
| Teams activity export row count | To be documented |
| Organization summary export row count | To be documented |

## Initial Findings

To be completed after validation.

## Risk Prioritization

| Priority | Risk Area | Reason |
|---|---|---|
| High | To be documented | To be documented |
| Medium | To be documented | To be documented |
| Low | To be documented | To be documented |

## Improvement Backlog

| Backlog Item | Related Future Project | Priority |
|---|---|---|
| Review unlicensed users and account purpose | Microsoft 365 / Entra cleanup | Medium |
| Define break-glass account strategy | Conditional Access / PIM | High |
| Review privileged role assignments | PIM / Identity Governance | High |
| Review guest collaboration settings | SharePoint / Teams / External Collaboration | Medium |
| Review Microsoft 365 Groups lifecycle | Groups / Teams / SharePoint Governance | Medium |
| Review user-owned apps and trial settings | M365 Org Settings / App Governance | Medium |
| Review integrated apps and agent availability | Copilot / Agent Governance | High |
| Review Copilot readiness and usage reports | Copilot / Agent Governance | Medium |
| Review report privacy and troubleshooting needs | Reporting / Governance | Low |
| Create reusable Graph reporting scripts | Automation | Medium |
| Add error handling and logging to scripts | Automation | Medium |
| Plan Defender XDR and Sentinel monitoring | Security Monitoring | High |
| Plan KQL-based investigation labs | Sentinel / Defender | High |
| Plan Intune endpoint compliance project | Intune / Endpoint Management | High |
| Plan Purview data governance project | Compliance / Data Governance | High |
| Plan Bicep / ARM infrastructure automation | Azure Systems Engineering | Medium |

## Agent / Copilot Governance Impact

Several findings from this baseline are relevant to future Copilot and agent governance.

Key areas include:

- Group membership and Teams-connected groups
- SharePoint and OneDrive usage visibility
- Integrated apps and agent-related app visibility
- Report privacy settings
- Admin role assignments
- User-owned apps and services
- Guest collaboration settings
- Copilot readiness, usage, and agents reports
- Power Platform and Copilot Studio future governance

This project does not configure Copilot or agents, but it identifies governance areas that should be reviewed before broader AI or agent adoption.

## Enterprise Considerations

In an enterprise environment, risk findings should be reviewed, prioritized, assigned, and tracked.

Important considerations include:

- Who owns each risk?
- Which risks require immediate remediation?
- Which risks require future project work?
- Which risks require business approval?
- Which risks affect security, compliance, operations, or cost?
- Which risks should be validated through automation?
- Which risks should be reviewed periodically?
- Which risks affect Copilot or agent readiness?

## PowerShell and Microsoft Graph Opportunities

Future automation can improve risk review and evidence collection.

Possible future tasks:

| Task | Tooling |
|---|---|
| Generate recurring user/license risk report | Microsoft Graph PowerShell |
| Generate privileged role report | Microsoft Graph PowerShell |
| Generate group ownership report | Microsoft Graph PowerShell |
| Generate guest access report | Microsoft Graph PowerShell |
| Export Message center and service health data | Microsoft Graph service communications API |
| Export usage and adoption reports | Microsoft Graph reports API |
| Build sanitized risk summary output | PowerShell |
| Create reusable risk review script | PowerShell |
| Schedule recurring risk exports | Azure Automation / Task Scheduler |

## Framework Mapping

| Framework / Concept | Related Control | How This Review Supports It |
|---|---|---|
| Operational Excellence | Risk visibility | Consolidates findings from the Microsoft 365 tenant baseline |
| Governance | Risk ownership | Prepares findings for ownership, prioritization, and remediation |
| Security | Least privilege and access review | Identifies admin role, group, guest, and app governance risks |
| Compliance Readiness | Evidence and reporting | Documents risks and supports future audit readiness |
| Cost Management | License hygiene | Identifies license and user review opportunities |
| Automation | Repeatable risk reporting | Uses Graph exports and row counts as validation evidence |
| Agent Governance | AI readiness | Identifies Copilot and agent governance dependencies |

## Reflection Questions

- What is a security or governance finding?
- What is the difference between an observation and a risk?
- Why are unlicensed users worth reviewing?
- Why should privileged roles be reviewed periodically?
- Why is break-glass planning important before enforcing stronger access controls?
- Why do Microsoft 365 Groups and Teams-connected groups matter for Copilot and agent readiness?
- Why are user-owned apps and trials a governance concern?
- Why are integrated apps important for agent governance?
- Why is PowerShell / Graph validation stronger than portal-only evidence?
- How would you explain this risk review to a hiring manager?
- Which findings should become future hands-on projects?

## Lessons Learned

To be completed after validation.