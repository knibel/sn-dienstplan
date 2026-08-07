const { When, Then } = require("@cucumber/cucumber");
const assert = require("assert");

function activityRow(page, name) {
  return page.locator(`#activitiesList .staffrow[data-activity="${name}"]`);
}

function poolChip(page, name) {
  return page.locator(`#activityPool .chip[data-activity="${name}"]`);
}

function plannedChip(world, name, group, shiftLabel) {
  return world.page
    .locator(world.cellSelector(group, shiftLabel))
    .locator(`.chip.activity[data-activity="${name}"]`);
}

When("ich den Aktivitäten-Dialog öffne", async function () {
  await this.page.locator("#btnActivities").click();
  await this.page.locator("#activitiesDialog").waitFor({ state: "visible" });
});

When("ich den Aktivitäten-Dialog schließe", async function () {
  await this.page.locator("#activitiesClose").click();
  await this.page.locator("#activitiesDialog").waitFor({ state: "hidden" });
});

Then("sehe ich im Aktivitäten-Dialog die Aktivität {string}", async function (name) {
  await activityRow(this.page, name).waitFor({ state: "visible" });
});

Then("sehe ich im Aktivitäten-Dialog nicht die Aktivität {string}", async function (name) {
  await activityRow(this.page, name).waitFor({ state: "hidden" });
});

When("ich eine neue Aktivität {string} hinzufüge", async function (name) {
  await this.page.locator("#newActivityName").fill(name);
  await this.page.locator("#newActivityAdd").click();
  await activityRow(this.page, name).waitFor();
});

When(
  "ich eine neue Aktivität {string} mit Icon {string} hinzufüge",
  async function (name, icon) {
    await this.page.locator("#newActivityName").fill(name);
    await this.page.locator(`#newActivityIcons .icon-swatch[data-icon="${icon}"]`).click();
    await this.page.locator("#newActivityAdd").click();
    await activityRow(this.page, name).waitFor();
  }
);

When("ich das Icon der Aktivität {string} auf {string} setze", async function (name, icon) {
  await activityRow(this.page, name).locator(`.icon-swatch[data-icon="${icon}"]`).click();
});

Then("hat die Aktivität {string} das Icon {string}", async function (name, icon) {
  const row = activityRow(this.page, name);
  const selected = await row.locator(".icon-swatch.selected").getAttribute("data-icon");
  assert.strictEqual(selected, icon, `Aktivität "${name}" sollte Icon ${icon} haben, war ${selected}`);
  const shown = await row.locator(".ico").innerText();
  assert.strictEqual(shown.trim(), icon);
});

When("ich versuche eine Aktivität ohne Namen hinzuzufügen", async function () {
  await this.page.locator("#newActivityName").fill("");
  const dialogPromise = this.captureNextDialog();
  await this.page.locator("#newActivityAdd").click();
  await dialogPromise;
});

When("ich versuche die Aktivität {string} erneut hinzuzufügen", async function (name) {
  await this.page.locator("#newActivityName").fill(name);
  const dialogPromise = this.captureNextDialog();
  await this.page.locator("#newActivityAdd").click();
  await dialogPromise;
});

When("ich versuche die Aktivität {string} zu löschen", async function (name) {
  const dialogPromise = this.captureNextDialog();
  await activityRow(this.page, name).getByRole("button", { name: "Löschen" }).click();
  await dialogPromise;
});

When("ich die Aktivität {string} lösche", async function (name) {
  const row = activityRow(this.page, name);
  const dialogPromise = this.captureNextDialog();
  await row.getByRole("button", { name: "Löschen" }).click();
  await dialogPromise;
  await row.waitFor({ state: "hidden" });
});

Then("erscheint die Aktivität {string} im Aktivitäten-Pool", async function (name) {
  await poolChip(this.page, name).waitFor({ state: "visible" });
});

Then("erscheint die Aktivität {string} nicht im Aktivitäten-Pool", async function (name) {
  assert.strictEqual(await poolChip(this.page, name).count(), 0);
});

Then(
  "zeigt die Aktivität {string} im Aktivitäten-Pool das Icon {string}",
  async function (name, icon) {
    const shown = await poolChip(this.page, name).locator(".ico").innerText();
    assert.strictEqual(shown.trim(), icon, `Pool-Chip "${name}" sollte Icon ${icon} zeigen, war ${shown}`);
  }
);

When(
  "ich die Aktivität {string} in Gruppe {string} und Schicht {string} ziehe",
  async function (name, group, shiftLabel) {
    const before = await plannedChip(this, name, group, shiftLabel).count();
    await poolChip(this.page, name).dragTo(this.page.locator(this.cellSelector(group, shiftLabel)));
    await this.page.waitForFunction(
      ({ selector, expected }) => document.querySelectorAll(selector).length === expected,
      {
        selector: `${this.cellSelector(group, shiftLabel)} .chip.activity[data-activity="${name}"]`,
        expected: before + 1,
      }
    );
  }
);

Then(
  "ist die Aktivität {string} in Gruppe {string} und Schicht {string} eingeplant",
  async function (name, group, shiftLabel) {
    await plannedChip(this, name, group, shiftLabel).first().waitFor({ state: "visible" });
  }
);

Then(
  "ist die Aktivität {string} nicht in Gruppe {string} und Schicht {string} eingeplant",
  async function (name, group, shiftLabel) {
    assert.strictEqual(await plannedChip(this, name, group, shiftLabel).count(), 0);
  }
);

Then("ist die Aktivität {string} nicht eingeplant", async function (name) {
  const chips = this.page.locator(`#grid .chip.activity[data-activity="${name}"]`);
  assert.strictEqual(await chips.count(), 0);
});

When(
  "ich die geplante Aktivität {string} in Gruppe {string} und Schicht {string} öffne",
  async function (name, group, shiftLabel) {
    await plannedChip(this, name, group, shiftLabel).first().click();
    await this.page.locator("#activityDialog").waitFor({ state: "visible" });
  }
);

When("ich im Aktivitäts-Dialog die Schicht {string} wähle", async function (shift) {
  await this.page.locator("#actDlgShift").selectOption({ label: shift });
});

When("ich im Aktivitäts-Dialog die Gruppe {string} wähle", async function (group) {
  await this.page.locator("#actDlgGroup").selectOption({ label: group });
});

When("ich den Aktivitäts-Dialog mit {string} bestätige", async function (action) {
  const map = {
    Übernehmen: "#actDlgOk",
    Abbrechen: "#actDlgCancel",
    "Aus Plan nehmen": "#actDlgRemove",
  };
  const sel = map[action];
  assert.ok(sel, `Unbekannte Dialog-Aktion: ${action}`);
  await this.page.locator(sel).click();
  await this.page.locator("#activityDialog").waitFor({ state: "hidden" });
});
