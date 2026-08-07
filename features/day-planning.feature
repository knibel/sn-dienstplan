# language: de
Funktionalität: Tagesplanung
  Als Planerin möchte ich Modus und Infos eines Tages pflegen
  und Personen einer Schicht und Gruppe zuordnen.

  Grundlage:
    Angenommen die Dienstplan-App ist geöffnet

  Szenario: Standardmäßig Normalbetrieb
    Dann ist der Tagesmodus "Normalbetrieb"

  Szenario: Tag auf Schließung setzen
    Wenn ich den Tagesmodus auf "Schließung" setze
    Dann ist der Tagesmodus "Schließung"

  Szenario: Info Tag und Info Kita speichern
    Wenn ich als Info Tag "Ausflug Zoo" eintrage
    Und ich als Info Kita "Elternabend 18 Uhr" eintrage
    Dann enthält das Feld Info Tag "Ausflug Zoo"
    Und enthält das Feld Info Kita "Elternabend 18 Uhr"

  Szenario: Gruppenraster mit Schichten wird angezeigt
    Dann sehe ich die Gruppen:
      | Gruppe              |
      | Sonne               |
      | Mond                |
      | Sterne              |
      | Wolken              |
      | Springer            |
      | Praktikanten/-innen |
      | Leitung             |
    Und sehe ich die Schichtspalten:
      | Schicht       |
      | Frühschicht   |
      | Mittelschicht |
      | Spätschicht   |

  Szenario: Geladenes Personal ist eingeteilt
    Dann ist "Bernd" in Gruppe "Sonne" und Schicht "Frühschicht" eingeteilt
    Und ist "Anna" in Gruppe "Sonne" und Schicht "Spätschicht" eingeteilt
    Und ist "Frieda" in Gruppe "Mond" und Schicht "Frühschicht" eingeteilt
    Und der Pool zeigt "Alle eingeteilt."

  Szenario: Person per Dialog in andere Schicht verschieben
    Wenn ich den Chip "Bernd" öffne
    Und ich im Chip-Dialog die Schicht "Mittelschicht" wähle
    Und ich den Chip-Dialog mit "Übernehmen" bestätige
    Dann ist "Bernd" in Gruppe "Sonne" und Schicht "Mittelschicht" eingeteilt
    Und ist "Bernd" nicht in Gruppe "Sonne" und Schicht "Frühschicht" eingeteilt

  Szenario: Person als abwesend (krank) markieren
    Wenn ich den Chip "Erik" öffne
    Und ich im Chip-Dialog die Abwesenheit "krank" wähle
    Und ich den Chip-Dialog mit "Übernehmen" bestätige
    Dann ist der Chip "Erik" als "krank" markiert

  Szenario: Person aus dem Plan nehmen
    Wenn ich den Chip "Mirjam" öffne
    Und ich den Chip-Dialog mit "Aus Plan nehmen" bestätige
    Dann ist "Mirjam" nicht eingeteilt
    Und erscheint "Mirjam" im Pool

  Szenario: Gasteinsatz in anderer Gruppe
    Wenn ich den Chip "Bernd" öffne
    Und ich im Chip-Dialog die Gruppe "Mond" wähle
    Und ich den Chip-Dialog mit "Übernehmen" bestätige
    Dann ist "Bernd" in Gruppe "Mond" und Schicht "Frühschicht" eingeteilt
    Und ist der Chip "Bernd" als Gasteinsatz markiert

  Szenario: Gruppe-Kommentar erfassen
    Wenn ich für die Gruppe "Sonne" den Kommentar "Bringdienst beachten" eintrage
    Dann enthält der Kommentar der Gruppe "Sonne" "Bringdienst beachten"
