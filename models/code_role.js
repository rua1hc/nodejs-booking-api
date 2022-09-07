const Sequelize = require("sequelize");
module.exports = (sequelize, DataTypes) => {
    return code_role.init(sequelize, DataTypes);
};

class code_role extends Sequelize.Model {
    static init(sequelize, DataTypes) {
        return super.init(
            {
                role_id: {
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
                tableName: "code_role",
                timestamps: false,
                indexes: [
                    {
                        name: "PRIMARY",
                        unique: true,
                        using: "BTREE",
                        fields: [{ name: "role_id" }],
                    },
                ],
            }
        );
    }
}
