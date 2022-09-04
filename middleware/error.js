import winston from "winston";
module.exports = function (err, req, res, next) {
    winston.error(err);

    res.status(500).send("Internal Request Error!");
};
