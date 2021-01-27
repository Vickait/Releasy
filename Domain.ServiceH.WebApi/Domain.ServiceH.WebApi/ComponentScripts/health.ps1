Param(
	[Parameter(Mandatory=$true)][string]$iisAppName,
	[Parameter(Mandatory=$true)][string]$envname,
	[Parameter(Mandatory=$true)][string]$envType,
	[Parameter(Mandatory=$false)][string]$envId,
	[Parameter(Mandatory=$true)][string]$portNumber
)

Write-Output "Validating site http://localhost`:$portNumber/health/selftest ..."
Invoke-WebRequest -Uri "http://localhost`:$portNumber/health/selftest" -UseBasicParsing