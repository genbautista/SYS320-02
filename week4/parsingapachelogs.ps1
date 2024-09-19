function ApacheLogs1(){
$logsNotFormatted = Get-Content -Path C:\xampp\apache\logs\access.log
$tableRecords = @()

for($i= 0; $i -lt $logsNotFormatted.count; $i++){
$words = $logsNotFormatted[$i].split(" ");
$tableRecords += [pscustomobject]@{ "IP" = $words[0];
                                    "Time" = $words[3].Trim('[');
                                    "Method" = $words[5].Trim('[');
                                    "Page" = $words[6];
                                    "Protocol" = $words[7];
                                    "Response" = $words[8];
                                    "Referrer" = $words[9];
                                    "Client" = $words[11..($words.count -1)];}
}
return $tableRecords | Where-Object { $_.IP -ilike "10.*" }
}
$tableRecords = ApacheLogs1
$tableRecords | Format-Table -AutoSize -Wrap
