# ADR-0006: Deployment: Image lokal bauen und per VPN/SSH auf das NAS übertragen

- **Status:** Akzeptiert (unter Vorbehalt der Freigabe durch den Vorstand)
- **Datum:** 2026-10-09

## Kontext

Das NAS hat **keinen Internetzugang**. Ein Image aus einer Registry kann es also nicht
selbst laden, auch kein Basis-Image. Wir gehen davon aus, dass der Entwickler einen
VPN-Zugang zum Kita-Netz und einen Admin-Zugang zum NAS bekommt. Auf einem Synology-NAS
dürfen sich nur Mitglieder der Administratorgruppe per SSH anmelden, und Docker-Befehle
brauchen dort `sudo`.

## Entscheidung

Updates werden mit einem Skript (`deploy.sh`) auf dem Rechner des Entwicklers eingespielt:

1. Tests ausführen.
2. Image lokal bauen; das aktuelle Basis-Image wird dabei aus dem Internet geholt.
3. Image über VPN und SSH auf das NAS übertragen
   (`docker save … | ssh nas docker load`).
4. Container auf dem NAS mit der neuen Version neu starten (`docker compose up -d`).

Die Daten liegen immer in einem Ordner außerhalb des Containers.

## Betrachtete Alternativen

- **Image aus einer Registry (z. B. GitHub Container Registry):** Nicht möglich, weil das NAS
  kein Internet hat. Außerdem gehört GitHub zu Microsoft.
- **Image auf dem NAS bauen:** Braucht ebenfalls ein Basis-Image aus dem Internet und
  Dateikopien bei jedem Update. Verworfen.
- **Fester Container, Anwendungscode in einem NAS-Ordner (Weg 2):** Updates bräuchten nur
  Schreibrecht auf einen Ordner, kein Admin-Recht. Dafür bekäme das Basis-Image nur selten
  Updates. Bleibt die **Rückfallebene**, falls kein Admin-Zugang erteilt wird.

## Konsequenzen

- Server, Anwendung und Laufzeitumgebung bilden eine gemeinsame Version.
- Sicherheits-Updates des Basis-Images kommen mit jedem Deployment mit.
- Ein Rückschritt ist einfach: Die alte Version bleibt als Image auf dem NAS.
- Jedes Deployment setzt VPN und Admin-Zugang voraus. Wird der Admin-Zugang nicht erteilt,
  ersetzt ein neues ADR diese Entscheidung durch Weg 2. Weil die Daten außerhalb des
  Containers liegen, ist der Wechsel dann nur eine andere Konfiguration.
