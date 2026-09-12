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
      | Tag        |
      | Montag     |
      | Dienstag   |
      | Mittwoch   |
      | Donnerstag |
      | Freitag    |
    Wenn ich den Tag "Mittwoch" wähle
    Dann der Tag "Mittwoch" ist aktiv

  Szenario: Zu einer beliebigen Kalenderwoche springen
    Wenn ich per Klick auf die Wochenbeschriftung zu KW 37 im Jahr 2026 springe
    Dann zeigt die Wochenbeschriftung "KW 37 · 07.09.2026 – 11.09.2026"
    Und der Tag "Montag" ist aktiv

  Szenario: Mit der Taste W zu einer Kalenderwoche springen
    Wenn ich die Taste "w" drücke
    Dann ist der Dialog "Zu Kalenderwoche springen" geöffnet
    Wenn ich im Sprungdialog KW 1 und Jahr 2027 eingebe und bestätige
    Dann zeigt die Wochenbeschriftung "KW 1 · 04.01.2027 – 08.01.2027"

  Szenario: KW 53 eines Jahres mit 53 Wochen ist erreichbar
    Wenn ich per Klick auf die Wochenbeschriftung zu KW 53 im Jahr 2026 springe
    Dann zeigt die Wochenbeschriftung "KW 53 · 28.12.2026 – 01.01.2027"

  Szenario: Ungültige Kalenderwoche wird abgewiesen
    Wenn ich per Klick auf die Wochenbeschriftung zu KW 53 im Jahr 2025 springe
    Dann ist der Dialog "Zu Kalenderwoche springen" geöffnet
    Und zeigt der Sprungdialog den Fehler "Das Jahr 2025 hat nur 52 Kalenderwochen."

  Szenario: Sprungdialog ist mit der aktuellen Woche vorbelegt
    Wenn ich per Klick auf die Wochenbeschriftung zu KW 2 im Jahr 2026 springe
    Und ich die Taste "w" drücke
    Dann ist der Sprungdialog mit KW 2 und Jahr 2026 vorbelegt

  Szenario: Pfeiltasten wechseln die Woche
    Wenn ich per Klick auf die Wochenbeschriftung zu KW 10 im Jahr 2026 springe
    Und ich die Taste "ArrowRight" drücke
    Dann zeigt die Wochenbeschriftung "KW 11 · 09.03.2026 – 13.03.2026"
    Wenn ich die Taste "ArrowLeft" drücke
    Und ich die Taste "ArrowLeft" drücke
    Dann zeigt die Wochenbeschriftung "KW 9 · 23.02.2026 – 27.02.2026"

  Szenario: Taste T springt zur heutigen Woche
    Wenn ich per Klick auf die Wochenbeschriftung zu KW 10 im Jahr 2020 springe
    Und ich die Taste "t" drücke
    Dann zeigt die Wochenbeschriftung die heutige Woche

  Szenario: Tastenkürzel greifen nicht in Eingabefeldern
    Wenn ich mir die Wochenbeschriftung merke
    Und ich in das Tagesinfo-Feld "w" tippe
    Dann ist kein Dialog geöffnet
    Und ist die Wochenbeschriftung wieder die gemerkte
