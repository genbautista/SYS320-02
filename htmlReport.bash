#!/bin/bash
echo "<html>" >> report.html
echo "<h1>Access logs with IOC indicators:</h1>" >> report.html
echo "<body>" >> report.html
echo "<table style='border: 2px solid; '>" >> report.html
while IFS= read -r line; do
echo "<tr>" >> report.html
for content in $line; do
echo "<td style='border: 1px solid; '>$content</td>" >> report.html
done
echo "</tr>" >> report.html
for content in $line;  do
echo "<td style='border: 1px solid; '>$content</td>" >> report.html
done
echo "</tr>" >> report.html
done < report.txt

echo "</table></body></html>" >> report.html
mv report.html /var/www/html/

