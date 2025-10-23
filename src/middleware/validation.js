const { body } = require('express-validator');

exports.loginValidation = [
  body('email')
    .isEmail()
    .withMessage('Please provide a valid email'),
  body('password')
    .isLength({ min: 6 })
    .withMessage('Password must be at least 6 characters long')
];

exports.createRecordValidation = [
  body('name')
    .notEmpty()
    .withMessage('Name is required'),
  body('data')
    .notEmpty()
    .withMessage('Data is required')
];