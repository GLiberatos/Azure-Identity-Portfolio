# Project 04 — Module 04: Group Policy Basics

## Lab Objective

Learn how Group Policy actually targets users and computers by building three things in the
`iron.local` domain and proving each with live validation: a fine-grained password policy
(PSO) for account lockout, an OU-scoped user GPO, and security filtering. Two well-known
"gotchas" are reproduced deliberately and then fixed, so the behavior is understood rather
than memorized.

This module was completed with a real domain-joined client (`WORKSTATION1`), so validation
shows policy *applying and taking effect*, not just simulated results.

---

## Why This Lab Matters

Group Policy questions are constant in Windows and identity support: "why isn't this policy
applying?", "why is this user locked out / never locked out?", "why did it work for one user
but not another?". Almost every one of those tickets comes down to **scope** — where the
object lives, what the policy is linked to, and who it's filtered to. Getting the mental model
right here prevents hours of guessing later, and the source-of-authority and least-privilege
themes carry straight into the hybrid identity and Conditional Access work ahead.

---

## What This Lab Teaches

- The GPO processing model (LSDOU, "later wins", Enforced, Block Inheritance).
- That Account Policies (password/lockout) for domain users come only from the domain root or
  a PSO — never from an OU-linked GPO.
- Fine-grained password policies (PSOs) scoped to a group via ADAC.
- That GPO targeting follows the **object's** OU, not the admin's location.
- Security filtering, and the MS16-072 "Authenticated Users needs Read" behavior.
- Which validation tool reports which scope (`net accounts`,
  `Get-ADUserResultantPasswordPolicy`, Group Policy Modeling, `gpresult`).

---

## Before You Start

| Requirement | State in this lab |
| --- | --- |
| Domain controller healthy | `EntraConnectDC`, `iron.local` (Modules 02–03) |
| OU structure + users | `LAB\Corp\...` with department OUs; users created (Module 03) |
| Domain-joined client | `WORKSTATION1` (Windows 11, joined to `iron.local`) |
| Logged in as | `IRON\Administrator` on the DC; a standard user on the client |
| Test user | `abrown` (Alex Brown), located in the **Finance** OU |

> Lab environment: VMware Workstation hosts the DC and `WORKSTATION1`; VMware ESXi 8 hosts
> additional VMs. Only the DC and `WORKSTATION1` participate in AD for this module.

---

## Tools Used

- Group Policy Management Console (`gpmc.msc`)
- Active Directory Administrative Center (`dsac.exe`) — for the PSO
- Active Directory Users and Computers (`dsa.msc`)
- PowerShell (`Get-ADUserResultantPasswordPolicy`)
- Command Prompt (`net accounts`, `gpupdate`, `gpresult`) on the DC and on `WORKSTATION1`

---

## The Mental Model

A GPO has a **Computer Configuration** and a **User Configuration** half and does nothing
until it is **linked** to a Site, Domain, or OU (SDOU). Key rules:

- **Processing order: Local → Site → Domain → OU**, and later wins; an **Enforced** link
  overrides that and ignores blocking.
- **Targeting follows the object:** computer settings apply by the *computer's* OU; user
  settings apply by the *user's* OU. The admin's location is irrelevant.
- **Inheritance flows down**; **Block Inheritance** stops inherited policy (except Enforced).
- **Security filtering** decides *who* a GPO applies to; a GPO needs both **Read** and
  **Apply group policy** on the target to take effect.

---

## Build A — Account Lockout the Right Way (PSO)

### The problem this exposes

The domain had a GPO, `LAB-Sec-AccountLockout-Policy`, containing Account Lockout settings
(threshold 5, duration 10, reset 10) linked to the **LAB OU**. Intuitively that should lock
out lab users after 5 bad attempts. It does not.

Confirmed on the DC:

```cmd
net accounts
```

Result (key line): `Lockout threshold: Never` — even though the GPO sets 5.

**Why:** Account Policies (password and lockout) only become the effective **domain** policy
when applied at the **domain root**, and a domain has a single effective account policy.
Linking those settings to a child OU is ignored for domain accounts (it would only affect the
local SAM accounts of computers placed in that OU). The duration/observation values shown by
`net accounts` are inert while the threshold is Never.

### The fix: a fine-grained password policy (PSO)

A PSO overrides the single domain policy for specific **users or global security groups**
(not OUs). Steps used:

1. Created a Global Security group `SG-PSO-LockoutTest` in `LAB\Corp\Groups` and added
   `abrown`.
2. In ADAC → Tree view → `iron (local)` → **System** → **Password Settings Container** →
   **New → Password Settings**:
   - **Name:** `PSO-LabUsers-Lockout`
   - **Precedence:** `10` (lowest number wins when multiple PSOs collide)
   - Password half mirrored the domain (length 7, history 24, complexity on, max age 42),
     **min age set to 1 day** (deliberately stricter than the domain's 0 — stops instant
     password cycling).
   - **Lockout:** failed attempts `5`, reset after `10` min, lockout duration `10` min.
   - **Directly Applies To:** `SG-PSO-LockoutTest`.

