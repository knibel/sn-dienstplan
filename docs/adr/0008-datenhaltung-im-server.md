# ADR-0008: Datenhaltung als JSON-Dateien mit Versionsprüfung und Historie

- **Status:** Vorgeschlagen
- **Datum:** 2026-10-09
- **Geltung:** Geplantes Redesign, noch nicht umgesetzt

> **Zukünftiges Vorhaben – noch nicht umgesetzt.** Diese Entscheidung gilt für das geplante
> Client-Server-Redesign. Die aktuelle Entwicklung der bestehenden Anwendung
> (`dienstplan.html`, eine Datei, offline nutzbar) ist davon nicht berührt; für sie gilt
> weiterhin die CLAUDE.md.

## Kontext

Der Server hält den Arbeitsstand und den veröffentlichten Stand (ADR-0005). Die Datenmenge
ist klein (ca. 20 Mitarbeitende, einige Gruppen, Wochenpläne). Im Wesentlichen bearbeitet
eine Person, es können aber zwei Browser-Tabs oder PCs gleichzeitig offen sein.

## Entscheidung (Vorschlag)

- **Speicherform:** Arbeitsstand und veröffentlichter Stand liegen als JSON-Dateien im
  Datenordner. Es gibt keine Datenbank. Dateien werden so geschrieben, dass bei einem Abbruch
  keine halbe Datei entsteht.
- **Gleichzeitiges Bearbeiten:** Jeder Stand trägt eine Versionsnummer. Der Server lehnt eine
  Speicherung ab, die auf einer veralteten Version beruht, und die Bearbeitung zeigt einen
  Hinweis. Änderungen werden nie stillschweigend überschrieben.
- **Historie:** Der Server bewahrt die letzten etwa 30 veröffentlichten Fassungen auf. Damit
  lässt sich ein Fehler am selben Tag zurücknehmen, ohne auf das nächtliche Backup zu warten.
- **Export und Import** als JSON bleiben als Rückfallebene erhalten.

## Konsequenzen

- Die Daten sind direkt lesbar und werden vom NAS-Backup erfasst.
- Wie die Daten aus der bisherigen Anwendung übernommen werden, ist noch offen.
