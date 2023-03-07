[long]$age = Read-Host "Hoe oud bnen je"


if ($age -lt 16){
    Write-Host "Je bent jonger dan 16"
}

elseif($age -lt 25){
    Write-Host "Je bent jonger dan 25"
}

elseif($age -lt 40){
    Write-Host "Je bent jonger dan 40"
}

elseif($age -gt 40){
    Write-Host "Je bent ouder dan 40"
}
else {
    Write-Host "Het moet wel een nummer zijn!"
}