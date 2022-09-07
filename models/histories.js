const Sequelize = require("sequelize");
module.exports = (sequelize, DataTypes) => {
    return histories.init(sequelize, DataTypes);
};

class histories extends Sequelize.Model {
    static init(sequelize, DataTypes) {
        return super.init(
            {
                history_id: {
                    autoIncrement: true,
                    type: DataTypes.INTEGER,
                    allowNull: false,
                    primaryKey: true,
                },
                doctor_id: {
                    type: DataTypes.INTEGER,
                    allowNull: false,
                },
                patient_id: {
                    type: DataTypes.INTEGER,
                    allowNull: false,
                },
                description: {
                    type: DataTypes.TEXT,
                    allowNull: true,
                },
                files: {
                    type: DataTypes.TEXT,
                    allowNull: true,
                },
            },
            {
                sequelize,
                tableName: "histories",
                timestamps: false,
                indexes: [
                    {
                        name: "PRIMARY",
                        unique: true,
                        using: "BTREE",
                        fields: [{ name: "history_id" }],
                    },
                ],
            }
        );
    }
}
