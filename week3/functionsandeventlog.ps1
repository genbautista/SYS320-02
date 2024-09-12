Get-EventLog system -source Microsoft-Windows-Winlogon

$numDays = Read-Host "Enter the number of days";
function customTable{
param([int]$numDays)

$loginouts = Get-EventLog system -source Microsoft-Windows-Winlogon -After (Get-Date).addDays(-$numDays)
$loginoutsTable = @()
for($i=0; $i -lt $loginouts.Count; $i++){

$event = ""
if($loginouts[$i].InstanceId -eq 7001){$event="Logon"}
if($loginouts[$i].InstanceId -eq 7002){$event="Logoff"}

$user = $loginouts[$i].ReplacementStrings[1]

$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated;`
                                     "Id" = $loginouts[$i].InstanceId;`
                                     "Event" = $event;`
                                     "User" = $user;
                                     }
}
$loginoutsTable

for ($i = 0; $i -lt $loginouts.Count; $i++){
$SID = New-Object System.Security.Principal.SecurityIdentifier($loginoutsTable[$i].User)
$loginoutsTable[$i].User = $SID.Translate([System.Security.Principal.NTAccount])
}
$loginoutsTable
}
customTable($numDays)

function Get-StartShutdownEvents {
param ([int]$numDays)
$events = Get-EventLog system -After (Get-Date).AddDays(-$numDays) | Where-Object { $_.EventID -in 6005, 6006 }
$eventsTable = @()
foreach ($event in $events){
$customEvent = ""
if($event.EventID -eq 6006){$customEvent = "Shutdown"}
if($event.EventID -eq 6005){$customEvent = "Startup"}
$eventsTable += [pscustomobject]@{"Time" = $event.TimeGenerated;`
                                     "Id" = $event.EventId;`
                                     "Event" = $customEvent;`
                                     "User" = "System";
                                     }
}
return $eventsTable
}
Get-StartShutdownEvents -numDays $numDays
