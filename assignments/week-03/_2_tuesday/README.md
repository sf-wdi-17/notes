# Create a Calculator Using Forms

Create a page with four forms, one for each calculation.

Each form should have two inputs and post to its own route.

The server will then perform the desired calculation for the specific form and send the result as plain text as response.

For example, if I enter `2` and `4` in the addition form and submit it, a new page should be rendered that says `6`.

To get you started, here's where the forms should post:

```
/add
/subtract
/multiply
/divide
```

Also remember that you'll need body parser.
