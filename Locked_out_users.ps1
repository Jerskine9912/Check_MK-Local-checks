import-module ActiveDirectory

$Global:locked_users = ""
$Global:Locked_total = ""
$Global:status_code = ""
$Global:des = ""

function Locked_accounts {

$global:locked_users = Get-ADUser -filter * -Properties LockedOut | Where-Object -Property LockedOut -eq 1 | select -exp name
$global:Locked_total = Get-ADUser -filter * -Properties LockedOut | Where-Object -Property LockedOut -eq 1 | measure | select -exp count

}

function Alert {

    if ($global:locked_total -gt 0) {
    $global:status_code = "2"
    $global:desc = "There are $Locked_total users currently loccked out they are $global:locked_users"
    }
    else {
    $global:status_code = "0"
    $global:desc = "No users currently locked out"
    }
}


locked_accounts 
Alert
Write-output "$status_code User_LockOut Locked_Out_Total=$Locked_total $desc"