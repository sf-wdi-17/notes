# Know Your Relationships!

## High-Level Lesson Overview

Hopefully, you already feel like you have some familiarity with associations (since we covered relationships/associations in Sequelize). Today we'll be:

 - Reviewing what you already learned about associations
 - Translatihg what you've learned into Rails
   + _Because Ruby is synchronous, working with associations is a snap!_
 - Discussing migrations in **much more detail** than when we worked in Sequelize _(as promised! Yay!)_

---

## **H**opefully **H**elpful **H**ints

When you are **creating associations** in Rails' ActiveRecord (or most any ORM, for that matter):

  - You'll define the relationships in your models (the blueprint for your objects)
    + Don't forget to define all sides of the relationship (more on this in a moment)
  - Remember to put the foreign key for a relationship in your migrations
    + If you're not sure which side of the relationship has the foreign key, just use this simple rule: The model with `belongs_to` must include a foreign key.


## Learning Objectives

| Objective                                                                     |  
| :-------------------                                                          |  
| Understand how to create one-to-many and many-to-many relationships in rails. |  
| Understand how to modify migrations to add foreign keys to tables             |  
| Understand how to create a join table                                         |  
| Understand how to create model instances when they have associations.         |  

---

## Associations: A few common types

| Relationship type | Abbreviation            | Description                                                       | Example                                                                                        |  
| :---------------  | :---------------------- | ------------                                                      | ------------                                                                                   |  
| One-to-Many       | 1:N                     | Parent model is associated with many children from another model  | One owner `has_many` pets.                                                                     |  
| Many-to-Many      | N:M                     | Two models. Both can be associated with many of the other.        | Libraries and books. One library can have many books, while one book can be in many libraries. |


### Active Learning:

Before we move into the actual syntax, let's work together for 10 minutes to come up with some examples of both one-to-one and one-to-many relationships.

## One to many (1:N) Relationship

__Example__:
One owner `has_many` pets and...
A pet `belongs_to` one owner (this model will have a foreign key [FK] `owner_id`)

**Always remember!** : Whenever there is a `belongs_to` in the model, there should be a _FK in the matching migration_!

---

### So to set this up, we'll need two models:

```console
rails generate model Pet name:string
rails generate model Owner name:string
```

**Then, we'll need to add the following to our models:**

```ruby
class Owner < ActiveRecord::Base
    has_many :pets
end

class Pet < ActiveRecord::Base
    belongs_to :owner
end
```

Note that in this case, `belongs_to` uses the singular form of the class name (`:owner`), while `has_many` uses the pluralized form (`:pets`). 

But if you think about it, this is exactly how you'd want to say this in plain English. For example, if we were just discussing the relationship between pets and owners, we'd say:

  - "One owner has many pets"
  - "A pet belongs to an owner"

Now, as mentioned, we have to add a foreign key in our migration, so in our pets migration file we should add:

`t.integer :owner_id`

But wait, we could also do something more _rail-sy_ and say  

`t.references :owner`

This makes the association a bit more semantic and readable and has a few bonuses:

  1. It defines the name of the foreign key column (in this case, `owner_id`) for us.
  2. It adds a **foreign key constraint** which ensures **referential data integrity**  in our Postgresql database. (And if you want to know more about what that is, Google is going to be your friend here — or you can always ask me... after class.)

**But wait, there's more...**

We can actually get even more semantic and _rail-sy_ and say:

`t.belongs_to :owner`

This will do the same thing as `t.references`, but it has the added benefit of being super semantic for anyone reading your migrations later on.

---

### Wading in Deeper: Using our Associations

Before we can use our associations, we have to set up our database tables. Let's all run:

```console
rake db:migrate
```

Now, let's jump into our rails console by typing `rails c` at a command prompt, and check out how these new associations can help us define relationships between models:

```ruby
fido = Pet.create(name: "Fido")
lassie = Pet.create(name: "Lassie")
brett = Owner.create(name: "brett")
brett.pets
fido.owner
brett.pets << fido # Makes "fido" one of my pets
brett.pets << lassie # Makes "lassie" another one of my pets
brett.pets.size
brett.pets.map(&:name)
brett.pets.each {|x| puts "My pet is named #{x.name}!"}
fido.owner

# What's going to be returned when we do this?
fido.owner.name
```

Remember: We just saw that in Rails, we can associate two model **instances** together using the `<<` operator.

---

#### Wait!!!! What if I forget to add a foreign key before I first run `rake db:migrate`?

If you were to make the mistake of running `rake db:migrate` before adding a foreign key to the table's migration, it's ok. There's no need to panic. You can always fix this by creating a new migration...

```console
rails generate migration NameOfMigrationHere
```

...and then modifying it to include the following:

