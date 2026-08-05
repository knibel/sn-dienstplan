const { When, Then } = require("@cucumber/cucumber");
const assert = require("assert");

function groupRow(page, name) {
  return page.locator(`#groupsList .staffrow[data-group="${name}"]`);
}

function hexToRgb(hex) {
  const h = hex.replace("#", "");
  const n = parseInt(h.length === 3 ? h.split("").map((c) => c + c).join("") : h, 16);
  return `rgb(${(n >> 16) & 255}, ${(n >> 8) & 255}, ${n & 255})`;
}

When("ich den Gruppen-Dialog öffne", async function () {
  await this.page.locator("#btnGroups").click();
  await this.page.locator("#groupsDialog").waitFor({ state: "visible" });
});

When("ich den Gruppen-Dialog schließe", async function () {
  await this.page.locator("#groupsClose").click();
  await this.page.locator("#groupsDialog").waitFor({ state: "hidden" });
});

Then("sehe ich im Gruppen-Dialog die Gruppe {string}", async function (name) {
  await groupRow(this.page, name).waitFor({ state: "visible" });
});

Then("sehe ich im Gruppen-Dialog nicht die Gruppe {string}", async function (name) {
  await groupRow(this.page, name).waitFor({ state: "hidden" });
});

When("ich eine neue Gruppe {string} hinzufüge", async function (name) {
  await this.page.locator("#newGroupName").fill(name);
  await this.page.locator("#newGroupAdd").click();
  await groupRow(this.page, name).waitFor();
});

When("ich eine neue Gruppe {string} mit Farbe {string} hinzufüge", async function (name, color) {
  await this.page.locator("#newGroupName").fill(name);
  await this.page.locator(`#newGroupColors .color-swatch[data-color="${color}"]`).click();
  await this.page.locator("#newGroupAdd").click();
  await groupRow(this.page, name).waitFor();
});

When("ich die Farbe der Gruppe {string} auf {string} setze", async function (name, color) {
  await groupRow(this.page, name)
    .locator(`.color-swatch[data-color="${color}"]`)
    .click();
});

Then("hat die Gruppe {string} die Farbe {string}", async function (name, color) {
  const selected = groupRow(this.page, name).locator(".color-swatch.selected");
  const actual = await selected.getAttribute("data-color");
  assert.strictEqual(
    String(actual).toLowerCase(),
    color.toLowerCase(),
    `Gruppe "${name}" sollte Farbe ${color} haben, war ${actual}`
  );
});

Then("hat die Gruppenzeile {string} die Hintergrundfarbe {string}", async function (name, color) {
  const label = this.page.locator(".g-label").filter({ hasText: new RegExp(`^${name.replace(/[.*+?^${}()|[\]\\]/g, "\\$&")}$`) });
  const bg = await label.evaluate((el) => getComputedStyle(el).backgroundColor);
  assert.strictEqual(bg, hexToRgb(color), `Gruppenzeile "${name}" sollte ${color} haben, war ${bg}`);
});

When("ich versuche eine Gruppe ohne Namen hinzuzufügen", async function () {
  await this.page.locator("#newGroupName").fill("");
  const dialogPromise = this.captureNextDialog();
  await this.page.locator("#newGroupAdd").click();
  await dialogPromise;
});

When("ich versuche die Gruppe {string} erneut hinzuzufügen", async function (name) {
  await this.page.locator("#newGroupName").fill(name);
  const dialogPromise = this.captureNextDialog();
  await this.page.locator("#newGroupAdd").click();
  await dialogPromise;
});

When("ich versuche die Gruppe {string} zu löschen", async function (name) {
  const row = groupRow(this.page, name);
  const dialogPromise = this.captureNextDialog();
  await row.getByRole("button", { name: "Löschen" }).click();
  await dialogPromise;
});

When("ich die Gruppe {string} lösche", async function (name) {
  const row = groupRow(this.page, name);
  const dialogPromise = this.captureNextDialog();
  await row.getByRole("button", { name: "Löschen" }).click();
  await dialogPromise;
  await row.waitFor({ state: "hidden" });
});
