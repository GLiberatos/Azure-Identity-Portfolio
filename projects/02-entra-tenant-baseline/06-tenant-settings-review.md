# Entra Tenant Settings Review

## Purpose

This document captures tenant-wide Microsoft Entra ID settings reviewed as part of the Entra tenant baseline project.

The purpose is to understand identity security posture before implementing Conditional Access, Privileged Identity Management, Identity Governance, Intune, Microsoft 365 governance, or automation.

## Why Tenant Settings Matter

Tenant-wide settings influence how users, groups, guests, applications, and devices behave across the identity environment.

A tenant settings review helps answer questions such as:

- What tenant am I working in?
- What user permissions are currently allowed?
- Who can create groups?
- Are external guests allowed?
- Who can invite external users?
- Are cross-tenant access settings configured?
- Are devices registered or joined?
- Are application registrations and enterprise applications present?
- What areas require future security hardening?

## Tenant Settings Summary

| Area | Current State | Notes |
|---|---|---|
| Tenant properties | Reviewed | Tenant overview was previously captured in `01-tenant-overview-sanitized.png` |
| Default domain | Default developer domain | Tenant uses default `.onmicrosoft.com` developer tenant domain |
| User settings | Reviewed | Standard user permissions reviewed |
| Group settings | Reviewed | Group creation and self-service group settings reviewed |
| External collaboration settings | Reviewed | Guest access and guest invitation settings reviewed |
| Cross-tenant access settings | Reviewed | Inbound and outbound B2B collaboration settings reviewed |
| Devices overview | Reviewed | Device join and registration settings reviewed |
| App registrations | Not reviewed | To be reviewed in future application governance work |
| Enterprise applications | Not reviewed | To be reviewed in future application governance work |

## Review Areas

### Tenant Properties

Tenant properties provide high-level information about the Microsoft Entra tenant.

Review items:

- Tenant name
- Primary domain
- Tenant type
- Region or location information, if visible
- Tenant ID visibility, but do not publish tenant ID

### User Settings

User settings affect what non-administrative users can do in the tenant.

Review items:

- Whether users can access the Entra admin center
- Whether users can register applications
- Whether users can create security groups
- Whether users can create Microsoft 365 groups
- Whether users can invite guests
- Whether users can manage their own profile information

### Group Settings

Group settings affect group creation, ownership, and membership behavior.

Review items:

- Group creation permissions
- Microsoft 365 group creation behavior
- Security group management
- Dynamic group availability
- Naming policy availability, if visible
- Expiration policy availability, if visible

### External Collaboration Settings

External collaboration settings affect guest access and B2B collaboration.

Review items:

- Guest invite permissions
- Guest user access restrictions
- Collaboration restrictions
- Allowed or blocked domains, if configured
- Guest self-service sign-up settings, if visible

### Cross-Tenant Access Settings

Cross-tenant access settings affect inbound and outbound collaboration with other Microsoft Entra organizations.

Review items:

- Default inbound access settings
- Default outbound access settings
- Organizational settings, if any
- B2B collaboration posture
- B2B direct connect posture
- Tenant restrictions, if visible

### Device Settings

Device settings affect how devices register or join Microsoft Entra ID.

Review items:

- Total devices
- Device join or registration settings
- Local administrator settings
- Device management connection to Intune, if visible
- Device baseline notes for future Intune project

### Application Settings

Application settings affect how applications are registered, consented to, and used.

Review items:

- App registrations overview
- Enterprise applications overview
- Admin consent posture
- User consent posture
- Future application governance needs

## Screenshot Evidence

| Screenshot | Purpose |
|---|---|
| 01-tenant-overview-sanitized.png | Shows tenant overview and tenant context |
| 13-user-settings-sanitized.png | Shows user settings baseline |
| 14-group-settings-sanitized.png | Shows group settings baseline |
| 15-external-collaboration-settings-sanitized.png | Shows external collaboration baseline |
| 16-cross-tenant-access-settings-sanitized.png | Shows cross-tenant access baseline |
| 17-devices-overview-sanitized.png | Shows device overview baseline |

## Screenshot Privacy Notes

Do not expose:

- Tenant ID
- Full tenant domain
- User principal names
- Admin account names
- Object IDs
- Application IDs
- Client IDs
- Personal email addresses
- Private identifiers

