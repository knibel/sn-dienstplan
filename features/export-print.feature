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

  Szenario: Druckansicht enthält Personal, Aktivitäten und Sonstiges
    Dann enthält die Druckansicht der aktuellen Woche "Bernd"
    Und enthält die Druckansicht der aktuellen Woche "🤸 Turnen"
    Und enthält die Druckansicht der aktuellen Woche "⭐ Sommerfest"

  Szenario: Volle Schichtzelle läuft im Druck nicht seitlich aus der Zelle
    Angenommen ist "Bernd" in Gruppe "Sonne" und Schicht "Frühschicht" eingeteilt
    Und ist "Clara" in Gruppe "Sonne" und Schicht "Frühschicht" eingeteilt
    Wenn ich die Aktivität "Fußball spielen" in Gruppe "Sonne" und Schicht "Frühschicht" ziehe
    Und ich die Aktivität "Elterncafé" in Gruppe "Sonne" und Schicht "Frühschicht" ziehe
    Dann läuft in der Druckansicht keine Schichtzelle seitlich über ihre Zelle hinaus
