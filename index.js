import express from "express";
import winston from "winston";
// import helmet from "helmet";
// import compression from "compression";

const app = express();
require("./startup/logging")();
require("./startup/connectDB")();
require("./startup/routes")(app);

// if (app.get("env") === "production") {
//     app.use(helmet());
//     app.use(compression());
// }

const port = process.env.PORT || 8000;
const server = app.listen(port, () =>
    winston.info(`Server running on port ${port}...`)
);

module.exports = server;
