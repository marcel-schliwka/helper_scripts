$scriptPath = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

$currentPath = [System.Environment]::GetEnvironmentVariable("PATH", "User")

if ($currentPath -notcontains $scriptPath)
{
    $newPath = $currentPath + ";" + $scriptPath
    [System.Environment]::SetEnvironmentVariable("PATH", $newPath, "User")
    Write-Host "Verzeichnis hinzugefügt: $scriptPath"
}
else
{
    Write-Host "Verzeichnis bereits in PATH enthalten: $scriptPath"
}
