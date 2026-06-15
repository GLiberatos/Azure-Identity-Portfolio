# Project 04 — Module 03: Active Directory Structure

## 🎯 Purpose
This module covers the configuration and deployment of an enterprise-grade Organizational Unit (OU) path, security group footprint, and standardized user object scheme within Active Directory Domain Services. This structure establishes the definitive Identity boundary that maps directly to the Microsoft Entra Cloud Sync provisioning scope.

---

## 🧠 What This Lab Teaches
* **Enterprise OU Architecture:** Implementing a nested directory hierarchy that segregates system resources, core groups, and corporate user bodies.
* **Identity Lifecycle Provisioning:** Crafting accounts utilizing an alternate User Principal Name (UPN) mapping scheme at birth to facilitate immediate cloud matching.
* **Directory Automation at Scale:** Leveraging PowerShell scripting arrays to bulk-build structural departmental footprints across user and workstation vectors simultaneously.

---

## 🛑 Before You Start
* **Domain Environment Active:** Root Domain Controller (`EntraConnectDC`) is promoted and operational for `iron.local`.
* **UPN Suffix Provisioned:** The custom tenant routing suffix `xkdk1.onmicrosoft.com` is registered inside Active Directory Domains and Trusts.
* **Privileged Credentials:** Administrative access via `IRON\Administrator` to modify the directory tree.

---

## 🖱️ GUI Build Steps

### Step 1: Initialize Top-Level and Corporate Container Boundaries
1. Log into `EntraConnectDC` and launch **Active Directory Users and Computers** (`dsa.msc`).
2. Right-click the root node `iron.local`, point to **New**, and select **Organizational Unit**.
3. Set the name to **`LAB`** and ensure the checkbox for **Protect container from accidental deletion** is active.
4. Right-click the newly built `LAB` OU, select **New -> Organizational Unit**, and create the **`Corp`** container (ensure deletion protection is enabled).

### Step 2: Establish Resource and Object Categorization Tiering
1. Right-click the **`Corp`** OU and create three individual nested sub-OUs, maintaining deletion protection on each:
   * **`Computers`** (Container for system assets)
   * **`Groups`** (Container for authorization boundaries)
   * **`Users`** (Container for enterprise personnel)
2. Right-click the newly built **`Computers`** sub-OU, select **New -> Organizational Unit**, and name it **`Workstations`**.
3. Right-click the **`Workstations`** OU, select **New -> Organizational Unit**, and name it **`Departments`**.
4. Right-click the **`Users`** sub-OU, select **New -> Organizational Unit**, and name it **`Departments`**.

### Step 3: Populate Department Paths and Provision Sync Target Objects
1. Under both `Computers\Workstations\Departments\` and `Users\Departments\`, create individual OUs manually for each standard business sector:
   * `Engineering`, `Finance`, `HR`, `IT`, `Operations`, `Sales`
2. Navigate to the `Corp\Groups\` container, right-click an empty space, and choose **New -> Group**.
   * **Group Name:** `M365-CloudSync-Users`
   * **Group Scope:** `Global`
   * **Group Type:** `Security`
3. Navigate to the `Corp\Users\Departments\IT\` container, right-click, and choose **New -> User**.
   * **First Name:** `George` | **Last Name:** `Liberatos`
   * **User Logon Name:** `gliberatos`
   * **User Logon Name Suffix:** Click the dropdown menu and change it from `@iron.local` to **`@xkdk1.onmicrosoft.com`**.
   * *Why this option?* This ensures the identity aligns natively with the verified cloud anchor domain during future synchronization phases.
4. Open the properties of the `gliberatos` user object, navigate to the **Member Of** tab, click **Add**, and make the account a member of the `M365-CloudSync-Users` security group.

---

## 💻 Command Prompt Steps
Execute the traditional Active Directory command-line query utility to verify that your directory paths match the target organizational blueprint:

```cmd
dsquery ou "OU=Corp,OU=LAB,DC=iron,DC=local"
```
* **What this proves:** Queries the internal directory database engine via standard LDAP strings, validating that the parent containers and all multi-nested departmental branches have successfully committed to the database.

---

## 📜 PowerShell Steps
Run this optimized administrative script array to automatically audit or bulk-generate the nested departmental structure across your workstation and user boundaries:

```powershell
# Define the core sync boundaries and sub-departments based on architecture layout
$TargetOUBase = "OU=Corp,OU=LAB,DC=iron,DC=local"
$BusinessUnits = @("Engineering", "Finance", "HR", "IT", "Operations", "Sales")

