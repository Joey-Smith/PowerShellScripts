#-------------------------------------------------------------------------------------------
# Author: Joey Smith
# Date: 2025-06-28
# Description: This script signs a PowerShell script using a specified certificate.
# Credit:
#	Salaudeen Rajack - https://www.sharepointdiary.com/2020/12/how-to-sign-powershell-script.html
#-------------------------------------------------------------------------------------------

$certificateThumbprint = "<Thumbprint>"
$scriptPath = "<Script Path>"
 
# Get the certificate from the CurrentUser store using the thumbprint
$certificate = Get-ChildItem -Path Cert:\CurrentUser\My | Where-Object {$_.Thumbprint -eq $certificateThumbprint}
 
# Sign the script with the certificate
Set-AuthenticodeSignature -FilePath $scriptPath -Certificate $certificate