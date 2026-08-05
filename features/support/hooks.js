const { Before, After, BeforeAll, AfterAll, setDefaultTimeout } = require("@cucumber/cucumber");
const { chromium } = require("playwright");
const fs = require("fs");
const path = require("path");

setDefaultTimeout(30_000);

const DOWNLOAD_DIR = path.resolve(__dirname, "../../test-results/downloads");
const REPORT_DIR = path.resolve(__dirname, "../../reports");

let sharedBrowser;

BeforeAll(async function () {
  fs.mkdirSync(DOWNLOAD_DIR, { recursive: true });
  fs.mkdirSync(REPORT_DIR, { recursive: true });

  // Lokale JSON ist gitignored – für Tests aus der Vorlage anlegen, falls fehlend
  const localPath = path.resolve(__dirname, "../../dienstplan.local.json");
  const examplePath = path.resolve(__dirname, "../../dienstplan.local.example.json");
  if (!fs.existsSync(localPath) && fs.existsSync(examplePath)) {
    fs.copyFileSync(examplePath, localPath);
  }

  sharedBrowser = await chromium.launch({
    headless: process.env.HEADED !== "1",
  });
});

AfterAll(async function () {
  if (sharedBrowser) await sharedBrowser.close();
});

Before(async function () {
  this.browser = sharedBrowser;
  this.context = await this.browser.newContext({
    acceptDownloads: true,
    locale: "de-DE",
  });
  // Klassischer Download statt File System Access API (kein Dateidialog in Headless)
  await this.context.addInitScript(() => {
    delete window.showSaveFilePicker;
  });
  this.page = await this.context.newPage();
  this.downloadDir = DOWNLOAD_DIR;
  this.lastAlertMessage = null;
  this.lastDownloadPath = null;
  this.lastWeekLabel = null;
});

After(async function () {
  if (this.page) await this.page.close();
  if (this.context) await this.context.close();
});
