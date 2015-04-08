README.md
# More Express
## Authentication and All That


| Objectives |
| :---- |
| Review and apply the a simple password **authentication** strategy |
| Utilize in memory storage and cookies to create an Express application with Sessions |
| A simple sign and signout process |


## Background (10mins)

Review Sign Up Together

Explain in your own way -- using pictures, diagrams, words, dance, etc...

* What is **Authentication**?
* Why do we **hash** passwords?
* What's the general idea when someone sign's up for a site?
* What is HTTPS? Why should we care about this?


## Implementing **Simple Signup** Scheme

**Question**: *What will we need to do a simple sign up?*

* Express Framework: build our application and handle requests
* Middleware:
  * 'body-parser': for handling incoming form data.
  * (maybe) 'ejs': if we want to **render** or **template** views
  * (maybe) 'method-override': if we want to **PUT** or **DELETE** something.
* Models:
  * Sequelize Models: performing CRUD with PostgreSQL
* Migrations:
  * Sequelize Migrations: remembering what **changes** we make to the database tables.
* bcryptJS: Do you know who [Bruce Schneier](http://www.schneierfacts.com/facts/1101) is!!!!???!?

### Getting Setup (7mins)

[Let's share some code](https://code.stypi.com/delmer/WDI_SF_17/simple_login).
Set yourself up with a project folder.

```bash
mkdir simple_login
cd simple_login

touch package.json
touch app.js 

subl .
```

At our very least we need something like the following:

`simple_login/app.js`

```js
var express = require('express'),
    bodyParser = require('body-parser'),
    app = express();

app.use(bodyParser.urlencoded({extended: true}))

app.get("/signup", function (req, res) {
  res.send("Coming soon");
});

app.listen(3000, function () {
  console.log("SERVER RUNNING");
});
```

The above won't run unless we install those dependencies, so let's go ahead and make sure we do that now. 

#### Exercise 1

-----------

```
npm install --save express body-parser
```

* What happened? Why?

>  The problem is there is nothing in our `package.json` file.

Let's put something minimal in there.

`simple_login/package.json`

```js
{}
```

Now let's try to install

```
npm install --save express body-parser
```


--------------

#### Exercise 2

-------
Run your `app.js` file using `nodemon`

* What happens? What needs to be updated? Why?

-------




### Setting Up `Sequelize`

Now we don't have models yet so that's as good as any place as any to start.


#### Exercise

-------

Try doing the following

```bash
sequelize init
```

* What happened? Why didn't it work?

> The problem is that `sequelize` isn't installed.

---------

We will need to do the following:

```
npm install --save sequelize pg pg-hstore

sequelize init
```

You should now have something like the following directory structure

```bash
app.js
config/
  config.json
node_modules/
migrations/
models/
  index.js
package.json
```

### Configuring 

We need to configure our application to have a database.

* First remove the username and password fields.

`simple_login/config/config.json`

```javascript
{
  "development": {
    "database": "database_development",
    "host": "127.0.0.1",
    "dialect": "mysql"
  },
  "test": {
    "database": "database_test",
    "host": "127.0.0.1",
    "dialect": "mysql"
  },
  "production": {
    "database": "database_production",
    "host": "127.0.0.1",
    "dialect": "mysql"
  }
}
```

* Now rename the database to be the name of our project.


`simple_login/config/config.json`

```javascript
{
  "development": {
    "database": "simple_login_development",
    "host": "127.0.0.1",
    "dialect": "mysql"
  },
  "test": {
    "database": "simple_login_test",
    "host": "127.0.0.1",
    "dialect": "mysql"
  },
  "production": {
    "database": "simple_login_production",
    "host": "127.0.0.1",
    "dialect": "mysql"
  }
}
```


* Lastly, but most importantly we need to change the dialect to `postgres`.


```javascript
{
  "development": {
    "database": "simple_login_development",
    "host": "127.0.0.1",
    "dialect": "postgres"
  },
  "test": {
    "database": "simple_login_test",
    "host": "127.0.0.1",
    "dialect": "postgres"
  },
  "production": {
    "database": "simple_login_production",
    "host": "127.0.0.1",
    "dialect": "postgres"
  }
}
```


You can use the following 

```bash
createdb simple_login_development
```

#### Creating A User Model

Let's get back into terminal

```bash
sequelize model:create --name="User" --attributes="email:string, passwordDigest:string"
```

Open the model and migration file generated to verify that they are indeed correct. Then migrate.

```bash
sequelize db:migrate
```


Let's edit our `User` model to have the following code from Yesterday:

```javascript

var bcrypt = require("bcrypt");
var salt = bcrypt.genSaltSync(10);

module.exports = function (sequelize, DataTypes){
  var User = sequelize.define('User', {
    email: { 
      type: DataTypes.STRING, 
      unique: true, 
      validate: {
        len: [6, 30],
      }
    },
    passwordDigest: {
      type:DataTypes.STRING,
      validate: {
        notEmpty: true
      }
    }
  },

  {
    instanceMethods: {
      checkPassword: function(password) {
        return bcrypt.compareSync(password, this.passwordDigest);
      }
    },
    classMethods: {
      encryptPassword: function(password) {
        var hash = bcrypt.hashSync(password, salt);
        return hash;
      },
      createSecure: function(email, password) {
        if(password.length < 6) {
          throw new Error("Password too short");
        }
        return this.create({
          email: email,
          passwordDigest: this.encryptPassword(password)
        });
      
      },
      authenticate: function(email, password) {
        // find a user in the DB
        return this.find({
          where: {
            email: email
          }
        }) 
        .then(function(user){
          if (user === null){
            throw new Error("Username does not exist");
          }
          else if (user.checkPassword(password)){
            return user;
          }

        });
      }

    } // close classMethods
  }); // close define user
  return User;
}; // close User function

```

Be sure to install bcrypt

```bash
npm install --save bcrypt
```


### Creating A User

Let's go into the node terminal to play with our model.

```javascript
var db = require("./models");
db.User.
  createSecure("foobar", "foobar").
  then(function(){
    console.log("success!");
  });
```


### Putting It Together

Let's add our models to our app.

`simple_login/app.js`

```js
var express = require('express'),
    bodyParser = require('body-parser'),
    db = require("./models"),
    app = express();


```

Let's add a `POST /users` route to accept user signup requests.

```javascript
// where the user submits the sign-up form
app.post("/users", function (req, res) {

  // grab the user from the params
  var user = req.body.user;

  // create the new user
  db.User.
    createSecure(user.email, user.password).
    then(function(){
        res.send("SIGNED UP!");
      });
});

```


The complete code is just the following:


`simple_login/app.js`


```javascript
var express = require('express'),
    bodyParser = require('body-parser'),
    db = require("./models"),
    app = express();

app.use(bodyParser.urlencoded({extended: true}))

app.get("/signup", function (req, res) {
  res.send("Coming soon");
});

// where the user submits the sign-up form
app.post("/users", function (req, res) {

  // grab the user from the params
  var user = req.body.user;

  // create the new user
  db.User.
    createSecure(user.email, user.password).
    then(function(){
        res.send("SIGNED UP!");
      });
});

app.listen(3000, function () {
  console.log("SERVER RUNNING");
});
```

```bash
curl --data "user[email]=foobar&user[password]=foobar" localhost:3000/users

```

## Logging In: Part 1 -- Setup

Let's add some routes to be able to login.

`simple_login/app.js`

```javascript

app.post("/login", function (req, res) {
  var user = req.body.user;

  db.User
    .authenticate(user.email, user.password)
    .then(function (user) {
          res.send(user);
    });
});

```

Then test the route

```
curl --data "user[email]=foobar&user[password]=foobar" localhost:3000/login

```

### Creating Sessions

To introduce sessions we will need the `express-session` middleware.

```bash
npm install --save express-session

```


Then we add it to the list of require statements


`simple_login/app.js`

```javascript
var express = require('express'),
    bodyParser = require('body-parser'),
    db = require("./models"),
    session = require("express-session"),
    app = express();

app.use(bodyParser.urlencoded({extended: true}));

app.use(session({
  secret: 'super secret',
  resave: false,
  saveUninitialized: true
}))

```

Then your routes to see if they have a `set-cookie` header

```
curl --data "user[email]=foobar&user[password]=foobar" -i localhost:3000/signup
curl --data "user[email]=foobar&user[password]=foobar" -i localhost:3000/login
```


Notice the headers have a `set-cookie` key and value. Now we can create some special login functionality to save a user's data in the session.

`simple_login/app.js`

```javascript

app.use("/", function (req, res, next) {

  req.login = function (user) {
    req.session.userId = user.id;
  };

  req.currentUser = function () {
    return db.User.
      find({
        where: {
          id: req.session.userId
       }
      }).
      then(function (user) {
        req.user = user;
        return user;
      })
  };

  req.logout = function () {
    req.session.userId = null;
    req.user = null;
  }

  next(); 
});

```

## Logging In: Part 2 -- Routing

In our app.js we want to make sure we have the correct routing for logging in a user so let's update our login route.

`simple_login/app.js`

```javascript

app.post("/login", function (req, res) {
  var user = req.body.user;

  db.User
    .authenticate(user.email, user.password)
    .then(function (user) {
          res.send(user);
    });
});

```

Technically after you log someone in you want to redirect them to somewhere meaningful.


`simple_login/app.js`

```javascript

app.post("/login", function (req, res) {
  var user = req.body.user;

  db.User
    .authenticate(user.email, user.password)
    .then(function (user) {
          // note here the super step
          req.login(user);
          // We need to create this route
          res.redirectTo("/profile"); // redirect to user profile
      });
});

```

The user show path will be the following.


`simple_login/app.js`

```javascript

app.get("/profile", function (req, res) {
  req.currentUser()
      .then(function (user) {
        res.send(user.dataValues);
      })
});

```

However we need to play with this in the browser to verify this is working, so it's time to add some views.

## Adding Views

First we need to add `ejs`.

```bash
npm install --save ejs

```

Then we need to configure our middleware

`simple_login/app.js`

```javascript

var express = require('express'),
    bodyParser = require('body-parser'),
    db = require("./models"),
    session = require("express-session"),
    app = express();



app.set("view engine", "ejs"); // <--- throw in ejs

app.use(bodyParser.urlencoded({extended: true}));

app.use(session({
  secret: 'super secret',
  resave: false,
  saveUninitialized: true
}));


```

Then `mkdir` for views



### Adding A Login Path


We need a `GET /login` view and route.


`simple_login/app.js`

```javascript

app.get("/login", function (req, res) {
  res.render("login");
});

```

Then create the login view


`simple_login/views/login.ejs`

```html

<form method="post" action="/login">
  <div>
    <input type="text" name="user[email]">
  </div>
  <div>
    <input type="text" name="user[password]">
  </div>
  <button>Login</button>
</form>

```

### Adding A Profile

While we are at it let's add a real profile page.

`simple_login/views/profile.ejs`

```html

  Welcome, <%= user.email %>!

```

Let's update the route to render this.


`simple_login/app.js`

```javascript

app.get("/profile", function (req, res) {
  req.currentUser()
      .then(function (user) {
        res.render("profile.ejs", {user: user});
      });
});

```



## Exercises

1. Add a `GET /signup` route and view.
2. Login a user after `signup` and redirect to `/profile`.
