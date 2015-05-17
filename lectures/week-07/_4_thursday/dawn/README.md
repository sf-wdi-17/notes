# Using an API with Ruby and Rails

Objectives
Students will be able to...

1. Use Typhoeus, a ruby gem, to make HTTP requests to API's.
2. Parse the data returned by the API.
3. Use the data to create Dynamic content in a Rails app.

## Getting Started

The goal of the lab is to get comfortable with rails, api calls and json. By the end of the lab, you should have an app that uses routes, forms, and an api call that returns json.

Start a new Rails app by running the command `rails new omdb_app` and then `cd` into the app.

### Making HTTP Requests: [Typhoeus](https://github.com/typhoeus/typhoeus)

Check out the [Typhoeus](https://github.com/typhoeus/typhoeus) documentation and attempt to add Typhoeus to your rails project.

To check that you've done everything appropriately, run `rails c` and try making the function call

```bash
> Typhoeus.get("www.google.com")
```

Query parameters can be passed along like this

```bash
> response = Typhoeus.get("www.google.com", :params => {:name => "Tim" })
```

If you get any output then all is good in the world and Typhoeus is installed. To access the body of the request that we get back from Typhoeus we use the `.body` method on a request. Like this

```bash
> resp = Typhoeus.get("http://www.reddit.com/new.json")
> json_resp = JSON.parse(resp.body)
```

This gives us the body of the request.

### OMDB
The two routes, we're going to need

Number 1: http://www.omdbapi.com?s=SEARCH+TERM+PLUS+DELIMITED. This important part from the link above is the ?s=SEARCH+TERM+PLUS+DELIMITED. An example of a query we're going to make. [http://www.omdbapi.com?s=i+robot](http://www.omdbapi.com?s=i+robot).

This makes a GET request where we're searching for a particular movie title.

Number 2: http://www.omdbapi.com?i=IMDBID. This important part from the link above is the ?i=IMDBID. An example of a query we're going to make. [http://www.omdbapi.com?i=tt1083849](http://www.omdbapi.com?i=tt1083849).

This makes a GET request where we're searching for a particular movie with that IMDB ID.

**Exercise:** Use Typhoeus to make requests to each of these URLs.

Note: Be use to use `JSON.parse` on the body of the responses we get back from Typhoeus. If we forget to do this, the reponse we get back will be a string.



## Add Two Routes to our `routes.rb` file in the `config` directory. Additionally you'll need to generate a search controller and any required views. `rails g controller search`.

#### Search Route

Create a route for `/search`. This route should correspond to the `search#index` action and will allow our user to search for movies.

The `GET` route will present the user with a form - a search box.

```html
<%= form_tag("/search", method: "get") do %>
  <%= label_tag(:q, "Search for:") %>
  <%= text_field_tag(:q) %>
  <%= submit_tag("Search") %>
<% end %>
```

When the user submits a search, it'll make a request to our app's search route:
```
GET /search?q=users+search+terms
```

The app will make a request to the OMDB API with the user's search terms, and return these results to the user displaying the results.

#### Movie Info Route

Now that we've given the user a list of movies for their search, let's give them some info on the movies themselves.

When the user clicks on a movie title, we want to present a page with some details on the movie.

Create a route `/movie` and corresponding controller action and views for this information. We'll get the movie title from a query param containing the IMDB ID. For example, to get information on the movie "No Country for Old Men", you'd make a request to:

```
GET /movie?q=tt0477348
```

Our app needs to make a request to the OMDB API for the movie with this ID and present the user with an HTML page containing these results.

[Solution](https://github.com/sf-wdi-17/rails_apis_lesson)

