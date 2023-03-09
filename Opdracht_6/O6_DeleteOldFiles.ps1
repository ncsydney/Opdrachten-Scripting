# Zet de datum van vandaag -30 dagen gelijk aan het variabel $days
$days = (Get-Date).AddDays(-30)

# Zet de waarde van alle bestanden in de map data die ouder zijn dan 30 dagen gelijk aan het veriabel $OldFile
$Path = "C:\data"
$OldFile = Get-ChildItem -Path $Path -Recurse | Where-Object { !$_.PSIsContainer }  -and $_.CreationTime -lt $days 

$count = 0

# Itereert door $OldFiles
foreach($file in $OldFile){
    $count += 1
    if($count -gt 0){
        Write-Host "Oud bestand - [$file]"
    }
    else{
        Write-Host "Geen bestanden gevonden"
        break
    }
}

# Als het variabel $count groter is dan 0
if($count -gt 0 ){
    $Choice = Read-Host "Wil je de oude bestaben verwijderen? Y/N"

    # Als de keuze N is, breek het proces af
    if($Choice -eq "N"){
        Write-Host "Geanuleerd"
    }

    # Als de keuze Y is, worden de oude bestanden verwijdert
    elseif($Choice -eq "Y"){
        foreach($file in $OldFile){
            $count += 1
            Remove-Item -Recurse "$Path/$OldFile"  
        }

        # Als het variabel $count niet gelijk is aan 1
        if ($count -ne 1){
            Write-Host "$count bestanden verwijderd"
        }

        # Als het het variabel $count wel gelijk is aan 1
        else{
            Write-Host "$count bestand verwijderd"
        }
    }else{
        # Als de invoer niet Y of N is
        Write-Host "Invoer ongeldig"
        break
    }
}
Pause
