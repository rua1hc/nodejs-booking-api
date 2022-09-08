const winston = require("winston");
require("express-async-errors");

module.exports = function () {
    winston.configure({
        transports: [
            new winston.transports.Console({
                colorize: true,
                prettyPrint: true,
                handleExceptions: false,
            }),
            new winston.transports.File({
                filename: "logfile.log",
                handleExceptions: true,
                handleRejections: true,
            }),
        ],
    });

    // winston.add(
    //     new winston.transports.File({
    //         filename: "exceptions.log",
    //         handleExceptions: true,
    //         handleRejections: true,
    //     })
    // );

    // process.on("unhandledRejection", (ex) => {
    //     throw ex;
    // });
};
