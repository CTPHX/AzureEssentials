$conn = Get-AutomationConnection -Name AzureRunAsConnection
Add-AzAccount -ServicePrincipal -Tenant $conn.TenantID -ApplicationID $conn.ApplicationID -CertificateThumbprint $conn.CertificateThumbprint

Import-Module Az.Compute

$VMs = Get-AzVM | where {$_.Tags.Values -like '*test*'}

$VMs | stop-AzVM -Force

Write-Output $VMs.Name 
