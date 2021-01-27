Param(
	[Parameter(Mandatory=$true)][string]$sqlServerIp,
	[Parameter(Mandatory=$true)][string]$destDir,
	[Parameter(Mandatory=$true)][string]$iisAppName,
	[Parameter(Mandatory=$true)][string]$envname,
	[Parameter(Mandatory=$true)][string]$envType,
	[Parameter(Mandatory=$false)][string]$envId,
	[Parameter(Mandatory=$true)][string]$portNumber,
	[Parameter(Mandatory=$true)][string]$iisWebSiteName,
	[Parameter(Mandatory=$true)][string]$linuxIp,
	[Parameter(Mandatory=$true)][string]$packageName
)

. "$env:ModulesPath\envConfig.ps1"

$Invocation = (Get-Variable MyInvocation -Scope 0).Value
$executionRoot = Split-Path -Parent $Invocation.MyCommand.Definition

$envFilePath = ".\env-$envName$envId.ps1"
if (Test-Path $envFilePath){
	. "$envFilePath"
}

$siteEnvId=""
$envKeyPrefix=""

if($envType -ne "prod"){
	$siteEnvId = "-$envId"
	$envKeyPrefix="$envName$envId/"
}

#Tokenizing....
Write-Output "Tokenizing config.... "

$dynamicVariables = @"
__TEST_NAME__=$TestName
__TEST_TOKEN__=$TestToken
__GLOBAL_TEST_NAME__=$GlobalTestName
__GLOBAL_TEST_TOKEN__=$GlobalTestToken
"@

Write-Output "path for tokenizing: $executionRoot"
& "$env:ModulesPath\tokenize.ps1" -destDir "$executionRoot\..\" -dynamicVariables $dynamicVariables -fileNamePattern "*.SetParameters.xml"

#IIS
Write-Output "Creating IIS site..."
& "$env:ModulesPath\iisPublish.ps1" -destDir $destDir -portNumber $portNumber -iisWebSiteName $iisWebSiteName -packageName $packageName

Write-Output "Completed Successfully"
#Stop-Transcript