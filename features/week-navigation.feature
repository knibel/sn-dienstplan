# language: de
Funktionalität: Wochennavigation
  Als Planerin möchte ich zwischen Wochen wechseln,
  damit ich den Dienstplan für die richtige Kalenderwoche bearbeiten kann.

  Grundlage:
    Angenommen die Dienstplan-App ist geöffnet

  Szenario: Aktuelle Woche wird beim Start angezeigt
    Dann sehe ich den Titel "Dienstplan Spatzennest"
    Und die Wochenbeschriftung zeigt einen Datumsbereich von Montag bis Freitag
    Und der Tag "Montag" ist aktiv

  Szenario: Zur nächsten Woche wechseln
    Wenn ich zur nächsten Woche wechsle
    Dann ändert sich die Wochenbeschriftung
    Und der Tag "Montag" ist aktiv

  Szenario: Zur vorherigen Woche wechseln
    Wenn ich mir die Wochenbeschriftung merke
    Und ich zur nächsten Woche wechsle
    Und ich zur vorherigen Woche wechsle
    Dann ist die Wochenbeschriftung wieder die gemerkte

  Szenario: Wochentage Montag bis Freitag sind wählbar
    Dann sehe ich die Tagesreiter:
      | Tag         |
      | Montag      |
      | Dienstag    |
      | Mittwoch    |
      | Donnerstag  |
      | Freitag     |
    Wenn ich den Tag "Mittwoch" wähle
    Dann der Tag "Mittwoch" ist aktiv
