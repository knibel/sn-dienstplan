# language: de
Funktionalität: Wochenaktionen
  Als Planerin möchte ich Wochen zurücksetzen und von der Vorwoche übernehmen.

  Grundlage:
    Angenommen die Dienstplan-App ist geöffnet

  Szenario: Woche zurücksetzen stellt Standardzuteilung wieder her
    Wenn ich den Chip "Gül" öffne
    Und ich den Chip-Dialog mit "Aus Plan nehmen" bestätige
    Dann ist "Gül" nicht eingeteilt
    Wenn ich die Woche zurücksetze
    Dann ist "Gül" in Gruppe "Mäuse" und Schicht "Frühschicht" eingeteilt

  Szenario: Vorwoche kopieren übernimmt Zuteilungen
    Wenn ich den Chip "Gül" öffne
    Und ich im Chip-Dialog die Schicht "Spätschicht" wähle
    Und ich den Chip-Dialog mit "Übernehmen" bestätige
    Und ich zur nächsten Woche wechsle
    Und ich die Vorwoche kopiere
    Dann ist "Gül" in Gruppe "Mäuse" und Schicht "Spätschicht" eingeteilt

  Szenario: Vorwoche kopieren ohne vorhandene Vorwoche meldet Fehler
    Wenn ich zur vorherigen Woche wechsle
    Und ich versuche die Vorwoche zu kopieren
    Dann erscheint eine Meldung die "Keine Vorwoche vorhanden" enthält
