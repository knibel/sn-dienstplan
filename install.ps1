# ---------------------------------------------------------------------------
# Dienstplan-Installer
#
# Wird von update.cmd geladen und ausgefuehrt. Diese Datei darf sich jederzeit
# aendern - kommt eine weitere Datei zur Anwendung dazu, genuegt ein Eintrag
# in $Files. Die Nutzer muessen dafuer nichts neu verteilen.
#
# ACHTUNG: Dieselbe Liste steht in install.sh (Linux) - dort mitpflegen.
# ---------------------------------------------------------------------------

param(
    [Parameter(Mandatory = $true)]
    [string]$TargetDir
)

$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

# Aeltere update.cmd-Versionen uebergaben "%~dp0" mit Backslash am Ende - dann
# landet ein Anfuehrungszeichen im Pfad. Hier robust wegputzen, damit auch
# nicht aktualisierte Bootstrap-Dateien weiter funktionieren.
$TargetDir = $TargetDir.Trim().Trim('"').TrimEnd('\')
if ($TargetDir -match '^[A-Za-z]:$') { $TargetDir += '\' }

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$BaseUrl = 'https://raw.githubusercontent.com/knibel/sn-dienstplan/main'

# Alles, was zur Anwendung gehoert. Hier bei Bedarf erweitern.
$Files = @(
    'dienstplan.html'
)

Write-Host ''
Write-Host "Dienstplan aktualisieren in: $TargetDir"
Write-Host ''

# Erst alles herunterladen, dann erst ersetzen - so bleibt bei einem Abbruch
# mitten im Download die vorhandene Installation heil.
$StageDir = Join-Path $env:TEMP ("sn-dienstplan-" + [Guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $StageDir | Out-Null

try {
    foreach ($file in $Files) {
        Write-Host "  lade $file ..."
        $url = "$BaseUrl/$file" + '?t=' + [Guid]::NewGuid().ToString('N')
        Invoke-WebRequest -Uri $url -Headers @{ 'Cache-Control' = 'no-cache' } `
                          -OutFile (Join-Path $StageDir $file)
    }

    foreach ($file in $Files) {
        $target = Join-Path $TargetDir $file
        if (Test-Path $target) {
            Copy-Item $target "$target.bak" -Force
        }
        Copy-Item (Join-Path $StageDir $file) $target -Force
        Write-Host "  aktualisiert: $file"
    }

    Write-Host ''
    Write-Host 'Fertig. Die gespeicherten Plaene bleiben erhalten.'
    Write-Host 'Die vorherige Version liegt als *.bak daneben.'
    exit 0
}
catch {
    Write-Host ''
    Write-Host "FEHLER: $($_.Exception.Message)"
    Write-Host 'Es wurde nichts veraendert.'
    exit 1
}
finally {
    Remove-Item $StageDir -Recurse -Force -ErrorAction SilentlyContinue
}
