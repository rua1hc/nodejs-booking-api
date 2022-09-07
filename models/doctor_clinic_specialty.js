const Sequelize = require("sequelize");
module.exports = (sequelize, DataTypes) => {
    return doctor_clinic_specialty.init(sequelize, DataTypes);
};

class doctor_clinic_specialty extends Sequelize.Model {
    static init(sequelize, DataTypes) {
        return super.init(
            {
                dcs_id: {
                    autoIncrement: true,
                    type: DataTypes.INTEGER,
                    allowNull: false,
                    primaryKey: true,
                },
                doctor_id: {
                    type: DataTypes.INTEGER,
                    allowNull: false,
                    references: {
                        model: "users",
                        key: "user_id",
                    },
                },
                clinic_id: {
                    type: DataTypes.INTEGER,
                    allowNull: false,
                    references: {
                        model: "clinics",
                        key: "clinic_id",
                    },
                },
                specialty_id: {
                    type: DataTypes.INTEGER,
                    allowNull: false,
                    references: {
                        model: "specialties",
                        key: "specialty_id",
                    },
                },
            },
            {
                sequelize,
                tableName: "doctor_clinic_specialty",
                timestamps: false,
                indexes: [
                    {
                        name: "PRIMARY",
                        unique: true,
                        using: "BTREE",
                        fields: [{ name: "dcs_id" }],
                    },
                    {
                        name: "fk_dcs_users",
                        using: "BTREE",
                        fields: [{ name: "doctor_id" }],
                    },
                    {
                        name: "fk_dcs_clinics",
                        using: "BTREE",
                        fields: [{ name: "clinic_id" }],
                    },
                    {
                        name: "fk_dcs_specialties",
                        using: "BTREE",
                        fields: [{ name: "specialty_id" }],
                    },
                ],
            }
        );
    }
}
