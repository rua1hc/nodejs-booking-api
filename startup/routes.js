const express = require("express");
const error = require("../middleware/error");

module.exports = function (app) {
    app.use(express.json());

    app.use("/api/users", require("../routes/users"));

    app.use(error);
};
