const Sequelize = require("sequelize");
module.exports = (sequelize, DataTypes) => {
    return code_status.init(sequelize, DataTypes);
};

class code_status extends Sequelize.Model {
    static init(sequelize, DataTypes) {
        return super.init(
            {
                status_id: {
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
                tableName: "code_status",
                timestamps: false,
                indexes: [
                    {
                        name: "PRIMARY",
                        unique: true,
                        using: "BTREE",
                        fields: [{ name: "status_id" }],
                    },
                ],
            }
        );
    }
}
