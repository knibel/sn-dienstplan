# ADR-0001: Client-Server-Architektur mit Server im Docker-Container auf dem NAS

- **Status:** Akzeptiert
- **Datum:** 2026-10-09

## Kontext

Der Dienstplan ist heute eine einzelne HTML-Datei, die offline in Firefox auf einem
Windows-11-PC läuft. Die Daten liegen im `localStorage` dieses Browsers bzw. in
exportierten JSON-Dateien. Updates der Anwendung kommen über `update.cmd` von GitHub.

Künftig sollen alle Mitarbeitenden (ca. 20) den aktuellen Plan auf Geräten in der Kita
lesen können. Gepflegt wird er im Wesentlichen von einer Person an einem PC in der Kita,
der im selben lokalen Netz wie das NAS steht.

In der Kita läuft ein Synology DS1019+ (DSM 7.3, Docker, 8 GB RAM) rund um die Uhr. Es ist
nur im lokalen Netz erreichbar, hat keinen Internetzugang und wird täglich auf ein zweites
NAS gesichert. Der Admin hat keine Bedenken gegen einen kleinen Webdienst in Docker.

## Entscheidung

- Ein eigener kleiner Server läuft in einem Docker-Container auf dem NAS.
- Der Server liefert **sowohl die Bearbeitungs- als auch die Leseansicht** aus. Updates
  der Anwendung werden damit nur noch an einer Stelle eingespielt, nämlich im Container.
- Der Server hält die **maßgeblichen Daten** in einem Datenordner außerhalb des Containers.
  Dieser liegt im Bereich des täglichen NAS-Backups.
- Bearbeitet wird an einem PC in der Kita. Ein Zugriff aus dem Internet ist nicht vorgesehen.
- Mit Beginn des Redesigns entfallen die bisherigen Vorgaben „genau eine Datei“ und
  „offline nutzbar“. Die CLAUDE.md wird erst dann angepasst; bis dahin gilt sie für die
  bestehende Anwendung weiter.

## Betrachtete Alternativen

- **Anwendung vom NAS, Daten weiter im Browser des PCs:** Ohne NAS geht trotzdem nichts,
  und die Daten liegen ungesichert auf einem einzelnen PC. Verworfen.
- **Bearbeitung bleibt lokale Datei, nur die Leseansicht kommt vom NAS:** Die Bearbeitung
  bliebe offline nutzbar, aber es gäbe weiter zwei Update-Wege (`update.cmd` und Container).
  Verworfen.
- **Kein eigener Server, nur Dateien über Synology Web Station und WebDAV:** Firefox kann aus
  einer lokalen Datei nicht direkt in einen Ordner schreiben, und WebDAV sendet keine
  CORS-Header für Uploads aus dem Browser. „Veröffentlichen“ wäre nur mit Handarbeit
  möglich. Verworfen.
- **Raspberry Pi 3b als Server:** Ist vorhanden, aber weniger zuverlässig (SD-Karte) und
  nicht im NAS-Backup. Bleibt Rückfallebene.

## Konsequenzen

- Ist das NAS nicht erreichbar, kann weder bearbeitet noch gelesen werden. Das halten wir
  für vertretbar: Das NAS läuft rund um die Uhr im selben Gebäude, und ein Internetausfall
  stört nicht.
- Ohne HTTPS gibt es keinen Service Worker und damit keinen Offline-Zwischenspeicher
  (siehe ADR-0004).
- Die Daten werden automatisch vom NAS-Backup erfasst. Der JSON-Export bzw. -Import bleibt
  als Rückfallebene erhalten.
- `update.cmd`, `install.ps1` und `install.sh` werden für die neue Architektur nicht mehr
  gebraucht.
