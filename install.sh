#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# Dienstplan-Installer (Linux)
#
# Wird von update.sh geladen und ausgefuehrt. Diese Datei darf sich jederzeit
# aendern - kommt eine weitere Datei zur Anwendung dazu, genuegt ein Eintrag
# in FILES. Die Nutzer muessen dafuer nichts neu verteilen.
#
# ACHTUNG: Dieselbe Liste steht in install.ps1 (Windows) - dort mitpflegen.
# ---------------------------------------------------------------------------
set -euo pipefail

TARGET_DIR="${1:-}"
if [ -z "$TARGET_DIR" ]; then
  echo "FEHLER: Zielverzeichnis fehlt. Aufruf: install.sh <zielverzeichnis>" >&2
  exit 1
fi

BASE_URL="https://raw.githubusercontent.com/knibel/sn-dienstplan/main"

# Alles, was zur Anwendung gehoert (Dateien im Wurzelverzeichnis des Repos).
# Hier bei Bedarf erweitern.
FILES=(
  "dienstplan.html"
)

echo
echo "Dienstplan aktualisieren in: $TARGET_DIR"
echo

# Erst alles herunterladen, dann erst ersetzen - so bleibt bei einem Abbruch
# mitten im Download die vorhandene Installation heil.
STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT

for file in "${FILES[@]}"; do
  echo "  lade $file ..."
  if ! curl -fsSL -H 'Cache-Control: no-cache' \
       "$BASE_URL/$file?t=$RANDOM$RANDOM" -o "$STAGE/$file"; then
    echo >&2
    echo "FEHLER: $file konnte nicht geladen werden." >&2
    echo "Es wurde nichts veraendert." >&2
    exit 1
  fi
done

for file in "${FILES[@]}"; do
  target="$TARGET_DIR/$file"
  if [ -f "$target" ]; then
    cp -f "$target" "$target.bak"
  fi
  cp -f "$STAGE/$file" "$target"
  echo "  aktualisiert: $file"
done

echo
echo "Fertig. Die gespeicherten Plaene bleiben erhalten."
echo "Die vorherige Version liegt als *.bak daneben."
