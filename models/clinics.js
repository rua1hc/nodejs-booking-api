const Sequelize = require("sequelize");
module.exports = (sequelize, DataTypes) => {
    return clinics.init(sequelize, DataTypes);
};

class clinics extends Sequelize.Model {
    static init(sequelize, DataTypes) {
        return super.init(
            {
                clinic_id: {
                    autoIncrement: true,
                    type: DataTypes.INTEGER,
                    allowNull: false,
                    primaryKey: true,
                },
                name: {
                    type: DataTypes.STRING(255),
                    allowNull: false,
                },
                address: {
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
                tableName: "clinics",
                timestamps: false,
                indexes: [
                    {
                        name: "PRIMARY",
                        unique: true,
                        using: "BTREE",
                        fields: [{ name: "clinic_id" }],
                    },
                ],
            }
        );
    }
}
