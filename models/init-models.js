const DataTypes = require("sequelize").DataTypes;
const _bookings = require("./bookings");
const _clinics = require("./clinics");
const _code_role = require("./code_role");
const _code_status = require("./code_status");
const _code_timeslot = require("./code_timeslot");
const _doctor_clinic_specialty = require("./doctor_clinic_specialty");
const _histories = require("./histories");
const _schedules = require("./schedules");
const _specialties = require("./specialties");
const _users = require("./users");

const sequelize = require("../startup/db");

function initModels(sequelize) {
    const bookings = _bookings(sequelize, DataTypes);
    const clinics = _clinics(sequelize, DataTypes);
    const code_role = _code_role(sequelize, DataTypes);
    const code_status = _code_status(sequelize, DataTypes);
    const code_timeslot = _code_timeslot(sequelize, DataTypes);
    const doctor_clinic_specialty = _doctor_clinic_specialty(
        sequelize,
        DataTypes
    );
    const histories = _histories(sequelize, DataTypes);
    const schedules = _schedules(sequelize, DataTypes);
    const specialties = _specialties(sequelize, DataTypes);
    const users = _users(sequelize, DataTypes);

    users.belongsTo(code_role, { as: "role", foreignKey: "role_id" });
    code_role.hasMany(users, { as: "users", foreignKey: "role_id" });

    bookings.belongsTo(code_status, { as: "status", foreignKey: "status_id" });
    code_status.hasMany(bookings, { as: "bookings", foreignKey: "status_id" });

    doctor_clinic_specialty.belongsTo(clinics, {
        as: "clinic",
        foreignKey: "clinic_id",
    });
    clinics.hasMany(doctor_clinic_specialty, {
        as: "doctor_clinic_specialties",
        foreignKey: "clinic_id",
    });

    doctor_clinic_specialty.belongsTo(specialties, {
        as: "specialty",
        foreignKey: "specialty_id",
    });
    specialties.hasMany(doctor_clinic_specialty, {
        as: "doctor_clinic_specialties",
        foreignKey: "specialty_id",
    });

    doctor_clinic_specialty.belongsTo(users, {
        as: "doctor",
        foreignKey: "doctor_id",
    });
    users.hasMany(doctor_clinic_specialty, {
        as: "doctor_clinic_specialties",
        foreignKey: "doctor_id",
    });

    schedules.belongsTo(users, { as: "doctor", foreignKey: "doctor_id" });
    users.hasMany(schedules, { as: "schedules", foreignKey: "doctor_id" });

    return {
        bookings,
        clinics,
        code_role,
        code_status,
        code_timeslot,
        doctor_clinic_specialty,
        histories,
        schedules,
        specialties,
        users,
    };
}

const models = initModels(sequelize);

module.exports = models;
// module.exports = initModels;
// module.exports.initModels = initModels;
// module.exports.default = initModels;
