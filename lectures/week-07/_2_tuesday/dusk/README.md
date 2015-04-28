# Authorization in Rails
Lecture on how to add authorization to a Rails app.

# Objective
Students will be able to...

- use the gem Pundit to add authorization to an existing Rails app
- peruse the gem's documentation to implement it with a partner
- authorize certain user actions

# Link
We have tried implementing our own custom authorization logic in Node projects. This becomes messy quickly. In Rails, we want to use a gem called [Pundit](https://github.com/elabs/pundit) instead.

# Active Learning
Pair up in groups of two. One of you will be the navigator, the other one the driver, meaning only one of you actually codes.

Do the following:

- Clone [this app](https://github.com/sf-wdi-17/cookbook_authorization) and cd into it
- Bundle the gems, load the schema and start the server
- Check out the app. It comes with devise authentication and recipe crudding. You need to be logged in to crud recipes
- Read the [pundit documentation](https://github.com/elabs/pundit) (or at least the parts that are needed to do the following)
- Make it so that only the creator of a recipe can read, edit, update, and delete it (in the controller)
- Make it so that edit and delete links don't show on the views if the user cannot edit or delete the specific recipe
- If you're lost, consult the repo's [solution branch](https://github.com/sf-wdi-17/cookbook_authorization/tree/solution) or have a look at the [solution's diff](https://github.com/sf-wdi-17/cookbook_authorization/commit/a90593b6f47792e739a72119dae6d28df44784a8)

# Reflect
Have the driver reiterate the steps needed to install Pundit. Ask each other questions if anything is unclear. Challenge each other and test each other's knowledge!

We will also go over it together and implement it jointly.

# Now and Then
Pundit is a great tool you will likely use in your career as web developer. A good but outdated alternative you are likely to come across in existing projects is [CanCan](https://github.com/ryanb/cancan); or, a later, more maintained version of it, [CanCanCan](https://github.com/CanCanCommunity/cancancan).

