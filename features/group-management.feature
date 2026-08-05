# language: de
Funktionalität: Gruppenverwaltung
  Als Planerin möchte ich Gruppen anlegen und unbenutzte löschen,
  damit das Raster zum aktuellen Kita-Stand passt.

  Grundlage:
    Angenommen die Dienstplan-App ist geöffnet

  Szenario: Gruppen-Dialog öffnen und geladene Gruppen sehen
    Wenn ich den Gruppen-Dialog öffne
    Dann sehe ich im Gruppen-Dialog die Gruppe "Mäuse"
    Und sehe ich im Gruppen-Dialog die Gruppe "Hasen"

  Szenario: Neue Gruppe hinzufügen
    Wenn ich den Gruppen-Dialog öffne
    Und ich eine neue Gruppe "Füchse" hinzufüge
    Dann sehe ich im Gruppen-Dialog die Gruppe "Füchse"
    Wenn ich den Gruppen-Dialog schließe
    Dann sehe ich die Gruppen:
      | Gruppe                 |
      | Mäuse                  |
      | Hasen                  |
      | Mäuschen               |
      | Häschen                |
      | Springer               |
      | Praktikanten/-innen    |
      | Leitung                |
      | Füchse                 |

  Szenario: Leerer Gruppenname wird abgelehnt
    Wenn ich den Gruppen-Dialog öffne
    Und ich versuche eine Gruppe ohne Namen hinzuzufügen
    Dann erscheint eine Meldung die "Bitte einen Namen eingeben" enthält

  Szenario: Doppelter Gruppenname wird abgelehnt
    Wenn ich den Gruppen-Dialog öffne
    Und ich versuche die Gruppe "Mäuse" erneut hinzuzufügen
    Dann erscheint eine Meldung die "bereits" enthält
    Und sehe ich im Gruppen-Dialog die Gruppe "Mäuse"

  Szenario: Benutzte Gruppe kann nicht gelöscht werden
    Wenn ich den Gruppen-Dialog öffne
    Und ich versuche die Gruppe "Mäuse" zu löschen
    Dann erscheint eine Meldung die "kann nicht gelöscht werden" enthält
    Und sehe ich im Gruppen-Dialog die Gruppe "Mäuse"

  Szenario: Unbenutzte Gruppe löschen
    Wenn ich den Gruppen-Dialog öffne
    Und ich eine neue Gruppe "Füchse" hinzufüge
    Und ich die Gruppe "Füchse" lösche
    Dann sehe ich im Gruppen-Dialog nicht die Gruppe "Füchse"
    Wenn ich den Gruppen-Dialog schließe
    Dann sehe ich die Gruppen:
      | Gruppe                 |
      | Mäuse                  |
      | Hasen                  |
      | Mäuschen               |
      | Häschen                |
      | Springer               |
      | Praktikanten/-innen    |
      | Leitung                |

  Szenario: Geladene Gruppen behalten ihre Farben
    Wenn ich den Gruppen-Dialog öffne
    Dann hat die Gruppe "Mäuse" die Farbe "#e8623c"
    Und hat die Gruppe "Hasen" die Farbe "#3f8f5b"

  Szenario: Gruppe mit gewählter Farbe anlegen
    Wenn ich den Gruppen-Dialog öffne
    Und ich eine neue Gruppe "Füchse" mit Farbe "#7a56b0" hinzufüge
    Dann hat die Gruppe "Füchse" die Farbe "#7a56b0"
    Wenn ich den Gruppen-Dialog schließe
    Dann hat die Gruppenzeile "Füchse" die Hintergrundfarbe "#7a56b0"

  Szenario: Gruppenfarbe nachträglich ändern
    Wenn ich den Gruppen-Dialog öffne
    Und ich die Farbe der Gruppe "Mäuse" auf "#0d8f9c" setze
    Dann hat die Gruppe "Mäuse" die Farbe "#0d8f9c"
    Wenn ich den Gruppen-Dialog schließe
    Dann hat die Gruppenzeile "Mäuse" die Hintergrundfarbe "#0d8f9c"

  Szenario: Default-Farbe bevorzugt unbenutzte Farbe
    Wenn ich den Gruppen-Dialog öffne
    Und ich die Farbe der Gruppe "Leitung" auf "#e8623c" setze
    Und ich eine neue Gruppe "Füchse" hinzufüge
    Dann hat die Gruppe "Füchse" die Farbe "#5a6472"
