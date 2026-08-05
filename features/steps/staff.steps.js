const { When, Then } = require("@cucumber/cucumber");
const assert = require("assert");

When("ich den Personal-Dialog öffne", async function () {
  await this.page.locator("#btnStaff").click();
  await this.page.locator("#staffDialog").waitFor({ state: "visible" });
});

When("ich den Personal-Dialog schließe", async function () {
  await this.page.locator("#staffClose").click();
  await this.page.locator("#staffDialog").waitFor({ state: "hidden" });
});

Then("sehe ich im Personal-Dialog die Person {string}", async function (name) {
  const row = this.page.locator("#staffList .staffrow", { hasText: name });
  await row.waitFor({ state: "visible" });
});

When(
  "ich eine neue Person {string} in Gruppe {string} mit Schicht {string} hinzufüge",
  async function (name, group, shift) {
    await this.page.locator("#newName").fill(name);
    await this.page.locator("#newGroup").selectOption({ label: group });
    await this.page.locator("#newShift").selectOption({ label: shift });
    await this.page.locator("#newAdd").click();
    await this.page.locator("#staffList .staffrow", { hasText: name }).waitFor();
  }
);

When("ich die Person {string} deaktiviere", async function (name) {
  const row = this.page.locator("#staffList .staffrow", { hasText: name });
  await row.getByRole("button", { name: "Deaktivieren" }).click();
  await row.waitFor({ state: "visible" });
  const cls = await row.getAttribute("class");
  assert.ok(cls.includes("inactive"), `Person "${name}" sollte inaktiv sein`);
});

When("ich versuche die Person {string} zu löschen", async function (name) {
  const row = this.page.locator("#staffList .staffrow", { hasText: name });
  const dialogPromise = this.captureNextDialog();
  await row.getByRole("button", { name: "Löschen" }).click();
  await dialogPromise;
});
