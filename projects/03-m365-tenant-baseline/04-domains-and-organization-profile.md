# Microsoft 365 Domains and Organization Profile

## Purpose

This document captures the Microsoft 365 domains and organization profile baseline for the Microsoft 365 Tenant Baseline project.

The purpose is to understand the tenant domain configuration, organization profile, and release preference posture before deeper Microsoft 365 administration, Exchange Online, SharePoint Online, Teams, Intune, Purview, security, or automation work.

## Why Domains and Organization Profile Matter

Domains and organization profile settings are foundational Microsoft 365 tenant settings.

Domains affect user sign-in names, email addresses, Exchange Online mail routing, Teams identity, SharePoint and OneDrive user experience, and tenant branding.

Organization profile settings affect tenant identity, administrative contact information, release preferences, and user-facing organization information.

A domains and organization profile review helps answer:

- Which domains are configured in the tenant?
- Which domain is default?
- Are custom domains present?
- Are domains verified and healthy?
- Are DNS records configured or pending?
- What organization profile information exists?
- What release preference is configured?
- What risks should be reviewed before production use?

## Relationship to Prior Work

Project 02 documented the Microsoft Entra ID identity baseline.

Project 03 has already documented:

- Microsoft 365 tenant context
- Microsoft 365 admin center navigation
- Users and licenses

This file builds on that work by reviewing the Microsoft 365 tenant domain and organization profile layer.

This does not repeat the Project 02 identity inventory or the Project 03 users and license review.

## Review Scope

### In Scope

- Microsoft 365 domain list
- Default domain
- Domain status
- Custom domain presence, if any
- Domain details, if safely reviewed
- Organization profile
- Release preferences
- DNS/domain risk awareness
- Enterprise considerations
- Future PowerShell / Microsoft Graph opportunities

### Out of Scope

- Adding a custom domain
- Buying a domain
- Changing the default domain
- Editing DNS records
- Changing organization profile information
- Changing release preferences
- Configuring Exchange mail routing
- Configuring SPF, DKIM, or DMARC
- Publishing billing or private organization information

## Domain Summary

| Domain Item | Current State | Notes |
|---|---|---|
| Total domains | 1 | One domain is listed in the Microsoft 365 admin center |
| Default `.onmicrosoft.com` domain | Present | Default developer tenant domain is present |
| Custom domains | None observed | No custom domains were observed during this review |
| Default domain | Default `.onmicrosoft.com` domain | Domain name sanitized in public documentation |
| Domain status | Healthy | Domain status showed healthy |
| DNS issues observed | None observed | No DNS issues were shown during review |

## Organization Profile Summary

| Organization Profile Item | Current State | Notes |
|---|---|---|
| Organization profile reviewed | Yes | Reviewed from Microsoft 365 admin center |
| Organization information | Reviewed | Sensitive organization details should not be published |
| Data location | Reviewed | Data location was reviewed if visible |
| Release preferences | Standard release for everyone | Tenant receives updates when broadly released |
| Help desk information | Reviewed | Reviewed if visible; do not expose private contact details |
| Custom themes | Reviewed | Reviewed if visible |

## Review Process

The review was performed using the Microsoft 365 admin center.

Areas reviewed:

- Settings > Domains
- Domain list
- Domain details, if safely reviewed
- Settings > Org settings
- Organization profile
- Release preferences

No configuration changes were made.

## Screenshot Evidence

| Screenshot | Purpose |
|---|---|
| 08-domains-overview-sanitized.png | Shows Microsoft 365 domain baseline and healthy default domain |
| 11-release-preferences-sanitized.png | Shows Standard release preference configuration |

## Screenshot Privacy Notes

Do not expose:

- Full tenant domain
- Custom domain if personal/private
- Tenant ID
- Organization address
- Phone number
- Technical contact
- Personal email addresses
- Billing information
- Private DNS values
- Subscription identifiers
- Private organization details

## Initial Findings

- The Microsoft 365 tenant currently has 1 domain listed.
- The tenant uses the default `.onmicrosoft.com` developer tenant domain.
- No custom domains were observed during this review.
- The default domain showed a healthy status.
- No DNS issues were observed in the domain overview.
- Organization profile settings were reviewed.
- Release preferences are configured for Standard release for everyone.
- No domain, DNS, organization profile, or release preference changes were made during this review.

## Domain and DNS Risk Observations

- No custom domain is currently configured, which is acceptable for a developer tenant but would not normally represent a production Microsoft 365 environment.
- In production, a verified custom domain is usually required for professional user sign-in names and email addresses.
- Domain and DNS changes can affect Exchange Online, Teams, SharePoint, OneDrive, and identity-related services.
- Incorrect DNS records can cause mail flow, authentication, service discovery, or collaboration issues.
- Exchange Online will require deeper DNS review later, including MX, SPF, DKIM, and DMARC.
- The default `.onmicrosoft.com` domain should remain available as the tenant fallback domain.
- Release preferences should align with change management expectations because Targeted release can expose users to changes earlier.
- Standard release is appropriate for a stable baseline because updates arrive after broader release.

## Enterprise Considerations

In an enterprise environment, domain and organization profile settings should be carefully managed.

Important considerations include:

- Who owns public DNS?
- Who approves domain changes?
- Who manages domain verification?
- Who manages Exchange DNS records?
- Who manages SPF, DKIM, and DMARC?
- Which domain should be the default user domain?
- Are domains documented for onboarding and offboarding?
- Are organization profile contacts current?
- Are release preferences aligned with change management?
- Are Targeted release users identified intentionally?

## PowerShell and Microsoft Graph Opportunities

Future reporting can improve domain and tenant profile visibility.

Possible future automation tasks:

| Task | Tooling |
|---|---|
| Export verified domains | Microsoft Graph PowerShell |
| Identify default domain | Microsoft Graph PowerShell |
| Export organization details | Microsoft Graph PowerShell |
| Review tenant organization settings | Microsoft Graph PowerShell |
| Compare portal findings to Graph output | PowerShell / Microsoft Graph |
| Generate tenant domain baseline report | PowerShell / Microsoft Graph |

## Framework Mapping

| Framework / Concept | Related Control | How This Review Supports It |
|---|---|---|
| Operational Excellence | Domain inventory | Documents tenant domain state before changes |
| Governance | Domain ownership | Supports clear ownership of DNS and tenant identity |
| Security | DNS and mail security readiness | Prepares for Exchange and email authentication work |
| Change Management | Release preferences | Documents Microsoft 365 update exposure |
| Compliance Readiness | Organization profile evidence | Supports tenant documentation and audit readiness |
| Automation | Graph reporting | Prepares for repeatable tenant domain reporting |

## Lessons Learned

- Microsoft 365 domains are foundational tenant settings that affect identity, email, collaboration, and service access.
- A default `.onmicrosoft.com` domain is expected in a Microsoft 365 tenant.
- Custom domains are important in production environments but were not configured in this developer tenant.
- Domain health should be reviewed before configuring Exchange Online, Teams, SharePoint, or OneDrive.
- DNS ownership and change control are important enterprise responsibilities.
- Release preferences affect how quickly Microsoft 365 changes appear in the tenant.
- Standard release provides a more stable update posture than Targeted release.