const Sequelize = require("sequelize");
module.exports = (sequelize, DataTypes) => {
    return code_timeslot.init(sequelize, DataTypes);
};

class code_timeslot extends Sequelize.Model {
    static init(sequelize, DataTypes) {
        return super.init(
            {
                timeslot_id: {
                    autoIncrement: true,
                    type: DataTypes.INTEGER,
                    allowNull: false,
                    primaryKey: true,
                },
                valueEn: {
                    type: DataTypes.STRING(50),
                    allowNull: false,
                },
                valueVn: {
                    type: DataTypes.STRING(50),
                    allowNull: false,
                },
            },
            {
                sequelize,
                tableName: "code_timeslot",
                timestamps: false,
                indexes: [
                    {
                        name: "PRIMARY",
                        unique: true,
                        using: "BTREE",
                        fields: [{ name: "timeslot_id" }],
                    },
                ],
            }
        );
    }
}
