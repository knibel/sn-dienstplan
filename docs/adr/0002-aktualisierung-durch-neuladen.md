# ADR-0002: Aktualisierung durch regelmäßiges Neuladen statt Live-Events oder Push

- **Status:** Akzeptiert
- **Datum:** 2026-10-09

## Kontext

Ursprüngliches Ziel war, dass Mitarbeitende Änderungen per Update-Event auf ihren Tablets
erhalten. Dagegen sprechen mehrere Punkte:

- Web Push und Benachrichtigungen setzen HTTPS mit einem Zertifikat voraus, dem das Gerät
  vertraut. Es gibt nur ein selbstsigniertes Zertifikat, keine interne PKI und keine
  Geräteverwaltung (MDM).
- Bei Chrome bzw. Samsung laufen Push-Nachrichten über Google (FCM). Das widerspricht der
  Vorgabe der Kita, keine Dienste von Microsoft oder Google zu nutzen.
- Kurzfristige Änderungen (z. B. bei Krankheit) betreffen meist Personen, die gerade nicht
  vor einem Gerät in der Kita stehen. Sie werden ohnehin persönlich informiert.

## Entscheidung

Es reicht, dass die Anzeige **aktuell ist, sobald jemand hinschaut**. Die Leseansicht lädt
den veröffentlichten Stand regelmäßig (alle paar Minuten) neu und markiert, was sich seit
der letzten Veröffentlichung geändert hat.

## Betrachtete Alternativen

- **Live-Events (Server-Sent Events):** Funktioniert ohne HTTPS, braucht aber eine dauerhaft
  offene Verbindung und mehr Servercode. Gegenüber dem regelmäßigen Neuladen bringt das
  kaum einen Nutzen. Verworfen, lässt sich später aber ergänzen, ohne die Architektur
  umzubauen.
- **Web Push bei geschlossenem Browser:** Siehe Kontext (HTTPS, Google). Verworfen.
- **Fester Rhythmus wie heute (wöchentliches PDF):** Kurzfristige Änderungen gehen unter.
  Verworfen.

## Konsequenzen

- Es gibt keine aktive Benachrichtigung. Die Anzeige kann einige Minuten hinterherhinken.
- Der Server muss keine Verbindungen offen halten und kennt keine Clients.
- Ein Gerät, das aus war, zeigt nach dem Einschalten automatisch den aktuellen Stand.
