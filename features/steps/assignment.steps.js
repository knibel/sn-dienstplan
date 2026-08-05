const { When, Then } = require("@cucumber/cucumber");
const assert = require("assert");

Then(
  "ist {string} in Gruppe {string} und Schicht {string} eingeteilt",
  async function (name, group, shift) {
    const cell = this.page.locator(this.cellSelector(group, shift));
    const chip = cell.locator(`.chip[data-name="${name}"]`);
    await chip.waitFor({ state: "visible" });
  }
);

Then(
  "ist {string} nicht in Gruppe {string} und Schicht {string} eingeteilt",
  async function (name, group, shift) {
    const cell = this.page.locator(this.cellSelector(group, shift));
    const chip = cell.locator(`.chip[data-name="${name}"]`);
    await assert.strictEqual(await chip.count(), 0);
  }
);

Then("ist {string} nicht eingeteilt", async function (name) {
  const chipInGrid = this.page.locator(`#grid .chip[data-name="${name}"]`);
  await assert.strictEqual(await chipInGrid.count(), 0);
});

Then("der Pool zeigt {string}", async function (text) {
  const pool = await this.page.locator("#pool").innerText();
  assert.ok(pool.includes(text), `Pool sollte "${text}" enthalten, war "${pool}"`);
});

Then("erscheint {string} im Pool", async function (name) {
  const chip = this.page.locator(`#pool .chip[data-name="${name}"]`);
  await chip.waitFor({ state: "visible" });
});

Then("erscheint {string} nicht im Pool", async function (name) {
  const chip = this.page.locator(`#pool .chip[data-name="${name}"]`);
  await assert.strictEqual(await chip.count(), 0);
});

When("ich den Chip {string} öffne", async function (name) {
  await this.page.locator(`#grid .chip[data-name="${name}"]`).click();
  await this.page.locator("#chipDialog").waitFor({ state: "visible" });
});

When("ich im Chip-Dialog die Schicht {string} wähle", async function (shift) {
  await this.page.locator("#dlgShift").selectOption({ label: shift });
});

When("ich im Chip-Dialog die Gruppe {string} wähle", async function (group) {
  // options may be "Hasen" or "Hasen (Stamm)"
  const options = await this.page.locator("#dlgGroup option").allTextContents();
  const match = options.find((o) => o === group || o.startsWith(group + " "));
  assert.ok(match, `Gruppe "${group}" nicht im Dialog gefunden`);
  await this.page.locator("#dlgGroup").selectOption({ label: match });
});

When("ich im Chip-Dialog die Abwesenheit {string} wähle", async function (away) {
  await this.page.locator("#dlgAway").selectOption({ label: away });
});

When("ich den Chip-Dialog mit {string} bestätige", async function (action) {
  const map = {
    Übernehmen: "#dlgOk",
    Abbrechen: "#dlgCancel",
    "Aus Plan nehmen": "#dlgRemove",
  };
  const sel = map[action];
  assert.ok(sel, `Unbekannte Dialog-Aktion: ${action}`);
  await this.page.locator(sel).click();
  await this.page.locator("#chipDialog").waitFor({ state: "hidden" });
});

Then("ist der Chip {string} als {string} markiert", async function (name, away) {
  const chip = this.page.locator(`#grid .chip[data-name="${name}"]`);
  const cls = await chip.getAttribute("class");
  assert.ok(
    cls.includes(`away-${away}`),
    `Chip "${name}" sollte Klasse away-${away} haben, war "${cls}"`
  );
});

Then("ist der Chip {string} als Gasteinsatz markiert", async function (name) {
  const chip = this.page.locator(`#grid .chip[data-name="${name}"]`);
  const cls = await chip.getAttribute("class");
  assert.ok(cls.includes("guest"), `Chip "${name}" sollte Klasse guest haben, war "${cls}"`);
});
