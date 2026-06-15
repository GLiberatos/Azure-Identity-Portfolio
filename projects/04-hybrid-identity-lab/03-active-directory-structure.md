# Project 04 — Module 03: Active Directory Structure

## 🎯 Purpose

[cite_start]This module covers the design, manual provisioning, and scripted deployment of a production-aligned Organizational Unit (OU) hierarchy, security groups, and user accounts[cite: 392]. [cite_start]It establishes a clean identity tiering model that isolates modern business workloads and defines the exact synchronization scope for Microsoft Entra Cloud Sync[cite: 395, 396].

---

## 🧠 What This Lab Teaches

* [cite_start]Enterprise OU-Tiering Architecture: Designing directory trees to support delegation of control, clean Group Policy inheritance, and distinct identity boundaries[cite: 392, 394].
* [cite_start]Hybrid Identity Alignment: Preparing user accounts with alternative User Principal Name (UPN) suffixes at birth to guarantee native cloud matching[cite: 403, 404].
* [cite_start]Directory Structural Controls: Implementing directory safety mechanisms to prevent accidental modifications or bulk destruction of assets[cite: 400, 401].

---

## 🛑 Before You Start

* [cite_start]Lab Environment State: The root Domain Controller (`<hostname>`) is fully operational within the isolated `<domain>.local` forest[cite: 359, 421].
* [cite_start]UPN Routing Baseline: The cloud routing suffix `@<tenant>.onmicrosoft.com` has been added as an alternative UPN suffix within Active Directory Domains and Trusts[cite: 140, 421].
* [cite_start]Execution Privileges: Logged into the Domain Controller as an active member of the `Domain Admins` group[cite: 398].

---

## 🖱️ GUI Build Steps

### Step 1: Create the Nested Organizational Unit (OU) Hierarchy

1. [cite_start]Open Server Manager, click Tools in the top right, and select Active Directory Users and Computers (`dsa.msc`)[cite: 398].
2. In the left navigation pane, right-click the root domain node `[cite_start]<domain>.local[cite: 421]` [cite_start], select New, and click Organizational Unit[cite: 399].
3. In the Name field, enter `LAB`. [cite_start]Ensure the checkbox for Protect container from accidental deletion is explicitly checked[cite: 400]. [cite_start]Click OK[cite: 450].
   * [cite_start]*What this setting does:* Flags the object's security descriptor with an explicit Access Control Entry (ACE) denying the `Delete` and `Delete Tree` permissions to everyone[cite: 476, 479].
   * [cite_start]*Why we choose it:* Protects core infrastructure nodes from bulk accidental deletions or script errors[cite: 401, 480].
   * *What other options exist / When used:* Leaving it unchecked. This is only acceptable for temporary staging containers slated for rapid decommissioning.
4. Right-click the newly created `LAB` OU, select New -> Organizational Unit, name it `Corp`, ensure deletion protection is checked, and click OK.
5. Right-click the `Corp` OU and create two nested sub-OUs following the exact click steps above (ensure deletion protection is enabled on each):
   * `Computers`
   * `Users`
