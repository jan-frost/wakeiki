const { Given, When, Then } = require('@cucumber/cucumber');
const { expect } = require('chai');

Given('I have launched the app', async function () {

    // This step might not need any implementation if your test runner
    // automatically launches the app before each scenario
    // If needed, you can add app launching logic here
});

When('the app loads', async function () {
    // Wait for the app to fully load
    // This is a placeholder and might need adjustment based on your app's structure
    await browser.waitUntil(async () => {
        const elem = await browser.$('body');
        return await elem.isDisplayed();
    }, { timeout: 10000, timeoutMsg: 'App did not load within 10 seconds' });
});

Then('I should see the main page title {string}', async function (expectedTitle) {
    const titleElement = await browser.$('body > div > h1');
    const actualTitle = await titleElement.getText();
    expect(actualTitle).to.equal(expectedTitle);
});

