const { validationResult } = require('express-validator');
const express = require('express');
const router = express.Router();

router.get('/profile', async (req, res) => {
  try {
    res.json({
      success: true,
      message: 'Profile data retrieved successfully',
      user: req.user
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Internal server error'
    });
  }
});

router.get('/internal/data', async (req, res) => {
  try {
    const data = {
      success: true,
      message: 'Internal data retrieved successfully',
      data: {
        timestamp: new Date().toISOString(),
        user: req.user,
        metrics: {
          requests: Math.floor(Math.random() * 1000),
          activeUsers: Math.floor(Math.random() * 50),
          uptime: process.uptime()
        }
      }
    };

    res.json(data);
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Internal server error'
    });
  }
});

router.post('/internal/records', async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ 
        success: false, 
        errors: errors.array() 
      });
    }

    const record = {
      id: Date.now(),
      ...req.body,
      createdBy: req.user.id,
      createdAt: new Date().toISOString()
    };

    res.status(201).json({
      success: true,
      message: 'Internal record created successfully',
      record
    });

  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Internal server error'
    });
  }
});

module.exports = router;