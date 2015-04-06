#Authentication & Authorization Part I

##Think-Pair-Share (15-20 min)

* How should we model people using our app? (Let's call them users for simplicity's sake).
* What sort of information do we need to store about them?
* Is there anything we need to be careful about?
* How do we verify that the person is who they say they are?
* How do we know that they're even a person at all?
* How might we go about making the information about them secure?


##Objectives
* Students will be able to articulate the differences between authentication and authorization.
* Students will be able to explain what encryption is and what it's use cases are.
* Students will be able to use Bcrypt to encrypt and compare passwords.
* Students will be able to attatch class and instance methods for authenticating users using sequelize.

##Authentication, Authorization, and Encryption

###Authentication
Authentication is used by a server when the server needs to know exactly who is accessing their information or site.

**Think: 'Who is this?'**

###Authorization
Authorization is a process by which a server determines if the client has permission to use a resource or access a file and is usually coupled with authentication so that the server has some concept of who the client is that is requesting access.

**Think: 'What do they have access to?'**

###Encryption
Encryption involves the process of transforming data so that it is **unreadable by anyone who does not have a decryption key**. 

The key take away is that you want as much data as possible to be impossible to deal with for anyone that's trying to use it. So in the case that it does fall in to the hands of someone with malicious intent, it will be near useless in its current state.

**NOTE: NEVER ROLL YOUR OWN ENCRYPTION! ALWAYS USE PUBLIC, COMMUNITY VERIFIED FORMS OF ENCRYPTION**

###Context
In the context of the questions we asked earlier, we used a **password** to **authenticate** our user so that we can know what data the user is **authorized** to use or access.

We **encrypt** the user's password, so that anyone that get's ahold of our users password wont know what it is.


