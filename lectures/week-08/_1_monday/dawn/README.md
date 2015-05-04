# Intro JSON API's
## A Rails Tour


### Setup

To get started building our sample application let's start from the beginning.

```
rails new intro_json -T
cd intro_json
```

## Setup Rails Models

Let's have a `user` with `articles` 

```
rails g model user email first_name last_name password_digest
```

and next we generate the associated article

```
rails g model article title content:text 
```

and we can add a migration to add the `user_id` column by running the following migration.

```
rails g migration AddUserIdToArticles user:references
```

and we can even create a comments model and practice our **Polymorphic** associations.


```
rails g model comment body:text user:references
```

and add our reference to create a polymorphic association

```
rails g migration AddCommentableToComments commentable:references
```

`db/migrate/..._add_commentable_to_comments.rb`

```
class AddCommentableToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :commentable, index: true
  end
end
```

which we need to update to add our `polymorphic: true` key


`db/migrate/..._add_commentable_to_comments.rb`

```
class AddCommentableToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :commentable, polymorphic: true, index: true
  end
end
```

the above is equivalent to writing the following


```
class AddCommentableToComments < ActiveRecord::Migration
  def change
    add_column :comments, :commentable_id, :integer
    add_index :comments, :commentable_id
    add_column :comments, :commentable_type, :string
  end
end
```


### Setting Up Model Relationships

The ERD!


![ERD](app_erd)


`user.rb`

```
class User < ActiveRecord::Base
  
  has_many :articles

  has_many :comments, as: :commentable
  
end

```


`article.rb`

```
class Article < ActiveRecord::Base

  has_many :comments, as: :commentable
  
end
```

`comment.rb`

```
class Comment < ActiveRecord::Base
  belongs_to :user

  belongs_to :commentable, polymorphic: true

  has_many :comments, as: :commentable
end


```

### Seeding Some Data


```
group :development, :test do
  gem 'ffaker'
end

```


and


```


(10).times do |n|
  user = User.new
  user.email = "#{n}#{Faker::Internet.email}"
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.save
  (10).times do |n|
    article = user.articles.new
    article.title = Faker::HipsterIpsum.words(5).join(" ")
    article.content = Faker::HipsterIpsum.paragraph
    article.save
    
    old_comment = nil
    (20).times do |n|
      params = Hash.new
      params[:body] = Faker::HipsterIpsum.paragraph
      
      if rand(3) && old_comment
        old_comment = old_comment.comments.create params
      else
        new_comment = article.comments.create params
        old_comment = new_comment
      end
      old_comment.user_id = user.id
      old_comment.save
    end
  end
end


```

### Controller Setup

We need a few controllers. Let's start with `users`.

Addd the routes for users.


```
Rails.application.routes.draw do
  resources :users
end
```


```
rails g controller users index show new edit
```

Next let's setup our controller to [`respond_to`](http://api.rubyonrails.org/classes/ActionController/MimeResponds.html) different types of requests.


`users_controller.rb`

```
  def index
    @users = User.all

    respond_to do |format|
      format.html
      format.json { render json: @users}
    end
  end
```

If we go to localhost we should be able to view all `users`

[`localhost:3000/users.json`](localhost:3000/users.json)


```
[
  {"id":1,"email":"0felicia.glover@strosin.info","first_name":"Giles","last_name":"Nikolaus","created_at":"2015-01-21T09:51:35.155Z","updated_at":"2015-01-21T09:51:35.155Z" ...},
  {"id":2,"email":"0ursula@greenholt.biz","first_name":"Lavon","last_name":"Raynor","created_at":"2015-01-21T09:52:11.101Z","updated_at":"2015-01-21T09:52:11.101Z" ...},
  ...
]
```


How was it able to do that? Let's rake routes to find out.

```
   Prefix Verb   URI Pattern               Controller#Action
    users GET    /users(.:format)          users#index
          POST   /users(.:format)          users#create
 new_user GET    /users/new(.:format)      users#new
edit_user GET    /users/:id/edit(.:format) users#edit
     user GET    /users/:id(.:format)      users#show
          PATCH  /users/:id(.:format)      users#update
          PUT    /users/:id(.:format)      users#update
          DELETE /users/:id(.:format)      users#destroy

```


See how the uri has the pattern `GET /users(.:format)`

### Question

* What does that mean?


### Answer

Regular parameters in the `uri` are denoted with the `:` syntax -- see how `/users/:id` has `:id` as a paramter. The `:format` is just another paramameter.


### Breaking It down

The statement below is just saying based on the `params[:format]` we should do different things. Note: how we didn't do anything for the `format.html` because by default rails will `render :index`.


```
    respond_to do |format|
      format.html
      format.json { render json: @users}
    end

```

### Exercise

* Repeat the above process for the `articles` controller, i.e. `localhost:3000/articles.json` should return all `articles` as `json`.

* Modify the `users#index` to try to render both a `user` and `user.articles`.

