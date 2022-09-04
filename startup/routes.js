import express from "express";

import error from "../middleware/error";

module.exports = function (app) {
    app.use(express.json());

    app.use(error);
};
