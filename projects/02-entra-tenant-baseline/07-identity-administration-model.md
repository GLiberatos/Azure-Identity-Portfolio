# Identity Administration Model and Enterprise Design

## Purpose

This document defines the identity administration model for the Microsoft Entra ID tenant used in this portfolio lab.

The purpose is to document how identities, groups, administrative access, and source-of-authority decisions should be handled before building Conditional Access, Privileged Identity Management, Identity Governance, Intune, Microsoft 365 administration, or automation.

## Why an Identity Administration Model Matters

An identity administration model helps answer important operational and security questions:

- Where should users be created?
- Which identities are cloud-only?
- Which identities are synchronized from Active Directory?
- Which accounts should have administrative access?
- How should privileged roles be assigned?
- What accounts should be protected as emergency access accounts?
- What should be managed from Active Directory vs Microsoft Entra ID?
- What should be reviewed before enabling Conditional Access or PIM?

Without an administration model, an identity environment can become inconsistent, risky, and difficult to troubleshoot.

## Current Lab Identity Model

This lab uses a hybrid identity model.

```text
Active Directory Domain Services
→ Microsoft Entra Connect / sync agent
→ Microsoft Entra ID
→ Microsoft 365 E5 Developer tenant
```

| Identity Area        | Current Lab Model                                                              |
| -------------------- | ------------------------------------------------------------------------------ |
| Standard lab users   | Created in Active Directory and synchronized to Microsoft Entra ID             |
| Cloud-only users     | Created directly in Microsoft Entra ID for cloud-native testing                |
| Guest users          | Invited into Microsoft Entra ID when needed                                    |
| Administrative users | Reviewed separately from standard users                                        |
| Groups               | Mix of synced Active Directory groups and cloud-only Microsoft Entra groups    |
| Devices              | Reviewed in Microsoft Entra ID; deeper management will occur in Intune project |

## Identity Source of Authority

Source of authority defines where an object should be managed.

For this lab, the source-of-authority model is:

| Object / Task                  | Source of Authority                | Notes                                                          |
| ------------------------------ | ---------------------------------- | -------------------------------------------------------------- |
| Synced standard users          | Active Directory                   | Create, modify, disable, and organize synced users in AD first |
| Synced group membership        | Active Directory                   | Modify synced group membership in AD first                     |
| Cloud-only test users          | Microsoft Entra ID                 | Used for cloud-native identity testing                         |
| Guest users                    | Microsoft Entra ID                 | Used for external collaboration testing                        |
| Microsoft 365 groups           | Microsoft 365 / Microsoft Entra ID | Used for collaboration scenarios                               |
| Role assignments               | Microsoft Entra ID                 | Reviewed and managed in Entra roles and administrators         |
| Conditional Access assignments | Microsoft Entra ID                 | Future project                                                 |
| PIM assignments                | Microsoft Entra ID Governance      | Future project                                                 |
| Device compliance              | Intune                             | Future project                                                 |

## Cloud-Only vs Synced Identity Rules

### Synced Identities

Synced identities are created in Active Directory and synchronized into Microsoft Entra ID.

Use synced identities for:

- Standard employee-style lab users
- Department-based test users
- Hybrid identity testing
- On-premises source-of-authority scenarios
- Entra Connect validation
- Future Conditional Access testing with hybrid identities

Management rule:

```text
Manage synced users in Active Directory first.
```

### Cloud-Only Identities

Cloud-only identities are created directly in Microsoft Entra ID.

Use cloud-only identities for:

- Cloud admin accounts
- Break-glass / emergency access account planning
- Cloud-native test users
- Guest or external identity testing
- Service-specific cloud testing where sync is not required

Management rule:

```text
Manage cloud-only users in Microsoft Entra ID.
```

## Administrative Account Strategy

Administrative accounts should be reviewed separately from standard user accounts.

Recommended account categories:

| Account Type             | Purpose                                                | Source                                     |
| ------------------------ | ------------------------------------------------------ | ------------------------------------------ |
| Standard user account    | Daily non-admin work                                   | Synced from AD or cloud-only               |
| Cloud admin account      | Administrative work in Microsoft Entra / Microsoft 365 | Cloud-only preferred                       |
| Emergency access account | Break-glass access if normal admin access fails        | Cloud-only                                 |
| Sync/service account     | Directory synchronization or service integration       | Service-specific                           |
| Test admin account       | Lab role testing                                       | Cloud-only or synced depending on scenario |

## Break-Glass / Emergency Access Planning

Emergency access accounts are used when normal administrative access fails.

For this lab, emergency access planning should be documented before enforcing Conditional Access or PIM policies.

Recommended design notes:

- Emergency access accounts should be cloud-only.
- Emergency access accounts should use the default .onmicrosoft.com domain.
- Emergency access accounts should not depend on on-premises Active Directory.
- Emergency access accounts should not be synchronized from AD.
- Emergency access accounts should not be tied to a specific employee.
- Emergency access credentials should be stored securely.
- Emergency access sign-ins should be monitored.
- Emergency access accounts should be tested periodically.
- Emergency access accounts should be excluded from restrictive Conditional Access policies in a carefully controlled way.

## Privileged Role Strategy

Privileged roles should be assigned only when required.

Current observed baseline:

| Role Area                               | Current Observation                 |
| --------------------------------------- | ----------------------------------- |
| Global Administrator                    | 1 active direct assignment observed |
| Conditional Access Administrator        | Assignment observed                 |
| Security Administrator                  | Assignment observed                 |
| Privileged Authentication Administrator | Assignment observed                 |
| Other admin roles                       | Additional review required          |

Future target model:

