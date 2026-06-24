const { Builder } = require('selenium-webdriver');
const edge = require('selenium-webdriver/edge');

async function createDriver() {
    const options = new edge.Options();

    // Flags para que no falle por razones externas
    options.addArguments('--disable-extensions');
    options.addArguments('--disable-gpu');
    options.addArguments('--no-sandbox');

    // Construimos el driver con Edge
    const driver = await new Builder()
        .forBrowser('MicrosoftEdge')
        .setEdgeOptions(options)
        .build();

    return driver;
}

module.exports = { createDriver };