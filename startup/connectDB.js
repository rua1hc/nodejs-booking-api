import winston from "winston";
const { Sequelize } = require("sequelize");

module.exports = function () {
    const sequelize = new Sequelize("database", "root", null, {
        dialect: "mysql",
    });

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