## Initial Findings

- Users can register applications.
- Non-admin users are not currently restricted from creating tenants.
- Users can create security groups.
- Users are not restricted from accessing the Microsoft Entra admin center.
- Guest users have limited access to directory object properties and memberships.
- LinkedIn account connections are allowed.
- The "keep me signed in" prompt is enabled.
- Group owners cannot manage group membership requests in My Groups.
- Users can create security groups.
- Users can create Microsoft 365 groups.
- Guest invitation settings are currently broad, allowing anyone in the organization to invite guest users, including guests and non-admins.
- Guest self-service sign-up via user flows is disabled.
- External users are allowed to remove themselves from the organization.
- Collaboration invitations are allowed to any domain.
- Cross-tenant B2B collaboration is allowed by default for inbound and outbound collaboration.
- B2B direct connect is blocked by default.
- Cross-tenant trust settings are disabled.
- Users may join devices to Microsoft Entra ID.
- Users may register devices with Microsoft Entra ID.
- Multifactor authentication is not required directly from the device registration setting.
- The maximum number of devices per user is set to 50.
- The registering user is added as local administrator on the device during Microsoft Entra join.
- Microsoft Entra Local Administrator Password Solution is not enabled.

## Risk Observations

- Allowing users to register applications may create application governance risk if consent and app registration activity are not reviewed.
- Allowing non-admin users to create tenants may increase unmanaged tenant sprawl risk.
- Allowing users to create security groups and Microsoft 365 groups may lead to group sprawl without naming, ownership, and lifecycle controls.
- Allowing broad guest invitations may increase external access risk.
- Allowing invitations to any external domain provides flexibility but should be reviewed before production use.
- Cross-tenant B2B collaboration is allowed by default and should be reviewed before enabling broader external collaboration scenarios.
- Device join and registration are open to all users and should be reviewed before the Intune and Conditional Access projects.
- Not requiring MFA during device registration may be acceptable in a lab, but enterprise environments should evaluate stronger device registration controls.
- Adding the registering user as local administrator during Microsoft Entra join may increase endpoint privilege risk.
- Microsoft Entra Local Administrator Password Solution is not enabled and should be reviewed during the Intune / endpoint management project.

## Enterprise Considerations

In an enterprise environment, tenant-wide settings should be reviewed before deploying identity controls.

Important considerations include:

- Restricting unnecessary default user permissions
- Reviewing whether users should be allowed to register applications
- Reviewing whether non-admin users should be allowed to create new tenants
- Controlling security group and Microsoft 365 group creation
- Implementing naming and expiration policies for Microsoft 365 groups
- Limiting guest invitation permissions to appropriate users or roles
- Reviewing allowed and blocked external collaboration domains
- Reviewing inbound and outbound cross-tenant access settings
- Evaluating device join and registration restrictions
- Requiring strong authentication for device registration through Conditional Access
- Reviewing local administrator behavior for Microsoft Entra joined devices
- Enabling Microsoft Entra LAPS where appropriate for endpoint security
- Documenting settings before implementing Conditional Access, PIM, Identity Governance, or Intune policies

## Framework Mapping

| Framework / Concept | Related Control | How This Project Supports It |
|---|---|---|
| Zero Trust | Verify explicitly | Reviews identity-wide access and collaboration settings |
| Least Privilege | User and admin permissions | Identifies tenant-wide permissions that may require restriction |
| Identity Governance | Guest and group controls | Prepares for future access review and lifecycle governance |
| Security | Tenant hardening | Identifies areas for future security improvements |
| Operational Excellence | Documentation | Creates repeatable tenant settings documentation |

## Lessons Learned

- Tenant-wide settings can affect the behavior of all users, groups, guests, devices, and applications.
- User settings should be reviewed before building Conditional Access, PIM, or application governance controls.
- Group creation settings are important because unmanaged group creation can lead to group sprawl.
- External collaboration settings are important because they control how guest users enter the tenant.
- Cross-tenant access settings help define how the tenant collaborates with other Microsoft Entra organizations.
- Device settings should be reviewed before building Intune, device compliance, or Conditional Access policies.
- A baseline review helps identify risks before making configuration changes.