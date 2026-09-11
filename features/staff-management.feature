# language: de
Funktionalität: Personalverwaltung
  Als Planerin möchte ich Personal anlegen, deaktivieren und löschen,
  damit der Stamm aktuell bleibt.

  Grundlage:
    Angenommen die Dienstplan-App ist geöffnet

  Szenario: Personal-Dialog öffnen und geladenes Personal sehen
    Wenn ich den Personal-Dialog öffne
    Dann sehe ich im Personal-Dialog die Person "Anna"
    Und sehe ich im Personal-Dialog die Person "Nadine"

  Szenario: Neue Person hinzufügen
    Wenn ich den Personal-Dialog öffne
    Und ich eine neue Person "Nora" in Gruppe "Leitung" hinzufüge
    Dann sehe ich im Personal-Dialog die Person "Nora"
    Wenn ich den Personal-Dialog schließe
    Und ich die Woche zurücksetze
    Dann ist "Nora" in Gruppe "Leitung" und Schicht "Frühschicht" eingeteilt

  Szenario: Springer anlegen – ohne Stammgruppe, bleibt im Pool
    Wenn ich den Personal-Dialog öffne
    Und ich eine neue Person "Nora" als "Springer" hinzufüge
    Dann ist die Person "Nora" im Personal-Dialog als "Springer" gekennzeichnet
    Und hat die Person "Nora" im Personal-Dialog keine Stammgruppe
    Wenn ich den Personal-Dialog schließe
    Und ich die Woche zurücksetze
    Dann ist "Nora" nicht eingeteilt
    Und erscheint "Nora" im Pool
    Und ist der Pool-Chip "Nora" als "Springer" gekennzeichnet

  Szenario: Praktikant/-in anlegen und einteilen
    Wenn ich den Personal-Dialog öffne
    Und ich eine neue Person "Paul" als "Praktikant/-in" hinzufüge
    Und ich den Personal-Dialog schließe
    Dann erscheint "Paul" im Pool
    Und ist der Pool-Chip "Paul" als "Praktikant/-in" gekennzeichnet
    Wenn ich "Paul" aus dem Pool in Gruppe "Sterne" und Schicht "Mittelschicht" ziehe
    Dann ist "Paul" in Gruppe "Sterne" und Schicht "Mittelschicht" eingeteilt
    Und ist der Chip "Paul" als "Praktikant/-in" gekennzeichnet
    Und ist der Chip "Paul" nicht als Gasteinsatz markiert

  Szenario: Springer und Praktikant/-in sind im Raster unterscheidbar
    Dann ist der Chip "Mirjam" als "Springer" gekennzeichnet
    Und ist der Chip "Ole" als "Praktikant/-in" gekennzeichnet
    Und sind die Chips "Mirjam" und "Ole" unterschiedlich gekennzeichnet

  Szenario: Bestehende Person zum Springer machen
    Wenn ich den Personal-Dialog öffne
    Und ich die Kennzeichnung der Person "Lars" auf "Springer" setze
    Dann ist die Person "Lars" im Personal-Dialog als "Springer" gekennzeichnet
    Und hat die Person "Lars" im Personal-Dialog keine Stammgruppe
    Wenn ich den Personal-Dialog schließe
    Dann ist der Chip "Lars" als "Springer" gekennzeichnet
    Wenn ich die Woche zurücksetze
    Dann ist "Lars" nicht eingeteilt
    Und erscheint "Lars" im Pool

  Szenario: Springer erhält beim Zurücknehmen der Kennzeichnung wieder eine Stammgruppe
    Wenn ich den Personal-Dialog öffne
    Und ich die Kennzeichnung der Person "Mirjam" auf "Mitarbeiter/-in" setze
    Und ich die Stammgruppe der Person "Mirjam" auf "Wolken" setze
    Und ich den Personal-Dialog schließe
    Und ich die Woche zurücksetze
    Dann ist "Mirjam" in Gruppe "Wolken" und Schicht "Frühschicht" eingeteilt
    Und ist der Chip "Mirjam" nicht gekennzeichnet

  Szenario: Person deaktivieren entfernt sie aus neuen Standardzuteilungen
    Wenn ich den Personal-Dialog öffne
    Und ich die Person "Lars" deaktiviere
    Und ich den Personal-Dialog schließe
    Und ich zur nächsten Woche wechsle
    Dann ist "Lars" nicht eingeteilt
    Und erscheint "Lars" nicht im Pool

  Szenario: Eingeteilte Person kann nicht gelöscht werden
    Wenn ich den Personal-Dialog öffne
    Und ich versuche die Person "Anna" zu löschen
    Dann erscheint eine Meldung die "kann nicht gelöscht werden" enthält
    Und sehe ich im Personal-Dialog die Person "Anna"
