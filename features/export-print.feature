# language: de
Funktionalität: Export und Druck
  Als Planerin möchte ich den Plan als PDF drucken.

  Grundlage:
    Angenommen die Dienstplan-App ist geöffnet

  Szenario: Druckdialog erlaubt Umfangwahl
    Wenn ich den Druckdialog öffne
    Dann ist der Druckdialog geöffnet
    Und kann ich den Druckumfang "Nur aktuelle Woche" wählen
    Und kann ich den Druckumfang "Alle erfassten Wochen" wählen
    Wenn ich den Druckdialog abbreche
    Dann ist der Druckdialog geschlossen

  Szenario: Druckansicht enthält Personal und geplante Aktivitäten
    Dann enthält die Druckansicht der aktuellen Woche "Bernd"
    Und enthält die Druckansicht der aktuellen Woche "🤸 Turnen"
