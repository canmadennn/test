const cds = require("@sap/cds");
const cov2ap = require("@cap-js-community/odata-v2-adapter");
const { server } = require("@sap/cds");


cds.on("bootstrap", (app) => {
    app.use((req, res, next) => {
        cov2ap();
        next();
    });
});


// cds.once("listening", ({server}) => {
//     server.keepAliveTimeout = 5 * 60 * 1000
// });


module.exports = cds.server;