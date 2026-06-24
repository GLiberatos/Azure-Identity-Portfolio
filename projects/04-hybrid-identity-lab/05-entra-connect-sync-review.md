# Project 04 — Module 05: Microsoft Entra Connect Sync Review and Validation

## Lab Objective

Review and validate the Microsoft Entra Connect Sync setup that was already installed on the
domain controller, instead of building it from scratch. The goal is to confirm which sync
product is running, that it is healthy, how users sign in to the cloud, and what
gets synced.

## Why This Lab Matters

In real jobs, directory sync is often already running before you arrive. A support or identity
engineer is frequently asked to *inspect and confirm* a sync setup, not install one: "Is sync
healthy? How do users authenticate? Which accounts are in scope?" This module is that exact
skill — reading an existing configuration and explaining it in plain terms.

## What This Lab Teaches

- The difference between the two Microsoft sync products and how to tell which one you have.
- How to read sync health (is it on, is it paused, how often does it run).
- The cloud sign-in method (Password Hash Synchronization) and what it means.
- The "source anchor" — the permanent ID that keeps each account matched to its cloud copy.
- How to see the sync scope (which accounts actually sync).
- That a configuration export contains sensitive data that must be sanitized before it can
  go in a public repo — and how to do it.

## Before You Start

| Requirement | State |
|---|---|
| Domain controller healthy | `EntraConnectDC`, `iron.local` (Modules 02–04) |
| Entra Connect Sync | Already installed on the DC |
| Logged in as | Domain admin on the DC |
| Tenant | A Microsoft 365 / Entra lab tenant (domain sanitized as `<tenant>.onmicrosoft.com`) |

## Tools Used

- PowerShell with the `ADSync` module (`Get-ADSyncScheduler`, `Get-ADSyncConnector`)
- The Microsoft Entra Connect wizard ("View or export current configuration")
- Synchronization Service Manager (`miisclient.exe`) for run history

## Plain-Language Model

Think of two address books. The on-premises Active Directory (`iron.local`) is the
master copy. The cloud (Microsoft Entra ID) holds a copy that the sync tool keeps
updated. Entra Connect runs on a schedule (every 30 minutes), looks for changes in the master,
and copies them up to the cloud. The master always wins.

---

## Discovery and Findings

### 1. Which sync product is running?

```powershell
Get-Service ADSync | Select-Object Status, Name, DisplayName
```

Result: the `ADSync` service ("Microsoft Azure AD Sync") is Running.

Meaning: this is the full Microsoft Entra Connect Sync product (the heavier engine with
a local database and on-server configuration). The lighter alternative, Entra Cloud Sync,
would instead show a small "provisioning agent" service and keep its settings in the cloud. No
provisioning agent is present, so this is confirmed as full Connect Sync.

### 2. Is it healthy and turned on?

```powershell
Get-ADSyncScheduler
```

The lines that matter, in plain terms:

| Setting | Value | What it means |
|---|---|---|
| `SyncCycleEnabled` | True | Automatic syncing is on. |
| `StagingModeEnabled` | False | This is the live server, not a passive backup. It really does push changes to the cloud. |
| `SchedulerSuspended` | False | Sync is not paused. |
| `CurrentlyEffectiveSyncCycleInterval` | 00:30:00 | It runs every 30 minutes. |

Meaning: the sync engine is healthy, active, and primary. Nothing is broken or paused.

### 3. What are the two ends of the connection?

```powershell
Get-ADSyncConnector | Select-Object Name, Type
```

Result: two connectors — one AD connector for `iron.local`, and one AAD connector
for the cloud tenant.

> Sanitization note: the cloud connector's name contains the real tenant domain. In any
> saved evidence, replace it with `<tenant>.onmicrosoft.com - AAD`.

### 4. How do users sign in, and how are accounts matched?

