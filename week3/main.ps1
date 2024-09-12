. (Join-Path $PSScriptRoot functionsandeventlog.ps1)

clear

$loginoutsTable = customTable -numDays $numDays
$loginoutsTable 

$eventsTable = Get-StartShutdownEvents -numDays $numDays
$eventsTable
