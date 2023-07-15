$apiUrl = "http://localhost:3000/computerinfo"
$response = Invoke-RestMethod -Uri $apiUrl -Method Get
$computerName = $response.ComputerName
$operatingSystem = $response.OS
$domain = $response.Domain
$internalIP = $response.InternalIP
$processor = $response.Processor
$totalRAM = $response.TotalRAM

Write-Output "Computer Name: $computerName"
Write-Output "Operating System: $operatingSystem"
Write-Output "Domain: $domain"
Write-Output "Internal IP: $internalIP"
Write-Output "Processor: $processor"
Write-Output "Total RAM: $totalRAM GB"