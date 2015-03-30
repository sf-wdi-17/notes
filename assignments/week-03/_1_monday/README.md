# Create a Calculator Using Routes in Express

Using what we learned today about Express and routes, create a calculator.

To get started, you'll want to use GitHub to fork our [Express server repo](https://github.com/sf-wdi-17/simple-server) (the same one we used in class today). Once forked to your own GitHub account, then you'll clone it to your computer.

To clone a repo, you'll want to go to a bash prompt in your terminal (you'll know you're there if you see a '$' at the end of the prompt string). Make sure you `cd` into whatever directory you've been using to do your homework. (Note that if you already cloned this repo in class, and you try to clone again in the same directory, git will give you an error).

```bash
git clone git@github.com:sf-wdi-17/simple-server.git
```

Once the clone is complete, type the following to enter the simple-server repo directory:

```bash
cd simple-server
```

Ok, if you're here, you should be ready to go, just type `subl .` to open the directory in Sublime Text.

## Ok, now what?

First, you'll want to create an index page that uses the root 'route' that explains to a user how to add/subtract/multiply/divide.

Something like:
```js
app.get('/', function(req, res) {
   res.send("") // Your HTML would go here. 
});
```

Next, you'll want to create 4 additional routes for the calculator functions.You'll need one for adding, another for subtracting, and two more for multiplying and dividing. We hope you'll be able to figure out how to structure these routes, but if you have trouble, send us a message on Slack!

Make sure to use named URL parameters like what we did [in class this afternoon for Exercises 3-5]( ../../../lectures/week-03/_1_monday/dusk/README.md). We'd probably call those params `:x` and `:y`, but you can call them anything you want. After all, you're the developer and you're in control!