# Validate path existence and output active container footprints
foreach ($Unit in $BusinessUnits) {
    Get-ADOrganizationalUnit -Filter "Name -eq '$Unit'" | Select-Object Name, DistinguishedName
}
```
* **Why it matters:** Portraying resource discovery using the ActiveDirectory module validates structural integrity before configuring data connection rules with the cloud.

---

## 🔍 Validation

### Expected Baseline Post-Deployment
| Metric / Object Identity | Expected Directory Status | Verification Mechanism |
| :--- | :--- | :--- |
| **Parent Boundary** | `OU=LAB,DC=iron,DC=local` exists | `Get-ADOrganizationalUnit` check |
| **Target User Path** | Nested under `IT` department path | Check via Active Directory Users and Computers |
| **Object Cloud Routing Suffix** | UPN matches `@xkdk1.onmicrosoft.com` | Run `Get-ADUser gliberatos -Properties UserPrincipalName` |
| **Sync Tracking Matrix** | User mapped inside group membership parameters | Run `Get-ADGroupMember M365-CloudSync-Users` |

### What Failure Looks Like
* **Symptom:** Running the `dsquery` command or browsing via `dsa.msc` shows the departments created directly under the root domain node or completely missing from the `LAB\Corp` pathway.
* **Root Cause:** The nesting steps were run without selecting the precise parent structural layer first, requiring object moves to realign paths.

---

## 🛠️ Troubleshooting

| Issue | Possible Cause | How to Validate | Fix |
| :--- | :--- | :--- | :--- |
| **Cannot find cloud suffix option in GUI** | Suffix missing from Active Directory hierarchy | Check forest properties via Active Directory Domains and Trusts | Open Domains and Trusts console, access properties, add `xkdk1.onmicrosoft.com` as alternative suffix |
| **Accidental placement error when dragging OUs** | Deletion protection blocks modification | Attempting to move container throws an "Access Denied" block | Go to View -> Advanced Features in `dsa.msc`. Access OU Properties -> Object tab. Clear the deletion protection checkbox, perform move, and re-enable protection immediately. |

---

## 🔒 Security & Governance Notes
* **Boundary Hardening via Deletion Protection:** Activating accidental deletion blocks on production container nodes acts as a vital safety net. It prevents bulk execution scripts or accidental admin actions from downing entire business unit objects.
* **Sync Boundary Containment:** Limiting the Microsoft Entra synchronization scope to the isolated `LAB\Corp` branch prevents administrative default accounts from leaving the on-premises perimeter, which aligns with modern Zero Trust security best practices.

---

## 📝 Documentation Evidence
The following structural breakdown verifies the completed nested container layout inside the `iron.local` directory partition:

```text
Active Directory Users and Computers [EntraConnectDC.iron.local]
└── iron.local
    └── LAB (Protected)
        └── Corp (Protected)
            ├── Computers
            │   └── Workstations
            │       └── Departments
            │           ├── Engineering
            │           ├── Finance
            │           ├── HR
            │           ├── IT
            │           ├── Operations
            │           └── Sales
            ├── Groups
            │   └── M365-CloudSync-Users (Global Security Group)
            └── Users
                └── Departments
                    ├── Engineering
                    ├── Finance
                    ├── HR
                    ├── IT (Contains: George Liberatos [UPN: gliberatos@xkdk1.onmicrosoft.com])
                    ├── Operations
                    └── Sales
```

---

## 🎓 Lessons Learned
* **The Importance of Scoping Boundaries:** Structuring user paths into designated, distinct branches simplifies identity management and allows you to set precise synchronization rules for hybrid environments.
* **Preventing UPN Mismatches:** Setting user login suffixes to match your verified cloud domain right at creation prevents synchronization conflicts and fallback errors inside Microsoft Entra ID.

---

## 🗣️ Interview Talking Points
> "When configuring hybrid environments, I avoid using default directory containers for production identities. In my lab environment, I deployed a customized, tiered Organizational Unit architecture nested within a protected parent boundary. This design isolates standard enterprise resources and personnel paths into an explicit synchronization target zone. By assigning alternative, cloud-ready User Principal Name suffixes to user objects at creation, I ensure proper routing and clean identity matching before any data reaches the cloud tenant."