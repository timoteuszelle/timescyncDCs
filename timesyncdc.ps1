#the select object -index can be skiped, recommended for lager environments for controlled sync.
$DomainName = (Get-ADDomain).DNSRoot
$AllDCs = Get-ADDomainController -Filter * -Server $DomainName | Select-Object name
$Selection = $AllDCs | Select-Object -Index 0,1,2,3,4,5,6,7,8,9
Invoke-Command -ComputerName $Selection.name -ScriptBlock {
w32tm /config /syncfromflags:domhier /update
net stop w32time
net start w32time}
