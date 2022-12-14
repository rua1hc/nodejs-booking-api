const Sequelize = require("sequelize");
module.exports = (sequelize, DataTypes) => {
    return schedules.init(sequelize, DataTypes);
};

class schedules extends Sequelize.Model {
    static init(sequelize, DataTypes) {
        return super.init(
            {
                schedule_id: {
                    autoIncrement: true,
                    type: DataTypes.INTEGER,
                    allowNull: false,
                    primaryKey: true,
                },
                currentNumber: {
                    type: DataTypes.INTEGER,
                    allowNull: false,
                },
                maxNumber: {
                    type: DataTypes.INTEGER,
                    allowNull: false,
                },
                doctor_id: {
                    type: DataTypes.INTEGER,
                    allowNull: false,
                    references: {
                        model: "users",
                        key: "user_id",
                    },
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
                tableName: "schedules",
                timestamps: false,
                indexes: [
                    {
                        name: "PRIMARY",
                        unique: true,
                        using: "BTREE",
                        fields: [{ name: "schedule_id" }],
                    },
                    {
                        name: "fk_schedules_users",
                        using: "BTREE",
                        fields: [{ name: "doctor_id" }],
                    },
                ],
            }
        );
    }
}
