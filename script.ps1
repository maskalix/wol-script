$MACAddresses = Get-Content "$PSScriptRoot\adresses.txt"
Write-Host "Pripravuji k odeslani..." -ForegroundColor black -BackgroundColor red;
Write-Host "Odesilam:";
Foreach ($MACAddress in $MACAddresses) {
$MacByteArray = $MacAddress -split "[:-]" | ForEach-Object { [Byte] "0x$_"}
[Byte[]] $MagicPacket = (,0xFF * 6) + ($MacByteArray  * 16)
$UdpClient = New-Object System.Net.Sockets.UdpClient
$UdpClient.Connect(([System.Net.IPAddress]::Broadcast),7)
$UdpClient.Send($MagicPacket,$MagicPacket.Length)
$UdpClient.Close()
   }
Write-Host "Zapinaci balicek rozeslan." -ForegroundColor black -BackgroundColor green;
Write-Host "Zmacknete jakekoliv tlacitko pro zavreni...";
sleep 0
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")