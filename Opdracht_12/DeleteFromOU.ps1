# Verkrijgt alle users uit de OU 'IT' en slaat het resultaat op in het variabel $AllUsers
$OU = "OU=IT, DC=scripting, DC=local"
$AllUsers = Get-ADUser -Filter * -SearchBase $OU
$count = 0

# Itereert door alle gebruikers
foreach($User in $AllUsers){
    $count += 1
    Write-Host "Gevonden gebruiker [$($User | Select-Object -Expandproperty Name)]"
}

# Vraagt welke gebruiker je wilt verwijderen
$DelUser = Read-Host "`nWelke gebruiker wil je verwijderen"

# Bevestigt of je de gebruiker echt wilt verwijderen
$choice = Read-Host "`nWeet je zeker dat je gebruiker $DelUser wilt verwijderen? Y/N"

# Als de keuze anders is dan Y
if(!($choice -eq "Y")){
    Write-Host "Geanuleerd"
    Pause
}
# Als de keuze Y is, verwijder de gebruiker
else{
    Get-ADUser -Filter {Name -eq $DelUser} | Remove-ADUser
    Write-Host "Gebruiker $DelUser verwijdert uit AD"
    pause
}
