#Skrypt which get back last date of login users to domain

cls

$while = $true
$ADUsers = @()

while($while -eq $true)
{
    Write-Host "Enter the Domain User name or if you want to get information about last login date of all domain users type 'all':  " -NoNewline
    $HMUsers = Read-Host

    $ADUsers = Get-ADUser -Filter * -Properties 'Name', 'LastLogonDate' 

    if($HMUsers -eq 'all')
    {      
        $usersInfo = foreach($item2 in $ADUsers)
        {
            [PSCustomObject]@{
                UserName       = $item2.Name
                LastLogonDate  = if ($item2.LastLogonDate) { $item2.LastLogonDate } else { "N/A" }
            }
        }
        $usersInfo
        $while = $false
        break
    }
    else
    {
        $User = Get-ADUser -Filter "Name -eq '$HMUsers'" -Properties 'Name', 'LastLogonDate'
        if($HMUsers -eq $User.Name)
        {
            'User ' + $User.Name + ' last logon date ' + $User.LastLogonDate
            
            $while = $false
        }    
        else
        {
            Write-Host "You put $HMUsers and it is wrong answer, try again !"
        }
    }
}