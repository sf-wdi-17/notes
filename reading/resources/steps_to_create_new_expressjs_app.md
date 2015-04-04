# Starting a New Node/Express.js Application: Step-By-Step Instructions
If you've been having trouble remembering the steps to take to get up and running with Node/Express.js, follow this guide. Let me know if you encounter any issues. Thanks! 

-Brett





## Start a New Application From Scratch
Follow the steps below to start a new application from scratch. If you're supposed to be starting from an existing git repository (on GitHub or another git server), please see the relevant instructions below instead.

### QuickStart Directions
In the code block below, I've listed all the commands you'll need to set up a new ExpressJS application on your computer in the order you'll need to execute them. 

#### NOTES:

 - Anything surrounded by `< >` markers is intended to be a placeholder.
	 - `<app_name>` is a placeholder for the name of the app you'll be creating.
 - This version of the guide is intentionally brief. If you'd prefer more details, skip to the "Full Details" section below.

#### Commands to Enter
Enter the following commands at a `bash` prompt one-by-one (unless otherwise indicated in the comments).
```bash
# Before starting setup, you have to navigate to the directory where you keep ExpressJS applications
cd <directory_where_you_keep_all_applications>

# Once in your 'code' directory, run the following commands
mkdir <app_name>
cd <app_name>

# Start adding files
touch app.js
echo "# README for <app_name>" > README.md
echo "node_modules" > .gitignore

# Initializations
git init
npm init

# Install dependencies: This assumes you're using Sequelize and PG
npm install --save express ejs body-parser method-override lodash pg pg-hstore sequelize

# Setup DB
createdb <app_name>
sequelize init

# That's it. Open your project:
subl .
```

Don't forget to edit your sequelize configuration by modifying the `dialect` and `database` fields in the `config.json` file!

### Full Details

#### Part 1: Creating a New Directory
First, you have to navigate to the directory where you want to keep your Node/Express.js projects. I can't tell you exactly where this is on your computer, but I recommend you pick a particular location, and stick with it. For me, this location is `~/code/` which means it's a folder called `code` in my *home directory* (because, as we've said, `~` means the **current user's home folder**).

So to get started, execute the steps below, replacing anything that looks like this `<insert here>` with whatever string/value is appropriate on your computer.
```bash
# Change to the directory where you keep your apps
cd <path_where_you_keep_express_apps>

# Create a new directory for your application
mkdir <app_name>

# This command should print at least 1 line if the directory was created properly
ls -ld <app_name>

# Move into the new directory you just created
cd <app_name>
```
Now you have created a directory for your new project, and changed into that new directory.

#### Part 2: Add Required Files
The next step is to add some files that will be required by Node/Express.js and Git.
```bash
touch app.js # Creates the main server file you'll need.
echo "README for <app_name>" > README.md # Creates a README file for use with GitHub documentation
echo "node_modules" > .gitignore
```
You can check to make sure you're on track by typing `ls -lA` at the prompt. When you hit enter, you should see the following output:
```sh
-rw-r--r--@ 1 <user>  staff  <date> <time> .gitignore
-rw-r--r--@ 1 <user>  staff  <date> <time> README.md
-rw-r--r--@ 1 <user>  staff  <date> <time> app.js
```
If the output doesn't look like this, something is wrong and I'd suggest you navigate back to the directory where you normally keep your code and start again (you might also want to run `rm -rf <app_name>` before you start again to remove the work you already did.)

#### Part 3: Initialize Git and NPM
Now you have to get a git repo set up and initialize NPM for your project.
```bash
# Initialize a new git repo
git init 

# Create 'package.json' file
npm init # Press enter in response to all prompts.
```
To confirm everything has gone as expected, first run `ls -lA` again. You should now see:
```sh
drwxr-xr-x@ 9 <user>  staff  306 Apr  4 00:14 .git
-rw-r--r--@ 1 <user>  staff   13 Apr  4 00:08 .gitignore
-rw-r--r--@ 1 <user>  staff   22 Apr  4 00:08 README.md
-rw-r--r--@ 1 <user>  staff    0 Apr  4 00:08 app.js
-rw-r--r--@ 1 <user>  staff  202 Apr  4 00:14 package.json
```
Also, you can run `cat package.json` to confirm the npm configuration file was created correctly. The output should be something like:
```json
{
  "name": "<app_name>",
  "version": "1.0.0",
  "description": "",
  "main": "app.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC"
}
```

#### Part 4: Install Dependencies with NPM
So now you'll need to install the dependencies you'll need for an Express.js application.
```bash
# Install basic dependencies
npm install --save express ejs body-parser method-override 

# Install Postgres and Sequelize stuff if using a database
npm install --save sequelize pg pg-hstore lodash
```
Run `cat package.json` again to confirm you've done this correctly. If you have, the `package.json` file should now look like this:
```json
{
  "name": "<app_name>",
  "version": "1.0.0",
  "description": "",
  "main": "app.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC",
  "dependencies": {
    "body-parser": "^1.12.2",
    "ejs": "^2.3.1",
    "express": "^4.12.3",
    "lodash": "^3.6.0",
    "method-override": "^2.3.2",
    "pg": "^4.3.0",
    "pg-hstore": "^2.3.2",
    "sequelize": "^2.0.5"
  }
}
```

#### Part 5: Create your database and initialize Sequelize
If you're application will use a database *and you plan to persist data to that database*, you'll want to **set up a database** and **initialize Sequelize**.
```bash
createdb <app_name>
sequelize init
```
##### Part 5.1: Confirming Sequelize Initialization
Sequelize will have created a bunch of additional folders and files for you. You can check that this happened by typing `ls -l` at the `bash` prompt and checking that the following lines are present in the output:
```bash
drwxr-xr-x  3 <user>  staff    102 Apr  3 21:08 config
drwxr-xr-x  3 <user>  staff    102 Apr  3 21:08 migrations
drwxr-xr-x  4 <user>  staff    136 Apr  3 21:08 models
```

##### Part 5.2: Confirming Database Creation
If you want to confirm that the database was actually created by the `createdb` command, you can type `psql` at a bash prompt. Once you're into the psql application (you'll know you're there because you're prompt will change so it ends with a `#`), type:
```
\list <app_name>
```
If your database was created correctly, the database should be returned by this command and you'll see `(1 row)` at the bottom. You'll see the following output.

      Name   | Owner | Encoding |   Collate   |    Ctype    | Access privileges 
    ---------+-------+----------+-------------+-------------+-------------------
     <app_name> | <user> | UTF8     | en_US.UTF-8 | en_US.UTF-8 | 
    (1 row)

If `createdb` did not create the database correctly (or maybe you entered the name of your application incorrectly), you'll get back `(0 rows)` instead:

     Name | Owner | Encoding | Collate | Ctype | Access privileges 
    ------+-------+----------+---------+-------+-------------------
    (0 rows)


#### Part 6: Configuring Sequelize
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
  - Change the value for the `database` key to `<app_name>`
  - Change the value for `dialect` to `postgres`

When you've made the changes, your `config.json` file should look something like this:
```json
{
  "development": {
    "database": "<app_name>",
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
Remember that `<app_name>` should always be replaced with the name of your project (so it should be replaced with something like `classmates_app`).

#### Part 7: You're Done! Now Build Your Application
To get started editing your application, simply type `subl .` to open your **whole application** in Sublime Text.

> Written by Brett Levenson on April 3, 2015 with [StackEdit](https://stackedit.io/).

