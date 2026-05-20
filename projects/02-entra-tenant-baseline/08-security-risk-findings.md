# Entra Security and Risk Findings

## Purpose

This document summarizes security observations, risk findings, and future improvement areas identified during the Microsoft Entra tenant baseline review.

The goal is not to remediate every finding in this project. The goal is to document the current state and identify what should be addressed in future projects.

## Reviewed Areas

The following areas were reviewed during Project 02:

- Tenant overview
- Directory synchronization status
- Password Hash Sync
- User inventory
- Cloud-only users
- Synced users
- Guest users
- Group inventory
- Security groups
- Microsoft 365 groups
- Synced groups
- Administrative roles
- Tenant-wide user settings
- Group settings
- External collaboration settings
- Cross-tenant access settings
- Device settings
- Identity administration model

## Strengths Observed

| Area | Strength | Why It Matters |
|---|---|---|
| Hybrid identity | Directory sync is enabled | Supports realistic AD-to-Entra identity scenarios |
| Password Hash Sync | Enabled | Supports cloud authentication using synchronized password hashes |
| User inventory | Cloud-only and synced users were identified | Helps separate management responsibilities |
| Group inventory | Group types were reviewed | Helps prepare for access control and governance |
| Role baseline | Privileged roles were reviewed | Helps prepare for least privilege and PIM work |
| Documentation | Screenshots and findings were sanitized | Supports safe public portfolio documentation |
| Source of authority | AD vs Entra management model documented | Reduces confusion when managing synced objects |

## Risk Findings

| Finding | Risk Level | Why It Matters | Future Mitigation |
|---|---|---|---|
| Broad guest invitation settings | Medium | Broad guest invitation can increase external access exposure | Review in Identity Governance and M365 governance projects |
| Users can create security groups | Medium | Can lead to group sprawl and inconsistent access management | Review group creation restrictions and naming standards |
| Users can create Microsoft 365 groups | Medium | Can create unmanaged collaboration spaces | Review M365 group governance, expiration, and ownership |
| Users can register applications | Medium | Can create app consent and application governance risk | Review app registration and consent governance |
| Users may join devices to Entra ID | Medium | Can increase unmanaged device exposure | Review in Intune and Conditional Access projects |
| MFA not required during device registration setting | Medium | Device registration could occur without stronger verification | Review with Conditional Access and Intune policies |
| Registering user becomes local admin during Entra join | Medium | Can increase endpoint privilege risk | Review in Intune / endpoint management project |
| Entra LAPS not enabled | Low / Medium | Local admin password management is not currently enforced | Review during Intune / endpoint security project |
| Permanent privileged role assignments observed | Medium / High | Standing privilege increases impact if an admin account is compromised | Review with PIM in future project |
| Break-glass account strategy not fully implemented | Medium | Lack of emergency access planning can create lockout risk | Design and validate emergency access accounts before CA/PIM enforcement |

## Risk Notes

The findings above are not failures.

They represent baseline observations that should be reviewed before implementing stronger controls.

In a real enterprise, these findings would normally be reviewed with:

- Identity team
- Security team
- Compliance team
- Endpoint management team
- Microsoft 365 administrators
- Business stakeholders

## Future Project Mapping

| Finding / Topic | Future Project |
|---|---|
| Conditional Access and MFA enforcement | Project 05 — Conditional Access Lab |
| Device join and compliance controls | Project 06 — Intune / Endpoint Management Lab |
| Microsoft 365 group governance | Project 03 and Project 08 |
| SharePoint / OneDrive external sharing | Project 08 |
| Privileged role hardening | Project 09 — Privileged Identity Management Lab |
| Access reviews and lifecycle controls | Project 10 — Identity Governance Lab |
| App registration and consent governance | Future app governance work / Project 12 automation |
| Security monitoring | Project 13 — Security Monitoring and Microsoft Sentinel |
| Compliance mapping | Project 14 — Microsoft Purview and Compliance Mapping |
| Okta comparison | Project 17 — Okta AD Integration and IAM Comparison |

## Recommended Improvement Backlog

| Priority | Improvement | Reason |
|---|---|---|
| High | Document and create emergency access account strategy | Needed before enforcing Conditional Access or PIM |
| High | Review Global Administrator and privileged role assignments | Reduces standing privilege risk |
| High | Review Conditional Access baseline plan | Needed for MFA, admin protection, and access control |
| Medium | Review guest invitation permissions | Reduces external access exposure |
| Medium | Review group creation permissions | Reduces group sprawl |
| Medium | Review Microsoft 365 group lifecycle | Supports ownership, expiration, and cleanup |
| Medium | Review application registration and consent settings | Reduces app governance risk |
| Medium | Review device join and registration settings | Prepares for Intune and device compliance |
| Low / Medium | Review Entra LAPS readiness | Supports endpoint local admin security |

## Enterprise Considerations

In an enterprise environment, these findings should be prioritized based on:

- Business risk
- User impact
- Licensing availability
- Existing security requirements
- Compliance requirements
- Operational readiness
- Help desk support readiness
- Change management requirements

Recommended enterprise rollout approach:

1. Document current settings.
2. Identify risk.
3. Prioritize controls.
4. Test with pilot users.
5. Use report-only or limited-scope policies where possible.
6. Validate impact.
7. Document rollback steps.
8. Roll out in phases.
9. Monitor logs and user impact.
10. Review regularly.

## Framework Mapping

| Framework / Concept | Related Finding | How This Review Supports It |
|---|---|---|
| Zero Trust | Identity and device controls | Identifies where stronger verification may be needed |
| Least Privilege | Admin roles and user permissions | Documents privileged access and broad user permissions |
| Identity Governance | Guests, groups, and lifecycle | Identifies areas for future access reviews |
| Operational Excellence | Baseline documentation | Creates a repeatable review process |
| Security | Risk identification | Documents identity risks before remediation |
| Compliance Readiness | Evidence and control mapping | Supports future HIPAA, GDPR, NIST, CIS, and audit mapping |

## Lessons Learned

- A baseline review should identify both strengths and risks.
- Risk findings do not always need immediate remediation, but they should be documented.
- Tenant-wide settings can create broad security impact.
- Guest access, group creation, application registration, and device registration should be reviewed before production use.
- Privileged roles should be reviewed before enabling stronger access controls.
- Future projects should address these findings in a planned and controlled way.