const { When, Then } = require("@cucumber/cucumber");
const assert = require("assert");
const path = require("path");
const fs = require("fs");

When("ich den Plan speichere", async function () {
  await this.page.locator("#btnSave").click();
});

When("ich Speichern unter wähle", async function () {
  const [download] = await Promise.all([
    this.page.waitForEvent("download"),
    this.page.locator("#btnSaveAs").click(),
  ]);
  const suggested = download.suggestedFilename();
  const target = path.join(this.downloadDir, suggested);
  await download.saveAs(target);
  this.lastDownloadPath = target;
  this.lastDownloadName = suggested;
});

When("ich die Anwendung schließe und wieder öffne", async function () {
  await this.page.close();
  this.page = await this.context.newPage();
  await this.openApp({ clearStorage: false });
});

Then("wird eine JSON-Datei heruntergeladen", async function () {
  assert.ok(this.lastDownloadName.endsWith(".json"), `Erwartete .json, war ${this.lastDownloadName}`);
  assert.ok(fs.existsSync(this.lastDownloadPath));
});

Then("enthält die heruntergeladene JSON-Datei {string}", async function (fragment) {
  assert.ok(this.lastDownloadPath, "Keine heruntergeladene Datei vorhanden");
  const content = fs.readFileSync(this.lastDownloadPath, "utf8");
  assert.ok(content.includes(fragment), `Erwartete "${fragment}" in JSON, Inhalt war: ${content.slice(0, 200)}`);
});

When("ich den Druckdialog öffne", async function () {
  await this.page.locator("#btnPrint").click();
  await this.page.locator("#printDialog").waitFor({ state: "visible" });
});

Then("ist der Druckdialog geöffnet", async function () {
  assert.ok(await this.page.locator("#printDialog").isVisible());
});

Then("ist der Druckdialog geschlossen", async function () {
  await this.page.locator("#printDialog").waitFor({ state: "hidden" });
});

Then("kann ich den Druckumfang {string} wählen", async function (label) {
  const options = await this.page.locator("#printScope option").allTextContents();
  assert.ok(options.includes(label), `Druckumfang "${label}" fehlt`);
});

When("ich den Druckdialog abbreche", async function () {
  await this.page.locator("#printCancel").click();
});
