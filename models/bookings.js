const Sequelize = require("sequelize");
module.exports = (sequelize, DataTypes) => {
    return bookings.init(sequelize, DataTypes);
};

class bookings extends Sequelize.Model {
    static init(sequelize, DataTypes) {
        return super.init(
            {
                booking_id: {
                    autoIncrement: true,
                    type: DataTypes.INTEGER,
                    allowNull: false,
                    primaryKey: true,
                },
                status_id: {
                    type: DataTypes.INTEGER,
                    allowNull: false,
                    references: {
                        model: "code_status",
                        key: "status_id",
                    },
                },
                doctor_id: {
                    type: DataTypes.INTEGER,
                    allowNull: false,
                },
                patient_id: {
                    type: DataTypes.INTEGER,
                    allowNull: false,
                },
                date: {
                    type: DataTypes.DATEONLY,
                    allowNull: true,
                },
                timeType: {
                    type: DataTypes.STRING(255),
                    allowNull: true,
                },
            },
            {
                sequelize,
                tableName: "bookings",
                timestamps: false,
                indexes: [
                    {
                        name: "PRIMARY",
                        unique: true,
                        using: "BTREE",
                        fields: [{ name: "booking_id" }],
                    },
                    {
                        name: "fk_bookings_code_status",
                        using: "BTREE",
                        fields: [{ name: "status_id" }],
                    },
                ],
            }
        );
    }
}