| Role Need                     | Preferred Approach                              |
| ----------------------------- | ----------------------------------------------- |
| Tenant-wide emergency access  | Cloud-only emergency access accounts            |
| Daily administration          | Task-specific admin roles                       |
| Read-only review              | Global Reader or Security Reader where possible |
| Conditional Access management | Conditional Access Administrator                |
| User management               | User Administrator                              |
| Group management              | Groups Administrator                            |
| Hybrid identity management    | Hybrid Identity Administrator                   |
| Role management               | Privileged Role Administrator                   |
| Temporary privileged access   | PIM eligible assignments in a future project    |

## Least Privilege Design Notes

Least privilege means assigning only the access required to perform a task.

For this portfolio, least privilege will be applied by:

- Avoiding unnecessary Global Administrator use
- Separating standard user and admin activity
- Documenting privileged role assignments
- Using task-specific roles where possible
- Reviewing permanent role assignments
- Planning future PIM eligible assignments
- Reviewing guest and external access separately
- Reviewing application registration and consent settings separately

## Lab vs Enterprise Design

| Area                 | Lab Design                                      | Enterprise Design Consideration                                  |
| -------------------- | ----------------------------------------------- | ---------------------------------------------------------------- |
| Domain controller    | Sync service installed on DC for lab simplicity | Dedicated Entra Connect server preferred                         |
| Sync scope           | Selected lab OU structure                       | Carefully planned OU or attribute-based filtering                |
| Admin accounts       | Small number of lab admin accounts              | Separate admin accounts, emergency accounts, PAWs, monitoring    |
| Global Administrator | 1 active assignment observed                    | Keep assignments minimal and monitored                           |
| Break-glass accounts | Planning documented                             | Two or more cloud-only emergency accounts recommended            |
| Conditional Access   | Not configured in this project                  | Use report-only, pilot groups, exclusions, and rollback planning |
| PIM                  | Future project                                  | Use eligible assignments where possible                          |
| Groups               | Mix of synced and cloud-only groups             | Group lifecycle, naming, ownership, expiration, access reviews   |
| Devices              | Baseline reviewed only                          | Intune compliance, enrollment restrictions, device controls      |
| External users       | Baseline reviewed only                          | Guest lifecycle, cross-tenant settings, access reviews           |

## Identity Naming and Organization Notes

Future identity naming should be clear and consistent.

Possible lab naming examples:

| Object Type         | Example Naming Pattern           |
| ------------------- | -------------------------------- |
| Cloud admin account | `adm-cloud-username`             |
| Break-glass account | `bg-emergency-01`                |
| Test user           | `test-dept-user01`               |
| Synced AD user      | `Managed using existing AD naming` |
| Security group      | `grp-purpose-scope`              |
| Microsoft 365 group | `m365-purpose-team`              |
| Dynamic group       | `dyn-rule-purpose`               |

Public documentation should avoid exposing real usernames, tenant domains, personal email addresses, tenant IDs, object IDs, or sensitive admin account names.

## Future Improvement Backlog

The following items should be reviewed in future projects:

| Improvement Area                                | Future Project                     |
| ----------------------------------------------- | ---------------------------------- |
| Conditional Access baseline                     | Project 05                         |
| MFA rollout and testing                         | Project 05                         |
| Privileged Identity Management                  | Project 09                         |
| Identity Governance and access reviews          | Project 10                         |
| Intune device compliance                        | Project 06                         |
| Microsoft 365 group governance                  | Project 03 / Project 08            |
| SharePoint and OneDrive access governance       | Project 08                         |
| Application registration and consent governance | Future application governance work |
| Microsoft Graph reporting                       | Project 12                         |
| Okta comparison                                 | Project 17                         |

## Security and Risk Notes

| Risk                                      | Why It Matters                        | Future Mitigation                                |
| ----------------------------------------- | ------------------------------------- | ------------------------------------------------ |
| Too many permanent privileged assignments | Increases impact of admin compromise  | Review roles and use PIM later                   |
| Broad guest invitation settings           | Can increase external access exposure | Review external collaboration settings           |
| Users can create groups                   | Can cause group sprawl                | Add group governance and naming standards        |
| Users can register applications           | Can create app governance risk        | Review app registration and consent settings     |
| Device join open to all users             | Can increase unmanaged device risk    | Review in Intune and Conditional Access projects |
| Cloud-only admin accounts not documented  | Can create unclear ownership          | Document admin account model                     |
| Emergency access not fully designed       | Can create tenant lockout risk        | Plan and validate break-glass accounts           |

## Framework Mapping

| Framework / Concept    | Related Control              | How This Project Supports It                                           |
| ---------------------- | ---------------------------- | ---------------------------------------------------------------------- |
| Zero Trust             | Verify explicitly            | Establishes identity and admin account baseline before access policies |
| Least Privilege        | Role separation              | Defines task-based role assignment strategy                            |
| Identity Governance    | Lifecycle and access review  | Prepares for future access reviews and privileged access reviews       |
| Operational Excellence | Documentation                | Creates repeatable identity administration model                       |
| Security               | Privileged access protection | Identifies admin account and emergency access considerations           |
| Compliance Readiness   | Evidence and auditability    | Documents identity management decisions and future controls            |

## Lessons Learned

- A tenant baseline should include both technical inventory and administration design.
- Hybrid identity requires clear source-of-authority rules.
- Synced identities and cloud-only identities should be managed differently.
- Administrative accounts require separate review from standard users.
- Emergency access planning should happen before enforcing Conditional Access or PIM.
- Least privilege requires task-specific roles instead of relying on Global Administrator.
- Lab design can differ from enterprise design, but the differences should be documented.

