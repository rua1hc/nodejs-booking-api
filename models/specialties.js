const Sequelize = require("sequelize");
module.exports = (sequelize, DataTypes) => {
    return specialties.init(sequelize, DataTypes);
};

class specialties extends Sequelize.Model {
    static init(sequelize, DataTypes) {
        return super.init(
            {
                specialty_id: {
                    autoIncrement: true,
                    type: DataTypes.INTEGER,
                    allowNull: false,
                    primaryKey: true,
                },
                name: {
                    type: DataTypes.STRING(255),
                    allowNull: false,
                },
                description: {
                    type: DataTypes.TEXT,
                    allowNull: true,
                },
                image: {
                    type: DataTypes.STRING(255),
                    allowNull: true,
                },
            },
            {
                sequelize,
                tableName: "specialties",
                timestamps: false,
                indexes: [
                    {
                        name: "PRIMARY",
                        unique: true,
                        using: "BTREE",
                        fields: [{ name: "specialty_id" }],
                    },
                ],
            }
        );
    }
}
