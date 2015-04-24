# Rails Models

## Objectives
By the end of today you should be able to...

* Generate models & migrations in Rails
* Use the rails console
* Add validations to our models

## Definitions

###ORM
**ORM** stands for object relational mapping. ORM describes a software system that maps SQL queries and results into objects. **Active Record** is the ORM system that is used in Rails.

###Models
**Models** are Ruby classes. They talk to the database, store and validate data, perform the business logic and otherwise do the heavy lifting.

###Migrations
A **migration** is a set of database instructions. Those
instructions are Ruby code, which migrates our database from one state
to another. Essentially they describe database changes.

###Validations
**Validations** are used to ensure that only valid data is saved into your database. For example, it may be important to your application to ensure that every user provides a valid email address and mailing address.

##Let's get started!

Please type all this by hand so you're not blindly copying & pasting and you remember it better.

Generate a new Rails project.

`rails new models_example`

Enter your app's direct.

`cd models_example/`

Create our database.

`rake db:create`

## Generate a Models & a Migrations

Create a new model called User with first_name and last_name
properties that are strings. Look at the output and try to decifer what files it just made for you.

`rails generate model User first_name:string last_name:string`

Migrate our database to create the **users** table.

`rake db:migrate`

## Familiarize yourself with the Rails Console

To enter, go to terminal and in the root of your rails app type

`rails console` or `rails c`

(This is IRB with your rails app loaded in.)

Inside of your Rails console, create a new User object.

`irb(main):001:0> albert = User.new`

Set the name of the user.

```
irb(main):002:0> albert.first_name = "Albert"
irb(main):002:0> albert.last_name = "Einstein"
```

Save your user to the database.

`irb(main):003:0> albert.save`

Retrieve all of the users in the database and store then im a users variable.

`irb(main):004:0> users = User.all`

Exit the console.

`exit`

##Modify the existing DB with another Migration

Let's also store a user's age along with their names. Generate a new
migration file named AddAgeToUsers.

`rails generate migration add_age_to_users age:integer`

This will automatically create the right migration.

Run the migration so that the column is added to the table.

`rake db:migrate`

We can check that the migration ran successfully.

`rake db:migrate:status`

NB: We can also undo the migration if we didn't like it.

`rake db:rollback`

#CRUD the users in the Console

#### Create
* `user = User.create(first_name: "Abraham", last_name: "Lincoln")`
* `user = User.create(first_name: "Abraham", last_name: "Maslow")`

NB: See all your users with `User.all`


#### Update

* Find - `user = User.find(1) #the number '1' passed into the find method corresponds to the id of the user it will find`
* Set - `user.first_name = "Taco"`
* Save - `user.save`

**or**

* Find — `user = User.find(1)` 
* Update — `user.update_attributes(first_name: "Taco")`

#### Delete

* Find - `user = User.find(1)`
* Destroy - `user.destroy`

#### More Finding

* `User.all` -> returns an array of allusers
* `User.find_by_last_name('Lincoln')` -> returns the first user that meets the criteria
* `User.where(first_name: 'Abraham')` -> returns an array of users that meet the criteria
* `User.first` -> finds first user
* `User.last` -> finds last user


## Validate your Models

We set our [validations](http://guides.rubyonrails.org/active_record_validations.html) in our app/models/user.rb model.

Let's make sure each user definitely has a first name and a last name before they're saved.

```ruby
class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
end
```

* Type `reload!` into the console to update your model validations.
* Try saving a user with no first or last name and see what error is thrown.

## Callbacks

- before_
- after_

##Further Reading

* [Active Record Overview](http://guides.rubyonrails.org/active_record_basics.html)
* [Migrations](http://edgeguides.rubyonrails.org/active_record_migrations.html)
* [Validations](http://guides.rubyonrails.org/active_record_validations.html)