### Validation

```powershell
Get-ADUserResultantPasswordPolicy abrown
```

Returned the PSO with `LockoutThreshold : 5`, `LockoutDuration : 00:10:00`,
`LockoutObservationWindow : 00:10:00`, `Precedence : 10`, `MinPasswordAge : 1.00:00:00`, and
`AppliesTo` listing `SG-PSO-LockoutTest`.

For a user **not** in the group (`adm-jrivera`), the same cmdlet returned **nothing** — they
fall back to the domain default.

```cmd
net accounts
```

Still shows `Lockout threshold: Never` — and that's correct. `net accounts` reports the
**domain-wide** policy; a PSO is per-user, so it never appears there. The right tool to prove
a PSO is `Get-ADUserResultantPasswordPolicy`.

> Sanitization: the cmdlet output includes `ObjectGUID` — redact it (`<OBJECT-GUID>`) before
> committing evidence.

---

## Build B — An OU-Scoped User GPO

### Build

1. GPMC → **Group Policy Objects** → **New** → `LAB-User-CtrlPanelLockdown`.
2. **Edit** → **User Configuration → Policies → Administrative Templates → Control Panel** →
   **Prohibit access to Control Panel and PC settings** → **Enabled**.
   - Chosen because it's a User-side setting (applies by the user's OU) and is harmless and
     fully reversible.
3. Linked the GPO to the **Finance** OU — the OU where the test user `abrown` actually lives
   (`OU=Finance,OU=Departments,OU=Users,OU=Corp,OU=LAB,DC=Iron,DC=local`). The link is what
   activates an otherwise-inert GPO; targeting follows the user object, so the link goes where
   the user is.

### Validation — prediction then reality

**Group Policy Modeling** (on the DC) for user `abrown` listed
`LAB-User-CtrlPanelLockdown` as the **Winning GPO** for the Control Panel setting.

**Live on `WORKSTATION1`** signed in as `abrown`:

```cmd
gpupdate /force
gpresult /r /scope:user
```

- Under **Applied Group Policy Objects**: `LAB-User-CtrlPanelLockdown` listed.
- `Group Policy was applied from: EntraConnectDC.Iron.local` — confirms the client reached the
  DC (DNS/SYSVOL/Netlogon healthy end to end).
- **Effect confirmed:** opening Control Panel produced a "restrictions" pop-up — the policy
  didn't just deliver, it *worked*.

### The targeting contrast

On the **DC** as the logged-on admin account:

```cmd
gpresult /r /scope:user
```

- **Applied Group Policy Objects: N/A** — the admin account lives in `CN=Users`, not the
  Finance OU, so the GPO correctly does **not** apply. Same command, two users, two results:
  proof that targeting follows the object's OU.

> Sanitization: the DC `gpresult` reveals the sync service account name and its `ADSync*`
> group memberships (Entra Connect / Cloud Sync artifacts). Redact the account name and trim
> the `ADSync*` lines from committed evidence — they expose privileged service-account context.

---

## Build C — Security Filtering and MS16-072

### Goal

Narrow the GPO from "all Authenticated Users in the OU" to a specific group, so only chosen
users get it even within the same OU.

### Steps and the gotcha

1. Created `SG-CtrlPanelLockdown-Apply` (Global Security) in `LAB\Corp\Groups`; added only
   `abrown`.
2. GPMC → GPO → **Scope → Security Filtering** → **removed Authenticated Users**, **added**
   `SG-CtrlPanelLockdown-Apply`.
3. On `WORKSTATION1` as `abrown`: `gpupdate /force` then `gpresult /r /scope:user` — the GPO
   **dropped off** the applied list and **Control Panel opened again**, even though `abrown`
   is in the apply group.

**Why:** since the MS16-072 hardening, GPOs are retrieved in the **computer's** security
context. Removing Authenticated Users left the *computer* unable to **Read** the GPO, so it
silently failed to apply for everyone.

### The fix

1. GPMC → GPO → **Delegation** tab → **Add** `Authenticated Users` with **Read** only (not
   "Read and Apply").
2. `gpupdate /force` + `gpresult /r /scope:user` on `WORKSTATION1` as `abrown` — GPO **back**
   on the applied list, Control Panel **blocked** again.

### Negative test (control case)

A second user in the **same Finance OU**, **not** a member of
`SG-CtrlPanelLockdown-Apply`, could still open Control Panel. This confirms the filter truly
scopes the policy (OU membership alone is not enough — Apply permission is required) and that
restoring Read did not re-widen Apply to everyone.

