import winston from "winston";
require("express-async-errors");

module.exports = function () {
    winston.exceptions.handle(
        new winston.transports.File({ filename: "exceptions.log" })
    );

    // process.on("unhandledRejection", (ex) => {
    //     throw ex;
    // });
    winston.rejections.handle(
        new winston.transports.File({ filename: "rejections.log" })
    );

    winston.add(
        new winston.transports.Console({
            colorize: true,
            prettyPrint: true,
            handleExceptions: true,
        })
    );

    winston.add(new winston.transports.File({ filename: "logfile.log" }));
};
