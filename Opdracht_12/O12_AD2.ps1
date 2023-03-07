# Importeert de module ActiveDirectory
Import-Module ActiveDirectory

# Maakt tabel objecten van de items in CSV-bestanden door de cmdlet Import-Csv
$Users = import-csv "C:\data\users.csv"
$count = 0
$NewUsers = ""

# Als het bestand 'users.csv' leeg is
if(!($Users)){
    Write-Host "Geen gebruikers gevonden in CSV-bestand"
}

# Als het bestand 'users.csv' niet leeg is
else {

    # Itereert door het CSV-bestand.
    foreach($User in $Users){
        $count += 1
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
        $GlobalFolder = "C:\GlobalFolder\"
        $HomeDirectory = ($UserRoot+$Lastname)
        $SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
        $Rule = New-Object System.Security.AccessControl.FileSystemAccessRule `
            ($Group,"Read, Write","ContainerInherit, ObjectInherit","None","Allow")
    
        # Kijkt of de gebruiker in de AD bestaat
        if(Get-ADUser -Filter {sAMAccountName -eq $FullName}){
                $count = 0
                Write-Host "Gebruiker [$FullName] bestaat al in AD" -ForegroundColor DarkRed
            }
            else{
                
                # Maakt de nieuwe gebruikers aan
                New-ADUser -Name $FullName -GivenName $Firstname -Surname $Lastname `
                -DisplayName $FullName -SamAccountName $Username -HomeDrive $HomeDrive `
                -HomeDirectory $HomeDirectory -UserPrincipalName $UPN -Path $OU `
                -AccountPassword $SecurePassword -Enabled $true -PasswordNeverExpires $true `
                -PassThru
                
                $NewUsers += "Gebruiker [$FullName] toegevoegd aan AD`n"

                # Voegt alle aangemaakte gebruikers toe aan de groep Personeel
                Add-ADGroupMember -Identity $Group -Members $FUllName
                
                Write-Host "Gebruiker [$FullName] toegevoegd aan AD" -ForegroundColor Green

                # Kijkt of het de folde $GlobalFolder bestaat, zo niet, wordt de folder aangemaakt 
                if(!(Test-Path($GlobalFolder))){
                    New-Item -Path $GlobalFolder -Type Directory 
                }
                
                # Als de folder $GlobalFolder bestaat, geef de groep Personeel Lees en Schrijf rechten
                if(Test-Path($GlobalFolder)){
                    $ACL = Get-Acl $GlobalFolder
                    
                $ACL.AddAccessRule($Rule)
                Set-Acl $GlobalFolder $ACL
                }

            }
        }
}
Write-Host $NewUsers -ForegroundColor Green
pause