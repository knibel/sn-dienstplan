const { When, Then } = require("@cucumber/cucumber");
const assert = require("assert");

Then("ist der Tagesmodus {string}", async function (mode) {
  const value = await this.page.locator("#dayMode").inputValue();
  assert.strictEqual(value, mode);
});

When("ich den Tagesmodus auf {string} setze", async function (mode) {
  await this.page.locator("#dayMode").selectOption({ label: mode });
});

When("ich als Info Tag {string} eintrage", async function (text) {
  await this.page.locator("#dayInfo").fill(text);
});

When("ich als Info Kita {string} eintrage", async function (text) {
  await this.page.locator("#houseInfo").fill(text);
});

Then("enthält das Feld Info Tag {string}", async function (text) {
  const value = await this.page.locator("#dayInfo").inputValue();
  assert.ok(value.includes(text), `Info Tag sollte "${text}" enthalten, war "${value}"`);
});

Then("enthält das Feld Info Kita {string}", async function (text) {
  const value = await this.page.locator("#houseInfo").inputValue();
  assert.ok(value.includes(text), `Info Kita sollte "${text}" enthalten, war "${value}"`);
});

Then("enthält das Feld Info Tag nicht {string}", async function (text) {
  const value = await this.page.locator("#dayInfo").inputValue();
  assert.ok(!value.includes(text), `Info Tag sollte nicht "${text}" enthalten`);
});

Then("sehe ich die Gruppen:", async function (table) {
  const expected = table.hashes().map((r) => r.Gruppe);
  const labels = await this.page.locator(".g-label").allInnerTexts();
  assert.deepStrictEqual(labels, expected);
});

Then("sehe ich die Schichtspalten:", async function (table) {
  const expected = table.hashes().map((r) => r.Schicht);
  const heads = await this.page.locator(".ghead").allInnerTexts();
  for (const shift of expected) {
    assert.ok(heads.includes(shift), `Schichtspalte "${shift}" fehlt in ${heads.join(", ")}`);
  }
});

function groupLabel(page, group) {
  return page.locator(".g-label").filter({ hasText: new RegExp(`^${escapeRegExp(group)}$`) });
}

function escapeRegExp(s) {
  return s.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
}

When(
  "ich für die Gruppe {string} den Kommentar {string} eintrage",
  async function (group, comment) {
    const rowLabel = groupLabel(this.page, group);
    const commentBox = rowLabel.locator(
      "xpath=following-sibling::div[contains(@class,'commentcol')][1]//textarea"
    );
    await commentBox.fill(comment);
  }
);

Then(
  "enthält der Kommentar der Gruppe {string} {string}",
  async function (group, comment) {
    const rowLabel = groupLabel(this.page, group);
    const commentBox = rowLabel.locator(
      "xpath=following-sibling::div[contains(@class,'commentcol')][1]//textarea"
    );
    const value = await commentBox.inputValue();
    assert.ok(value.includes(comment), `Kommentar sollte "${comment}" enthalten, war "${value}"`);
  }
);
