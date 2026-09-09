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

  Szenario: Aktivität an Info Kita hängen und wieder entfernen
    Wenn ich die Aktivität "Fußball spielen" in die Notizfläche "Info Kita" ziehe
    Dann hängt die Aktivität "Fußball spielen" an der Notizfläche "Info Kita"
    Wenn ich die Aktivität "Fußball spielen" aus der Notizfläche "Info Kita" entferne
    Dann hängt die Aktivität "Fußball spielen" nicht an der Notizfläche "Info Kita"

  Szenario: Eintrag an Info Tag hängen und wieder entfernen
    Wenn ich den Eintrag "Fotograf" in die Notizfläche "Info Tag" ziehe
    Dann hängt der Eintrag "Fotograf" an der Notizfläche "Info Tag"
    Wenn ich den Eintrag "Fotograf" aus der Notizfläche "Info Tag" entferne
    Dann hängt der Eintrag "Fotograf" nicht an der Notizfläche "Info Tag"

  Szenario: Aktivität an den Kommentar einer Gruppe hängen und wieder entfernen
    Wenn ich die Aktivität "Turnen" in die Notizfläche der Gruppe "Mond" ziehe
    Dann hängt die Aktivität "Turnen" an der Notizfläche der Gruppe "Mond"
    Und hängt die Aktivität "Turnen" nicht an der Notizfläche der Gruppe "Sonne"
    Wenn ich die Aktivität "Turnen" aus der Notizfläche der Gruppe "Mond" entferne
    Dann hängt die Aktivität "Turnen" nicht an der Notizfläche der Gruppe "Mond"

  Szenario: Notiz neben dem Freitext bleibt erhalten
    Wenn ich die Aktivität "Elterncafé" in die Notizfläche "Info Tag" ziehe
    Und ich als Info Tag "Ausflug Zoo" eintrage
    Dann hängt die Aktivität "Elterncafé" an der Notizfläche "Info Tag"
    Und enthält das Feld Info Tag "Ausflug Zoo"

  Szenario: Notiz bleibt beim Tageswechsel am jeweiligen Tag
    Wenn ich die Aktivität "Turnen" in die Notizfläche "Info Tag" ziehe
    Und ich den Tag "Dienstag" wähle
    Dann hängt die Aktivität "Turnen" nicht an der Notizfläche "Info Tag"
    Wenn ich den Tag "Montag" wähle
    Dann hängt die Aktivität "Turnen" an der Notizfläche "Info Tag"

  Szenario: Info Kita gilt für die ganze Woche
    Wenn ich die Aktivität "Turnen" in die Notizfläche "Info Kita" ziehe
    Und ich den Tag "Mittwoch" wähle
    Dann hängt die Aktivität "Turnen" an der Notizfläche "Info Kita"

  Szenario: Ziehen ins Freitextfeld landet in der Notizfläche
    Wenn ich die Aktivität "Turnen" auf das Freitextfeld "Info Tag" ziehe
    Dann hängt die Aktivität "Turnen" an der Notizfläche "Info Tag"
    Und enthält das Feld Info Tag nicht "Turnen"

  Szenario: Ziehen ins Kommentarfeld landet in der Notizfläche
    Wenn ich den Eintrag "Fotograf" auf das Kommentarfeld der Gruppe "Sonne" ziehe
    Dann hängt der Eintrag "Fotograf" an der Notizfläche der Gruppe "Sonne"
    Und enthält der Kommentar der Gruppe "Sonne" nicht "Fotograf"

  Szenario: An ein Info-Feld gehängte Aktivität kann nicht gelöscht werden
    Wenn ich die Aktivität "Elterncafé" in die Notizfläche "Info Kita" ziehe
    Und ich den Aktivitäten-Dialog öffne
    Und ich versuche die Aktivität "Elterncafé" zu löschen
    Dann erscheint eine Meldung die "kann nicht gelöscht werden" enthält
    Und sehe ich im Aktivitäten-Dialog die Aktivität "Elterncafé"
