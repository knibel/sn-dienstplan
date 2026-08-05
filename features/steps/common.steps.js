const { Given, When, Then } = require("@cucumber/cucumber");
const assert = require("assert");

Given("die Dienstplan-App ist geöffnet", async function () {
  await this.openApp();
});

Then("sehe ich den Titel {string}", async function (title) {
  const text = await this.page.locator("header h1").innerText();
  assert.ok(text.includes(title), `Erwarteter Titel enthält "${title}", war "${text}"`);
});

Then("erscheint der Hinweis {string}", async function (msg) {
  const flash = this.page.locator("#flash");
  await flash.waitFor({ state: "visible" });
  await this.page.waitForFunction(
    (expected) => {
      const el = document.getElementById("flash");
      return el && el.classList.contains("show") && el.textContent.includes(expected);
    },
    msg
  );
});

Then("erscheint eine Meldung die {string} enthält", async function (fragment) {
  assert.ok(
    this.lastAlertMessage && this.lastAlertMessage.includes(fragment),
    `Erwartete Alert-Meldung mit "${fragment}", war "${this.lastAlertMessage}"`
  );
});
