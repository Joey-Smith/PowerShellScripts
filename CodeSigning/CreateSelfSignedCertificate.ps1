#-------------------------------------------------------------------------------------------
# Author: Joey Smith
# Date: 2025-06-28
# Description: This script creates a self-signed certificate and makes it trusted on the local machine.
# Credit:
#	Salaudeen Rajack - https://www.sharepointdiary.com/2020/12/how-to-sign-powershell-script.html
#	Microsoft - https://learn.microsoft.com/en-us/entra/identity-platform/howto-create-self-signed-certificate
#-------------------------------------------------------------------------------------------

$certificateName = "<Certificate Name (AKA Common Name or Subject)>"
$certificateEmail = "<Certificate Email>"
$certificatePath = [Environment]::GetFolderPath("MyDocuments")+"\$certificateName.cer"
#$certificatePFXPath = [Environment]::GetFolderPath("MyDocuments")+"\$certificateName.pfx"
#$password = ConvertTo-SecureString -String "{myPassword}" -Force -AsPlainText  ## Replace {myPassword}
 
#Create a self-signed certificate
$certificate = New-SelfSignedCertificate -CertStoreLocation Cert:\CurrentUser\My -Subject "CN=$certificateName,E=$certificateEmail" -KeySpec Signature -Type CodeSigningCert

#Export the Certificate to "Documents" Folder in your computer
Export-Certificate -Cert $certificate -FilePath $certificatePath
#Export-PfxCertificate -Cert $certificate -FilePath $certificatePFXPath -Password $password   ## Specify your preferred location
 
#Add Certificate to the "Trusted Root Store"
Get-Item $certificatePath | Import-Certificate -CertStoreLocation "Cert:\LocalMachine\Root"
#Get-Item $certificatePFXPath | Import-PfxCertificate -CertStoreLocation "Cert:\LocalMachine\Root" -Password (ConvertTo-SecureString -String "{myPassword}" -Force –AsPlainText)
  
Write-host "Certificate Thumbprint:" $certificate.Thumbprint
