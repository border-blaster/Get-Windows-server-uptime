# Get-Windows-server-uptime

Script checks uptime for one server or all of the servers connected to an AD domain. Just running the script
will query AD for servers, then check them for uptime. The output is a list of servers that are offline (did
not answer a ping) or online, sorted by how long ago it was started. 

To check just one system, enter the name after the script:

> PS C:\scripts> .\Get-ServerUptime.ps1 server1
