# Nested Resources

## Learning Objectives
- Understand how routes work
- Recall how `resources` work in Rails
- Understand nested routes/resources

## Let's get setup

We're going to discuss routes, resources, and nested resources in the
context of an authors and books app. `Books` will belong to `AUthors`, in other words, a `Book` will be a `nested resource` of an `Author`.

But to get started talking about nested resources, we'll first need a Rails application that:

  1. Has an `Author` model, along with matching
    + Routes (the 7 usual suspects)
    + Controller
    + Views
  2. A user should be able to:
    + Get all authors
    + Add a new author
    + Edit an author
    + Delete an author

So let's take **20 minutes now** to build the skeleton of this application. Please help each other to get setup. We'll discuss any pain points afterwards.

## Routes

### Review: what do we know about routes? ###

What would the following accomplish, if it was located in `routes.rb`?

    get '/authors/:id', to: 'authors#show'

- `get` is the HTTP verb to be matched
- `'/authors/:id` is the URL to be matched.
- `to: 'authors'` refers to the authors_controller.rb
- `#show` refers to the show method within authors_controller.rb

In other words, if a request comes in to the server matching the
'/authors/:id' URL, then we call the `show` method (a.k.a., action)
inside of `authors_controller.rb`.

### So now: What do we know about resources? ###

Q: What does this do if it's located in `routes.rb`?

    resources :authors

What's a good way to check? Hint: `rake routes`.

A: It generates all the URLs for a given resource (i.e., Author).

    $ rake routes
          Prefix Verb   URI Pattern            Controller#Action
         authors GET    /authors               authors#index
                 POST   /authors               authors#create
      new_author GET    /authors/new           authors#new
     edit_author GET    /authors/:id/edit      authors#edit
          author GET    /authors/:id           authors#show
                 PATCH  /authors/:id           authors#update
                 PUT    /authors/:id           authors#update
                 DELETE /authors/:id           authors#destroy

Hopefully, everyone managed to complete the setup of the Author resource. Try running `rake routes` to confirm this for yourself.

### Nested resources

Ok, we've seen resources.  What's all this nonsense about _nested_
resources? Well, sometimes you'll have resources that "belong to"
other resources.  We've already seen how to establish such a
relationship in the model layer, but we can also represent
this relationship in our routes.  In our example, we're going to have a
resource called Book that belongs to another resource, called Author.

#### Implementing Nested Resources Together ####

In `routes.rb`, replace `resources :authors` with the following:

    resources :authors do
        resources :books
    end

Running `rake routes` will show that this generates the following
URLs:

```console
$ rake routes
```

| Prefix           | Verb   | URI Pattern                        | Controller#Action |  
| -----:           | :----- | :---                               | :-----------      |  
| author_books     | GET    | /authors/:author_id/books          | books#index       |  
|                  | POST   | /authors/:author_id/books          | books#create      |  
| new_author_book  | GET    | /authors/:author_id/books/new      | books#new         |  
| edit_author_book | GET    | /authors/:author_id/books/:id/edit | books#edit        |  
| author_book      | GET    | /authors/:author_id/books/:id      | books#show        |  
|                  | PATCH  | /authors/:author_id/books/:id      | books#update      |  
|                  | PUT    | /authors/:author_id/books/:id      | books#update      |  
|                  | DELETE | /authors/:author_id/books/:id      | books#destroy     |  
| authors          | GET    | /authors                           | authors#index     |  
|                  | POST   | /authors                           | authors#create    |  
| new_author       | GET    | /authors/new                       | authors#new       |  
| edit_author      | GET    | /authors/:id/edit                  | authors#edit      |  
| author           | GET    | /authors/:id                       | authors#show      |  
|                  | PATCH  | /authors/:id                       | authors#update    |  
|                  | PUT    | /authors/:id                       | authors#update    |  
|                  | DELETE | /authors/:id                       | authors#destroy   |  


- '/authors' will list all the authors.
- '/authors/17' will show info about that author.
- '/authors/17/books' will show all that author's books.
- '/authors/17/books/5' will show info about that author's 5th book.

## Controller#Action

In `authors_controller.rb`, the `#show` method (a.k.a., action) can
get access to the requested authorId through the `params` hash.

    def show
        authorId = params[:id]
    end

In `books_controller.rb`, the `#show` method (a.k.a., action) needs to
get both the authorId AND the bookId in order to retrieve the specific
book.

    def show
        authorId = params[:author_id]
        bookId = params[:id]
    end

You can look at the generated routes to tell what the parameters will
be named.

    Prefix        Verb   URI Pattern                      Controller#Action
    author_book   GET    /authors/:author_id/books/:id    books#show

#### Exercise ####

Create `books_controller.rb` by running the following in the terminal:

    rails generate controller books

Now let's all spend 20 minutes Implementing the standard CRUD operations on books. Try to get as far as you can, and then we'll come back and discuss.

Hint: Think about the fact that `books` now belong to `authors` which means we can't ever access a book `:id` in the URL unless we also have an `:author_id` in the URL.

If you're a bit stuck, feel free to look at the [completed version I created](prepped/authors_books_app/README.md)

## What You'll Need to Know About ERB

Let's talk some more about this syntax and why it's helpful.

```rhtml
    <%= form_for @author %>
    <% end %>

    <%= form_for [@author, @book] %>
    <% end %>

    <%= link_to "Show an author", @author %>

    <%= link_to "Edit an author", edit_author_path(@author) %>

    <%= button_to "Delete Author", @author, :method => :delete %>

    <%= button_to "Delete Author's Book", [@author, book], :method => :delete %>
```

## Prefix

* Q: What's the first column output from `rake routes`?
* A: Prefix

- Q: When I do a `redirect_to <blank>_path`, what can fill in the blank?
- A: Prefix

- Q: When I do a `form_for <blank>_path(model)`, what can fill in the
blank?
- A: Prefix

## Bonus: Can we handle multiple models in one form?

Let's suppose that we want to create an Author and a Book at the same
time.  We can accomplish this using **Active Record Nested
Attributes**  Nested attributes allow you to save attributes on
associated records through the parent.

Read more about Nested Attributes on
[Rails Docs](http://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html).


## Resources
- [Rails Routing](http://guides.rubyonrails.org/routing.html)
