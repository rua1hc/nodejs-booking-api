const { Sequelize } = require("sequelize");

const sequelize = new Sequelize("sql_bookingCare", "root", "240690", {
    dialect: "mysql",
});

module.exports = sequelize;
