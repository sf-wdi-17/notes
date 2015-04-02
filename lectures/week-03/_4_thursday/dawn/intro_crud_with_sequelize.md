# CRUD with Sequelize (Using the User model from earlier today):

It's time to hop into __the laboratory__ to use our models. So open your node REPL and require your db:

```js
var db = require('./models');
```

## Create

```js
> db.user.create({ first_name: 'jane', last_name: 'doe', age: 26 })
  .then(function(user) {
  // you can now access the newly created task via the variable data
  });
```

## Read

```js
db.user.find(1)
  .then(function(user) {
  // user will be an instance of User and stores the content of the table entry with id 1. if such an entry is not defined you will get null
});
```



The methodfindOrCreate can be used to check if a certain element is already existing in the database. If that is the case the method will result in a respective instance. If the element does not yet exist, it will be created.
µ
```js
db.user.findOrCreate({ where: { first_name: 'jane' }})
  .then(function(result) {
    console.log("User is: ", result[0]);
    console.log("Was created: ", result[1]); // returns true if the user was created
  });
```

If you don't like that `user#findOrCreate` returns an array you can use `spread`


```js
db.user
  .findOrCreate({ where: { first_name: 'jane' }})
  .spread(function(user, creatd) {
    console.log("User is: ", user);
    console.log("Was created: ", created); // returns true if the user was created
  });
```

```js
db.user
  .findAll()
  .then(function(users) {
  // users will be an array of all User instances
});
```

## Update

```js
// way 1

User.find({ where: { first_name: 'jane' } })
  .then(function(user){
    user.first_name = 'Taco'
    task.save()
      .then(function() {});
})

// way 2
db.user
  .find({ where: { first_name: 'jane' } })
  .then(function(user){
    user.updateAttributes({
      first_name: 'Taco'
    }).then(function() {})
  })

```

## Delete

[destroy](http://sequelizejs.com/docs/latest/instances#destroy)

```js
db.user
  .find({ where: { first_name: 'jane' } })
  .then(function(user){
    user.destroy().then(function() {})
  })
```

## Older Listeners + Callbacks

When you make a request

These are all the same for success handling

```js
// each one is valid
Model.findAll().on('success', function(data) {})
Model.findAll().success(function(data) { })
Model.findAll().ok(function(data) { })
```

These are all the same for error handling

```js
Model.findAll().on('error', function(err) { })
Model.findAll().error(function(err) { })
Model.findAll().failure(function(err) {  })
Model.findAll().fail(function(err) {  })
```

These are all the same when you want one event to contain both the error and success information.

```js
Model.findAll().complete(function(err, result) { /* bar */ })
Model.findAll().done(function(err, result) { /* bar */ })
```