##Bcrypt for Encryption
[Bcrypt](https://www.npmjs.org/package/bcrypt) is a community accepted encryption library. It supports both synchronous and asynchronous encryption. For now, we're going to use the synchronous flavor.

**Note:** The words [hash](http://en.wikipedia.org/wiki/Hash_function) and encrypt are sometimes used synonymously.

Now lets play in terminal a little bit.

First let's make a new directory and change into it.

```bash
$ mkdir authEx
```

```bash
$ cd authEx
```

Next lets install bcrypt and open up a node REPL.

```bash
$ npm install --save bcrypt
```


```bash
$ node
```

And now the fun begins!

```
> var bcrypt = require('bcrypt');
> var salt = bcrypt.genSaltSync(10);
> var password = "password";
> var password_digest = bcrypt.hashSync(password, salt);
> console.log(password_digest) // => $2a$10$/WmjcfvMZ9CHmCeWB0EUeudGXlUS8c5NA9uR4NPs/SWeJNr.1ufC6
```

##Building a Basic User Model

Let's start with a basic User with an in an email and a hashed password.

```js
var bcrypt = require('bcrypt');

function User(email, password) {
  var salt = bcrypt.genSaltSync(10);
  this.email = email;
  this.password_digest = bcrypt.hashSync(password, salt);
};

var Mike = new User('mjdesa@gmail.com', 'password');
var Del = new User('delmer@ga.co', 'password2');
console.log("Mike is", Mike);
console.log("Del is", Del);
```

Now lets add a method to the User's prototype that allows us to check the validity of a password.

```js
var bcrypt = require('bcrypt');

function User(email, password) {
  var salt = bcrypt.genSaltSync(10);
  this.email = email;
  this.password_digest = bcrypt.hashSync(password, salt);
};

User.prototype.comparePass = function(pass) {
  var samePass = bcrypt.compareSync(pass, this.password_digest);
  return samePass;
};

var Mike = new User('mjdesa@gmail.com', 'password');
var Del = new User('delmer@ga.co', 'password2');


console.log("Mike is", Mike);
console.log("Mike's password is 'hello':", Mike.comparePass('hello'));
console.log("Mike's password is 'password':", Mike.comparePass('password'));

console.log("Del is", Del);
console.log("Del's password is 'password':", Del.comparePass('password'));
console.log("Del's password is 'password2':", Del.comparePass('password2'));
```

**Exercise:** Add a method to the User's prototype that takes two parameters: an old password, and a new one. If the old password provided is correct, update the User's password_digest to be the encrypted new password. 

A Quick re-factor

```js
var bcrypt = require('bcrypt');

function User(email, password) {
  this.email = email;
  this.password_digest = User.hash(password);
};

User.hash = function(pass) {
  var salt = bcrypt.genSaltSync(10);
  return bcrypt.hashSync(pass, salt);
 }

User.prototype.comparePass = function(pass) {
  var samePass = bcrypt.compareSync(pass, this.password_digest);
  return samePass;
};

...

var Mike = new User('mjdesa@gmail.com', 'password');
var Del = new User('delmer@ga.co', 'password2');


console.log("Mike is", Mike);
console.log("Mike's password is 'hello':", Mike.comparePass('hello'));
console.log("Mike's password is 'password':", Mike.comparePass('password'));

console.log("Del is", Del);
console.log("Del's password is 'password':", Del.comparePass('password'));
console.log("Del's password is 'password2':", Del.comparePass('password2'));
```

##All this stuff, again, but now with sequelize!

First and foremost, lets make a new directory

```bash
$ mkdir auth_example
$ cd auth_example
```
Now lets make an example db for our authoration stuff

```bash
$ createdb auth_example
```
Then the usual nonsense for sequelize

```bash
$ sequelize init
$ sequelize model:create --name user --attributes "email:STRING, password_digest:STRING"
```

Update config/config.json to look like

```js
{
  "development": {
    "database": "auth_example",
    "host": "127.0.0.1",
    "dialect": "postgres"
  },
  "test": {
    "database": "auth_example",
    "host": "127.0.0.1",
    "dialect": "postgres"
  },
  "production": {
    "database": "auth_example",
    "host": "127.0.0.1",
    "dialect": "postgres"
  }
}
```

Adjust migration to look like this
```js
"use strict";
module.exports = {
  up: function(migration, DataTypes, done) {
    migration.createTable("users", {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: DataTypes.INTEGER
      },
      email: {
        type: DataTypes.STRING,
        unique: true
      },
      password_digest: {
        type: DataTypes.STRING
      },
      createdAt: {
        allowNull: false,
        type: DataTypes.DATE
      },
      updatedAt: {
        allowNull: false,
        type: DataTypes.DATE
      }
    }).done(done);
  },
  down: function(migration, DataTypes, done) {
    migration.dropTable("users").done(done);
  }
};
```

Then we're going to run

```bash
$ sequelize db:migrate
```

Update models/user to look like this

```js
"use strict";

var bcrypt = require("bcrypt");
var salt = bcrypt.genSaltSync(10);

////module.exports = function(sequelize, DataTypes) {
//  var user = sequelize.define("user", {
//    email: DataTypes.STRING,
//    password_digest: DataTypes.STRING
//  }, {
//    classMethods: {
//      associate: function(models) {
//        // associations can be defined here
//      }
//    }
//  });
//
//  return user;
//};


module.exports = function (sequelize, DataTypes){
  var User = sequelize.define('user', {
    email: { 
      type: DataTypes.STRING, 
      unique: true, 
      validate: {
        len: [6, 30],
      }
    },
    password_digest: {
      type:DataTypes.STRING,
      validate: {
        notEmpty: true
      }
    }
  },

  {
    instanceMethods: {
      checkPassword: function(password) {
        return bcrypt.compareSync(password, this.password_digest);
      }
    },
    classMethods: {
      encryptPassword: function(password) {
        var hash = bcrypt.hashSync(password, salt);
        return hash;
      },
      createSecure: function(email, password, err, success ) {
        if(password.length < 6) {
          err({message: "Password should be more than six characters"});
        }
        else{
          this.create({
            email: email,
            password_digest: this.encryptPassword(password)
          }).error(function(error) {
            console.log(error);
            if(error.email){
              err({message: 'Your username should be at least 6 characters long', email: email});
            }
            else{
              err({message: 'An account with that username already exists', email: email});
            }
          }).success(function(user) {
            success({message: 'Account created, please log in now'});
          });
        }
      },
      authenticate: function(email, password, err, success) {
        // find a user in the DB
        this.find({
          where: {
            email: email
          }
        })
        // when that's done, 
        .done(function(error,user){
          if(error){
            console.log(error);
            err({message: "Oops! Something went wrong"});
          }
          else if (user === null){
            err({message: "Username does not exist"});
          }
          else if ((User.comparePass(password, user.password_digest)) === true){
            success();
          }
          else {
            err({message: "Invalid password"});
          }
        });
      }

    } // close classMethods
  }); // close define user
  return User;
}; // close User function
```
Now play around with this stuff in command line

```bash
$ node
> var db = require('./models/index');
> db.user.createSecure('example@example.com', 'password', function(msg) { console.log(msg); }, function(msg) { console.log('Success', msg); });
