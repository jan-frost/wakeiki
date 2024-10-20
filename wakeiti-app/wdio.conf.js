const httpServer = require('http-server');
let server;
exports.config = {
    runner: 'local',
    framework: 'cucumber',
    cucumberOpts: {
        require: ['./features/step_definitions/**/*.js'],
    },
    specs: [
        './features/**/*.feature'
    ],
    capabilities: [{
        browserName: 'chrome',
        browserVersion: 'stable',
        "goog:chromeOptions": {
            args: [
                "--disable-gpu",
                "--headless=new",
            ],
        },
    }],
    logLevel: 'info',
    reporters: ['spec'],
    baseUrl: 'http://localhost:8000',
    waitforTimeout: 10000,
    connectionRetryTimeout: 120000,
    connectionRetryCount: 3,
    
    onPrepare: function (config, capabilities) {
        return new Promise((resolve) => {
            server = httpServer.createServer({
                root: './www',
                cors: true,
                port: 8000,
            });

            server.listen(8000, () => {
                console.log('Local server started on http://localhost:8000');
                resolve();
            });
        });
    },

    onComplete: function(exitCode, config, capabilities, results) {
        if (server) {
            server.close();
        }
    },

    beforeScenario: function (world, context) {
        // Navigate to the app before each scenario
        return browser.url('/');
    }
};