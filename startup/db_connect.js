const winston = require("winston");
const sequelize = require("./db");

module.exports = function () {
    sequelize
        .authenticate()
        .then(() =>
            winston.info("MySQL connection has been established successfully.")
        );
    // try {
    //     await sequelize.authenticate();
    //     winston.log("MySQL connection has been established successfully.");
    // } catch (error) {
    //     winston.error("Unable to connect to the database:", error);
    // }

    // sequelize.close();
};
