var DataTypes = require("sequelize").DataTypes;
var _bookings = require("./bookings");
var _clinics = require("./clinics");
var _code_role = require("./code_role");
var _code_status = require("./code_status");
var _code_timeslot = require("./code_timeslot");
var _doctor_clinic_specialty = require("./doctor_clinic_specialty");
var _histories = require("./histories");
var _schedules = require("./schedules");
var _specialties = require("./specialties");
var _users = require("./users");

function initModels(sequelize) {
  var bookings = _bookings(sequelize, DataTypes);
  var clinics = _clinics(sequelize, DataTypes);
  var code_role = _code_role(sequelize, DataTypes);
  var code_status = _code_status(sequelize, DataTypes);
  var code_timeslot = _code_timeslot(sequelize, DataTypes);
  var doctor_clinic_specialty = _doctor_clinic_specialty(sequelize, DataTypes);
  var histories = _histories(sequelize, DataTypes);
  var schedules = _schedules(sequelize, DataTypes);
  var specialties = _specialties(sequelize, DataTypes);
  var users = _users(sequelize, DataTypes);

  doctor_clinic_specialty.belongsTo(clinics, { as: "clinic", foreignKey: "clinic_id"});
  clinics.hasMany(doctor_clinic_specialty, { as: "doctor_clinic_specialties", foreignKey: "clinic_id"});
  users.belongsTo(code_role, { as: "role", foreignKey: "role_id"});
  code_role.hasMany(users, { as: "users", foreignKey: "role_id"});
  bookings.belongsTo(code_status, { as: "status", foreignKey: "status_id"});
  code_status.hasMany(bookings, { as: "bookings", foreignKey: "status_id"});
  doctor_clinic_specialty.belongsTo(specialties, { as: "specialty", foreignKey: "specialty_id"});
  specialties.hasMany(doctor_clinic_specialty, { as: "doctor_clinic_specialties", foreignKey: "specialty_id"});
  doctor_clinic_specialty.belongsTo(users, { as: "doctor", foreignKey: "doctor_id"});
  users.hasMany(doctor_clinic_specialty, { as: "doctor_clinic_specialties", foreignKey: "doctor_id"});
  schedules.belongsTo(users, { as: "doctor", foreignKey: "doctor_id"});
  users.hasMany(schedules, { as: "schedules", foreignKey: "doctor_id"});

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
module.exports = initModels;
module.exports.initModels = initModels;
module.exports.default = initModels;