> Hint: you might want to try 

  ```
    render json: {
                user: ...,
                articles: ...,
              }
  ```

## Nested Routing/Resources

We have a very natural relationship between `users` and `articles`, and our routing should reflect that relationship.



```

Rails.application.routes.draw do

  # from exercise 1
  resources :articles

  resources :users do
    resources :articles
  end

end

```

which gives us the following routes:

```
Prefix Verb   URI Pattern                                 Controller#Action
articles GET    /articles(.:format)                         articles#index
POST   /articles(.:format)                         articles#create
new_article GET    /articles/new(.:format)                     articles#new
edit_article GET    /articles/:id/edit(.:format)                articles#edit
article GET    /articles/:id(.:format)                     articles#show
PATCH  /articles/:id(.:format)                     articles#update
PUT    /articles/:id(.:format)                     articles#update
DELETE /articles/:id(.:format)                     articles#destroy
user_articles GET    /users/:user_id/articles(.:format)          articles#index
POST   /users/:user_id/articles(.:format)          articles#create
new_user_article GET    /users/:user_id/articles/new(.:format)      articles#new
edit_user_article GET    /users/:user_id/articles/:id/edit(.:format) articles#edit
user_article GET    /users/:user_id/articles/:id(.:format)      articles#show
PATCH  /users/:user_id/articles/:id(.:format)      articles#update
PUT    /users/:user_id/articles/:id(.:format)      articles#update
DELETE /users/:user_id/articles/:id(.:format)      articles#destroy
users GET    /users(.:format)                            users#index
POST   /users(.:format)                            users#create
new_user GET    /users/new(.:format)                        users#new
edit_user GET    /users/:id/edit(.:format)                   users#edit
user GET    /users/:id(.:format)                        users#show
PATCH  /users/:id(.:format)                        users#update
PUT    /users/:id(.:format)                        users#update
DELETE /users/:id(.:format)                        users#destroy


```

in particular we see we have the following set of routes now

```

# resources :articles

articles GET    /articles(.:format)                         articles#index
POST   /articles(.:format)                         articles#create
new_article GET    /articles/new(.:format)                     articles#new
edit_article GET    /articles/:id/edit(.:format)                articles#edit
article GET    /articles/:id(.:format)                     articles#show
PATCH  /articles/:id(.:format)                     articles#update
PUT    /articles/:id(.:format)                     articles#update
DELETE /articles/:id(.:format)                     articles#destroy


# resources :users do
#  resources :articles
# end
# gives us the following

# resources :users plus resources :articles

user_articles GET    /users/:user_id/articles(.:format)          articles#index
POST   /users/:user_id/articles(.:format)          articles#create
new_user_article GET    /users/:user_id/articles/new(.:format)      articles#new
edit_user_article GET    /users/:user_id/articles/:id/edit(.:format) articles#edit
user_article GET    /users/:user_id/articles/:id(.:format)      articles#show
PATCH  /users/:user_id/articles/:id(.:format)      articles#update
PUT    /users/:user_id/articles/:id(.:format)      articles#update
DELETE /users/:user_id/articles/:id(.:format)      articles#destroy

# resources :users

users GET    /users(.:format)                            users#index
POST   /users(.:format)                            users#create
new_user GET    /users/new(.:format)                        users#new
edit_user GET    /users/:id/edit(.:format)                   users#edit
user GET    /users/:id(.:format)                        users#show
PATCH  /users/:id(.:format)                        users#update
PUT    /users/:id(.:format)                        users#update
DELETE /users/:id(.:format)                        users#destroy

```

Note how we have the following routes going by convention to the same method

```
 GET    /users/:user_id/articles(.:format)          articles#index
 GET    /articles(.:format)                         articles#index
```

But in our `ArticlesController` we only have the following:

```
class ArticlesController < ApplicationController

  def index
    @articles = Article.all

    respond_to do |format|
      format.html
      format.json { render json: @articles}
    end
  end

  ...

end
```

we need conditional logic to determine if `:user_id` is being passed in as a param.

```
class ArticlesController < ApplicationController

  def index
    if params[:user_id]
      @articles = Article.all
    else
      @user = User.find(params[:id])
      @articles = @user.articles
    end

    respond_to do |format|
      format.html
      format.json { render json: @articles}
    end

  end

  ...
  
end
```

### Excluding Certain Attributes


When we `respond_to` we should be aware of what we are sending to those using our application.


```
GET /users returns


  [
    {"id":1,"email":"0felicia.glover@strosin.info","first_name":"Giles","last_name":"Nikolaus","created_at":"2015-01-21T09:51:35.155Z","updated_at":"2015-01-21T09:51:35.155Z", password_digest: "2asdf7s8d7f6a8df7s8fdas"},
    ...
  ]

```

We should be excluding the `password_digest`.


```
    respond_to do |format|
      format.html
      format.json { render json: @users, except: [:password_digest]}
    end

```

## Resources

[except](http://www.daveperrett.com/articles/2010/10/03/excluding-fields-from-rails-json-and-xml-output/)
