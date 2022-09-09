const _ = require("lodash");
const Joi = require("joi");
const bcrypt = require("bcrypt");
const express = require("express");

// const auth = require("../middleware/auth");
// const asyncMiddleware = require("../middleware/async");
const { users } = require("../models/init-models");

const router = express.Router();

// router.get("/", async (req, res, next) => {
//     try {
//         const data = await users.findAll({
//             attributes: { exclude: ["password"] },
//             raw: true,
//         });
//         res.send(data);
//     } catch (ex) {
//         next(ex);
//     }
// });
// router.get("/", asyncMiddleware(async (req, res) => {
//         const data = await users.findAll({
//             attributes: { exclude: ["password"] },
//             raw: true,
//         });
//         res.send(data);
//     })
// );
router.get("/", async (req, res) => {
    const data = await users.findAll({
        attributes: { exclude: ["password"] },
        raw: true,
    });

    res.send(data);
});

router.get("/:id", async (req, res) => {
    const user = await users.findOne({ where: { user_id: req.params.id } });
    if (!user) return res.status(404).send("User ID not found.");

    res.send(user);
});

router.post("/", async (req, res) => {
    const { error } = validate(req.body);
    if (error) return res.status(400).send(error);

    const salt = await bcrypt.genSalt(10);
    const password = await bcrypt.hash(req.body.password, salt);

    const [user, created] = await users.findOrCreate({
        where: { email: req.body.email },
        defaults: {
            password,
            first_name: req.body.first_name,
            last_name: req.body.last_name,
            role_id: req.body.role_id,
            phone: req.body.phone,
            address: req.body.address,
            gender: req.body.gender,
            image: req.body.image,
        },
    });
    if (created) {
        res.send(_.pick(user, ["user_id", "first_name", "last_name", "email"]));
    } else {
        res.status(400).send("This email is already registered.");
    }
});

router.put("/:id", async (req, res) => {
    const { error } = validate(req.body);
    if (error) return res.status(400).send(error.details[0].message);

    const user = await users.findOne({ where: { user_id: req.params.id } });
    if (!user) return res.status(404).send("User ID not found.");

    const salt = await bcrypt.genSalt(10);
    const password = await bcrypt.hash(req.body.password, salt);

    // 1st method
    // await users.update(
    //     {
    //         password,
    //         first_name: req.body.first_name,
    //         last_name: req.body.last_name,
    //         role_id: req.body.role_id,
    //         phone: req.body.phone,
    //         address: req.body.address,
    //         gender: req.body.gender,
    //         image: req.body.image,
    //     },
    //     { where: { user_id: req.params.id } }
    // );

    // 2nd method
    user.password = password;
    user.first_name = req.body.first_name;
    user.last_name = req.body.last_name;
    user.role_id = req.body.role_id;
    user.phone = req.body.phone;
    user.address = req.body.address;
    user.gender = req.body.gender;
    user.image = req.body.image;
    await user.save();

    res.send(user);
});

router.delete("/:id", async (req, res) => {
    const user = await users.findOne({ where: { user_id: req.params.id } });
    if (!user) return res.status(404).send("User ID not found.");

    // await users.destroy({ where: { user_id: req.params.id } });
    await user.destroy();
    res.send(user);
});

function validate(user) {
    const scheme = Joi.object({
        email: Joi.string().email().max(255).required(),
        password: Joi.string().min(3).max(255).required(),
        first_name: Joi.string().min(1).max(50).required(),
        last_name: Joi.string().min(1).max(50).required(),
        role_id: Joi.number().integer().min(1).required(),
        phone: Joi.string().min(3).max(50).required(),
        address: Joi.string().min(1).max(255),
        gender: Joi.boolean().required(),
        image: Joi.string().min(1).max(255),
    });
    return scheme.validate({
        email: user.email,
        password: user.password,
        first_name: user.first_name,
        last_name: user.last_name,
        role_id: user.role_id,
        phone: user.phone,
        address: user.address,
        gender: user.gender,
        image: user.image,
    });
}

module.exports = router;