These came from the configuration export (the wizard's "View or export current configuration").

- Sign-in method: Password Hash Synchronization (PHS) plus Seamless single sign-on.
  In plain terms: users sign in to cloud apps with the same password as on-prem, and on a
  domain-joined PC they often get signed in silently. Password writeback / self-service
  password reset is also enabled.
- Source anchor: `mS-DS-ConsistencyGuid`. This is the permanent ID tag that ties each
  on-prem account to its cloud copy so they never lose track of each other. It is the modern
  choice (older setups used `objectGUID`). Combined with the routable UPN suffix set back in
  Module 03, this is what keeps account matching clean.

> Cross-check lesson: a PowerShell one-liner I tried for these values returned nothing.
> That did not mean the feature was off — the query simply didn't match how this version
> stores the setting. The configuration export gave the real answer. Lesson: when one source
> comes back empty, confirm with another before concluding anything. The clean PowerShell check
> for the sign-in method is `Get-ADSyncAADCompanyFeature` (shows `PasswordHashSync : True`).

### 5. What actually syncs (the scope)?

From the export's filtering settings:

- Included: the whole domain (`DC=Iron,DC=local`).
- Excluded: only the default built-in system containers (Builtin, Computers, the default
  Users container, System, Domain Controllers, and similar).

Meaning in plain terms: the rule is "sync everything in the domain except the built-in
system folders." So the accounts in the `LAB` organizational unit — the lab's test accounts,
such as `abrown` — do sync to the cloud. For this lab that is intended: the `LAB` OU
exists to hold disposable test identities that are meant to be synced and experimented with.

Two smaller observations:
- The sync scope is controlled by folder (OU), not by group. So a security group is not
  currently used to gate who syncs.
- Group Writeback is enabled (cloud groups can be written back into the `LAB` OU), and the
  export has a safety limit that stops a cycle if it would delete more than 500 cloud
  objects at once.

---

## Validation Summary

| Check | How | Result |
|---|---|---|
| Which product | `Get-Service ADSync` | Running → full Entra Connect Sync |
| Healthy / on | `Get-ADSyncScheduler` | Enabled, not staging, not paused, 30-min cycle |
| Both ends connected | `Get-ADSyncConnector` | AD (`iron.local`) + cloud tenant |
| Sign-in method | Config export / `Get-ADSyncAADCompanyFeature` | PHS + Seamless SSO |
| Account matching | Config export | Source anchor `mS-DS-ConsistencyGuid` |
| What syncs | Config export filtering | Whole domain minus built-in containers; `LAB` test accounts in scope (intended) |

---

## Sanitizing the Configuration Export (Required Before Any Public Commit)

The exported configuration is genuinely useful evidence, but in its raw form it contains
several sensitive values. Uploading it to a private analysis session is fine; committing
it to a public repo is not until these are replaced. Once a secret is in git history it
stays there, so this is a sanitize-before-save step.

| Item in the export | What it is | Replace with |
|---|---|---|
| `tenantId` | The real tenant (directory) ID | `<TENANT-ID>` |
| `administrator` | A real Global Admin sign-in name | `admin@<tenant>.onmicrosoft.com` |
| AAD connector name | Contains the real tenant domain | `<tenant>.onmicrosoft.com - AAD` |
| `serviceAccount` | The sync service (gMSA) account name | `IRON\<gMSA>$` |
| `onPremisesDirectoryAccount` | The on-prem sync (MSOL) account name | `IRON\MSOL_<redacted>` |

Save the cleaned copy as `evidence/05-connect-config-sanitized.json`. Catching this — knowing a
config export leaks a tenant ID — is itself a portfolio-worthy data-handling skill.

---

## Troubleshooting

| Symptom | Likely cause | How to check | Fix / note |
|---|---|---|---|
| A PowerShell setting query returns empty | The query doesn't match this version's format | Confirm with the config export or a different cmdlet | Cross-check before concluding the feature is off |
| Unsure which sync product is installed | Two products look similar | `Get-Service ADSync` vs a provisioning agent | ADSync running = full Connect Sync |
| Sync seems "on" but nothing reaches the cloud | Server is in staging mode | `Get-ADSyncScheduler` → `StagingModeEnabled` | If True, it's a passive server by design |
| Not sure a change synced yet | Waiting on the 30-min cycle | `Start-ADSyncSyncCycle -PolicyType Delta` | Forces an immediate delta sync |

---

## Security and Governance Notes

- Sync runs on the domain controller. This is a fine lab shortcut. In production the
  sync server is a high-value (Tier 0) system and is normally placed on a dedicated member
  server, separate from the DC.
- Config exports carry secrets. Tenant ID and admin sign-in names live inside them; always
  sanitize before anything public.
- Context decides severity. "An account is syncing to the cloud" is only a risk if it's a
  real, privileged account. Here the synced accounts are disposable lab test objects in
  the `LAB` OU, so syncing them is intended and harmless. The same raw fact can be a serious
  finding in one environment and a non-issue in another — judgment depends on context, not the
  fact alone.

---

## What I Learned

How to inspect an existing Microsoft Entra Connect Sync deployment and explain it end to end:
confirming it's the full Connect Sync product, checking its health with `Get-ADSyncScheduler`,
identifying the sign-in method (Password Hash Synchronization with Seamless SSO) and the modern
source anchor (`mS-DS-ConsistencyGuid`), and reading the sync scope to see exactly which
accounts reach the cloud. I also learned that a configuration export contains sensitive values
(tenant ID, admin sign-in name) that must be sanitized before it can go public, and that when
one query returns empty, the right move is to cross-check another source rather than assume.

## Interview Explanation

"I inherited an environment where directory sync was already running, so my job was to inspect
and validate it rather than build it. I confirmed it was full Entra Connect Sync, checked the
scheduler to prove it was healthy and live rather than in staging, and identified the sign-in
method as Password Hash Sync with Seamless SSO and the source anchor as
`mS-DS-ConsistencyGuid`. I read the filtering to confirm exactly which accounts were in scope.
I also flagged that the configuration export contained a real tenant ID and admin sign-in name,
so it had to be sanitized before it could be documented publicly — which is the kind of
data-handling judgment these roles depend on."