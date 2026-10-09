# ADR-0007: Server in Node.js ohne Framework

- **Status:** Akzeptiert
- **Datum:** 2026-10-09
- **Geltung:** Geplantes Redesign, noch nicht umgesetzt

> **Zukünftiges Vorhaben – noch nicht umgesetzt.** Diese Entscheidung gilt für das geplante
> Client-Server-Redesign. Die aktuelle Entwicklung der bestehenden Anwendung
> (`dienstplan.html`, eine Datei, offline nutzbar) ist davon nicht berührt; für sie gilt
> weiterhin die CLAUDE.md.

## Kontext

Der Server soll wenig Arbeitsspeicher und Rechenzeit brauchen. Die Last ist sehr gering:
einige Lesegeräte laden alle paar Minuten neu, und eine Person bearbeitet. Das NAS hat
8 GB RAM und einen Intel Celeron mit 4 Kernen. Oberfläche und Tests (Cucumber.js,
Playwright) sind bereits in JavaScript geschrieben.

Gemessen: Ein minimaler Node-20-HTTP-Server braucht im Leerlauf etwa 40 MB Arbeitsspeicher.

## Entscheidung

- Der Server wird in **Node.js** geschrieben, nur mit dem eingebauten `http`-Modul und
  **ohne Framework**.
- Basis-Image ist eine **Alpine-Variante** von Node.
- Im Compose-File werden Obergrenzen für Arbeitsspeicher und Prozessor gesetzt, damit der
  Container andere Dienste auf dem NAS nie stört.
- Die vorhandenen Cucumber-Tests werden um Tests für den Server erweitert.

## Betrachtete Alternativen

- **Go:** Typisch 5–15 MB Arbeitsspeicher und ein Image von etwa 10 MB, also deutlich
  sparsamer. Dafür eine zweite Sprache im Projekt, und Datenmodell bzw. Prüfregeln lassen
  sich nicht mit dem Client teilen. Verworfen, weil der Mehrbedarf von Node auf dem NAS
  nicht ins Gewicht fällt.
- **Python:** Kein Vorteil gegenüber Node, nur eine weitere Sprache. Verworfen.

## Konsequenzen

- Oberfläche, Server und Tests sind in einer Sprache geschrieben.
- Geschätzt 45–60 MB Arbeitsspeicher im Betrieb, also weniger als 1 % des NAS.
- Ohne Framework schreiben wir Routing, Passwortprüfung und Auslieferung von Dateien selbst.
  Bei dem kleinen Umfang ist das überschaubar und vermeidet Abhängigkeiten.
