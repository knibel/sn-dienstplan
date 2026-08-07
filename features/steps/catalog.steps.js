const { When, Then } = require("@cucumber/cucumber");
const assert = require("assert");

// Kategorien verhalten sich technisch identisch – die Schritte gelten deshalb
// für "Aktivitäten" und "Sonstiges" gleichermaßen.
const POOL_ID = { activity: "activityPool", misc: "miscPool" };
const CAT_BY_LABEL = { Aktivitäten: "activity", Sonstiges: "misc" };
const CAT_BY_NOUN = { Aktivität: "activity", Eintrag: "misc" };

function catOfLabel(label) {
  const cat = CAT_BY_LABEL[label];
  assert.ok(cat, `Unbekannte Kategorie: ${label}`);
  return cat;
}

function catOfNoun(noun) {
  const cat = CAT_BY_NOUN[noun];
  assert.ok(cat, `Unbekannte Kategorie: ${noun}`);
  return cat;
}

function catalogRow(page, name) {
  return page.locator(`#catalogList .staffrow[data-item="${name}"]`);
}

function poolChip(page, cat, name) {
  return page.locator(`#${POOL_ID[cat]} .chip.item[data-item="${name}"]`);
}

function plannedChip(world, cat, name, group, shiftLabel) {
  return world.page
    .locator(world.cellSelector(group, shiftLabel))
    .locator(`.chip.item[data-cat="${cat}"][data-item="${name}"]`);
}

When(/^ich den (Aktivitäten|Sonstiges)-Dialog öffne$/, async function (label) {
  const cat = catOfLabel(label);
  await this.page.locator(cat === "activity" ? "#btnActivities" : "#btnMisc").click();
  await this.page.locator(`#catalogDialog[data-cat="${cat}"]`).waitFor({ state: "visible" });
});

When(/^ich den (?:Aktivitäten|Sonstiges)-Dialog schließe$/, async function () {
  await this.page.locator("#catalogClose").click();
  await this.page.locator("#catalogDialog").waitFor({ state: "hidden" });
});

Then(
  /^sehe ich im (?:Aktivitäten|Sonstiges)-Dialog (?:die|den) (?:Aktivität|Eintrag) "([^"]*)"$/,
  async function (name) {
    await catalogRow(this.page, name).waitFor({ state: "visible" });
  }
);

Then(
  /^sehe ich im (?:Aktivitäten|Sonstiges)-Dialog nicht (?:die|den) (?:Aktivität|Eintrag) "([^"]*)"$/,
  async function (name) {
    await catalogRow(this.page, name).waitFor({ state: "hidden" });
  }
);

When(
  /^ich (?:eine neue Aktivität|einen neuen Eintrag) "([^"]*)" hinzufüge$/,
  async function (name) {
    await this.page.locator("#newItemName").fill(name);
    await this.page.locator("#newItemAdd").click();
    await catalogRow(this.page, name).waitFor();
  }
);

When(
  /^ich (?:eine neue Aktivität|einen neuen Eintrag) "([^"]*)" mit Icon "([^"]*)" hinzufüge$/,
  async function (name, icon) {
    await this.page.locator("#newItemName").fill(name);
    await this.page.locator(`#newItemIcons .icon-swatch[data-icon="${icon}"]`).click();
    await this.page.locator("#newItemAdd").click();
    await catalogRow(this.page, name).waitFor();
  }
);

When(
  /^ich das Icon (?:der Aktivität|des Eintrags) "([^"]*)" auf "([^"]*)" setze$/,
  async function (name, icon) {
    await catalogRow(this.page, name).locator(`.icon-swatch[data-icon="${icon}"]`).click();
  }
);

Then(
  /^hat (?:die|der) (?:Aktivität|Eintrag) "([^"]*)" das Icon "([^"]*)"$/,
  async function (name, icon) {
    const row = catalogRow(this.page, name);
    const selected = await row.locator(".icon-swatch.selected").getAttribute("data-icon");
    assert.strictEqual(selected, icon, `"${name}" sollte Icon ${icon} haben, war ${selected}`);
    const shown = await row.locator(".ico").innerText();
    assert.strictEqual(shown.trim(), icon);
  }
);

When(
  /^ich versuche (?:eine Aktivität|einen Eintrag) ohne Namen hinzuzufügen$/,
  async function () {
    await this.page.locator("#newItemName").fill("");
    const dialogPromise = this.captureNextDialog();
    await this.page.locator("#newItemAdd").click();
    await dialogPromise;
  }
);

When(
  /^ich versuche (?:die Aktivität|den Eintrag) "([^"]*)" erneut hinzuzufügen$/,
  async function (name) {
    await this.page.locator("#newItemName").fill(name);
    const dialogPromise = this.captureNextDialog();
    await this.page.locator("#newItemAdd").click();
    await dialogPromise;
  }
);

