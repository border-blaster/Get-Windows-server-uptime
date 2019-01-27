### Get-ServerUptime
### github.com/border-blaster
### v2019-01-27


## Input
$getcompies=$args[0]

if ($getcompies -eq $null) {
    #No input came in, grabbing all of the comptuers with an OS that looks like a server
    #Consider using -searchbase here to limit which servers you are checking. 
    $compies = Get-ADComputer -Properties * -Filter 'OperatingSystem -like "*server*"'
    }
    Else {
    #Yep, assume there is a computer name in the input
    $compies = Get-ADComputer -Identity $getcompies -Properties *
    }


Write-Host $compies.count

$ONCompies = @()
$OFFCompies = @("name")

foreach ($comp in $compies) {
    
    # Before checking the uptime, check that it is even on - with a ping.
    if (Test-Connection $comp.name -Quiet) {
        
        $LastBoot = gwmi win32_operatingsystem -ComputerName $comp.name | %{ $_.ConvertToDateTime($_.LastBootUpTime) }
        $RunningUptime = ($LastBoot - (get-date))

        $ONCompies += @([PSCustomObject]@{Name = $comp.Name;  LastBoot = $LastBoot; RunnnigUptime = $RunningUptime})

    } Else {$offcompies+=$comp}
 }


Write-host "Hosts that may be offline"
Write-Host $offcompies.name

Write-host "Hosts sorted by time running"
$ONCompies | sort-object RunnnigUptime
