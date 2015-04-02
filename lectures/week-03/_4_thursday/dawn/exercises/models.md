# Exercises

### Setup

Create a new project folder

```
mkdir intro_examples && cd intro_examples
```

Then init an npm project

```
npm init
```

and only install sequelize

```
npm install --save  pg sequelize
```


### Initialize A Sequelize Setup

Use the `sequelize init` command to generate your model folders. Then create a db to play with:

```
createdb example_dev
```

Edit your `config.json` to use the db you created above.

```
{
  "development": {
    "database": "example_dev",
    "host": "127.0.0.1",
    "dialect": "postgres"
  },
  ...

}
```


### Model Creation

* Use the `sequelize` tool to create a `book` model with the following attributes:
  * `title string`
  * `author string`
  * `synopsis text`
  * `library_id integer`

* Use the `sequelize` tool to create a `library` model with the following attributes:
  * `name string`


#### Migrate

Be sure to migrate your newly created models, and be prepared to run into errors every time you go through this process

```
sequelize db:migrate
```

### Exercises

Go into your node terminal for the following, i.e.

```
node
> var db = require('./models');
```

First Create Two Libraries with names of your choosing:

Next let's create some of the following books:

* create a book with the title 'The Giver', author 'Lois Lowry', a synopsis of your choosing, and library_id of 1.
* create a book with the title 'The Taker', author 'Lisa', a synopsis of your choosing, and library_id of 1.
* create a book with the title 'The Hunger Games', author 'Suzanne Collins', a synopsis of your choosing, and library_id of 1.


Next let's create another set of books

* create a book with the title 'Harry Potter', author 'J.K. Rowling', a synopsis of your choosing, and library_id of **2**.
* create a book with the title 'Twilight', author 'Stephenie Meyer', a synopsis of your choosing, and library_id of **2**.
* create a book with the title 'Divergent', author 'Veronica Roth', a synopsis of your choosing, and library_id of **2**.








