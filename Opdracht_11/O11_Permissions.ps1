$Folder = "C:\opdracht11"

# Kijkt of de folder bestaat, zo niet, wordt het pad aangemaakt
if(!(Test-Path($Folder))){
    Write-Host "Folder niet gevonden!"
    Write-Host "Folder wordt gemaakt."
    New-Item -Path $Folder -ItemType Directory
    Write-Host "Folder aangemaakt!"
}

# Als de folder bestaat, geef de groep Personeel lees en schrijf rechten 
if(Test-Path($Folder)){
    $Group = "Personeel"
    $ACL = Get-Acl $Folder
    $Rule = New-Object System.Security.AccessControl.FileSystemAccessRule($Group,"Read, Write","ContainerInherit, ObjectInherit","None","Allow")
    $ACL.AddAccessRule($Rule)
    Set-Acl $Folder $ACL
}
else{
    Write-Host "Fout bij uitvoeren van script"
}