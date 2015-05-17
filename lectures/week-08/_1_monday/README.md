# Building a JSON API with Rails

## Objectives
Students will be able to:

- build a JSON API
- understand the benefits of having an API
- distinguish distributed from monolithic systems

## Link
What if we wanted to build something like the OMDB API?

## Educate & Engage
It turns out that building an API with Rails is astonishingly easy. All that changes, really, is the controller layer: Instead of rendering a view, you render a JSON object.

For example, in a movies app:

```ruby
class MoviesController < ApplicationController
  def index
    @movies = Movie.all

    # Only difference
    render json: @movies
  end
end
```

The only difference is that extra line at the end. It will tell rails to not render an HTML file, but instead just convert `@movies` into a JSON object and send that back to the client. That's it!

## Active Learning
Let's build a really simple OMDB clone. It will just have a few movies in the database that an API user can search through.

Here are the requirements for our app. An API user should be able to:

- Search for a movie by title at `/movies` with a `q` parameter. E.g.: `/movies?q=Jaws`
- Receive a JSON array of all movies that match the title

We will try out the API with Typhoeus in IRB.

## Reflect
Team up with your buddy and explain to each other how to build a JSON API (as stated above, it's really only a minor difference compared to a standard web app).

## Now And Then
As we will see, knowing how to build a JSON API is good for two reasons:

1. It enables you to build single page applications (SPAs). You may not want to reload the whole page whenever you submit a form, such as when you submit a comment on Facebook. It happens **asynchronously**.
2. If your app has multiple front ends, such as a website and a mobile app, you want to build a distributed system. Both the client side website as well as the mobile app should access the same back end, which can be a JSON API.

Additional features you might want to add to an API:

- Authentication through JSON web tokens (JWTs)
- Request throttle (e.g. with [Rack Attack](https://github.com/kickstarter/rack-attack))
- Ability not only to fetch, but to CRUD resources
