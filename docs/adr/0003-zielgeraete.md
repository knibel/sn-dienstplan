# ADR-0003: Zielgeräte: Kita-Geräte mit modernem Browser, keine privaten Handys

- **Status:** Akzeptiert
- **Datum:** 2026-10-09
- **Geltung:** Geplantes Redesign, noch nicht umgesetzt

> **Zukünftiges Vorhaben – noch nicht umgesetzt.** Diese Entscheidung gilt für das geplante
> Client-Server-Redesign. Die aktuelle Entwicklung der bestehenden Anwendung
> (`dienstplan.html`, eine Datei, offline nutzbar) ist davon nicht berührt; für sie gilt
> weiterhin die CLAUDE.md.

## Kontext

Für die Leseansicht sind Tablets pro Gruppe geplant (Samsung Tab A11+). Vorhanden sind ein
altes iPad und ein Samsung Tab S3. Wo die Geräte stehen und ob sie fest angebracht sind,
entscheidet die Kita; für die Entwicklung spielt das keine Rolle.

## Entscheidung

- Die Leseansicht ist für **Kita-Geräte** gedacht (Tablets, PC oder Bildschirm), nicht für
  private Handys der Mitarbeitenden.
- Unterstützt werden **aktuelle Browser**. Für sehr alte Geräte (z. B. das alte iPad)
  treffen wir keine besonderen Vorkehrungen.
- Eine Optimierung für kleine Handybildschirme ist nicht nötig.

## Konsequenzen

- „Keine privaten Handys“ ist eine organisatorische Vorgabe. Technisch kann jedes Gerät im
  Kita-Netz die Adresse öffnen. Durchgesetzt wird die Vorgabe über das Lesepasswort
  (ADR-0004).
- Damit die Anzeige zuverlässig funktioniert, sollten die Geräte dauerhaft Strom haben.
  Das ist Aufgabe der Kita, nicht der Anwendung.
