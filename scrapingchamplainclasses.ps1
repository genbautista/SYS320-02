function gatherClasses(){
$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.7/Courses-1.html

$trs=$page.ParsedHTML.body.getElementsByTagName("tr")

$FullTable = @()
for($i=1; $i -lt $trs.length; $i++){
    $tds = $trs[$i].getElementsByTagName("td")
    $Times = $tds[5].innerText.split("-")
    $FullTable += [pscustomobject]@{"Class Code" = $tds[0].innerText; `
                                    "Title"      = $tds[1].innerText; `
                                    "Days"       = $tds[4].innerText; `
                                    "Time Start" = $Times[0]; `
                                    "Time End"   = $Times[1]; `
                                    "Instructor"  = $tds[6].innerText; `
                                    "Location"   = $tds[9].innerText; `
                                    }
}
return $FullTable
}

#function for scrapingOthers.ps1

function daysTranslator($FullTable){
for ($i=0; $i -lt $FullTable.length; $i++){
$Days=@()
if($FullTable[$i].Days -ilike "*M*") { $Days += "Monday" }
if($FullTable[$i].Days -ilike "*T[TWF]*") { $Days += "Tuesday" }
ElseIf($FullTable[$i].Days -ilike "*T*") { $Days += "Tuesday" }
if($FullTable[$i].Days -ilike "*W*") { $Days += "Wednesday" }
if($FullTable[$i].Days -ilike "*TH*") { $Days += "Thursday" }
if($FullTable[$i].Days -ilike "*F*") { $Days += "Friday" }
$FullTable[$i].Days = $Days
}
return $FullTable
}

$FullTable = daysTranslator(gatherClasses)

ending for function of scrapingOthers

$FullTable | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End" | `
             where { $_."Instructor" -ilike "Furkan Paligu" }

$FullTable | Where-Object { ($_.Location -ilike "JOYC 310") -and ($_.Days -contains "Monday") } | `
             Sort-Object "Time Start" | `
             Select-Object "Time Start", "Time End", "Class Code"

$ITSInstructors = $FullTable | Where-Object { ($_. "Class Code" -ilike "SYS*") -or `
                                              ($_. "Class Code" -ilike "SEC*") -or `
                                              ($_. "Class Code" -ilike "NET*") -or `
                                              ($_. "Class Code" -ilike "FOR*") -or `
                                              ($_. "Class Code" -ilike "CSI*") -or `
                                              ($_. "Class Code" -ilike "DAT*") } `
                             | Select-Object "Instructor" `
                             | Sort-Object "Instructor" -Unique
$ITSInstructors

$FullTable | where { $_.Instructor -in $ITSInstructors.Instructor } `
           | Group-Object "Instructor" | Select-Object Count, Name| Sort-Object Count -Descending
