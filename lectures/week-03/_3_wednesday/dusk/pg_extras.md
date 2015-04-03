# Postgres Extras

If we have some extra time, we'll talk about another feature of Postgres: The ability to read from, and write to a file.

## Using a SQL file

We can tell postgres to execute a set of SQL instructions in a file with a `.sql` extension.


`example.sql`
```
CREATE DATABASE example_app;

\c example_app

CREATE TABLE person (
      id serial primary key,
      name text,
      age integer
    );
    
INSERT INTO person ( name, age)
      VALUES ('Zed', 37);
\d+ person
```

Now imagine we want to be able to re-create this database from scratch with a basic set of data. How can we do this on demand? First of all, we'll want to add one line to our `example.sql` file that uses the `DROP DATABASE IF EXISTS` keyword:

```
DROP DATABASE IF EXISTS example_app;
CREATE DATABASE example_app;

\c example_app

CREATE TABLE person (
      id serial primary key,
      name text,
      age integer
    );
    
INSERT INTO person ( name, age)
      VALUES ('Zed', 37);
\d+ person
```

Once we save the `example.sql` file with this code, we can run the file from our command prompt by typing:
```bash
# Note that for this to work, you'd have to cd into the directory where example.sql is stored.
psql -f example.sql

# As an alternative, you could write out the full path to the file:
psql -f ~/code/example.sql
```

## Resources
[Other Helpful Postgresql Commands](http://www.chesnok.com/daily/2013/11/06/top-10-psql-commands-i-use/)