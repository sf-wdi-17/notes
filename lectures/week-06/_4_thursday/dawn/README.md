## Intro to Rails

###Learning Objectives
By the end of this lecture you should be able to...

- Distinguish between Express, Sinatra and Rails
- Articulate the Rails philosophy
- Describe MVC
- Start a new app
- Navigate Rails directory structure
- Link routes, controllers and views

##Philosophy

Rails values...

* DRYness
* Separation of Concerns & Modularity
* Abstraction & encapsulation
* Convention over configuration

### Separation of Concerns

In writing a large application it is important to establish something known as **Separation of Concerns**, *writing modular code that focuses on one aspect within the application.* The benefit of this is similar to idea of **compartmentalization** with respect to a production line, which allows for *more rapid development* by being able to **divide and conquer** the construction of a product. Compartments can focus on one task and optimize functional concerns far outside the scope of other compartments, but still work together to achieve the same product.  Ultimately it reduces the headache of debugging and controlling a large application that can ultimately grow to a level of complexity that no one person could ever fully comprehend (nor want or need to). 

### Organizational Principles

In order to manage the development of emerging aspects within a project it is important to construct a guideline that will shape how things are separated, a **design pattern**, which everyone can use to maintain **consistent** organization of different aspects. This is a *conventional* choice that helps to understandably scale a project. Part of the role of a developer is to become familiar with using design patterns, but this takes time (and trust), as different patterns emphasize an array of qualities: scalability, modularity, security, performance, et cetera.

##MVC

Rails uses an __MVC__ architecture

<b>M</b>odel - The model refers to the data objects that we use. It's the object oriented approach to design. The data in our database will be the most common type of object that we'll put there.

<b>V</b>iew - The view is the Presentation layer. It's what the user sees and interacts with, essentially the web pages. The HTML, the CSS and the JavaScript. The controller processes and responds to user events, such as clicking on links and submitting forms. 

<b>C</b>ontroller - The controller will make decisions based on the request and then control what happens in response. It controls the interaction with our models and with our views. 

![MVC Diagram](http://elibildner.files.wordpress.com/2012/06/screen-shot-2012-06-05-at-2-12-18-am.png)

##Railstaurant Metaphore
The **client** is a customer eating in the restaurant, the **server** is the waiter, the **router** is waiter who hands off orders, the **controller** is the kitchen, the **database** is the giant walk-in refrigerator with ingredients, the **model** is the person fetching ingredients from the refrigerator, the **view** is the chef who makes the meal look pretty and relays it back to the customer.

##Setup

### How to create a rails project

``` rails new NAME_OF_APP```

But then it says, bundle install at the end, so, it's created all the files, and now it's telling bundler to install all of the gems that might be missing. 

### Bundler

Bundler is a separate gem from Rails, and can be used outside of
Rails, but Rails is going to depend on it to manage the RubyGems that
our application needs. The first thing that you need to know is that
there are two files that matter to bundler - Gemfile and Gemfile.lock.
Look at Gemfile. This contains configuration information about what
gems we want to load. And, specifically, what version of gems as well.
This might look similar to the package.json file from our Node/Express
days.

Bundler is going to sort all of those out for us, and it's going to
create a tree of gems that it ought to load with all the dependencies
that ought to be loaded with it. And, after it creates that list, or
manifest file, it's going to store it in Gemfile.lock. We can take a
look at that file as well. You'll see, it looks very similar in
content, but the format is very different.

You never want to edit Gemfile.lock yourself. That's Bundler's file to
put its results in. Gemfile is the one that you'll edit. Now, how do
you tell Bundler to take your Gemfile and turn it into Gemfile.lock?
Well, with one simple command: `bundle install`. You'll remember that
when we created our rails application at the end of the process, it
ran Bundle Install for us.


bundle exec - run this before rake db:migrate if you're having issues

### Start a server

`rails server`

or the equivalent but shorter:

`rails s`

This will start a server on localhost:3000

## Experiment

- create a new rails app: `rails new NAME_OF_APP`
- run `rails server` and see what happens
- open localhost:3000 in your favorite browser

##Gems
Gems are like NPMs. You have to put any gem you want to use in your Gemfile. You have to run bundle anytime you change your Gemfile. Your rails server needs to be restarted after any changes to your Gemfile.

## Create a controller and view

- `rails generate controller demo index`
- add "Hello, World!" in the erb page

- now how do we get to this page? What do we need? A route!
- go to routes.rb see that we have a /demo/index
- start the server and go to demo/index to see hello world!

## Rails File Structure

![Rails File Structure](http://i.imgur.com/whOL4DQ.png)

- most important directory - APP
	- models, views, controllers are all in here
	- helpers is where you put helper code for views
	- mailers - for sending emails
	- assets -> where we put static files
- bin 
	- bundle, rails, rake our binary files
- config
	- set config files for routes, db and environments
- db
	- store code related to db - Migrations go here!
- gemfile/gemfile lock
- lib 
- log
- public - simple html files here (anything here will be visible to the public)
- test for testing
- tmp - temp files for rails to store stuff
- vendor - much less used because of gems

## Routing

- in routes.rb we include our routing (very similar to app.js in express)

- simple route or match route
	- get "demo/index"
	- the same as match "demo/index", 
		- :to => "demo#index",
		- :via => :get

- root route

root :to => 'demo#index'
or 
root "demo#index"

- remember, routes in Rails are like express in that they start from the top and go to bottom

## Rendering templates

- in controller add 

```
def hello
  # will automatically look for a view in app/views/demo/hello.html.erb and render it
end
```
Always check out the terminal for request/response!

## Template file names

name.html.erb

- Template name: name
- Process with: ERB, looks just like EJS
- Output format: HTML

## Instance varialbes for data into our views

- inside a controller action include
- `@` infront of a Ruby variable makes it an instance variable
 
	```
	@taco = "Hello instance taco!"
	@array = [1,2,3]
	```
- instance variables from controller are available in the view the controller action renders
