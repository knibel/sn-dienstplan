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

  Szenario: Springer und Praktikant/-in sind im Ausdruck gekennzeichnet
    Dann ist "Mirjam" in der Druckansicht der aktuellen Woche als "Springer" gekennzeichnet
    Und ist "Ole" in der Druckansicht der aktuellen Woche als "Praktikant/-in" gekennzeichnet
    Und ist "Bernd" in der Druckansicht der aktuellen Woche nicht gekennzeichnet

  Szenario: Notizen an Info Kita und Gruppenkommentar erscheinen im Ausdruck
    Wenn ich die Aktivität "Elterncafé" in die Notizfläche "Info Kita" ziehe
    Und ich den Eintrag "Fotograf" in die Notizfläche der Gruppe "Sonne" ziehe
    Dann enthält die Druckansicht der aktuellen Woche "Info Kita:"
    Und enthält die Druckansicht der aktuellen Woche "☕ Elterncafé"
    Und enthält die Druckansicht der aktuellen Woche "📷 Fotograf"

  Szenario: Volle Schichtzelle läuft im Druck nicht seitlich aus der Zelle
    Angenommen ist "Bernd" in Gruppe "Sonne" und Schicht "Frühschicht" eingeteilt
    Und ist "Clara" in Gruppe "Sonne" und Schicht "Frühschicht" eingeteilt
    Wenn ich die Aktivität "Fußball spielen" in Gruppe "Sonne" und Schicht "Frühschicht" ziehe
    Und ich die Aktivität "Elterncafé" in Gruppe "Sonne" und Schicht "Frühschicht" ziehe
    Dann läuft in der Druckansicht keine Schichtzelle seitlich über ihre Zelle hinaus
