# language: de
Funktionalität: Speichern und Wiederherstellen
  Als Planerin möchte ich den Plan speichern,
  damit er nach dem Schließen der Anwendung wieder verfügbar ist.

  Grundlage:
    Angenommen die Dienstplan-App ist geöffnet

  Szenario: Gespeicherter Zustand bleibt nach erneutem Öffnen erhalten
    Wenn ich als Info Tag "Testnotiz Persistenz" eintrage
    Und ich den Plan speichere
    Dann erscheint der Hinweis "Gespeichert"
    Wenn ich die Anwendung schließe und wieder öffne
    Dann enthält das Feld Info Tag "Testnotiz Persistenz"

  Szenario: Speichern überschreibt den zuvor gespeicherten Zustand
    Wenn ich als Info Tag "Erste Version" eintrage
    Und ich den Plan speichere
    Und ich als Info Tag "Zweite Version" eintrage
    Und ich den Plan speichere
    Wenn ich die Anwendung schließe und wieder öffne
    Dann enthält das Feld Info Tag "Zweite Version"
    Und enthält das Feld Info Tag nicht "Erste Version"

  Szenario: Speichern unter erzeugt eine JSON-Datei
    Wenn ich als Info Tag "Exportnotiz" eintrage
    Und ich Speichern unter wähle
    Dann wird eine JSON-Datei heruntergeladen
    Und erscheint der Hinweis "Datei gespeichert"
    Und enthält die heruntergeladene JSON-Datei "Exportnotiz"

  Szenario: Automatisch speichern hält Änderungen ohne Speichern-Klick
    Wenn ich Automatisch speichern aktiviere
    Und ich als Info Tag "AutoSave Notiz" eintrage
    Wenn ich die Anwendung schließe und wieder öffne
    Dann enthält das Feld Info Tag "AutoSave Notiz"
    Und ist Automatisch speichern aktiv

  Szenario: Ohne Automatisch speichern gehen ungesicherte Änderungen verloren
    Wenn ich als Info Tag "Nur im Speicher" eintrage
    Wenn ich die Anwendung schließe und wieder öffne
    Dann enthält das Feld Info Tag nicht "Nur im Speicher"

  Szenario: Einstellung Automatisch speichern bleibt erhalten
    Wenn ich Automatisch speichern aktiviere
    Und ich den Plan speichere
    Wenn ich die Anwendung schließe und wieder öffne
    Dann ist Automatisch speichern aktiv
    Wenn ich Automatisch speichern deaktiviere
    Und ich den Plan speichere
    Wenn ich die Anwendung schließe und wieder öffne
    Dann ist Automatisch speichern inaktiv
