# ADR-0005: Entwurf und „Veröffentlichen“

- **Status:** Akzeptiert
- **Datum:** 2026-10-09
- **Geltung:** Geplantes Redesign, noch nicht umgesetzt

> **Zukünftiges Vorhaben – noch nicht umgesetzt.** Diese Entscheidung gilt für das geplante
> Client-Server-Redesign. Die aktuelle Entwicklung der bestehenden Anwendung
> (`dienstplan.html`, eine Datei, offline nutzbar) ist davon nicht berührt; für sie gilt
> weiterhin die CLAUDE.md.

## Kontext

Bisher war die Trennung natürlich: Am PC wurde geplant, und erst das PDF ging an die
Mitarbeitenden. Liegen die Daten auf dem Server (ADR-0001), könnte die Leseansicht jeden
Zwischenstand sofort zeigen, auch halbfertige Planungen.

## Entscheidung

- Der Server hält **zwei Stände**: den Arbeitsstand und den veröffentlichten Stand.
- Die Bearbeitung speichert in den Arbeitsstand. Erst der Knopf **„Veröffentlichen“**
  übernimmt ihn als veröffentlichten Stand.
- Die Leseansicht zeigt nur den veröffentlichten Stand.
- Die Bearbeitung weist deutlich darauf hin, wenn es unveröffentlichte Änderungen gibt.

## Betrachtete Alternativen

- **Jede Speicherung ist sofort sichtbar:** Zwischenstände wären für alle sichtbar, und die
  Markierung „geändert“ würde ständig anspringen. Verworfen.
- **Freigabe pro Woche:** Passt zum Planen auf Vorrat, bringt aber mehr Zustände mit sich,
  und Tippfehler in freigegebenen Wochen wären sofort sichtbar. Verworfen.

## Konsequenzen

- Die gewohnte Arbeitsweise bleibt: erst planen, dann gilt es.
- Die Markierung „geändert seit der letzten Veröffentlichung“ (ADR-0002) lässt sich direkt
  aus den beiden Ständen ableiten.
- Das Veröffentlichen kann vergessen werden. Dagegen hilft der Hinweis auf unveröffentlichte
  Änderungen.
- Die Entscheidung gilt unabhängig davon, wie die Leseansicht später aussieht (offener Punkt).
