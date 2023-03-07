Write-Host "Rekenmachine`n" 

[long]$num1 = Read-Host "Voer een getal in"
[long]$num2 = Read-Host "Voer nog een getal in"

# Optellen
$plus = $num1 + $num2
Write-Host "`n$num1 + $num2 = $plus"

# Aftrekken
$min = $num1 - $num2
Write-Host "$num1 - $num2 = $min"

# Vermenigvuldigen
$keer = $num1 * $num2
Write-Host "$num1 x $num2 = $keer"

# Delen
$delen = $num1 / $num2
Write-Host "$num1 / $num2 = $delen"

# Kwadraad
$kwadraad = [math]::Pow($num1, $num2)
Write-Host "$num1^$num2 = $kwadraad"