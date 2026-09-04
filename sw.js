// Service Worker fuer das online gehostete Dienstplan (z.B. GitHub Pages).
// Wird lokal per file:// geoeffnet nicht genutzt/registriert.
//
// Strategie: network-first fuer dienstplan.html. Ist der Client online,
// kommt immer die aktuelle Version vom Server (= Updates landen sofort beim
// naechsten Laden der Seite). Ist der Client offline, wird die zuletzt
// gecachte Version ausgeliefert.
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
    fetch(event.request)
      .then((response) => {
        if (response.ok) {
          const copy = response.clone();
          caches.open(CACHE_NAME).then((cache) => cache.put(event.request, copy));
        }
        return response;
      })
      .catch(() => caches.match(event.request))
  );
});
