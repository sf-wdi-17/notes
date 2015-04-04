# Starting a New Node/Express.js Application: Step-By-Step Instructions
If you've been having trouble remembering the steps to take to get up and running with Node/Express.js, follow this guide. Let me know if you encounter any issues. Thanks! -Brett

## Start from Scratch
Follow the steps below to start a new application from scratch. If you're supposed to be starting from an existing git repository (on GitHub or another git server), please see the relevant instructions below instead.

### Part 1: Creating a New Directory
First, you have to navigate to the directory where you want to keep your Node/Express.js projects. I can't tell you exactly where this is on your computer, but I recommend you pick a particular location, and stick with it. For me, this location is `~/code/` which means it's a folder called `code` in my *home directory*.

So to get started, execute the steps below, replacing anything that looks like this `<insert here>` with whatever string/value is appropriate on your computer.
```bash
cd <path_to_projects_directory>
mkdir <new_project_name>
cd <new_project_name>
```
Now you have created a directory for your new project, and changed into that new directory.

### Part 2: Add Required Files
The next step is to add some files that will be required by Node/Express.js and Git.
```bash
touch app.js # Creates the main server file you'll need.
echo "README for <new_project_name>" > README.md # Creates a README file for use with GitHub documentation
echo "node_modules" > .gitignore
```

### Part 3: Initialize Git and NPM
Now you have to get a git repo set up and initialize NPM for your project.
```bash
# initializes a new git repo in your project dir, run:
git init 

# Initialize npm and creates 'package.json' file. 
npm init # Press enter in response to all prompts.
```

### Part 4: Install Dependencies with NPM
So now you'll need to install the dependencies you'll need for an Express.js application.
```bash
# Install basic dependencies
npm install --save express ejs body-parser method-override 

# Install Postgres and Sequelize stuff if using a database
npm install --save sequelize pg pg-hstore
```

### Part 5: Create your database and initialize Sequelize
If you're application will use a database *and you plan to persist data to that database*, you'll want to **set up a database** and **initialize Sequelize**.
```bash
createdb <new_project_name>
sequelize init
```
#### Part 5.1: Confirming Sequelize Initialization
Sequelize will have created a bunch of additional folders and files for you. You can check that this happened by typing `ls -l` at the `bash` prompt and checking that the following lines are present in the output:
```bash
drwxr-xr-x  3 brett  staff    102 Apr  3 21:08 config
drwxr-xr-x  3 brett  staff    102 Apr  3 21:08 migrations
drwxr-xr-x  4 brett  staff    136 Apr  3 21:08 models
```
Additionally, if you type `ls -l config/` you can examine the *config directory* and you should see the config.json file in the output:
```bash
-rw-r--r--@ 1 brett  staff  423 Apr  3 21:08 config.json
```

#### Part 5.2: Confirming Database Creation
If you want to confirm that the database was actually created by the `createdb` command, you can type `psql` at a bash prompt. Once you're into the psql application (you'll know you're there because you're prompt will change so it ends with a `#`), type:
```sql
\list
```
If all has gone well, you should see a line in the list showing your database `<new_project_name>` and looks something like this:
```
test_db | <user_name> | UTF8 | en_US.UTF-8 | en_US.UTF-8 |
```

### Part 6: Configuring Sequelize
To finish setting up Sequelize, we have to make a few changes to the config.json file that was created by the `sequelize init` command.

Type `subl config/config.json` to open the **config.json** file in Sublime Text.

Once Sublime opens, you should see the following default version of the **config.json** file:
```json
{
  "development": {
    "username": "root",
    "password": null,
    "database": "database_development",
    "host": "127.0.0.1",
    "dialect": "mysql"
  },
  "test": {
    "username": "root",
    "password": null,
    "database": "database_test",
    "host": "127.0.0.1",
    "dialect": "mysql"
  },
  "production": {
    "username": "root",
    "password": null,
    "database": "database_production",
    "host": "127.0.0.1",
    "dialect": "mysql"
  }
}
```
We'll want to edit the `"development"` object within the file to configure the *development environment* for your application (in the future, we'll go over how to edit this file for deployment to a *production environment*). To set up your dev environment, make the following changes to `config.json`:
  - Remove the key/value pairs for `username` and `password`
  - Change the value for the `database` key to `<new_project_name>`
  - Change the value for `dialect` to `postgres`

When you've made the changes, your `config.json` file should look something like this:
```json
{
  "development": {
    "database": "<new_project_name>",
    "host": "127.0.0.1",
    "dialect": "postgres"
  },
  "test": {
    "username": "root",
    "password": null,
    "database": "database_test",
    "host": "127.0.0.1",
    "dialect": "mysql"
  },
  "production": {
    "username": "root",
    "password": null,
    "database": "database_production",
    "host": "127.0.0.1",
    "dialect": "mysql"
  }
}
```
Remember that `<new_project_name>` should always be replaced with the name of your project (so it should be replaced with something like `classmates_app`).

----------

That's it. You're ready to go! To get started editing your application, simply type `subl .` to open the *root of your application and all it's subdirectories* in Sublime Text.

> Written by Brett Levenson on April 3, 2015 with [StackEdit](https://stackedit.io/).

