# Architekturentscheidungen (ADR)

Hier halten wir fest, warum die Dienstplan-Anwendung so gebaut ist, wie sie gebaut ist.
Jede Entscheidung steht in einer eigenen Datei und wird nicht nachträglich umgeschrieben.
Ändert sich eine Entscheidung, entsteht ein neues ADR, das das alte ersetzt
(Status des alten: „Ersetzt durch ADR-XXXX“).

Format: Kontext – Entscheidung – Betrachtete Alternativen – Konsequenzen.

## Übersicht

| Nr. | Titel | Status |
|---|---|---|
| [0001](0001-client-server-auf-dem-nas.md) | Client-Server-Architektur mit Server im Docker-Container auf dem NAS | Akzeptiert |
| [0002](0002-aktualisierung-durch-neuladen.md) | Aktualisierung durch regelmäßiges Neuladen statt Live-Events oder Push | Akzeptiert |
| [0003](0003-zielgeraete.md) | Zielgeräte: Kita-Geräte mit modernem Browser, keine privaten Handys | Akzeptiert |
| [0004](0004-zugriffsschutz.md) | Zugriffsschutz mit Lese- und Bearbeitungspasswort, ohne HTTPS | Akzeptiert |
| [0005](0005-entwurf-und-veroeffentlichen.md) | Entwurf und „Veröffentlichen“ | Akzeptiert |
| [0006](0006-deployment-per-image-ueber-vpn.md) | Deployment: Image lokal bauen und per VPN/SSH auf das NAS übertragen | Akzeptiert (unter Vorbehalt) |
| [0007](0007-node-ohne-framework.md) | Server in Node.js ohne Framework | Akzeptiert |
| [0008](0008-datenhaltung-im-server.md) | Datenhaltung als JSON-Dateien mit Versionsprüfung und Historie | Vorgeschlagen |

## Offene Punkte

- **Inhalt der Leseansicht:** Lesemodus der Anwendung oder beim Veröffentlichen erzeugte
  Leseseite? Welcher Zeitraum (z. B. aktuelle und nächste Woche)? Wird mit den
  Mitarbeitenden geklärt.
- **Datenübernahme aus der bisherigen Anwendung:** Wird besprochen, sobald das neue
  Design steht.
- **Freigaben durch den Vorstand:** Betrieb auf dem NAS (laut Admin unbedenklich),
  VPN- und Admin-Zugang für den Entwickler (Voraussetzung für ADR-0006).

## Grundlagen

- Antworten des Kita-Admins vom 05.10.2026 zu NAS, Netz und Tablets
  (Synology DS1019+, DSM 7.3, Docker, 8 GB RAM; nur lokales Netz; tägliches NAS-Backup;
  nur selbstsigniertes Zertifikat; Vorgabe: keine Dienste von Microsoft oder Google).
- Architekturgespräch vom 09.10.2026.
