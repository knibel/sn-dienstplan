# language: de
Funktionalität: Aktivitäten
  Als Planerin möchte ich eigene Aktivitäten mit Icon anlegen
  und sie wie Personal in den Plan ziehen.

  Grundlage:
    Angenommen die Dienstplan-App ist geöffnet

  Szenario: Aktivitäten-Dialog öffnen und geladene Aktivitäten sehen
    Wenn ich den Aktivitäten-Dialog öffne
    Dann sehe ich im Aktivitäten-Dialog die Aktivität "Turnen"
    Und sehe ich im Aktivitäten-Dialog die Aktivität "Elterncafé"
    Und hat die Aktivität "Turnen" das Icon "🤸"

  Szenario: Neue Aktivität mit gewähltem Icon anlegen
    Wenn ich den Aktivitäten-Dialog öffne
    Und ich eine neue Aktivität "Tanzen" mit Icon "💃" hinzufüge
    Dann hat die Aktivität "Tanzen" das Icon "💃"
    Wenn ich den Aktivitäten-Dialog schließe
    Dann erscheint die Aktivität "Tanzen" im Aktivitäten-Pool

  Szenario: Icon einer Aktivität nachträglich ändern
    Wenn ich den Aktivitäten-Dialog öffne
    Und ich das Icon der Aktivität "Turnen" auf "🧘" setze
    Dann hat die Aktivität "Turnen" das Icon "🧘"
    Wenn ich den Aktivitäten-Dialog schließe
    Dann zeigt die Aktivität "Turnen" im Aktivitäten-Pool das Icon "🧘"

  Szenario: Leerer Aktivitätsname wird abgelehnt
    Wenn ich den Aktivitäten-Dialog öffne
    Und ich versuche eine Aktivität ohne Namen hinzuzufügen
    Dann erscheint eine Meldung die "Bitte einen Namen eingeben" enthält

  Szenario: Doppelter Aktivitätsname wird abgelehnt
    Wenn ich den Aktivitäten-Dialog öffne
    Und ich versuche die Aktivität "Turnen" erneut hinzuzufügen
    Dann erscheint eine Meldung die "bereits" enthält
    Und sehe ich im Aktivitäten-Dialog die Aktivität "Turnen"

  Szenario: Eingeplante Aktivität kann nicht gelöscht werden
    Wenn ich den Aktivitäten-Dialog öffne
    Und ich versuche die Aktivität "Turnen" zu löschen
    Dann erscheint eine Meldung die "kann nicht gelöscht werden" enthält
    Und sehe ich im Aktivitäten-Dialog die Aktivität "Turnen"

  Szenario: Nicht eingeplante Aktivität löschen
    Wenn ich den Aktivitäten-Dialog öffne
    Und ich die Aktivität "Elterncafé" lösche
    Dann sehe ich im Aktivitäten-Dialog nicht die Aktivität "Elterncafé"
    Wenn ich den Aktivitäten-Dialog schließe
    Dann erscheint die Aktivität "Elterncafé" nicht im Aktivitäten-Pool

  Szenario: Geladene Aktivität ist im Plan sichtbar
    Dann ist die Aktivität "Turnen" in Gruppe "Sonne" und Schicht "Mittelschicht" eingeplant

  Szenario: Aktivität per Ziehen in eine Zelle einplanen
    Wenn ich die Aktivität "Fußball spielen" in Gruppe "Mond" und Schicht "Frühschicht" ziehe
    Dann ist die Aktivität "Fußball spielen" in Gruppe "Mond" und Schicht "Frühschicht" eingeplant

  Szenario: Aktivität kann mehrfach eingeplant werden
    Wenn ich die Aktivität "Fußball spielen" in Gruppe "Mond" und Schicht "Frühschicht" ziehe
    Und ich die Aktivität "Fußball spielen" in Gruppe "Wolken" und Schicht "Spätschicht" ziehe
    Dann ist die Aktivität "Fußball spielen" in Gruppe "Mond" und Schicht "Frühschicht" eingeplant
    Und ist die Aktivität "Fußball spielen" in Gruppe "Wolken" und Schicht "Spätschicht" eingeplant

  Szenario: Geplante Aktivität per Dialog verschieben
    Wenn ich die geplante Aktivität "Turnen" in Gruppe "Sonne" und Schicht "Mittelschicht" öffne
    Und ich im Aktivitäts-Dialog die Schicht "Spätschicht" wähle
    Und ich im Aktivitäts-Dialog die Gruppe "Mond" wähle
    Und ich den Aktivitäts-Dialog mit "Übernehmen" bestätige
    Dann ist die Aktivität "Turnen" in Gruppe "Mond" und Schicht "Spätschicht" eingeplant
    Und ist die Aktivität "Turnen" nicht in Gruppe "Sonne" und Schicht "Mittelschicht" eingeplant

  Szenario: Geplante Aktivität aus dem Plan nehmen
    Wenn ich die geplante Aktivität "Turnen" in Gruppe "Sonne" und Schicht "Mittelschicht" öffne
    Und ich den Aktivitäts-Dialog mit "Aus Plan nehmen" bestätige
    Dann ist die Aktivität "Turnen" nicht eingeplant
    Und erscheint die Aktivität "Turnen" im Aktivitäten-Pool

  Szenario: Aktivitäten bleiben nach dem Speichern erhalten
    Wenn ich den Aktivitäten-Dialog öffne
    Und ich eine neue Aktivität "Tanzen" mit Icon "💃" hinzufüge
    Und ich den Aktivitäten-Dialog schließe
    Und ich die Aktivität "Tanzen" in Gruppe "Mond" und Schicht "Frühschicht" ziehe
    Und ich den Plan speichere
    Und ich die Anwendung schließe und wieder öffne
    Dann erscheint die Aktivität "Tanzen" im Aktivitäten-Pool
    Und ist die Aktivität "Tanzen" in Gruppe "Mond" und Schicht "Frühschicht" eingeplant
