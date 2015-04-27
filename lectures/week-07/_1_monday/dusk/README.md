# Relationships / Associations

Hopefully, you already feel like you have some familiarity with associations since we discussed associations in Sequelize.

In rails, here are some things to remember when working with associations:

  1. Always define all sides of a relationship.
  2. `belongs_to` has the foreign key (FK)
  3. Put your FKs in the migration files

## Objectives
  - Understand how to create one-to-many and many-to-many relationships in rails.
  - Understand how to modify migrations to add foreign keys to tables
  - Understand how to create a join table
  - Understand how to create model instances when they have associations.

---

# Common Types of Relationships

## One to many (1:N)

__Example__:
One owner `has_many` pets and...
Many pets `belongs_to` one owner

(FK goes in the pets table)

__Always remember__: Whenever there is a `belongs_to` in the model, there should be a FK in the matching migration!

---

### So to set this up, in our models we would add

```rb
class Owner < ActiveRecord::Base
    has_many :pets
end

class Pet < ActiveRecord::Base
    belongs_to :owner
end
```

Note that `belongs_to` uses the singular form of the class name ('owner'), while `has_many` uses the pluralized form ('pets').

Now, as mentioned, we have to add a foreign key in our migration, so in our pets migration file we should add:

`t.references :owner`

---

### Let's use our associated models

Now, let's jump into our rails console by typing `rails c` at a command prompt, and check out how these new associations can help us define relationships between models:

```rb
fido = Pet.create(name: "Fido")
lassie = Pet.create(name: "Lassie")
brett = Owner.create(name: "brett")
brett.pets
fido.owner
brett.pets << fido
brett.pets << lassie
brett.pets.size
brett.pets.map(&:name)
brett.pets.each {|x| puts "My pet is named #{x.name}!"}
fido.owner
```

---

#### What if I don't add my foreign key when I first create my models?

If you were to make a mistake and forget to add your foreign key references at first, you can always fix this by adding the following to a new migration:

```rb
change_table :pets do |t|
  t.references :owner
end
```

or

```rb
change_table :pets do |t|
  t.integer :owner_id
end
```

---

### Class Exercise 1

Imagine we're creating an online order system for an e-commerce site. A customer loads up their shopping cart with _items_ and a new _order_ is created when they check out. So we know we'll have an `order` model and an `item` model.

For this exercise, here are the attributes for each model:
Order: Name
Item: Name, description, price

Be sure to think about what the relationship between _Orders_ and _Items_ should be.

If the relationship is modeled correctly, you'll be able to assign a variable `o = Order.create` and then type `o.items` without getting back an error. You should also be able to assign a variable `i = Item.create` and then type `i.order` without an error.

Once you've finished creating the models:
  1. Create 5 items
  2. Create 2 Orders
  3. Assign 3 items to the order with id = 1, and 2 items to order with id = 2.
  4. Play around with some of the array methods you know (each, map, select, size) for each order

---

#### Exercise Bonus

Using your knowledge of procs and blocks, try to select only the items in an order that are less than a certain price.

You'll need to start with something like this:
```rb
someorder.items.select { ... } # Your code to select goes between the brackets.

# Note this could also be written like this
someorder.items.select do 
    # Code to select specific items goes here
end
```

---

## Many to Many (N:M) with 'through'

Thinking back to Sequelize, you should remember that a N:M relationship is appropriate whenever both models can possess more than one of the other.

Let's think about the example of students and courses. A student can take many courses and a course will have many students. If you think back to Sequelize, you'll recall that we used a _join_ table to create this kind of association.

---

### A Typical 'Join' Table

Remember that a _join_ table has two different FKs, one for each model it is associating. In the example below, 3 students have been associated with 4 different courses.

student_id | course_id
---------- | ---------
1 | 1
1 | 2
1 | 3
2 | 1
2 | 4
3 | 2
3 | 3

Let's make sure we understand how this _join table_ works before moving on.

---

### So how do we create N:M associations in rails?

We use the `has_many :relation, :through => :join` method. 

We'll start by creating 3 models

```bash
$ rails generate model Student name:string
$ rails generate model Course name:string
$ rails generate model Enrollment enrollment_date:date 
```

Note that "Enrollment" is our __join__ table.

---

After generating our models, we need to open them in sublime and edit them so they include the proper associations.

Your models should look as follows once you've finished making the necessary changes:

```rb
# models/course.rb
class Course < ActiveRecord::Base
    has_many :enrollments
    has_many :courses, :through => :enrollments
end
```

```rb
# models/student.rb
class Student < ActiveRecord::Base
    has_many :enrollments
    has_many :courses, :through => :enrollments
end
```

```rb
# models/enrollment.rb
class Enrollment < ActiveRecord::Base
    belongs_to :course
    belongs_to :student
end
```

---

We'll also want to modify the migration for the `enrollment` model before we run db:migrate. Make your enrollment model look like this:

```rb
class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.date :enrollment_date
      t.timestamps null: false

      # The foreign keys for the associations are defined below
      t.references :student
      t.references :course
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

```rb
brett = Student.create(name: "Brett")
mike = Student.create(name: "Mike")
del = Student.create(name: "Delmer")
```

Now we can create some courses too:
```rb
algebra = Course.create(name: "Algebra")
science = Course.create(name: "Science")
english = Course.create(name: "English")
french = Course.create(name: "French")
```

---

#### Associate our model instances

Now, because we've used `:through`, we can create our associations in the same way we do for a 1:N association.

```rb
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

```rb
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

Let's pair into groups of two. 

Let's create models for something like Amazon.com. Amazon has many products, and many customers. Customers can purchase many products at one time by creating a shopping cart, and that cart becomes an order once the customer completes checkout.

Your mission, should you wish to accept it:
  1. Create 3 models (the third model can be called "sale" or "order")
  2. Use the rails console to add products and customers to 2-3 'sales' (or 'orders')
  3. Use the rails console to display all products and customers associated with each order.

---

# Less Common Associations

For your reference only.

  - [has_one](http://guides.rubyonrails.org/association_basics.html#the-has-one-association)
  - [has_one through:](http://guides.rubyonrails.org/association_basics.html#the-has-one-through-association)
  - [has_and_belongs_to_many](http://guides.rubyonrails.org/association_basics.html#has-and-belongs-to-many-association-reference)

---

## Other Useful Notes

  - [Associations Docs](http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html)
  - [Model field data types](http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/TableDefinition.html#method-i-column)

  













