$RiskSummary = @(
    [PSCustomObject]@{
        RiskArea = "License Hygiene"
        Observation = "72 active users, 10 licensed users, 62 unlicensed users"
        RiskLevel = "Medium"
        RecommendedNextStep = "Review unlicensed users for cleanup, onboarding, or license assignment requirements"
    }
    [PSCustomObject]@{
        RiskArea = "Privileged Access"
        Observation = "Global Administrator, Reports Reader, and Security Administrator assignments observed"
        RiskLevel = "Medium"
        RecommendedNextStep = "Review privileged roles periodically and plan future PIM implementation"
    }
    [PSCustomObject]@{
        RiskArea = "Groups and Collaboration"
        Observation = "27 group objects observed, including 5 Teams/Microsoft 365 groups and 2 Teams-connected groups"
        RiskLevel = "Medium"
        RecommendedNextStep = "Review ownership, guest access, lifecycle, and Teams/SharePoint data exposure"
    }
    [PSCustomObject]@{
        RiskArea = "Guest and External Collaboration"
        Observation = "Guest-related Microsoft 365 Groups settings were visible and guest content access was allowed"
        RiskLevel = "Medium"
        RecommendedNextStep = "Review guest access strategy before expanding Teams, SharePoint, Copilot, or agent adoption"
    }
    [PSCustomObject]@{
        RiskArea = "User-Owned Apps and Trials"
        Observation = "Office Store access and user trial capabilities were enabled"
        RiskLevel = "Medium"
        RecommendedNextStep = "Review app governance, trial controls, licensing impact, and support ownership"
    }
    [PSCustomObject]@{
        RiskArea = "Integrated Apps and Agents"
        Observation = "2 deployed apps, 1,358 available apps, and 20 agent-filtered app results were visible"
        RiskLevel = "Medium"
        RecommendedNextStep = "Review app and agent governance, approval workflow, and Copilot/agent readiness"
    }
    [PSCustomObject]@{
        RiskArea = "Reports Privacy"
        Observation = "User, group, and site names were concealed in reports"
        RiskLevel = "Low"
        RecommendedNextStep = "Document privacy posture and understand troubleshooting tradeoffs"
    }
    [PSCustomObject]@{
        RiskArea = "Service Health and Change Management"
        Observation = "5 active service health issues and 533 Message center posts were observed"
        RiskLevel = "Medium"
        RecommendedNextStep = "Define ownership for service health review, Message center triage, and user communications"
    }
    [PSCustomObject]@{
        RiskArea = "Raw Report Handling"
        Observation = "Graph CSV exports were generated locally and excluded from GitHub using reports folder .gitignore"
        RiskLevel = "Low"
        RecommendedNextStep = "Keep raw exports local and publish only sanitized summaries"
    }
)

$RiskSummary |
Export-Csv -Path "$ReportsPath\m365-risk-summary.csv" -NoTypeInformation

$RiskSummary | Format-Table -AutoSize