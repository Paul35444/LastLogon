#!\bin\bash
Import-Module ActiveDirectory

#Define domain and use them all with the "*" wildcard option
	$doms = Get-ADDomainController -Filter {Name -like "*"}
#Get all users using the "*" wildcard option
	$users = Get-ADUser -Filter *
#Set time parameter to 0
	$time = 0

#Loop through every user
foreach ($user in $users) {
#Loop through every domain
	foreach ($dom in $doms) {
#Get every user in the domain loop
		$currentUser = Get-ADUser $user.SamAccountName | Get-ADObject -Properties lastLogon
#If condition to get when the user last logged on
		if ($currentUser.LastLogon -gt $time) {
#Set the time for the user to the last logon time
			$time = $currentUser.LastLogon
			}
#Set a datetime parameter to use for each user
	$dt = [DateTime]::FromFileTime($time)
#Create output for when each user last logged on
	Write-Host $currentUser "last logged on at:" $dt
	$time = 0
	}
}