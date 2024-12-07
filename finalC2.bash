#! /bin/bash
logfile="$1"
iocfile="$2"
cat "$logfile" | egrep -i -f "$iocfile" | cut -d' ' -f1,4,7 | tr -d '[' > report.txt
