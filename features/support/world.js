const { setWorldConstructor, World } = require("@cucumber/cucumber");
const path = require("path");
const { pathToFileURL } = require("url");

class DienstplanWorld extends World {
  constructor(options) {
    super(options);
    this.browser = null;
    this.context = null;
    this.page = null;
    this.lastWeekLabel = null;
    this.lastDownloadPath = null;
    this.lastAlertMessage = null;
    this.appUrl = pathToFileURL(
      path.resolve(__dirname, "../../dienstplan.html")
    ).href;
  }

  async openApp({ clearStorage = true } = {}) {
    await this.page.goto(this.appUrl);
    if (clearStorage) {
      await this.page.evaluate(() => localStorage.clear());
      await this.page.reload();
    }
    await this.page.waitForSelector("#weekLabel");
    await this.page.waitForFunction(
      () => document.getElementById("weekLabel")?.textContent?.trim().length > 0
    );
    // Frischer Start: lokale Entwicklungs-JSON per „Laden“ einspielen
    if (clearStorage) {
      const localJson = path.resolve(__dirname, "../../dienstplan.local.json");
      await this.page.locator("#fileInput").setInputFiles(localJson);
      await this.page.waitForFunction(
        () => (document.querySelectorAll("#grid .chip").length > 0)
      );
    }
  }

  async acceptNextDialog() {
    this.page.once("dialog", async (dialog) => {
      this.lastAlertMessage = dialog.message();
      await dialog.accept();
    });
  }

  async captureNextDialog() {
    return new Promise((resolve) => {
      this.page.once("dialog", async (dialog) => {
        this.lastAlertMessage = dialog.message();
        await dialog.accept();
        resolve(dialog.message());
      });
    });
  }

  shiftKey(label) {
    const map = {
      Frühschicht: "frueh",
      Mittelschicht: "mittel",
      Spätschicht: "spaet",
    };
    if (!map[label]) throw new Error(`Unbekannte Schicht: ${label}`);
    return map[label];
  }

  cellSelector(group, shiftLabel) {
    const shift = this.shiftKey(shiftLabel);
    return `.cell[data-group="${group}"][data-shift="${shift}"]`;
  }
}

setWorldConstructor(DienstplanWorld);
