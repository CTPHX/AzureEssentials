#Please import AZ.Accounts & Az.Automation into your AZ Automation Account
#Please see for more infomration https://github.com/Azure/azure-powershell/blob/master/src/Automation/Automation/help/New-AzAutomationSchedule.md

#Variables
$ResourceGroup = 'XXXXXX'
$AutomationAccount = 'XXXXXX'

# Connect to Azure with Run As account
$ServicePrincipalConnection = Get-AutomationConnection -Name 'AzureRunAsConnection'

Connect-AzAccount `
    -ServicePrincipal `
    -Tenant $ServicePrincipalConnection.TenantId `
    -ApplicationId $ServicePrincipalConnection.ApplicationId `
    -CertificateThumbprint $ServicePrincipalConnection.CertificateThumbprint

$AzureContext = Set-AzContext -SubscriptionId $ServicePrincipalConnection.SubscriptionID


#Create Schedule for for anything with the tag Test to Powerdown during the week(Evening)
$StartTime = (Get-Date "19:00:00").AddDays(1)
[System.DayOfWeek[]]$WeekDays = @([System.DayOfWeek]::Monday..[System.DayOfWeek]::Friday)
New-AzAutomationSchedule -AutomationAccountName $AutomationAccount -Name "TestPowerdownWeekdays" -StartTime $StartTime -WeekInterval 1 -DaysOfWeek $WeekDays -ResourceGroupName $ResourceGroup

#Create Schedule for for anything with the tag Test to Powerup during the week (Morning)
$StartTime = (Get-Date "07:00:00").AddDays(1)
[System.DayOfWeek[]]$WeekDays = @([System.DayOfWeek]::Monday..[System.DayOfWeek]::Friday)
New-AzAutomationSchedule -AutomationAccountName $AutomationAccount -Name "TestPowerdownWeekdays" -StartTime $StartTime -WeekInterval 1 -DaysOfWeek $WeekDays -ResourceGroupName $ResourceGroup
