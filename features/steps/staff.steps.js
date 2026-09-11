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
  "ich eine neue Person {string} in Gruppe {string} hinzufüge",
  async function (name, group) {
    await this.page.locator("#newName").fill(name);
    await this.page.locator("#newGroup").selectOption({ label: group });
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

// ---- Kennzeichnung: SpringerIn / PraktikantIn ----

function staffRow(page, name) {
  return page.locator("#staffList .staffrow", { hasText: name });
}

When(
  "ich eine neue Person {string} als {string} hinzufüge",
  async function (name, role) {
    await this.page.locator("#newName").fill(name);
    await this.page.locator("#newRole").selectOption({ label: role });
    await this.page.locator("#newAdd").click();
    await staffRow(this.page, name).waitFor();
  }
);

When(
  "ich die Kennzeichnung der Person {string} auf {string} setze",
  async function (name, role) {
    await staffRow(this.page, name).locator("select.role").selectOption({ label: role });
  }
);

When(
  "ich die Stammgruppe der Person {string} auf {string} setze",
  async function (name, group) {
    await staffRow(this.page, name).locator("select.stamm").selectOption({ label: group });
  }
);

Then(
  "ist die Person {string} im Personal-Dialog als {string} gekennzeichnet",
  async function (name, role) {
    const row = staffRow(this.page, name);
    const selected = await row.locator("select.role option:checked").textContent();
    assert.strictEqual(selected, role);
    const badge = await row.locator(".nm .role").textContent();
    assert.strictEqual(badge.trim(), role);
  }
);

Then(
  "hat die Person {string} im Personal-Dialog keine Stammgruppe",
  async function (name) {
    const row = staffRow(this.page, name);
    assert.strictEqual(await row.locator("select.stamm").isVisible(), false);
    const stamm = await this.page.evaluate(
      (n) => Staff.byName(Store.get().staff, n).stamm,
      name
    );
    assert.strictEqual(stamm, null);
  }
);

async function roleBadgeOf(page, selector) {
  const badge = page.locator(`${selector} small.role`);
  if ((await badge.count()) === 0) return null;
  return {
    text: (await badge.textContent()).trim(),
    cls: await badge.getAttribute("class"),
    bg: await badge.evaluate((el) => getComputedStyle(el).backgroundColor),
  };
}

Then("ist der Pool-Chip {string} als {string} gekennzeichnet", async function (name, role) {
  const badge = await roleBadgeOf(this.page, `#pool .chip[data-name="${name}"]`);
  assert.ok(badge, `Pool-Chip "${name}" hat keine Kennzeichnung`);
  assert.strictEqual(badge.text, role);
});

Then("ist der Chip {string} als {string} gekennzeichnet", async function (name, role) {
  const badge = await roleBadgeOf(this.page, `#grid .chip[data-name="${name}"]`);
  assert.ok(badge, `Chip "${name}" hat keine Kennzeichnung`);
  assert.strictEqual(badge.text, role);
});

Then("ist der Chip {string} nicht gekennzeichnet", async function (name) {
  const badge = await roleBadgeOf(this.page, `#grid .chip[data-name="${name}"]`);
  assert.strictEqual(badge, null, `Chip "${name}" sollte keine Kennzeichnung haben`);
});

Then("ist der Chip {string} nicht als Gasteinsatz markiert", async function (name) {
  const cls = await this.page.locator(`#grid .chip[data-name="${name}"]`).getAttribute("class");
  assert.ok(!cls.includes("guest"), `Chip "${name}" sollte nicht als Gast markiert sein, war "${cls}"`);
});

Then(
  "sind die Chips {string} und {string} unterschiedlich gekennzeichnet",
  async function (a, b) {
    const ba = await roleBadgeOf(this.page, `#grid .chip[data-name="${a}"]`);
    const bb = await roleBadgeOf(this.page, `#grid .chip[data-name="${b}"]`);
    assert.ok(ba && bb, "Beide Chips brauchen eine Kennzeichnung");
    assert.notStrictEqual(ba.text, bb.text, "Beschriftung sollte sich unterscheiden");
    assert.notStrictEqual(ba.bg, bb.bg, "Farbe der Kennzeichnung sollte sich unterscheiden");
  }
);

When(
  "ich {string} aus dem Pool in Gruppe {string} und Schicht {string} ziehe",
  async function (name, group, shift) {
    const cell = this.page.locator(this.cellSelector(group, shift));
    // Ziel mittig scrollen, damit es nicht unter Header/Toolbar (sticky) liegt.
    await cell.evaluate((el) => el.scrollIntoView({ block: "center" }));
    await this.page.locator(`#pool .chip[data-name="${name}"]`).dragTo(cell);
  }
);

function printPerson(page, name) {
  return page.evaluate((n) => {
    const s = Store.get();
    const box = document.createElement("div");
    box.innerHTML = Print.buildWeek(s.weeks[Store.weekKey()], s.staff, s.groups, s);
    const el = [...box.querySelectorAll(".pr-person")].find((p) =>
      p.firstChild && p.firstChild.textContent.trim() === n
    );
    if (!el) return null;
    // Kennzeichnung steckt als Klasse "role-<key>" am Namen selbst (kein Zusatztext)
    const m = /\brole-(\w+)/.exec(el.className);
    return { role: m ? Constants.roleLabel(m[1]) : null, text: el.textContent.trim() };
  }, name);
}

Then(
  "ist {string} in der Druckansicht der aktuellen Woche als {string} gekennzeichnet",
  async function (name, role) {
    const p = await printPerson(this.page, name);
    assert.ok(p, `"${name}" nicht in der Druckansicht gefunden`);
    assert.strictEqual(p.role, role);
    assert.strictEqual(p.text, name, "Kennzeichnung soll ohne Zusatztext am Namen erfolgen");
  }
);

Then(
  "ist {string} in der Druckansicht der aktuellen Woche nicht gekennzeichnet",
  async function (name) {
    const p = await printPerson(this.page, name);
    assert.ok(p, `"${name}" nicht in der Druckansicht gefunden`);
    assert.strictEqual(p.role, null);
  }
);
