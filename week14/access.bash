echo "File was accessed on $(date)" >> fileaccesslog.txt

echo "To: genesis.bautistasanc@mymail.champlain.edu" > emailform-2.txt
echo "Subject: File Access" >> emailform-2.txt
cat fileaccesslog.txt >> emailform-2.txt
cat emailform-2.txt | ssmtp genesis.bautistasanc@mymail.champlain.edu
