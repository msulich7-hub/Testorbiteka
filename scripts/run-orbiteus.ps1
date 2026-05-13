#Requires -Version 5.1
<#
  Uruchamia Orbiteusa (Docker) w katalogu obok Testorbiteki: ..\orbiteus
  Uruchom w PowerShellu z katalogu repo lub dowolnie: .\scripts\run-orbiteus.ps1
#>
$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Split-Path -Parent $ScriptDir
$ParentRoot = Split-Path -Parent $RepoRoot
$OrbiteusDir = Join-Path $ParentRoot "orbiteus"
$OrbiteusUrl = if ($env:ORBITEUS_URL) { $env:ORBITEUS_URL } else { "https://github.com/orbiteus/orbiteus.git" }

function Test-Command($Name) {
  return [bool](Get-Command $Name -ErrorAction SilentlyContinue)
}

if (-not (Test-Command "git")) {
  Write-Error "Brak git. Zainstaluj Git for Windows: https://git-scm.com/download/win"
}

$compose = $null
if (Test-Command "docker") {
  try {
    docker compose version 2>$null | Out-Null
    if ($LASTEXITCODE -eq 0) { $compose = "docker compose" }
  } catch { }
}
if (-not $compose) {
  Write-Error "Brak 'docker compose'. Zainstaluj Docker Desktop: https://docs.docker.com/desktop/"
}

if (Test-Path $OrbiteusDir) {
  if (-not (Test-Path (Join-Path $OrbiteusDir ".git"))) {
    Write-Error "Katalog istnieje, ale to nie jest repo git — usuń lub zmień: $OrbiteusDir"
  }
} else {
  Write-Host "Klonuję Orbiteus do: $OrbiteusDir"
  git clone $OrbiteusUrl $OrbiteusDir
}

Push-Location $OrbiteusDir
try {
  if (-not (Test-Path ".env")) {
    if (Test-Path ".env.example") {
      Copy-Item ".env.example" ".env"
      Write-Host "Utworzono .env z .env.example — przed produkcją zmień SECRET_KEY i hasła."
    }
  }
  Write-Host "Start (pierwszy raz może potrwać kilka minut)..."
  docker compose up --build
} finally {
  Pop-Location
}