---

## Validation Summary

| Check | Tool / scope | Result |
| --- | --- | --- |
| Domain lockout threshold | `net accounts` (domain) | `Never` — OU-linked lockout GPO inert |
| PSO governs `abrown` | `Get-ADUserResultantPasswordPolicy` (per-user) | Threshold 5, via `SG-PSO-LockoutTest` |
| Non-member user | `Get-ADUserResultantPasswordPolicy` | Nothing (domain default) |
| GPO predicted for `abrown` | GP Modeling | Winning GPO |
| GPO applied + effective | `gpresult` + open Control Panel (client) | Applied; access blocked |
| Admin not targeted | `gpresult` on DC | N/A (admin not in Finance OU) |
| Filter removes Auth Users | `gpresult` (client) | GPO drops off (MS16-072) |
| Read restored | `gpresult` (client) + control case | Applied for member; not for non-member |

---

## Troubleshooting

| Symptom | Cause | How to check | Fix |
| --- | --- | --- | --- |
| Domain users never lock out | Lockout set on an OU GPO, not root/PSO | `net accounts` shows `Never` | Set lockout at domain root or via a PSO |
| PSO not visible in `net accounts` | PSO is per-user, not domain-wide | `Get-ADUserResultantPasswordPolicy <user>` | Use the resultant-policy cmdlet to verify |
| GPO not applying to a user | User not in linked OU, or filtered out | `gpresult /r /scope:user` as that user | Link to the user's OU; check Security Filtering |
| GPO applies but no effect | Wrong half (User vs Computer) or needs refresh | `gpresult` winning GPO vs actual behavior | Confirm setting half; `gpupdate /force`, re-login |
| GPO silently stops after filtering | MS16-072: computer can't Read GPO | `gpresult` shows it filtered out | Add Authenticated Users (or Domain Computers) = Read on Delegation |
| Admin sees no policy on DC | Admin object not in target OU | `gpresult` on DC | Expected — targeting follows the object's OU |

---

## Evidence to Save

Sanitize before committing (redact ObjectGUID, sync account name, `ADSync*` groups).

- `evidence/04-net-accounts-threshold-never.txt` — proves the OU-linked lockout GPO is inert.
- `evidence/04-resultant-pso-abrown-sanitized.txt` — `Get-ADUserResultantPasswordPolicy`
  showing the PSO (ObjectGUID redacted).
- `evidence/04-gpresult-workstation1-applied.txt` — client `gpresult` with the GPO applied.
- `evidence/04-gpresult-dc-admin-na.txt` — DC `gpresult` showing N/A (account/group lines
  trimmed).

Screenshots only add value for the Control Panel "restrictions" pop-up if you want visual
proof of effect: `screenshots/04-controlpanel-blocked.png`.

---

## Security and Governance Notes

- **Account policy is domain-wide by design.** Differentiated lockout/password rules require
  PSOs; this is the correct, auditable way to give a subset of users stronger controls.
- **Least privilege via filtering.** Security filtering lets a policy apply to exactly the
  intended population, not everyone in an OU.
- **MS16-072 awareness is a real control.** Knowing GPOs read in the computer context prevents
  a security tightening (removing Authenticated Users) from silently disabling intended policy.
- **Service-account hygiene.** The DC `gpresult` exposed a sync service account in multiple
  privileged groups; such accounts should be named, scoped, and reviewed deliberately
  (revisited in Modules 05–06 and the privileged-access work).

---

## What I Learned

Group Policy behavior is almost entirely about scope. I proved that account-lockout settings
are ignored on an OU-linked GPO and must come from the domain root or a PSO; that a user GPO
applies based on the user's OU (validated live on a domain-joined client, with the Control
Panel actually blocked, and contrasted against the admin on the DC where it didn't apply); and
that security filtering needs Authenticated Users to retain Read after MS16-072 or the policy
silently fails. I also learned to match the validation tool to the scope: `net accounts` for
domain policy, `Get-ADUserResultantPasswordPolicy` for PSOs, and `gpresult`/Modeling for
resultant policy.

---

## Interview Explanation

"In my AD lab I worked through how Group Policy actually targets objects. I showed that account
lockout can't be enforced from an OU-linked GPO — domain accounts read that from the domain
root, so I used a fine-grained password policy scoped to a group and verified it with
`Get-ADUserResultantPasswordPolicy`. Then I built a user GPO, linked it to the user's OU, and
confirmed on a real domain-joined client that it applied and the setting actually took effect,
while proving it didn't apply to an admin in a different container. Finally I scoped it with
security filtering and hit the MS16-072 behavior — removing Authenticated Users broke it
silently because GPOs read in the computer's context — and fixed it by leaving Authenticated
Users with Read while granting Apply only to my target group. I confirmed the scope with a
negative test on a second user in the same OU."