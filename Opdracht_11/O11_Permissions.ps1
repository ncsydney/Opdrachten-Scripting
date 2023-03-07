$Folder = "C:\opdracht11"

# Kijkt of de folder bestaat, zo niet, wordt het pad aangemaakt
if(!(Test-Path($Folder))){
    Write-Host "Folder niet gevonden!" -ForegroundColor DarkYellow
    Write-Host "Folder wordt gemaakt." -ForegroundColor DarkYellow
    New-Item -Path $Folder -ItemType Directory
    Write-Host "Folder aangemaakt!" -ForegroundColor Green
}

# Als de folder bestaat, geef de groep Personeel lees en schrijf rechten 
if(Test-Path($Folder)){
    $Group = "Personeel"
    $ACL = Get-Acl $Folder
    $Rule = New-Object System.Security.AccessControl.FileSystemAccessRule($Group,"Read, Write","ContainerInherit, ObjectInherit","None","Allow")
    $ACL.AddAccessRule($Rule)
    Set-Acl $Folder $ACL
    Write-Host "Rechten voor de groep personeel zijn doorgevoerd" -ForegroundColor Green
}
else{
    Write-Host "Fout bij uitvoeren van script" -ForegroundColor DarkRed
}