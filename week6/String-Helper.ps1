# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>


<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}

function checkPassword(){
param([string]$password)

if ($password.Length -lt 6){
Write-Output "Password is too short. Needs 6 characters."
return $false}

if (-not $password -match "[a-zA-Z]"){
Write-Host "Password needs 1 letter." 
return $false
}
if (-not $password -match "[0-9]"){
Write-Output "Password needs one number"
return $false
}
if(-not $password -match "\W"){
Write-Output "Password needs one special character"
return $false
}
Write-Host "Password passes."
return $true
}
