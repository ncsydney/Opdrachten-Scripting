$Username = Get-Content Env:USERNAME
$ComputerName = Get-Content Env:Computername
$date = Get-Date -format "dd-MM-yyyy HH:mm:ss"
$filename = Get-Date -Format "MMMM-yyyy"

$IPAddress = Get-NetIPAddress -IPAddress 192.168.*.* | Select-Object -ExpandProperty IPAddress

$IPList= ''
foreach($Add in $IPAddress) {
    $IPList += "$Add, "

}
 $IPs = $IPList.TrimEnd(", ")

$text = "Logoff: $date `nComputer Name: $ComputerName `nIP Address: $IPs`nUsername: $Username `n"
$text | out-file -Append -Filepath "\\Server1\UserLogs\Logoff\$Username.$filename.log"
