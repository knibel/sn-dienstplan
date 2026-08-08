#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# Dienstplan-Updater (Bootstrap, Linux)
#
# Diese Datei liegt neben der dienstplan.html und aendert sich praktisch nie.
# Sie holt nur das aktuelle Installer-Skript von GitHub und startet es.
# Was genau installiert wird (eine Datei oder mehrere), steht im Installer.
# ---------------------------------------------------------------------------
set -euo pipefail

BASE_URL="https://raw.githubusercontent.com/knibel/sn-dienstplan/main"
TARGET_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"

if ! command -v curl >/dev/null 2>&1; then
  echo "FEHLER: curl ist nicht installiert (z.B. 'sudo apt install curl')." >&2
  exit 1
fi

INSTALLER="$(mktemp)"
trap 'rm -f "$INSTALLER"' EXIT

echo "Lade Installer..."
if ! curl -fsSL -H 'Cache-Control: no-cache' \
     "$BASE_URL/install.sh?t=$RANDOM$RANDOM" -o "$INSTALLER"; then
  echo >&2
  echo "FEHLER: Installer konnte nicht geladen werden. Besteht eine Internetverbindung?" >&2
  exit 1
fi

bash "$INSTALLER" "$TARGET_DIR"
