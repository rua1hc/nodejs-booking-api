const express = require("express");
const winston = require("winston");

const app = express();
require("./startup/logging")();
require("./startup/db_connect")();
require("./startup/routes")(app);
// require("./startup/production")(app);

const port = process.env.PORT || 8000;
const server = app.listen(port, () =>
    winston.info(`Server running on port ${port}...`)
);

module.exports = server;
