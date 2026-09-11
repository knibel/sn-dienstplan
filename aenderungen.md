# Änderungen seit Version 7c56c0d

## 0. Automatisch speichern – neu

In der Toolbar gibt es die Option **Automatisch speichern**. Ist die Checkbox angehakt, wird jede Änderung sofort im Browser (localStorage) gesichert – der Button „Speichern“ ist dann nicht mehr nötig. Die Einstellung selbst bleibt nach dem Schließen erhalten. Manuelles Speichern und „Speichern unter…“ funktionieren weiterhin.

## 1. Aktivitäten – neu

Es gibt jetzt einen eigenen **Aktivitäten-Katalog** neben dem Personal:

- Über den **Aktivitäten-Dialog** legst Du eigene Aktivitäten an (z. B. „Turnen", „Elterncafé") und wählst dazu ein **Symbol/Icon**. Das Icon lässt sich jederzeit nachträglich ändern.
- Aktivitäten liegen in einem eigenen **Pool** und werden – genau wie Personal – per **Drag & Drop** in eine Gruppe/Schicht gezogen.
- Eine Aktivität kann **mehrfach** eingeplant werden (z. B. in zwei Gruppen gleichzeitig).
- Eine eingeplante Aktivität lässt sich per Klick öffnen und dort **verschieben** (andere Gruppe/Schicht) oder **aus dem Plan nehmen**.
- Schutz vor Fehlern: leere Namen und doppelte Namen werden abgelehnt; eine Aktivität, die noch irgendwo eingeplant ist, kann nicht gelöscht werden.
- Aktivitäten erscheinen in der **Druckansicht** und bleiben beim Speichern erhalten.

## 2. „Sonstiges" – neu

Ein zweiter, vom Aktivitäten-Katalog **getrennter** Katalog für alles andere (Sommerfest, Fotograf …):

- Funktioniert genauso wie Aktivitäten: Dialog, eigener Pool, Drag & Drop, Verschieben, aus dem Plan nehmen, Löschschutz bei eingeplanten Einträgen.
- **Besonderheit:** Einträge dürfen **ohne Namen** angelegt werden – dann steht im Plan und im Ausdruck **nur das Symbol**. Mehrere namenlose Einträge mit verschiedenen Symbolen sind möglich; dasselbe Symbol zweimal namenlos wird abgelehnt.
- Ändert man das Symbol eines bereits eingeplanten namenlosen Eintrags, zieht die Änderung im Plan mit.

## 3. Personal: Schicht-Vorgabe entfallen

Beim Anlegen einer Person wird **keine Standard-Schicht mehr** hinterlegt – im Personal-Dialog gibt es nur noch Name und Stammgruppe. Neue Wochen starten für alle in der Frühschicht, die Zuteilung erfolgt dann im Wochenplan. Das war vorher doppelt gepflegt und hat verwirrt.

## 4. Ausdruck: sauberer Zeilenumbruch

In gut gefüllten Schichtzellen lief die Liste im PDF/Ausdruck seitlich aus der Zelle heraus. Jetzt wird **zwischen den Einträgen umgebrochen**, ein einzelner Name bzw. eine Aktivität bleibt dabei zusammen.


## 5. Personal: Kennzeichnung „Springer" / „Praktikant/-in" – neu

Im **Personal-Dialog** gibt es neben der Stammgruppe jetzt einen **Personal-Typ**: „Mitarbeiter/-in" (normal, mit Stammgruppe), „Springer" oder „Praktikant/-in".

- **Springer und Praktikanten/-innen haben keine Stammgruppe.** Die Gruppenauswahl entfällt für sie; beim Zurücksetzen einer Woche bzw. in neuen Wochen landen sie **im Pool „Nicht eingeteilt"** und werden von dort per Drag & Drop in die Gruppe gezogen, in der sie gebraucht werden. Ein Gasteinsatz (gestrichelte Umrandung) gibt es für sie nicht.
- Im **Browser** trägt der Chip ein Badge: **Springer** (weiß) bzw. **Praktikant/-in** (gelb) – so sind beide sofort erkennbar und voneinander unterscheidbar. Im Pool erscheinen sie neutral grau (keine Gruppenfarbe).
- Im **Ausdruck** liegt der Name auf einer dezent gefärbten Kachel (ohne Rahmen, ohne Zusatztext): **Springer** mintgrün, **Praktikant/-in** apricot. Die Legende unter dem Wochenplan erklärt beides.
- Die Kennzeichnung lässt sich auch **nachträglich** ändern; wird sie zurückgenommen, bekommt die Person wieder eine Stammgruppe.
- Bestehende Stände laufen unverändert weiter (alle Personen gelten als „Stammgruppe"). Die bisherigen Hilfsgruppen „Springer" und „Praktikanten/-innen" werden nicht mehr benötigt und können im Gruppen-Dialog gelöscht werden, sobald niemand mehr darin eingeteilt ist.
