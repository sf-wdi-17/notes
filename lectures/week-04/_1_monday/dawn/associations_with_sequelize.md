# Sequelize: Associations

## Quick Concept Review:

### Sequelize

Sequelize is an ORM **(Object Relational Mapper)**.
  - What's the basic function of Sequelize (or any ORM?)
  - What are the benefits of using an ORM in your applications?

### ORM Structure

**Object oriented application** <=> ORM <=> **Relational Database**

So, Sequelize is just a piece of *middleware* that helps map objects to tables in a relational database. This allows us to think and code in terms of objects, rather than writing complex SQL queries, while making persistence possible.

### The Purpose of ORMs (like Sequelize)
  - Represent object oriented data as models
  - Represent associations between those models
  - Validate (AKA *check*) data before it is stored in the database
  - Perform database operations in an object-oriented fashion


### ORM Terms Review

#### Models

What's a model? Why is it called a model?

  - A model is a blueprint for a particular class of objects.
  - A model **maps** the data in your database to objects in your application

#### Migrations

AKA *schema evolution* or *mutation*

  - A migration provides the means by which to update the structure of your objects and their associated database tables from one version into another.
  - A migration does not really act on specific instances of a class. Rather, it:
    * Defines the structure of an object and its associated database tables
    * Modifies (updates) the structure of an object and its associated database tables
    * Deletes a class from your database and application


### Review: CRUD Using Sequelize

Let's review how to perform the basic CRUD actions in Sequelize: 
  - **C**reate
  - **R**ead
  - **U**pdate
  - **D**elete

## Associations with Sequelize

###Learning Objectives

 - Understand what an "association" is
 - Understand the different types of associations and when to use them
 - Know how to create different types of associations between models in Sequelize
	 - One to many (1:N)
	 - Many to many (N:M)

### Getting started with associations

So what does it mean to say that two tables are "associated?" We've seen this idea before in **SQL**.

Databases should follow the same D.R.Y. principles as code. Database normalization allows us to eliminate redundancies, and reduce the chances of our DB containing incomplete, orphaned, or corrupted data, and associations are an important part of this process.

**The most common associations are:**

  - One-to-One (Denoted 1:1): In a *"one-to-one"* relationship, a child table is associated with **exactly one** parent, and that parent will have zero or one children. A good example would be a social media profile. Each user is entitled to one profile, but you might still separate your user authentication table from that users profile information.
  - One-to-Many (Denoted 1:N): In a *"one-to-many"* relationship between two objects, one object may have many "children", while the children have, at most, one "parent". For example, at many companies, a manager may manage zero or more employees, but each employee will only have 1 manager.
  - Many-to-Many (Denoted N:M): In a *"many to many"* relationship between two objects, each object may be associated with 0 or more instances of the other. For example, in a relationship between books and authors, a book may have many authors, and an author can write many books. 

### Creating One-To-Many Associations Using Sequelize

We're going to modify our classmates app. We'll:

 - Add a new model called **courses**.
 - Create a one-to-many association between **students** and **courses**.

#### Checking for Understanding:

 - What does this type of relationship signify?  
 - How can we express this relationship in simple, everyday language?

#### Making the Changes

First, let's create two different models. One for `Student` and one for `Course`

```
$ createdb <db_name>
$ sequelize init
$ sequelize model:create --name Student --attributes "name:string, age:integer"
$ sequelize model:create --name Course --attributes "name:string,description:text"
```

Let's not forget to update `config/config.json` before moving on.

Next, we'll modify the `associate` function in our models:

To do this, we change our `Classmate.js` model so that it contains:
```js
classMethods: {
      associate: function(models) {
        this.belongsTo(models.Course);
      }
    }
```

And we're going to change our `Course.js` model so that it contains:
```js
    classMethods: {
      associate: function(models) {
        this.hasMany(models.Student);
      }
    }
```

Finally, we want sequelize to take care of making these changes to our database for us, so we're going to make a small change to `app.js` that will have sequelize check our models on each run and make any necessary changes.

```js
  db.sequelize.sync().then(function() {
    var server = app.listen(3000, function() {
    // This part just adds a snazzy listening message:
    console.log(new Array(51).join("*"));
    console.log("\t LISTENING ON: \n\t\t localhost:3000");
    console.log(new Array(51).join("*")); 
  });
});
```

Now, if all has gone well, when we run our app using...
```
$ nodemon
```
...our database should be automatically updated with the appropriate foreign keys automatically. But we can check to make sure using `psql` in our terminal.

#### Fixing the Routes to Work with Associated 'courses' Table

So, we've now changed the structure of our database. It's a good change, because if the same course is being taken by many students, that course's name won't appear in the students table over and over again. But we still need to change our app to accomodate. 

But don't worry, it's a very small change.

Here's our new `/students` route, with the associations in use:
```js
app.get("/students", function (req, res) {
  db.book.findAll(
    {include: [db.Course]}
    ).then(function(students) {
    console.log("Showing all students:",students);

    res.render("students/index", {studentList: students});
  });
  
});
```

It's just one extra line: `{include: [db.Course]}`

Basically, this tells Sequelize, "Hey! Remember that association we set up between `student` and `course`, for each Student that you grab from the database, figure out the Course using the `courseId` foreign key, and add that author's information to the information returned with each book.

##### Quick Check:

 - What's different about the foreign keys that Sequelize expects vs. the foreign keys we've shown you so far?

#### So how would we go about grabbing all students and all the courses associated with each using Sequelize?

One way to do this is to use some special methods that Sequelize will create for you. These methods are called **getters and setters**.

Let's review the Sequelize documentation together and see if we can spot how we might do this.

[Sequelize Documentation](http://sequelize.readthedocs.org/en/latest/)

### Creating Many-to-Many Associations Using Sequelize

This isn't actually so different from creating one-to-many associations. What's more important is that we all understand the concept of many-to-many associations. They're tricky, and very important.

Let's take a look [at the documentation again](http://sequelize.readthedocs.org/en/latest/) and see if we can find out how to do this.

> Written by Brett Levenson with [StackEdit](https://stackedit.io/) on April 3, 2015.