6. Right-click the `Computers` OU, select New -> Organizational Unit, and name it `Workstations`. Right-click `Workstations` and create a nested OU named `Departments`.
7. Right-click the `Users` OU, select New -> Organizational Unit, and name it `Departments`.
8. Under both the `Computers\Workstations\Departments\` path and the `Users\Departments\` path, right-click and create separate nested OUs for each corporate business group:
   * `Engineering`, `Finance`, `HR`, `IT`, `Operations`, `Sales`

### Step 2: Provision the Sync-Targeting Security Group

1. In the left tree window, right-click the `Corp` OU, select New -> Organizational Unit, name it `Groups`, and click OK.
2. [cite_start]Right-click the newly constructed `Groups` OU, point to New, and select Group[cite: 405].
3. Configure the following explicit parameters within the group creation wizard:
   * [cite_start]Group name: `M365-CloudSync-Users` [cite: 405]
   * [cite_start]Group scope: Select `Global` [cite: 405]
   * [cite_start]Group type: Select `Security` [cite: 405]
4. [cite_start]Click OK[cite: 450].

#### Setting Explanations for Group Scope & Type:

* Global Scope:
  * *What it does:* Allows the group to contain accounts, global groups, and computer objects from its own domain, and allows it to be nested into Universal or Domain Local groups across the forest.
  * [cite_start]*Why we choose it:* Global security groups are highly efficient, match standard operational patterns, and are fully compatible with directory synchronization engines[cite: 406].
  * *What other options exist:* Universal or Domain Local scopes. Universal is utilized in multi-domain forests to catalog memberships across domain bounds. Domain Local is explicitly chosen to assign access permissions on a specific resource localized to a domain.
* Security Group Type:
  * *What it does:* Assigns a security identifier (SID) to the group, allowing it to be mapped inside security descriptors to control access to files, folders, and cloud applications.
  * [cite_start]*Why we choose it:* Essential for enforcing access boundaries and scoping identity synchronization maps[cite: 406].
  * *What other options exist:* Distribution groups. These lack a security SID and are used strictly as email expansion lists, never for permission enforcement.

### Step 3: Provision the Initial Hybrid Test User Account

1. Expand your tree view to navigate into the `LAB\Corp\Users\Departments\IT\` Organizational Unit.
2. [cite_start]Right-click an empty space in the main details pane, select New, and click User[cite: 402].
3. Complete the initial profile wizard window with the following baseline entries:
   * [cite_start]First name: `<admin-firstname>` [cite: 463]
   * [cite_start]Last name: `<admin-lastname>` [cite: 463]
   * [cite_start]User logon name: `<admin-user>` [cite: 463]
4. Locate the domain suffix dropdown menu to the right of the logon name box. [cite_start]Click the menu and explicitly switch the selection from `@<domain>.local` to `@<tenant>.onmicrosoft.com`[cite: 403, 463]. Click Next.
5. Set a secure enterprise-grade temporary password. Clear the checkbox for *User must change password at next logon* (optional for isolated automation testing fields) and check Password never expires. Click Next, then click Finish.
6. Double-click your newly constructed user object, click the Account tab, and verify that the User Principal Name (UPN) displays as `[cite_start]<admin-user>@<tenant>.onmicrosoft.com[cite: 463]`.
7. [cite_start]Switch to the Member Of tab, click Add, type `M365-CloudSync-Users`, click Check Names to resolve the object, and click OK[cite: 450]. Click Apply and OK to commit changes.

#### Setting Explanations for Identity Mapping Options:

* User Principal Name (UPN) Suffix Choice:
  * *What it does:* Sets the primary internet sign-in identity identifier for the user object.
  * *Why we choose it:* Entra ID can only verify public top-level domain ownership. [cite_start]Selecting the alternate UPN suffix at account creation avoids synchronization fallback errors[cite: 140, 404].
  * *What other options exist:* Leaving it set to the default `.local` namespace. [cite_start]This results in sync failures where Entra ID strips the unroutable domain suffix and replaces it with the default cloud alias format[cite: 140, 185].
* User Logon Name vs. Pre-Windows 2000 Logon Name:
  * *User Logon Name (UPN):* Uses an internet email-style syntax (`user@domain.com`) parsed natively by cloud environments and modern authentication endpoints.
  * *Pre-Windows 2000 Logon Name (sAMAccountName):* Uses an old-school flat directory layout format (`DOMAIN\user`) restricted to a 20-character limitation, serving legacy on-premises local network systems.

---

## 💻 Command Prompt Steps

Execute the native directory search utility from a command prompt on the Domain Controller to verify that your nesting layout has committed successfully to the database:

```cmd
dsquery ou "OU=Corp,OU=LAB,DC=<domain>,DC=local"
```

* [cite_start]What this command proves: Interrogates the local database instance using raw LDAP search strings, validating that all administrative sub-OUs and departmental tiers are correctly built and aligned beneath the parent management boundary[cite: 464].

---

## 📜 PowerShell Steps

Run the following script block within an administrative PowerShell console to programmatically verify that user assignments and directory attributes match expectations:

```powershell
# Task 1: Audit all newly generated business sector container paths
$TargetBase = "OU=Corp,OU=LAB,DC=<domain>,DC=local"
Get-ADOrganizationalUnit -Filter "Name -ne 'Corp'" -SearchBase $TargetBase | Select-Object Name, DistinguishedName

