Import-Module ActiveDirectory
$Users = import-csv 'users.csv'
$count = 0
$NewUsers = ""

if(!($Users)){Write-Host "Geen gebruikers gevonden in CSV-file"}

else {
    foreach($User in $Users){
        $Group = "Personeel"
        $Firstname = $User.GivenName
        $Lastname = $User.Surname
        $FullName = $Firstname+" "+$Lastname
        $Password = $User.AccountPassword
        $Domain = "@scripting.local"
        $UPN = $User.UPN+$Domain
        $OU = "OU=IT, DC=scripting, DC=local"
        $HomeDrive = "H:"
        $UserRoot = "\\Server1\Homedrives\"
        $HomeDirectory = ($UserRoot+$Lastname)
        $SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
    
        $count += 1
        
        # Kijkt of de gebruiker in de AD bestaat
        if(Get-ADUser -Filter {sAMAccountName -eq $FullName}){
                $count = 0
                Write-Host "Gebruiker [$FullName] bestaat al in AD" -ForegroundColor DarkRed
        }
        else{
            
            # Maakt de nieuwe gebruikers aan
            New-ADUser –Name $FullName –GivenName $Firstname –Surname $Lastname `
            -DisplayName $FullName –SamAccountName $Username –HomeDrive $HomeDrive `
            -HomeDirectory $HomeDirectory –UserPrincipalName $UPN -Path $OU `
            -AccountPassword $SecurePassword -Enabled $true –PasswordNeverExpires $True `
            -PassThru
            
            # Voegt alle aangemaakte gebruikers toe aan de groep Personeel
            Add-ADGroupMember -Identity $Group -Members $FUllName
            
            $NewUsers += "Gebruiker [$FullName] toegevoegd aan AD`n"
        }
    }
}
Write-Host $NewUsers -ForegroundColor Green
pause
