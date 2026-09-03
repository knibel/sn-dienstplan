// Service Worker fuer das online gehostete Dienstplan (z.B. GitHub Pages).
// Wird lokal per file:// geoeffnet nicht genutzt/registriert.
//
// Strategie: cache-first. Einmal geladen, bleibt die App auf der zuletzt
// akzeptierten Version, auch wenn online eine neuere existiert. Die Seite
// selbst prueft im Hintergrund auf eine neue Version (siehe dienstplan.html,
// UpdateNotice) und zeigt bei Unterschied einen Hinweis mit Button an. Erst
// ein Klick darauf schickt die Nachricht "applyUpdate" hierher, ersetzt den
// Cache-Eintrag und laedt die Seite neu.
const CACHE_NAME = "dienstplan-cache-v1";
const APP_FILE = "./dienstplan.html";

self.addEventListener("install", (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => cache.add(APP_FILE))
  );
  self.skipWaiting();
});

self.addEventListener("activate", (event) => {
  event.waitUntil(
    caches
      .keys()
      .then((keys) =>
        Promise.all(
          keys.filter((key) => key !== CACHE_NAME).map((key) => caches.delete(key))
        )
      )
      .then(() => self.clients.claim())
  );
});

self.addEventListener("fetch", (event) => {
  if (event.request.method !== "GET") return;
  event.respondWith(
    caches.match(event.request).then((cached) => cached || fetch(event.request))
  );
});

self.addEventListener("message", (event) => {
  if (event.data !== "applyUpdate") return;
  event.waitUntil(
    fetch(APP_FILE, { cache: "no-store" })
      .then((response) => {
        if (!response.ok) throw new Error("Update-Download fehlgeschlagen");
        return caches.open(CACHE_NAME).then((cache) => cache.put(APP_FILE, response));
      })
      .then(() => {
        event.source?.postMessage("updateApplied");
      })
  );
});
