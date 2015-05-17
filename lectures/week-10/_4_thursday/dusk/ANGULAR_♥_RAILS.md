https://thinkster.io/angular-rails/
#Angular ♥ Rails
>Objective: Students will understand and know how to start a project with a Rails server and AngularJS client.

Let's get right into it

```
rails new railsy-angular --skip-javascript -T
```
Rails ships with the gem Turbolinks which conflicts with AngularJS, and with jQuery which AngularJS largely replaces. The ```--skip-javascript``` will make a project without them. Rails also ships with unit test which we won't need so we remove it with ```-T```

Otherwise we'd have to:

**Remove turbolinks**

```
Gemfile

gem 'turbolinks'
```
```
application.js

//= require turbolinks

```

