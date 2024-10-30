#!bin/bash

allLogs=""
file="/var/log/apache2/access.log"

function getAllLogs(){
allLogs=$(cat "$file" | cut -d' ' -f1,7 | tr -d "[")
}

function ips(){
ipsAccessed=$(echo "$allLogs" | cut -d' ' -f1)
}

function pageCount(){
counts=$(cut -d' ' -f7 "$file" | sort | uniq -c | sort -nr)
}

function countingCurlAccess(){
curlCounts=$(grep "curl" "$file" | cut -d' ' -f1 | sort | uniq -c)
}

getAllLogs
ips
pageCount
countingCurlAccess
echo "$curlCounts"


