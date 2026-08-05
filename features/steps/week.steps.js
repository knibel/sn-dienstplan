const { When, Then } = require("@cucumber/cucumber");
const assert = require("assert");

Then(
  "die Wochenbeschriftung zeigt einen Datumsbereich von Montag bis Freitag",
  async function () {
    const label = await this.page.locator("#weekLabel").innerText();
    assert.match(label, /^\d{2}\.\d{2}\.\d{4}\s+–\s+\d{2}\.\d{2}\.\d{4}$/);

    const [from, to] = label.split("–").map((s) => s.trim());
    const parse = (s) => {
      const [d, m, y] = s.split(".").map(Number);
      return new Date(y, m - 1, d);
    };
    const fromDate = parse(from);
    const toDate = parse(to);
    assert.strictEqual(fromDate.getDay(), 1, "Start sollte Montag sein");
    assert.strictEqual(toDate.getDay(), 5, "Ende sollte Freitag sein");
    const diffDays = (toDate - fromDate) / (1000 * 60 * 60 * 24);
    assert.strictEqual(diffDays, 4);
  }
);

Then("der Tag {string} ist aktiv", async function (day) {
  const active = this.page.locator(".daytab.active");
  await assert.doesNotReject(async () => {
    await active.waitFor();
  });
  const text = await active.innerText();
  assert.ok(text.startsWith(day), `Aktiver Tag sollte "${day}" sein, war "${text}"`);
});

When("ich zur nächsten Woche wechsle", async function () {
  const before = await this.page.locator("#weekLabel").innerText();
  this.weekLabelBeforeNav = before;
  await this.page.locator("#nextWeek").click();
  await this.page.waitForFunction(
    (prev) => document.getElementById("weekLabel")?.textContent !== prev,
    before
  );
});

When("ich zur vorherigen Woche wechsle", async function () {
  const before = await this.page.locator("#weekLabel").innerText();
  this.weekLabelBeforeNav = before;
  await this.page.locator("#prevWeek").click();
  await this.page.waitForFunction(
    (prev) => document.getElementById("weekLabel")?.textContent !== prev,
    before
  );
});

Then("ändert sich die Wochenbeschriftung", async function () {
  const current = await this.page.locator("#weekLabel").innerText();
  assert.notStrictEqual(current, this.weekLabelBeforeNav);
});

When("ich mir die Wochenbeschriftung merke", async function () {
  this.lastWeekLabel = await this.page.locator("#weekLabel").innerText();
});

Then("ist die Wochenbeschriftung wieder die gemerkte", async function () {
  const current = await this.page.locator("#weekLabel").innerText();
  assert.strictEqual(current, this.lastWeekLabel);
});

Then("sehe ich die Tagesreiter:", async function (table) {
  const expected = table.hashes().map((r) => r.Tag);
  const tabs = await this.page.locator(".daytab").allInnerTexts();
  const names = tabs.map((t) => t.split(/\s+/)[0]);
  assert.deepStrictEqual(names, expected);
});

When("ich den Tag {string} wähle", async function (day) {
  await this.page.locator(".daytab", { hasText: day }).click();
});

When("ich die Woche zurücksetze", async function () {
  await this.acceptNextDialog();
  await this.page.locator("#btnResetWeek").click();
  await this.page.waitForTimeout(100);
});

When("ich die Vorwoche kopiere", async function () {
  await this.acceptNextDialog();
  await this.page.locator("#btnCopyPrev").click();
  await this.page.waitForTimeout(100);
});

When("ich versuche die Vorwoche zu kopieren", async function () {
  const dialogPromise = this.captureNextDialog();
  await this.page.locator("#btnCopyPrev").click();
  await dialogPromise;
});
