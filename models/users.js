const Sequelize = require("sequelize");

// node_modules\.bin\sequelize-auto -o "./models" -d sql_bookingCare -h localhost -p 3306 -u root -x 240690 -e mysql

module.exports = function (sequelize, DataTypes) {
    return sequelize.define(
        "users",
        {
            user_id: {
                autoIncrement: true,
                type: DataTypes.INTEGER,
                allowNull: false,
                primaryKey: true,
            },
            email: {
                type: DataTypes.STRING(255),
                allowNull: false,
                unique: true,
            },
            first_name: {
                type: DataTypes.STRING(50),
                allowNull: false,
            },
            last_name: {
                type: DataTypes.STRING(50),
                allowNull: false,
            },
            address: {
                type: DataTypes.STRING(255),
                allowNull: true,
            },
            gender: {
                type: DataTypes.BOOLEAN,
                allowNull: true,
            },
            role_id: {
                type: DataTypes.TINYINT,
                allowNull: false,
            },
        },
        {
            sequelize,
            tableName: "users",
            timestamps: false,
            indexes: [
                {
                    name: "PRIMARY",
                    unique: true,
                    using: "BTREE",
                    fields: [{ name: "user_id" }],
                },
            ],
        }
    );
};