When(
  /^ich versuche (?:die Aktivität|den Eintrag) "([^"]*)" zu löschen$/,
  async function (name) {
    const dialogPromise = this.captureNextDialog();
    await catalogRow(this.page, name).getByRole("button", { name: "Löschen" }).click();
    await dialogPromise;
  }
);

When(/^ich (?:die Aktivität|den Eintrag) "([^"]*)" lösche$/, async function (name) {
  const row = catalogRow(this.page, name);
  const dialogPromise = this.captureNextDialog();
  await row.getByRole("button", { name: "Löschen" }).click();
  await dialogPromise;
  await row.waitFor({ state: "hidden" });
});

Then(
  /^erscheint (?:die|der) (?:Aktivität|Eintrag) "([^"]*)" im (Aktivitäten|Sonstiges)-Pool$/,
  async function (name, label) {
    await poolChip(this.page, catOfLabel(label), name).waitFor({ state: "visible" });
  }
);

Then(
  /^erscheint (?:die|der) (?:Aktivität|Eintrag) "([^"]*)" nicht im (Aktivitäten|Sonstiges)-Pool$/,
  async function (name, label) {
    assert.strictEqual(await poolChip(this.page, catOfLabel(label), name).count(), 0);
  }
);

Then(
  /^zeigt (?:die|der) (?:Aktivität|Eintrag) "([^"]*)" im (Aktivitäten|Sonstiges)-Pool das Icon "([^"]*)"$/,
  async function (name, label, icon) {
    const shown = await poolChip(this.page, catOfLabel(label), name).locator(".ico").innerText();
    assert.strictEqual(shown.trim(), icon, `Pool-Chip "${name}" sollte Icon ${icon} zeigen, war ${shown}`);
  }
);

When(
  /^ich (?:die|den) (Aktivität|Eintrag) "([^"]*)" in Gruppe "([^"]*)" und Schicht "([^"]*)" ziehe$/,
  async function (noun, name, group, shiftLabel) {
    const cat = catOfNoun(noun);
    const before = await plannedChip(this, cat, name, group, shiftLabel).count();
    await poolChip(this.page, cat, name).dragTo(
      this.page.locator(this.cellSelector(group, shiftLabel))
    );
    await this.page.waitForFunction(
      ({ selector, expected }) => document.querySelectorAll(selector).length === expected,
      {
        selector:
          `${this.cellSelector(group, shiftLabel)} .chip.item[data-cat="${cat}"][data-item="${name}"]`,
        expected: before + 1,
      }
    );
  }
);

Then(
  /^ist (?:die|der) (Aktivität|Eintrag) "([^"]*)" in Gruppe "([^"]*)" und Schicht "([^"]*)" eingeplant$/,
  async function (noun, name, group, shiftLabel) {
    await plannedChip(this, catOfNoun(noun), name, group, shiftLabel)
      .first()
      .waitFor({ state: "visible" });
  }
);

Then(
  /^ist (?:die|der) (Aktivität|Eintrag) "([^"]*)" nicht in Gruppe "([^"]*)" und Schicht "([^"]*)" eingeplant$/,
  async function (noun, name, group, shiftLabel) {
    assert.strictEqual(
      await plannedChip(this, catOfNoun(noun), name, group, shiftLabel).count(),
      0
    );
  }
);

Then(/^ist (?:die|der) (Aktivität|Eintrag) "([^"]*)" nicht eingeplant$/, async function (noun, name) {
  const cat = catOfNoun(noun);
  const chips = this.page.locator(`#grid .chip.item[data-cat="${cat}"][data-item="${name}"]`);
  assert.strictEqual(await chips.count(), 0);
});

When(
  /^ich (?:die geplante|den geplanten) (Aktivität|Eintrag) "([^"]*)" in Gruppe "([^"]*)" und Schicht "([^"]*)" öffne$/,
  async function (noun, name, group, shiftLabel) {
    await plannedChip(this, catOfNoun(noun), name, group, shiftLabel).first().click();
    await this.page.locator("#itemDialog").waitFor({ state: "visible" });
  }
);

When(/^ich im (?:Aktivitäts|Eintrags)-Dialog die Schicht "([^"]*)" wähle$/, async function (shift) {
  await this.page.locator("#itemDlgShift").selectOption({ label: shift });
});

When(/^ich im (?:Aktivitäts|Eintrags)-Dialog die Gruppe "([^"]*)" wähle$/, async function (group) {
  await this.page.locator("#itemDlgGroup").selectOption({ label: group });
});

When(/^ich den (?:Aktivitäts|Eintrags)-Dialog mit "([^"]*)" bestätige$/, async function (action) {
  const map = {
    Übernehmen: "#itemDlgOk",
    Abbrechen: "#itemDlgCancel",
    "Aus Plan nehmen": "#itemDlgRemove",
  };
  const sel = map[action];
  assert.ok(sel, `Unbekannte Dialog-Aktion: ${action}`);
  await this.page.locator(sel).click();
  await this.page.locator("#itemDialog").waitFor({ state: "hidden" });
});
