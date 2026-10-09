# ADR-0004: Zugriffsschutz mit Lese- und Bearbeitungspasswort, ohne HTTPS

- **Status:** Akzeptiert
- **Datum:** 2026-10-09

## Kontext

Der Dienstplan enthält personenbezogene Daten (Namen, Arbeitszeiten, Abwesenheiten). Die
Lesegeräte werden von Gruppen gemeinsam genutzt. Bearbeitet wird im Wesentlichen von einer
Person. Lese- und Bearbeitungsansicht kommen vom selben Server (ADR-0001).

## Entscheidung

- **Lesen:** ein gemeinsames Passwort, das der Server abfragt. Es wird einmal pro Gerät
  eingegeben, und der Browser merkt es sich.
- **Bearbeiten:** ein eigenes, zweites Passwort. Der Server verlangt es für die
  Bearbeitungsansicht und für jede Anfrage, die Daten ändert. Das Lesepasswort reicht dafür
  nicht.
- **Kein HTTPS.** Das lokale Netz der Kita gilt als vertrauenswürdig (Vertrauensbasis).

## Betrachtete Alternativen

- **Kein Schutz beim Lesen:** Private Handys, Gäste oder Eltern im WLAN könnten den Plan
  sehen. Verworfen.
- **Bearbeitung nur von der Netzwerkadresse des Kita-PCs:** Bricht beim Tausch des PCs und
  ist kein echter Schutz. Verworfen.
- **Anmeldung pro Person:** Passt nicht zu gemeinsam genutzten Geräten und ist für eine
  bearbeitende Person zu aufwendig. Verworfen.
- **HTTPS mit selbstsigniertem Zertifikat:** Würde die Passwörter im Netz verschlüsseln.
  Wegen der Vertrauensbasis vorerst nicht umgesetzt; kann später ergänzt werden.

## Konsequenzen

- Die Passwörter werden unverschlüsselt im lokalen Netz übertragen.
- Wer das Lesepasswort weitergibt, hebelt den Schutz vor privaten Geräten aus.
- Es ist nicht nachvollziehbar, wer eine Änderung gemacht hat.
- Ohne HTTPS stehen Service Worker, Benachrichtigungen und andere Funktionen, die einen
  sicheren Kontext voraussetzen, nicht zur Verfügung.
- Die Passwörter gehören zu den Zugangsdaten der Kita (KeePass).
