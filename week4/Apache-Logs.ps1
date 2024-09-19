function apacheLogs
{
param
{
    [string]$PageVisited,
    [int]$httpCode,
    [string]$browser
}
$ipAddress = $filteredData | Select-Object -ExcludeProperty IPAddress
return $ipAddress
}
