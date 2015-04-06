var bcrypt = require('bcrypt');

function User(email, password) {
  this.email = email;
  this.password_digest =  User.hash(password);
}

User.hash = function(pass) {
  var salt = bcrypt.genSaltSync(10);
  return bcrypt.hashSync(pass, salt);
};

User.prototype.comparePass = function(pass) {
  var samePass = bcrypt.compareSync(pass, this.password_digest);
  return samePass;
};

User.prototype.updatePass = function(oldPass, newPass) {
  if (this.comparePass(oldPass)) {
    this.password_digest = User.hash(newPass);
  } else {
    console.log("ATTEMPTED TO CHANGE PASSWORD");
  }
  return this;
};

var Mike = new User('mjdesa@gmail.com', 'password');

console.log("Mike is", Mike);
console.log("Mike's password is 'hello':", Mike.comparePass('hello'));
console.log("Mike's password is 'password':", Mike.comparePass('password'));

Mike.updatePass('password', 'hello');

console.log("Mike is", Mike);
console.log("Mike's password is 'hello':", Mike.comparePass('hello'));
console.log("Mike's password is 'password':", Mike.comparePass('password'));
