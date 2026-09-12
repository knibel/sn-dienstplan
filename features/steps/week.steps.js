const { When, Then } = require("@cucumber/cucumber");
const assert = require("assert");

Then(
  "die Wochenbeschriftung zeigt einen Datumsbereich von Montag bis Freitag",
  async function () {
    const label = await this.page.locator("#weekLabel").innerText();
    assert.match(
      label,
      /^KW\s+\d{1,2}\s+·\s+\d{2}\.\d{2}\.\d{4}\s+–\s+\d{2}\.\d{2}\.\d{4}$/
    );

    const [from, to] = label.split("·")[1].split("–").map((s) => s.trim());
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

// ---- Sprung zu Kalenderwoche / Tastenkürzel ----

async function submitGotoWeek(page, kw, year) {
  await page.locator("#gotoKW").fill(String(kw));
  await page.locator("#gotoYear").fill(String(year));
  await page.locator("#gotoWeekGo").click();
}

When(
  "ich per Klick auf die Wochenbeschriftung zu KW {int} im Jahr {int} springe",
  async function (kw, year) {
    const before = await this.page.locator("#weekLabel").innerText();
    await this.page.locator("#weekLabel").click();
    await this.page.locator("#gotoWeekDialog[open]").waitFor();
    await submitGotoWeek(this.page, kw, year);
    // Entweder schließt der Dialog und die Woche wechselt, oder er bleibt mit Fehler offen
    await this.page.waitForFunction(
      (prev) =>
        document.getElementById("gotoWeekError")?.textContent ||
        document.getElementById("weekLabel")?.textContent !== prev,
      before
    );
  }
);

When("ich die Taste {string} drücke", async function (key) {
  await this.page.locator("body").click({ position: { x: 1, y: 1 } });
  await this.page.keyboard.press(key);
  await this.page.waitForTimeout(100);
});

When(
  "ich im Sprungdialog KW {int} und Jahr {int} eingebe und bestätige",
  async function (kw, year) {
    await submitGotoWeek(this.page, kw, year);
    await this.page.locator("#gotoWeekDialog[open]").waitFor({ state: "detached" }).catch(() => {});
    await this.page.waitForTimeout(100);
  }
);

When("ich in das Tagesinfo-Feld {string} tippe", async function (text) {
  const field = this.page.locator("#dayInfo");
  await field.click();
  await field.type(text);
  await this.page.waitForTimeout(100);
});

Then("zeigt die Wochenbeschriftung {string}", async function (expected) {
  await this.page.waitForFunction(
    (exp) => document.getElementById("weekLabel")?.textContent === exp,
    expected
  );
});

Then("ist der Dialog {string} geöffnet", async function (title) {
  const dlg = this.page.locator("dialog[open]", { hasText: title });
  await dlg.waitFor();
});

Then("ist kein Dialog geöffnet", async function () {
  assert.strictEqual(await this.page.locator("dialog[open]").count(), 0);
});

Then("zeigt der Sprungdialog den Fehler {string}", async function (msg) {
  await this.page.locator("#gotoWeekError", { hasText: msg }).waitFor();
});

Then(
  "ist der Sprungdialog mit KW {int} und Jahr {int} vorbelegt",
  async function (kw, year) {
    assert.strictEqual(await this.page.locator("#gotoKW").inputValue(), String(kw));
    assert.strictEqual(await this.page.locator("#gotoYear").inputValue(), String(year));
  }
);

Then("zeigt die Wochenbeschriftung die heutige Woche", async function () {
  const expected = await this.page.evaluate(() => {
    const mon = Dates.mondayOf(new Date());
    return "KW " + Dates.isoWeek(mon) + " · " + Dates.fmtDE(mon) + " – " + Dates.fmtDE(Dates.addDays(mon, 4));
  });
  await this.page.waitForFunction(
    (exp) => document.getElementById("weekLabel")?.textContent === exp,
    expected
  );
});
