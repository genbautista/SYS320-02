Get-Content C:\xampp\apache\logs\access.log ip
Get-Content C:\xampp\apache\logs\access.log -Last 5
Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 ',' 400 '
Get-Content C:\xampp\apache\logs\access.log | Select-String ' 200 ' -NotMatch

$A = Get-ChildItem C:\xampp\apache\logs\*.log | Select-String -AllMatches 'error'
$A[-5..-1]

$notfounds = Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 '
$regex = [regex] "(\b25[0-5]|\b2[0-4][0-9]|\b[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}"
$ipsUnorganized = $regex.Matches($notfounds)

$ips = @()
for($i=0; $i -lt $ipsUnorganized.Count; $i++){
$ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].Value; }
}
$ips | Where-Object { $_.IP -ilike "10.*" }

$ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }
$counts = $ipsoftens | group IP
$counts | Select-Object Count, Name
