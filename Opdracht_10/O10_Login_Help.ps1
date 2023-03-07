<#
    .SYNOPSIS
    Schrijft de inlogactiviteit van een gebruiker naar \\Server1\UserLogs\Logon\{name}.{date}.log

    .DESCRIPTION
    Dit script staat op de Domain Controller Server1 en is terug te vinden in het pad 'C:\Scripts\O9_Logon.ps1' of '\\Server1\Scripts\O9_logon.ps1'.
    Bij het inlog proces wordt het script automatisch uitgevoerd en wordt er data naar een log file geschreven.
    De log files zijn terug te vinden in het pad 'C\UserLogs\Logon' of '\\Server1\UserLogs\Logon'
    
    .PARAMETER *
    Dit script maakt geen gebruik van parameters

    .OUTPUTS
    \\Server1\UserLogs\Administrator.Februari-2023.log

    .LINK
    https://github.com/ncsydney/Opdrachten-Scripting

#>

$Username = Get-Content Env:USERNAME
$ComputerName = Get-Content Env:Computername
$date = Get-Date -format "dd-MM-yyyy HH:mm:ss"
$filename = Get-Date -Format "MMMM-yyyy"
$IPAddress = Get-NetIPAddress -IPAddress *.*.*.* | Select-Object -ExpandProperty IPAddress

$str = ''
foreach($Add in $IPAddress) {
    $IPList = $str += "$Add, "

}
    $IPs = $IPList.TrimEnd(", ")

$text = "Login: $date `nComputer Name: $ComputerName `nIP Address: $IPs`nUsername: $Username `n"
$text | out-file -Append -Filepath "\\SERVER1\UserLogs\Logon\$Username.$filename.log"