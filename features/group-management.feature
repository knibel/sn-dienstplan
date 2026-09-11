# language: de
Funktionalität: Gruppenverwaltung
  Als Planerin möchte ich Gruppen anlegen und unbenutzte löschen,
  damit das Raster zum aktuellen Kita-Stand passt.

  Grundlage:
    Angenommen die Dienstplan-App ist geöffnet

  Szenario: Gruppen-Dialog öffnen und geladene Gruppen sehen
    Wenn ich den Gruppen-Dialog öffne
    Dann sehe ich im Gruppen-Dialog die Gruppe "Sonne"
    Und sehe ich im Gruppen-Dialog die Gruppe "Mond"

  Szenario: Neue Gruppe hinzufügen
    Wenn ich den Gruppen-Dialog öffne
    Und ich eine neue Gruppe "Füchse" hinzufüge
    Dann sehe ich im Gruppen-Dialog die Gruppe "Füchse"
    Wenn ich den Gruppen-Dialog schließe
    Dann sehe ich die Gruppen:
      | Gruppe              |
      | Sonne               |
      | Mond                |
      | Sterne              |
      | Wolken              |
      | Leitung             |
      | Füchse              |

  Szenario: Leerer Gruppenname wird abgelehnt
    Wenn ich den Gruppen-Dialog öffne
    Und ich versuche eine Gruppe ohne Namen hinzuzufügen
    Dann erscheint eine Meldung die "Bitte einen Namen eingeben" enthält

  Szenario: Doppelter Gruppenname wird abgelehnt
    Wenn ich den Gruppen-Dialog öffne
    Und ich versuche die Gruppe "Sonne" erneut hinzuzufügen
    Dann erscheint eine Meldung die "bereits" enthält
    Und sehe ich im Gruppen-Dialog die Gruppe "Sonne"

  Szenario: Benutzte Gruppe kann nicht gelöscht werden
    Wenn ich den Gruppen-Dialog öffne
    Und ich versuche die Gruppe "Sonne" zu löschen
    Dann erscheint eine Meldung die "kann nicht gelöscht werden" enthält
    Und sehe ich im Gruppen-Dialog die Gruppe "Sonne"

  Szenario: Unbenutzte Gruppe löschen
    Wenn ich den Gruppen-Dialog öffne
    Und ich eine neue Gruppe "Füchse" hinzufüge
    Und ich die Gruppe "Füchse" lösche
    Dann sehe ich im Gruppen-Dialog nicht die Gruppe "Füchse"
    Wenn ich den Gruppen-Dialog schließe
    Dann sehe ich die Gruppen:
      | Gruppe              |
      | Sonne               |
      | Mond                |
      | Sterne              |
      | Wolken              |
      | Leitung             |

  Szenario: Gruppe mit nur eingeteilten SpringerInnen und PraktikantInnen löschen
    Wenn ich den Gruppen-Dialog öffne
    Und ich eine neue Gruppe "Füchse" hinzufüge
    Und ich den Gruppen-Dialog schließe
    Und ich den Chip "Mirjam" öffne
    Und ich im Chip-Dialog die Gruppe "Füchse" wähle
    Und ich den Chip-Dialog mit "Übernehmen" bestätige
    Und ich den Chip "Ole" öffne
    Und ich im Chip-Dialog die Gruppe "Füchse" wähle
    Und ich den Chip-Dialog mit "Übernehmen" bestätige
    Dann ist "Mirjam" in Gruppe "Füchse" und Schicht "Frühschicht" eingeteilt
    Und ist "Ole" in Gruppe "Füchse" und Schicht "Mittelschicht" eingeteilt
    Wenn ich den Gruppen-Dialog öffne
    Und ich die Gruppe "Füchse" lösche
    Dann sehe ich im Gruppen-Dialog nicht die Gruppe "Füchse"
    Wenn ich den Gruppen-Dialog schließe
    Dann ist "Mirjam" nicht eingeteilt
    Und erscheint "Mirjam" im Pool
    Und ist "Ole" nicht eingeteilt
    Und erscheint "Ole" im Pool

  Szenario: Gruppe mit eingeteiltem Stammpersonal kann nicht gelöscht werden
    Wenn ich den Gruppen-Dialog öffne
    Und ich eine neue Gruppe "Füchse" hinzufüge
    Und ich den Gruppen-Dialog schließe
    Und ich den Chip "Anna" öffne
    Und ich im Chip-Dialog die Gruppe "Füchse" wähle
    Und ich den Chip-Dialog mit "Übernehmen" bestätige
    Dann ist "Anna" in Gruppe "Füchse" und Schicht "Spätschicht" eingeteilt
    Wenn ich den Gruppen-Dialog öffne
    Und ich versuche die Gruppe "Füchse" zu löschen
    Dann erscheint eine Meldung die "kann nicht gelöscht werden" enthält
    Und sehe ich im Gruppen-Dialog die Gruppe "Füchse"

  Szenario: Geladene Gruppen behalten ihre Farben
    Wenn ich den Gruppen-Dialog öffne
    Dann hat die Gruppe "Sonne" die Farbe "#e8623c"
    Und hat die Gruppe "Mond" die Farbe "#3f8f5b"

  Szenario: Gruppe mit gewählter Farbe anlegen
    Wenn ich den Gruppen-Dialog öffne
    Und ich eine neue Gruppe "Füchse" mit Farbe "#7a56b0" hinzufüge
    Dann hat die Gruppe "Füchse" die Farbe "#7a56b0"
    Wenn ich den Gruppen-Dialog schließe
    Dann hat die Gruppenzeile "Füchse" die Hintergrundfarbe "#7a56b0"

  Szenario: Gruppenfarbe nachträglich ändern
    Wenn ich den Gruppen-Dialog öffne
    Und ich die Farbe der Gruppe "Sonne" auf "#0d8f9c" setze
    Dann hat die Gruppe "Sonne" die Farbe "#0d8f9c"
    Wenn ich den Gruppen-Dialog schließe
    Dann hat die Gruppenzeile "Sonne" die Hintergrundfarbe "#0d8f9c"

  Szenario: Default-Farbe bevorzugt unbenutzte Farbe
    Wenn ich den Gruppen-Dialog öffne
    Und ich die Farbe der Gruppe "Leitung" auf "#e8623c" setze
    Und ich eine neue Gruppe "Füchse" hinzufüge
    Dann hat die Gruppe "Füchse" die Farbe "#7a56b0"
