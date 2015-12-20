#This script schedules the application of the litigation hold feature in O365, provided the correct License has been applied


#Change these variables to match your environment
$AdminUsername = "*****@yourdomain.com"
$AdminPassword = "******!"


$SecurePassword = ConvertTo-SecureString $AdminPassword -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $AdminUsername,$SecurePassword

$Session = New-PSSession -ConfigurationName Microsoft.Exchange-ConnectionUri https://ps.outlook.com/powershell/ -Credential $cred -Authentication Basic -AllowRedirection


Import-PSSession $Session


Get-Mailbox -ResultSize "Unlimited" | Where {$_.LitigationHoldEnabled -match "False"} | ForEach-Object {$Identity = $_.alias; Set-Mailbox -Identity $Identity -LitigationHoldEnabled $True }

Remove-PSSession $Session
