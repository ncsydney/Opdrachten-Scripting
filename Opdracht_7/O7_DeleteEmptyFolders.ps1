# Verzamrlt alle lege folders en zet  ze gelijk aan het variabel $EmptyFolder
$Path = "C:\data"
$EmptyFolder = Get-ChildItem -Path $Path -recurse | Where-Object {$_.PSIsContainer -eq $True } | Where-Object {$_.GetFiles().Count -eq 0}

$count = 0

# Itereert door $EmptyFolder
foreach($file in $EmptyFolder){
    $count += 1
    if(!($count -eq 0)){
        Write-Host "Lege folder - [$file]"
    }
    else{
        Write-Host "Geen lege folders gevonden"
        break
    }
}
if($count -gt 0 ){
    $Choice = Read-Host "Wil je de lege folders verwijderen? Y/N"

    # Als de keuze N is, breek het proces af
    if($Choice -eq "N"){
        Write-Host "Geanuleerd"
    }

    # Als de keuze Y is, verwijder de bestanden
    elseif($Choice -eq "Y"){
        foreach($file in $EmptyFolder){
            $count += 1
            Remove-Item -Recurse "$Path\$EmptyFolder" 
        }

        # Als het variabel $count niet gelijk is aan 1
        if ($count -ne 1){
            Write-Host "$count lege folder verwijderd"
        }

        # Als het het variabel $count wel gelijk is aan 1
        else{
            Write-Host "$count lege folders verwijderd"
        }
    }else{
        Write-Host "Invoer ongeldig"
        break
    }
}

Pause