```ruby
change_table :pets do |t|
  # You ONLY need to add ONE OF THESE THREE to your new migration
  t.integer :owner_id
  # OR...
  t.references :owner
  # OR...
  t.belongs_to :owner
end
```

---

### Class Exercise 1

Let's jump over to [in-class exercise #1](associations_1toN_exercise.md) where you'll all work in groups on a solution.

---

## Many to Many (N:M) with 'through'

Thinking back to Sequelize, you should remember that a N:M relationship is appropriate whenever both models can possess more than one of the other.

Let's think about the example of students and courses. A student can take many courses and a course will have many students. If you think back to our SQL discussions, you'll recall that we used a _join_ table to create this kind of association.

---

### A Typical 'Join' Table

Remember that a _join_ table has two different FKs, one for each model it is associating. In the example below, 3 students have been associated with 4 different courses.

| student_id | course_id |  
| ---------- | --------- |  
| 1          | 1         |  
| 1          | 2         |  
| 1          | 3         |  
| 2          | 1         |  
| 2          | 4         |  
| 3          | 2         |  
| 3          | 3         |  

Let's make sure we understand how this _join table_ works before moving on.

---

### So how do we create N:M associations in rails?

We use the `has_many :relatedModel, :through => :joinTableName` method. 

We'll start by creating 3 models

```console
rails generate model Student name:string
rails generate model Course name:string
rails generate model Enrollment enrollment_date:date 
```

Note that "Enrollment" is our __join__ table.

---

After generating our models, we need to open them in sublime and edit them so they include the proper associations.

Your models should look as follows once you've finished making the necessary changes:

```ruby
# models/course.rb
class Course < ActiveRecord::Base
    has_many :enrollments
    has_many :courses, :through => :enrollments
end
```

```ruby
# models/student.rb
class Student < ActiveRecord::Base
    has_many :enrollments
    has_many :courses, :through => :enrollments
end
```

```ruby
# models/enrollment.rb
class Enrollment < ActiveRecord::Base
    belongs_to :course
    belongs_to :student
end
```

---

We'll also want to modify the migration for the `enrollment` model before we run db:migrate. Make your enrollment model look like this:

```ruby
class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.date :enrollment_date
      t.timestamps null: false

      # The foreign keys for the associations are defined below
      t.references :student
      t.references :course

      # or we can do this instead
      t.belongs_to :student
      t.belongs_to :course
    end
  end
end
```

Make sure your save the file before running `rake db:migrate`. 

(Also, just a reminder, if you're using postgresql, be sure to run `rake db:create` first!)

---

### Let's test out our models!

Open the rails console by running `rails c` in terminal.

At the command prompt, let's create some students:

```ruby
brett = Student.create(name: "Brett")
mike = Student.create(name: "Mike")
del = Student.create(name: "Delmer")
```

Now we can create some courses too:
```ruby
algebra = Course.create(name: "Algebra")
science = Course.create(name: "Science")
english = Course.create(name: "English")
french = Course.create(name: "French")
```

---

#### Associate our model instances

Now, because we've used `:through`, we can create our associations in the same way we do for a 1:N association. If you're the curious type, you can try just using `has_many` without `through` (outside of class time please!!) and then using the console to experiment and figure out how you'd associate, and then access various instances together. 

```ruby
brett.courses << algebra
brett.courses << french

mike.courses << science
mike.courses << english
mike.courses << french

# Here's a little trick: Use an array to associate multiple courses with a student in just one line of code.
del.courses << [english, algebra]
```

---

#### Let's see if it worked

Once you've done all of this, try the following and see if your output matches the below in _irb_.

```ruby
brett.courses.map(&:name)
# Outputs: => ["Algebra", "French"]

mike.courses.map(&:name)
# Outputs: => ["Science", "English", "French"]

del.courses.map(&:name)
# Outputs: => ["Algebra", "English"]
```

Side note: Anyone know why we're passing `&:name` to `.map` here? (Hint, it has something to do with Blocks and Procs)

---

### Many-to-Many Exercise 

To do this exercise, let's [head over to our many-to-many exercise file](associations_NtoM_exercise.md) and work together in groups of two.

---

# Less Common Associations

For your reference. If you'd like to experiment with these, go nuts! (after class please...)

  - [has_one](http://guides.rubyonrails.org/association_basics.html#the-has-one-association)
  - [has_one through:](http://guides.rubyonrails.org/association_basics.html#the-has-one-through-association)
  - [has_and_belongs_to_many](http://guides.rubyonrails.org/association_basics.html#has-and-belongs-to-many-association-reference)

---

## Other Useful Notes

  - [Associations Docs](http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html)
  - [Model field data types](http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/TableDefinition.html#method-i-column)

  













