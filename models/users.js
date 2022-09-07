const Sequelize = require("sequelize");
module.exports = (sequelize, DataTypes) => {
    return users.init(sequelize, DataTypes);
};

class users extends Sequelize.Model {
    static init(sequelize, DataTypes) {
        return super.init(
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
                    unique: "email",
                },
                password: {
                    type: DataTypes.STRING(255),
                    allowNull: false,
                },
                first_name: {
                    type: DataTypes.STRING(50),
                    allowNull: false,
                },
                last_name: {
                    type: DataTypes.STRING(50),
                    allowNull: false,
                },
                role_id: {
                    type: DataTypes.INTEGER,
                    allowNull: false,
                    references: {
                        model: "code_role",
                        key: "role_id",
                    },
                },
                phone: {
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
                image: {
                    type: DataTypes.STRING(255),
                    allowNull: true,
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
                    {
                        name: "email",
                        unique: true,
                        using: "BTREE",
                        fields: [{ name: "email" }],
                    },
                    {
                        name: "fk_users_code_role",
                        using: "BTREE",
                        fields: [{ name: "role_id" }],
                    },
                ],
            }
        );
    }
}
