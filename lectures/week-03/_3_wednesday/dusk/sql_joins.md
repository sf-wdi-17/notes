#SQL Joins

##Learning Objectives
By the end of this lesson we should all:
  - Know what a `join` is
  - Know what a _join table_ is
  - Know what a 'key' is, and know the difference between:
    + Primary keys, and...
    + Foreign keys
  - Understand the different types of joins, and:
    + What each type of join retrieves
    + How to visualize each type of join

##Quick SQL Review

So far, we've:
1. Installed Postgresql
2. Learned how to run `psql` and how to move around within the application
3. Learned how to CREATE/DROP DATABASES and TABLES
4. Learned the four basic SQL operations:
  - SELECT ... FROM ...
  - INSERT INTO () VALUES ()
  - UPDATE ... SET ...
  - DELETE FROM ...
5. Learned about `id` columns and their purpose as a unique identifier
6. Learned about a few data types in postgresql
  - VARCHAR(n)
  - TEXT
  - INTEGER
  - SERIAL

Using just these basic features, we essentially have something similar to a spreadsheet.

##Why are Joins Important

The main function of a relational database is to allow us to create relationships between different pieces of data. 

For example, if we're building a blog, we'll need to keep track of users, and we'll also want to store blog posts in our database. That's a start, but do you think it's important that we know which users wrote which posts?  

Imagine if facebook had no way of keeping track of what other users you were friends with, or which users wrote which post on your wall. Without the ability to perform joins, we'd have a very difficult time creating useful applications.

###Relationships and Joins

Postgres and other SQL databases are relational. They are designed for storing and viewing data that is interrelated. To accomplish this, we'll need some way for one table to express its relationship to another table. We do this using __keys__.

###Keys

**Primary Key:** We've actually already seen primary keys: The `id` column that we explained this morning is also called a table's __primary key__. 

__By definition:__
The primary key of a relational database table will uniquely identifies each record (AKA _row_) in the table.

**Foreign Key:**  A foreign key is a column (or a group of columns) in one table that a related table will use to establish and enforce the relationship, or _link_ between the data each table is responsible for storing. Very often, this __foreign key__ refers to the primary key of the related table.

####Foreign Key Example

![foreign_key](foreign_key.png)

#####First, we have to create a foreign key on one table

```sql
create table persons (
  id serial primary key,
  name text,
  age integer
);

create table pets (
  id serial primary key,
  name text,
  age integer,
  breed text,
  person_id integer
);

INSERT INTO persons ( name, age)
VALUES ('Zed', 37);

INSERT INTO persons ( name, age)
VALUES ('Bobby', 7);

INSERT INTO pets (name, breed, age, person_id)
VALUES ( 'Fluffy', 'Unicorn', 1000, 1);

INSERT INTO pets (name, breed, age, person_id)
VALUES ('Rocko', 'Dog', 4, 2);

INSERT INTO pets (name, breed, age, person_id)
VALUES ('Gigantor', 'Robot', 25, 1);

INSERT INTO pets (name, breed, age, person_id)
VALUES ('Goldy', 'Fish', 1, 2);

```

#####Now we can perform our first join

```sql
SELECT * FROM persons
INNER JOIN pets
ON persons.id = pets.person_id;

SELECT persons.name, pets.name from persons
INNER JOIN pets 
ON persons.id = pets.person_id;
```

**Other Types of Joins**  

![SQL Joins Diagram](http://lh5.ggpht.com/-fnOQYPFr8D0/UagAzBIgMvI/AAAAAAAABbo/3fBL5Fm3Y9Y/SQL%252520JOINs.jpg)  

Full Outer Join  

```sql
SELECT * FROM persons 
  FULL OUTER JOIN pets
  ON persons.id = pets.person_id;
```

Left Outer Join  

```sql

SELECT * FROM persons 
  LEFT OUTER JOIN pets
  ON persons.id = pets.person_id;

```

Right Outer Join  

```sql

SELECT * FROM persons 
  RIGHT OUTER JOIN pets
  ON persons.id = pets.person_id;

```  

Left Outer Join with Where  

```sql
SELECT * FROM persons
  LEFT OUTER JOIN pets
  ON persons.id = pets.person_id
  WHERE pets.breed = "unicorn";
```

Cross Join  

```sql
SELECT * FROM persons
  CROSS JOIN pets
  WHERE persons.id = 1;
```

####Join Tables

In the prior examples, the joins we've performed have established a relationship between two tables where a row in __one__ table can have a relationship to __many__ rows in another table.

But what if the data in two separate tables can have a __many to many__ relationship? Let's talk about what this might mean a bit more before we continue...

#####Working with a Join Table
Now that we understand this type of relationship, we'll need something to make this happen. We call this something a __join table__.

```sql
create table persons (
  id integer primary key,
  name text,
  age integer
);

create table pets (
  id integer primary key,
  name text,
  age integer,
  breed text,
  dead integer
);

create table persons_pets (
  person_id integer,
  pet_id integer 
);
```

Now we execute the following statement to join the two tables together and select data.

```sql
SELECT * FROM persons 
    INNER JOIN persons_pets
    ON persons.id = persons_pets.person_id
    INNER JOIN pets
    ON persons_pets.pet_id = pets.id;
```

####Exercise

Using the following code to get started, practice selecting data from your related tables using joins.

___First Create Your Tables__

```sql
create table persons (
  id integer primary key,
  name text,
  age integer
);

create table pets (
  id integer primary key,
  name text,
  age integer,
  breed text,
  dead integer
);

create table persons_pets (
  person_id integer,
  pet_id integer 
);
```