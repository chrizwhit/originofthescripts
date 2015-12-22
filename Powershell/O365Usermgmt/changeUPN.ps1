#Script to change users from onmicrosft to primary domain if they were synced with the wrong UPN before it was fixed.

 Get-MSolUser -All | Where { $_.UserPrincipalName.ToLower().EndsWith("onmicrosoft.com")
} | ForEach { Set-MsolUserPrincipalName -ObjectId $_.ObjectId -NewUserPrincipalName ($_.UserPrincipalName.Split(“@”)[0]
+ “@mydomain.com”) }
