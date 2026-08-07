# language: de
Funktionalität: Sonstiges
  Als Planerin möchte ich neben Aktivitäten auch sonstige Einträge mit Icon anlegen
  und sie wie Personal in den Plan ziehen.

  Grundlage:
    Angenommen die Dienstplan-App ist geöffnet

  Szenario: Sonstiges-Dialog öffnen und geladene Einträge sehen
    Wenn ich den Sonstiges-Dialog öffne
    Dann sehe ich im Sonstiges-Dialog den Eintrag "Sommerfest"
    Und sehe ich im Sonstiges-Dialog den Eintrag "Weihnachtsfeier"
    Und hat der Eintrag "Weihnachtsfeier" das Icon "🎄"

  Szenario: Neuen Eintrag mit gewähltem Icon anlegen
    Wenn ich den Sonstiges-Dialog öffne
    Und ich einen neuen Eintrag "Sternenwanderung" mit Icon "🌠" hinzufüge
    Dann hat der Eintrag "Sternenwanderung" das Icon "🌠"
    Wenn ich den Sonstiges-Dialog schließe
    Dann erscheint der Eintrag "Sternenwanderung" im Sonstiges-Pool

  Szenario: Icon eines Eintrags nachträglich ändern
    Wenn ich den Sonstiges-Dialog öffne
    Und ich das Icon des Eintrags "Sommerfest" auf "🌻" setze
    Dann hat der Eintrag "Sommerfest" das Icon "🌻"
    Wenn ich den Sonstiges-Dialog schließe
    Dann zeigt der Eintrag "Sommerfest" im Sonstiges-Pool das Icon "🌻"

  Szenario: Leerer Name wird abgelehnt
    Wenn ich den Sonstiges-Dialog öffne
    Und ich versuche einen Eintrag ohne Namen hinzuzufügen
    Dann erscheint eine Meldung die "Bitte einen Namen eingeben" enthält

  Szenario: Doppelter Name wird abgelehnt
    Wenn ich den Sonstiges-Dialog öffne
    Und ich versuche den Eintrag "Weihnachtsfeier" erneut hinzuzufügen
    Dann erscheint eine Meldung die "bereits" enthält
    Und sehe ich im Sonstiges-Dialog den Eintrag "Weihnachtsfeier"

  Szenario: Aktivitäten und Sonstiges sind getrennte Kataloge
    Wenn ich den Sonstiges-Dialog öffne
    Dann sehe ich im Sonstiges-Dialog nicht den Eintrag "Turnen"
    Wenn ich den Sonstiges-Dialog schließe
    Und ich den Aktivitäten-Dialog öffne
    Dann sehe ich im Aktivitäten-Dialog nicht die Aktivität "Weihnachtsfeier"

  Szenario: Eingeplanter Eintrag kann nicht gelöscht werden
    Wenn ich den Sonstiges-Dialog öffne
    Und ich versuche den Eintrag "Sommerfest" zu löschen
    Dann erscheint eine Meldung die "kann nicht gelöscht werden" enthält
    Und sehe ich im Sonstiges-Dialog den Eintrag "Sommerfest"

  Szenario: Nicht eingeplanten Eintrag löschen
    Wenn ich den Sonstiges-Dialog öffne
    Und ich den Eintrag "Fotograf" lösche
    Dann sehe ich im Sonstiges-Dialog nicht den Eintrag "Fotograf"
    Wenn ich den Sonstiges-Dialog schließe
    Dann erscheint der Eintrag "Fotograf" nicht im Sonstiges-Pool

  Szenario: Geladener Eintrag ist im Plan sichtbar
    Dann ist der Eintrag "Sommerfest" in Gruppe "Mond" und Schicht "Frühschicht" eingeplant

  Szenario: Eintrag per Ziehen in eine Zelle einplanen
    Wenn ich den Eintrag "Weihnachtsfeier" in Gruppe "Sonne" und Schicht "Spätschicht" ziehe
    Dann ist der Eintrag "Weihnachtsfeier" in Gruppe "Sonne" und Schicht "Spätschicht" eingeplant

  Szenario: Eintrag kann mehrfach eingeplant werden
    Wenn ich den Eintrag "Weihnachtsfeier" in Gruppe "Sonne" und Schicht "Spätschicht" ziehe
    Und ich den Eintrag "Weihnachtsfeier" in Gruppe "Wolken" und Schicht "Frühschicht" ziehe
    Dann ist der Eintrag "Weihnachtsfeier" in Gruppe "Sonne" und Schicht "Spätschicht" eingeplant
    Und ist der Eintrag "Weihnachtsfeier" in Gruppe "Wolken" und Schicht "Frühschicht" eingeplant

  Szenario: Geplanten Eintrag per Dialog verschieben
    Wenn ich den geplanten Eintrag "Sommerfest" in Gruppe "Mond" und Schicht "Frühschicht" öffne
    Und ich im Eintrags-Dialog die Schicht "Spätschicht" wähle
    Und ich im Eintrags-Dialog die Gruppe "Sterne" wähle
    Und ich den Eintrags-Dialog mit "Übernehmen" bestätige
    Dann ist der Eintrag "Sommerfest" in Gruppe "Sterne" und Schicht "Spätschicht" eingeplant
    Und ist der Eintrag "Sommerfest" nicht in Gruppe "Mond" und Schicht "Frühschicht" eingeplant

  Szenario: Geplanten Eintrag aus dem Plan nehmen
    Wenn ich den geplanten Eintrag "Sommerfest" in Gruppe "Mond" und Schicht "Frühschicht" öffne
    Und ich den Eintrags-Dialog mit "Aus Plan nehmen" bestätige
    Dann ist der Eintrag "Sommerfest" nicht eingeplant
    Und erscheint der Eintrag "Sommerfest" im Sonstiges-Pool

  Szenario: Sonstiges bleibt nach dem Speichern erhalten
    Wenn ich den Sonstiges-Dialog öffne
    Und ich einen neuen Eintrag "Sternenwanderung" mit Icon "🌠" hinzufüge
    Und ich den Sonstiges-Dialog schließe
    Und ich den Eintrag "Sternenwanderung" in Gruppe "Mond" und Schicht "Mittelschicht" ziehe
    Und ich den Plan speichere
    Und ich die Anwendung schließe und wieder öffne
    Dann erscheint der Eintrag "Sternenwanderung" im Sonstiges-Pool
    Und ist der Eintrag "Sternenwanderung" in Gruppe "Mond" und Schicht "Mittelschicht" eingeplant
