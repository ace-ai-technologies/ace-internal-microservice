const bcrypt = require('bcryptjs');

const users = [
  {
    id: 1,
    email: 'admin@aceaicompany.com',
    password: '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',
    role: 'admin'
  },
  {
    id: 2,
    email: 'user@aceaicompany.com',
    password: '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',
    role: 'user'
  }
];

exports.findById = async (id) => {
  return users.find(user => user.id === id);
};

exports.findByEmail = async (email) => {
  return users.find(user => user.email === email);
};

exports.create = async (userData) => {
  const hashedPassword = await bcrypt.hash(userData.password, 10);
  const newUser = {
    id: users.length + 1,
    email: userData.email,
    password: hashedPassword,
    role: userData.role || 'user'
  };
  users.push(newUser);
  return newUser;
};

exports.update = async (id, userData) => {
  const userIndex = users.findIndex(user => user.id === id);
  if (userIndex === -1) return null;
  
  users[userIndex] = { ...users[userIndex], ...userData };
  return users[userIndex];
};

exports.delete = async (id) => {
  const userIndex = users.findIndex(user => user.id === id);
  if (userIndex === -1) return false;
  
  users.splice(userIndex, 1);
  return true;
};

exports.getAll = async () => {
  return users;
};