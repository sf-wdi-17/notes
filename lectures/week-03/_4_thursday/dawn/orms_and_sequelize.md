# Getting started with Sequelize

## Learning Objectives:

At the end of this lesson, we should:
  - Understand what ORM is
  - Be able to explain what Sequelize is
  - Know how to include Sequelize in a Node.js application
    + and how to handle configuration for a development environment

We're also going to discuss models and:
  - How they relate to objects and tables
  - How to generate models using the Sequelize CLI

## Key terms + definitions

### Relational Database

A relational database is one designed to efficiently query and structure relationships between data. The data is typically structured into tables with columns and rows. 

**Think SQL when you think Relational Database.**

### ORM

ORM stands for **Object Relational Mapping**. 

On one end there is a **Relational Database**. On the other end there is an **object oriented application**, or some application that allows us to create objects for that matter. The **mapping** is just a way of using object methods to make queries and represent results returned from our database.

**Object oriented application** <=> ORM <=> **Relational database**

In short an ORM (Object Relational Mapper) is what we call an "abstraction layer". This means it's a piece of software that operates between us and some functionality we'd normally have to handle ourselves. In the case of an ORM, this layer helps map objects to our database. 

Because of this __awesomeness__, we can now just use JavaScript to create and work with our data instead of writing raw SQL queries.


If you want, you can [read some more about the benefits of using an ORM](http://stackoverflow.com/questions/1279613/what-is-an-orm-and-where-can-i-learn-more-about-it)

### Sequelize

From the Sequelize docs "To put it in a nutshell, it's an ORM (Object-Relational-Mapper). The library is written entirely in JavaScript and can be used in the Node.JS environment." In other words, Sequelize is an ORM that works with relational databases and Node.js. It allows us to:

- Represent models (AKA prototypes or classes) and their data.
- Handle associations (AKA relationships) between these models.
- Validate data before it gets stored (AKA 'persisted') to the database.
- Perform database operations in an object-oriented fashion _(this is the best part!)_

#### Model

So far this morning, we've been throwing around this word "model". But, wait, what's a model?

A model is just a class (or constructor) that maps to the data relation (table) and potentially bridges tables. You can think of a model as the blueprint for what each row of data is going to contain. You perform CRUD operations on __instances__ of your models.

#### Migrations

For now, we're not going to worry too much about migrations. But don't worry, we'll come back to them later.

In the meantime, here's a simple explanation of what migrations are:
 Migrations (also known as ‘schema evolution’ or ‘mutations’) are a way of changing your database schema from one version into another. You can think of a migration as the creation or changes you want to make to a database table or column. Before you can start manipulating your models, you need to create and run a migration. Examples of migrations are creating, deleting and altering tables (and their existing columns).

## Sequelize Setup

### Setup part 1: Install Sequelize-cli 

To get started with Sequelize, we'll want to install the __Sequelize Command Line Tools (CLI)__. At a `bash` prompt, run the following command from any directory:

```
npm install -g sequelize-cli
```

If you get an error, try it again but add `sudo` before the command.

### Setup part 2: Starting a new node project

Let's build our first app using Sequelize! First we need to create a node app and include our dependencies. __All in terminal__:

Navigate to the directory where you keep your projects/examples for this class. Then:

```bash
mkdir first_sequelize_app # creates a folder for your new node project
cd first_sequelize app # switches to that folder
touch app.js # create an app.js file (main server file)
echo "node_modules" > .gitignore # tells git what files to ignore in your project
git init # creates a new git repo
```

Now we initialize our project and add/save dependencies 

```bash
npm init
npm install --save express ejs
```

Note that for apps that use sequelize we'll need to do the following install (so you'll want to remember this for the future if you plan to use sequelize in your own apps):

```bash
npm install --save pg lodash sequelize
```

Create a database (using the postgres tool "createdb") and initialize a sequelize project (using a "sequelize-cli" tool):

```bash
createdb first_sequelize_app
sequelize init
```

### Setup part 3 - config.json, models and migrations:

Run the following command to open your project in Sublime:

```bash
subl .
```

In sublime we should now see a bunch of new folders. We now have config, migrations and models. This was created for us when we ran `sequelize init`. Let's start in the config folder and open up the config.json file. This file contains information about the database we are using as well as how to connect. We have three settings, one for development (what we will use now), test (for testing our code), and production (when we deploy our app on AWS/Heroku). Let's change the config.json so it looks like this (we will not be using the test or production environments, so just ignore those for now - all that matters is "development").

```json
{
  "development": {
    "database": "first_sequelize_app",
    "host": "127.0.0.1",
    "dialect": "postgres"
  },
  "test": {
    "database": "database_test",
    "host": "127.0.0.1",
    "dialect": "postgres"
  },
  "production": {
    "database": "database_production",
    "host": "127.0.0.1",
    "dialect": "postgres"
  }
}

```

Once this is complete, let's move to the models folder.

## Creating your first model

In order to create a model, we start with `sequelize model:create` and then specify the name of the model using the `--name` flag. Make sure your models are __always__ in the singular. This is a bit different than yesterday when we told you that table names should always be pluralized. However, using the singular form of a word for your model name actually makes sense, since your model represents a blueprint for an instance of an object — just like javascript constructors. And do we use the singular or plural form for constructors?

Moving on, after passing in the --name flag followed by the name of your model, you can then add an --attributes flag and pass in data about your model. When Sequelize generates your model, it will also generate a corresponding migration automatically. You only need to do this once for your model. Remember, if you want to make changes to your model after generating it - all you have to do is make a change and save it.

Here is an example of a command to generate a User model with a first_name, last_name and age. Make sure you do __not__ have any spaces for each of the attributes and their data types

`sequelize model:create --name User --attributes first_name:string,last_name:string,age:integer`

This will generate the following model:

```js
"use strict";

module.exports = function(sequelize, DataTypes) {
  var User = sequelize.define("User", {
    first_name: DataTypes.STRING,
    last_name: DataTypes.STRING,
    age: DataTypes.INTEGER
  }, {
    classMethods: {
      associate: function(models) {
        // associations can be defined here
      }
    }
  });

  return User;
};
```

I've now mentioned these "migrations" a few times. And while Sequelize uses migrations to manage your database and you _could as well_, we've agreed that for the time being, we're going to use some auto-magical features in Sequelize instead, and come back to migrations a bit later on.

### What is this "associate" thing in my model?

In the `associate` function, we specify any relations/associations (one to one, one to many or many to many) between our models (hasMany or belongsTo). These **"associations"** are essentially the __"joins"__ we talked about yesterday. And we'll definitely discuss this more a bit later. For now, just remember, the association (or relationship) between two tables goes in your models.

### Validations in Models

Sequelize has a bunch of validations we can add to our models to ensure that our data has met certain criteria before it gets added to our database. To include validations in your model, wrap them in a validate object. An examples of this is validating an email address (making sure it has a @ etc. as well as ensuring that it is never null):

```
module.exports = function(sequelize, DataTypes) {
  var User = sequelize.define("user", {
 

    email: {
      type: DataTypes.STRING,
      validate: {
        isEmail: true
       }
    },
  },

    {
    classMethods: {
      associate: function(models) {
        // associations can be defined here
      }
    }
  });

  return User;
};
```