# Connecting to Microsoft Graph
Connect-Mggraph -Scopes `
"User.Read.All", `
"Group.Read.All", `
"Directory.Read.All", `
"Organization.Read.All", `
"RoleManagement.Read.Directory", `
"Reports.Read.All" `
-UseDeviceCode

<# 
| Scope                           | Why we need it                      |
| ------------------------------- | ----------------------------------- |
| `User.Read.All`                 | Read users                          |
| `Group.Read.All`                | Read groups                         |
| `Directory.Read.All`            | Read directory objects              |
| `Organization.Read.All`         | Read tenant/org/license information |
| `RoleManagement.Read.Directory` | Read role management information    |
| `Reports.Read.All`              | Read usage reports                  |
#>

# Creating Project Reports Folder
$ProjectPath = "G:\Azure_Portfolio\azure-identity-portfolio\projects\03-m365-tenant-baseline"
$ReportsPath = Join-Path $ProjectPath "reports"
$ScriptsPath = Join-Path $ProjectPath "scripts"

New-Item -ItemType Directory -Path $ReportsPath -Force
New-Item -ItemType Directory -Path $ScriptsPath -Force

# Confirm Graph Connection
Get-MgContext -Verbose

<#
| Field       | Meaning                               |
| ----------- | ------------------------------------- |
| Account     | The signed-in admin account           |
| TenantId    | The tenant you connected to           |
| Scopes      | Permissions granted for the session   |
| Environment | Usually Global for commercial tenants |
#>

# Get tenant Organization Information
Get-MgOrganization | Format-List

# Export Organization Information
Get-MgOrganization |
Select-Object DisplayName, ID, VerifiedDomains |
Export-Csv -Path "$ReportsPath\m365-organization-summary.csv" -NoTypeInformation

# Export license / subscribed SKU information
Get-MgSubscribedSku | 
Select-Object SkuPartNumber, ConsumedUnits, @{N="Total Licenses";E={$_.PrepaidUnits.Enabled}} | 
Export-Csv -Path "$ReportsPath\m365-subscribed-skus.csv" -NoTypeInformation

# Export Users
Get-MgUser -All -Property Id, DisplayName, UserPrincipalName, AccountEnabled, UserType, CreatedDateTime |
Export-Csv -Path "$ReportsPath\m365-users.csv" -NoTypeInformation

Get-MgUser -All -Property Id,DisplayName,UserPrincipalName,AccountEnabled,UserType,CreatedDateTime |
Select-Object DisplayName, UserPrincipalName, AccountEnabled, UserType, CreatedDateTime |
Export-Csv -Path "$ReportsPath\m365-users.csv" -NoTypeInformation

# Export Groups
Get-MgGroup -All -Property Id, DisplayName, Mail, GroupTypes, SecurityEnabled, MailEnabled, Visibility, CreatedDateTime |
Export-Csv -Path "$ReportsPath\m365-groups.csv" -NoTypeInformation

# Role Assignment
Get-MgDirectoryRole |
Select-Object Id, DisplayName, Description |
Export-Csv -Path "$ReportsPath\m365-directory-roles.csv" -NoTypeInformation

# Role Members
$RoleMembers = foreach ($Role in Get-MgDirectoryRole) {
    $Members = Get-MgDirectoryRoleMember -DirectoryRoleId $Role.Id

    foreach ($Member in $Members) {
        [PSCustomObject]@{
            RoleName = $Role.DisplayName
            MemberName = $Member.AdditionalProperties.'displayName' 
            MemberId = $Member.Id
            MemberType = $Member.AdditionalProperties.'@odata.type'
        }
    }
}

$RoleMembers | 
Export-Csv -Path "$ReportsPath\m365-directory-role-members.csv" -NoTypeInformation

# M365 Active usage Report
Get-MgReportOffice365ActiveUserDetail -Period D30 -OutFile "$ReportsPath\m365-active-user-detail-d30.csv"

# M365 Teams usage Report
Get-MgReportTeamUserActivityUserDetail -Period D30 -OutFile "$ReportsPath\m365-teams-user-activity-d30.csv"