# Task 2: Validate the user object properties and confirm UPN routing assignment
Get-ADUser -Identity "<admin-user>" -Properties UserPrincipalName, MemberOf | Select-Object Name, UserPrincipalName, @{Name="GroupMembership";Expression={$_.MemberOf -join ','}}
```

### Why these commands matter:

* [cite_start]`Get-ADOrganizationalUnit` ensures the automation and synchronization paths are fully discoverable before deploying cloud components[cite: 465].
* [cite_start]`Get-ADUser` confirms the account is configured with the correct cloud routing attributes and group bindings, preventing synchronization issues[cite: 465].

---

## 🔍 Validation

### Expected Directory Configuration

| Metric / Target Object | Expected State | Verification Method |
| :--- | :--- | :--- |
| Parent Boundary | [cite_start]`OU=LAB,DC=<domain>,DC=local` exists and is active [cite: 467] | [cite_start]Run `Get-ADOrganizationalUnit` script check [cite: 467] |
| Object Cloud Routing Suffix | [cite_start]Primary UPN matches `@<tenant>.onmicrosoft.com` [cite: 469] | [cite_start]Run `Get-ADUser -Properties UserPrincipalName` [cite: 469] |
| Sync Control Container | [cite_start]User account sits within the nested `IT` OU layer [cite: 468] | [cite_start]Inspect via Active Directory Users and Computers [cite: 468] |
| Sync Tracking Matrix | [cite_start]User mapped inside group membership parameters [cite: 469] | [cite_start]Run `Get-ADGroupMember M365-CloudSync-Users` [cite: 470] |

### What Failure Looks Like

* [cite_start]Symptom: Running the `dsquery ou` command or checking the directory tree shows that departmental OUs were inadvertently created directly under the root domain node instead of within the `LAB\Corp` branch[cite: 471].
* [cite_start]Root Cause: The nesting steps were run without selecting the precise parent container first, or the PowerShell path variable was malformed during automated deployment[cite: 472].

---

## 🛠️ Troubleshooting

| Issue | Possible Cause | How to Validate | Fix |
| :--- | :--- | :--- | :--- |
| [cite_start]Cloud suffix dropdown option missing in GUI [cite: 474] | [cite_start]Suffix hasn't been added to the forest configuration [cite: 474] | [cite_start]Review the forest options using the Active Directory Domains and Trusts console [cite: 475] | [cite_start]Open the Active Directory Domains and Trusts tool, right-click the root node, select properties, add `<tenant>.onmicrosoft.com` as an alternative suffix, and hit apply[cite: 475]. |
| [cite_start]Object cannot be moved or thrown an Access Denied error [cite: 476, 477] | [cite_start]Deletion protection prevents structural changes [cite: 476] | [cite_start]Open object properties, go to the Object tab, and check the protection state [cite: 478] | Turn on Advanced Features in `dsa.msc` (View -> Advanced Features). [cite_start]Open the object's properties, select the Object tab, uncheck Protect container from accidental deletion, perform the move, and re-enable protection[cite: 477, 478]. |

---

## 🔒 Security and Governance Notes

* [cite_start]Why Source of Authority (SoA) Matters: In a hybrid infrastructure deployment, objects created locally remain authoritative on-premises[cite: 361]. [cite_start]Any future updates to user logins, department listings, or group memberships must be managed inside Active Directory, as the sync engine locks these properties from direct modification in the cloud[cite: 413, 414].
* [cite_start]Hardening the Sync Boundary: Restricting synchronization to the isolated `LAB\Corp` tree ensures that highly privileged built-in administrative accounts (like `Domain Admins`) stay confined to your local perimeter, reducing your overall cloud security risk[cite: 413, 481].

---

## 📝 Documentation Evidence

```cmd
PS C:\Windows\system32> dsquery ou "OU=Corp,OU=LAB,DC=<domain>,DC=local"
"OU=Computers,OU=Corp,OU=LAB,DC=<domain>,DC=local"
"OU=Workstations,OU=Computers,OU=Corp,OU=LAB,DC=<domain>,DC=local"
"OU=Departments,OU=Workstations,OU=Computers,OU=Corp,OU=LAB,DC=<domain>,DC=local"
"OU=Engineering,OU=Departments,OU=Workstations,OU=Computers,OU=Corp,OU=LAB,DC=<domain>,DC=local"
"OU=Finance,OU=Departments,OU=Workstations,OU=Computers,OU=Corp,OU=LAB,DC=<domain>,DC=local"
"OU=HR,OU=Departments,OU=Workstations,OU=Computers,OU=Corp,OU=LAB,DC=<domain>,DC=local"
"OU=IT,OU=Departments,OU=Workstations,OU=Computers,OU=Corp,OU=LAB,DC=<domain>,DC=local"
"OU=Operations,OU=Departments,OU=Workstations,OU=Computers,OU=Corp,OU=LAB,DC=<domain>,DC=local"
"OU=Sales,OU=Departments,OU=Workstations,OU=Computers,OU=Corp,OU=LAB,DC=<domain>,DC=local"
"OU=Groups,OU=Corp,OU=LAB,DC=<domain>,DC=local"
"OU=Users,OU=Corp,OU=LAB,DC=<domain>,DC=local"
"OU=Departments,OU=Users,OU=Corp,OU=LAB,DC=<domain>,DC=local"
"OU=Engineering,OU=Departments,OU=Users,OU=Corp,OU=LAB,DC=<domain>,DC=local"
"OU=Finance,OU=Departments,OU=Users,OU=Corp,OU=LAB,DC=<domain>,DC=local"
"OU=HR,OU=Departments,OU=Users,OU=Corp,OU=LAB,DC=<domain>,DC=local"
"OU=IT,OU=Departments,OU=Users,OU=Corp,OU=LAB,DC=<domain>,DC=local"
"OU=Operations,OU=Departments,OU=Users,OU=Corp,OU=LAB,DC=<domain>,DC=local"
"OU=Sales,OU=Departments,OU=Users,OU=Corp,OU=LAB,DC=<domain>,DC=local"

PS C:\Windows\system32> Get-ADUser -Identity "<admin-user>" -Properties UserPrincipalName | Select-Object Name, UserPrincipalName
Name             UserPrincipalName
----             -----------------
<admin-user>     <admin-user>@<tenant>.onmicrosoft.com
```

---

## 🎓 Lessons Learned

* [cite_start]Isolating Identity Sync Scopes: Grouping production-ready objects inside an isolated root container (like `LAB\Corp`) creates a secure management boundary for hybrid environments[cite: 413, 482].
* [cite_start]Preventing Cloud Sign-In Mismatches: Selecting a matching UPN suffix right when an account is created ensures a seamless user authentication experience once identities sync to the cloud[cite: 404, 483].

---

## 🗣️ Interview Talking Points

> [cite_start]"When building out hybrid directories, I avoid using default directory containers for production identities. Instead, I deploy a tiered Organizational Unit architecture nested within a protected parent boundary to cleanly isolate enterprise resources and personnel. By assigning alternative, cloud-ready User Principal Name suffixes to user objects at creation, I ensure proper routing and clean identity matching before any data reaches the cloud tenant." [cite: 484]