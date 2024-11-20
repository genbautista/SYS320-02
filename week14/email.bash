 echo "To: genesis.bautistasanc@mymail.champlain.edu" > emailform.txt
 echo "Subject:Security Incident" >> emailform.txt
 echo "Test" >> emailform.txt
 cat emailform.txt | ssmtp genesis.bautistasanc@mymail.champlain.edu

