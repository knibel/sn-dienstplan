# language: de
Funktionalität: Personalverwaltung
  Als Planerin möchte ich Personal anlegen, deaktivieren und löschen,
  damit der Stamm aktuell bleibt.

  Grundlage:
    Angenommen die Dienstplan-App ist geöffnet

  Szenario: Personal-Dialog öffnen und geladenes Personal sehen
    Wenn ich den Personal-Dialog öffne
    Dann sehe ich im Personal-Dialog die Person "Vivien"
    Und sehe ich im Personal-Dialog die Person "Beate"

  Szenario: Neue Person hinzufügen
    Wenn ich den Personal-Dialog öffne
    Und ich eine neue Person "Nora" in Gruppe "Springer" hinzufüge
    Dann sehe ich im Personal-Dialog die Person "Nora"
    Wenn ich den Personal-Dialog schließe
    Und ich die Woche zurücksetze
    Dann ist "Nora" in Gruppe "Springer" und Schicht "Frühschicht" eingeteilt

  Szenario: Person deaktivieren entfernt sie aus neuen Standardzuteilungen
    Wenn ich den Personal-Dialog öffne
    Und ich die Person "Birgit" deaktiviere
    Und ich den Personal-Dialog schließe
    Und ich zur nächsten Woche wechsle
    Dann ist "Birgit" nicht eingeteilt
    Und erscheint "Birgit" nicht im Pool

  Szenario: Eingeteilte Person kann nicht gelöscht werden
    Wenn ich den Personal-Dialog öffne
    Und ich versuche die Person "Vivien" zu löschen
    Dann erscheint eine Meldung die "kann nicht gelöscht werden" enthält
    Und sehe ich im Personal-Dialog die Person "Vivien"
