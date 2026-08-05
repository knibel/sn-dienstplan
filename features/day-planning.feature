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
      | Gruppe                 |
      | Mäuse                  |
      | Hasen                  |
      | Mäuschen               |
      | Häschen                |
      | Springer               |
      | Praktikanten/-innen    |
      | Leitung                |
    Und sehe ich die Schichtspalten:
      | Schicht       |
      | Frühschicht   |
      | Mittelschicht |
      | Spätschicht   |

  Szenario: Geladenes Personal ist eingeteilt
    Dann ist "Gül" in Gruppe "Mäuse" und Schicht "Frühschicht" eingeteilt
    Und ist "Vivien" in Gruppe "Mäuse" und Schicht "Spätschicht" eingeteilt
    Und ist "Daniel" in Gruppe "Hasen" und Schicht "Frühschicht" eingeteilt
    Und der Pool zeigt "Alle eingeteilt."

  Szenario: Person per Dialog in andere Schicht verschieben
    Wenn ich den Chip "Gül" öffne
    Und ich im Chip-Dialog die Schicht "Mittelschicht" wähle
    Und ich den Chip-Dialog mit "Übernehmen" bestätige
    Dann ist "Gül" in Gruppe "Mäuse" und Schicht "Mittelschicht" eingeteilt
    Und ist "Gül" nicht in Gruppe "Mäuse" und Schicht "Frühschicht" eingeteilt

  Szenario: Person als abwesend (krank) markieren
    Wenn ich den Chip "Barbara" öffne
    Und ich im Chip-Dialog die Abwesenheit "krank" wähle
    Und ich den Chip-Dialog mit "Übernehmen" bestätige
    Dann ist der Chip "Barbara" als "krank" markiert

  Szenario: Person aus dem Plan nehmen
    Wenn ich den Chip "Birgit" öffne
    Und ich den Chip-Dialog mit "Aus Plan nehmen" bestätige
    Dann ist "Birgit" nicht eingeteilt
    Und erscheint "Birgit" im Pool

  Szenario: Gasteinsatz in anderer Gruppe
    Wenn ich den Chip "Gül" öffne
    Und ich im Chip-Dialog die Gruppe "Hasen" wähle
    Und ich den Chip-Dialog mit "Übernehmen" bestätige
    Dann ist "Gül" in Gruppe "Hasen" und Schicht "Frühschicht" eingeteilt
    Und ist der Chip "Gül" als Gasteinsatz markiert

  Szenario: Gruppe-Kommentar erfassen
    Wenn ich für die Gruppe "Mäuse" den Kommentar "Bringdienst beachten" eintrage
    Dann enthält der Kommentar der Gruppe "Mäuse" "Bringdienst beachten"
