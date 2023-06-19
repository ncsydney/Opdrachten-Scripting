$Username = Get-Content Env:USERNAME
$ComputerName = Get-Content Env:Computername
$date = Get-Date -format "dd-MM-yyyy HH:mm:ss"
$filename = Get-Date -Format "MMMM-yyyy"
$IPAddress = Get-NetIPAddress -IPAddress *.*.*.* | Select-Object -ExpandProperty IPAddress

$IPList = ''
foreach($Add in $IPAddress) {
    $IPList += "$Add, "

}
    $IPs = $IPList.TrimEnd(", ")

$text = "Login: $date `nComputer Name: $ComputerName `nIP Address: $IPs`nUsername: $Username `n"
$text | out-file -Append -Filepath "\\SERVER1\UserLogs\Logon\$Username.$filename.log"

"Hallo " + $Computername
