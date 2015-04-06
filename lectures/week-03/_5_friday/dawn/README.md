# Restful Routing
Lecture on restful routing.

## Objectives
Students will be able to...

- Understand the key concepts behind restful routing
- Apply different routes for different actions with different http verbs
- Explore the limits of restful routing in plain HTML

## Link
For now, we structured routes as we pleased. There is a convention called "Restful Routing" that is widely spread and most commonly used for web development. It is recommended because of its clean syntax and widespread use. From now on, we will design routes following this design pattern.

## Exercise

The question is really how we map different routes to different database operations. Each route needs to direct to a different method in our app that manipulates data differently. In other words, we need to map the CRUD scheme onto our routes.

Given a users table, what could be the route to...

- list all users => maybe something like /allUsers?
- list one user
- render a page to edit a user
- update a user
- render a page to create a user
- create a user
- delete a user

## Educate & Engage
"REST" stands for "Representational State Transfer". Without getting into too much detail, it basically means that your routes and HTTP verbs should compliment each other in a meaningful way to map onto CRUD.

## How To Design Routes

Routes are usually used to display resources. Resources are normally just the same as a database table.

For example, let's say we have a users table in our database. That means whenever we want to display something to the client about the users, we are dealing with a resource that is called "users".

Routes are to be designed using the plural name of the resource.

Example routes to show, edit, update, delete, create a single user and to list all users:

| ACTION | ROUTE         | HTTP VERB |
|--------|---------------|-----------|
| list   | /users        | GET       |
| show   | /users/1      | GET       |
| edit   | /users/1/edit | GET       |
| new    | /users/new    | GET       |
| create | /users        | POST      |
| update | /users/1      | PATCH     |
| delete | /users/1      | DELETE    |

You will have to know these by heart. Please. Don't invent your own routes every time.

**Routes Are Not File Paths!**

Instead, they are arbitrary strings that your server will direct to a function. The only thing they have in common is the forward slash. Don't confuse the two!

File paths to your views should look like this (with the example of a users resource):

- views/users/index.html
- views/users/show.html
- views/users/edit.html

These are just files rendered by your server.

## Active Learning
Create a table like the one above with restful routes for the following use cases:

- list all photos
- list all animals
- show a photo
- delete a photo
- create a person
- edit an animal
- update an animal
- show a user
- update a car
- list all cars
- create a car
- render a page to create a car
- render a page to create an animal
- create an animal
- show a computer
- delete a phone
- edit a person

## Reflect
Restful routing is the standard design pattern for meaningful routes.

Again, please just learn these by heart and don't reinvent the wheel everytime you need to define a route.

## Now and Then
We will use restful routing whenever we design routes from here on out.
