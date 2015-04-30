# Intro Rails
## Sessions and Users


| Objectives |
| :--- |
| Utilize the Rails `session` storage object |
| review and setup controllers for concerns related to both `login` and `sign_up` |
| Setup helper methods to use throughout the application for user managment |

### Previously Learned

* Rails routing for a single resource
* Rails form helpers and various erb tags
* Rails model generation and migrations
* Rails gemfile and bundler

## Setup


Let's start a new Rails application:

* `rails new rails_auth_app -T -d postgresql`
* `cd rails_auth_app`
* `rake db:create`
* `subl .`

## Controller Setup

We will need two controllers

* **UsersController**: to handle concerns related to users: CRUD operations, and **sign_up**.
* **SessionsController**: to handle **session** related concerns: **login** and **logout**.


Let's begin by creating these controllers and their respective views


```
rails g controller users index show new edit
```

and 

```
rails g controller sessions new
```


## Model Setup

Let's leave our controllers be for the time being and setup our models.


```
rails g model user email:string password_digest:string
```

The `email` is obviously the natural username for our user, and the `password_digest` is just a super fancy term for a hashed password.


```
rake db:migrate
```


### Reviewing Authentication

When **authenticating** a user we are verifying their credentials prove they are who they say they are. When we are **authorizing** we are saying based on a users credentials and status they can access certain things, e.g. guest user, user, and admin all might have different permissions to access resources.


To **authenticate** our users we typically ask them for a unique pass phrase we can associate to their `email`, a **password**. A *password* is a very private piece of information that must be kept secret, and so, we strategically obscure in such a way that we can only **confirm** a user is **authentic**, but not what their *password is.* Storing a *raw password* would leave us vulnerable in the event of a successful attack that gained access to our DB.

Our library of choice for *password* obfuscation is called `BCrypt`. This will be added to our gemfile for authentication setup later. In Rails, the convention is to push more logic into our models, so it shouldn't come as a surprise that authentication setup will happen in the **user model.**

Let's uncomment the `bcrypt` at the bottom of our `Gemfile`.

`Gemfile`

```
...
	# Use ActiveModel has_secure_password
	gem 'bcrypt', '~> 3.1.7'
...

```

Then run `bundle install` to finish installation of `bcrypt`.



### Playing With `BCrypt`

As soon as something is installed via bundler we can access it via our `rails console.` Let's play in console.


```
	Loading development environment (Rails 4.1.6)
 ## Let's create our first password
	2.1.0 :001 > BCrypt::Password.create("foobar")
	 => "$2a$10$6MQQCxBpfu16koDVs3zkbeSXn1z4fqKx9xLp4.UOBQBDkgFaukWM2"

 ## Let's save our password to a variable
	2.1.0 :002 > pswrd = BCrypt::Password.create("foobar")
 	=> "$2a$10$pQnf/2eORAUxpP925ZClCObaIuWdsk4b0lm2Hnt4c2e8G7qzyqcvu"
 	
 ## Let's compare our password to another
 	2.1.0 :003 > pswrd == "blah"
 	=> false
 	
 ## Let's compare our password to original
 	2.1.0 :004 > pswrd == "foobar"
 	=> true
 	
 ## Exit
 	2.1.0 :005 > exit
```


This movitates quite a bit about how we might go about setting up an **authenticate** method for a **user**.


### Creating User#authenticate


Let's try something similar in our `User` model.


`app/models/user.rb`


```
require 'bcrypt'

class User < ActiveRecord::Base
  BCrypt::Engine.cost = 12
 
 
  attr_reader :password 

  def password=(unencrypted_password)
    if unencrypted_password.nil?
      self.password_digest = nil
    else 
      @password = unencrypted_password
      self.password_digest = BCrypt::Password.create(@password)
    end
  end

end

```

Let's take a look the control flow of our intimidating `password=` method. We have on goal here which is to use the password passed into the user object to be the **hashed** password we can save in the **password_digest**. Note: we never created a field called `password` for our user to save.

```
    if unencrypted_password.nil?
      ## when nil password_digest is nil
      self.password_digest = nil
    else 
      ## when not nil update password just for temporary reference
      @password = unencrypted_password
      ## update password_digest using hashing algorithm
      self.password_digest = BCrypt::Password.create(@password)
    end
```

### Playing with Password Hashing


Let's go back to rails console

```
 Loading development environment (Rails 4.1.6)
 2.1.0 :001 > friend = User.new
  => #<User id: nil, email: nil, password_digest: nil, created_at: nil, updated_at: nil> 
 2.1.0 :002 > friend.password="foobar"
  => "foobar" 
 2.1.0 :003 > friend.password_digest
  => "$2a$12$omsQW/6I7UseqI0AeFApMOk0pd7CApXWesK5SUvgo22KMkTfBCFGy"
 ## LGTM
 2.1.0 :004 > exit
```


### Authenticating A Password

Earlier we did the following to compare passwords.


```

 ## Let's save our password to a variable
	2.1.0 :002 > pswrd = BCrypt::Password.create("foobar")
 	=> "$2a$10$pQnf/2eORAUxpP925ZClCObaIuWdsk4b0lm2Hnt4c2e8G7qzyqcvu"
 	
 ## Let's compare our password to another
 	2.1.0 :003 > pswrd == "blah"
 	=> false
 	
 ## Let's compare our password to original
 	2.1.0 :004 > pswrd == "foobar"
 	=> true

```


Let's turn this into an `authenticate` method quite naturally.


`app/models/user.rb`

```

...

  def authenticate(unencrypted_password)
    if BCrypt::Password.new(password_digest) == unencrypted_password
      self
    else
      false
    end
  end

```


You can stare at the above it until it's clear it works the way we hope it does, or we can go back to our `rails console.`



```

Loading development environment (Rails 4.1.6)
2.1.0 :001 > friend = User.new
 => #<User id: nil, email: nil, password_digest: nil, created_at: nil, updated_at: nil>
2.1.0 :002 > friend.password = "foobar"
 => "foobar" 
2.1.0 :003 > friend.authenticate "blah"
 => false 
2.1.0 :004 > friend.authenticate "foobar"
 => #<User id: nil, email: nil, password_digest: "$2a$12$T/bdM5G.O/SLdsTn6jzT0OPj0SnWpEKwbhuN9Ry9Dl2...", created_at: nil, updated_at: nil> 
```

### Our Authenticated User Model


The only thing we need to add is a `password_confirmation` field for user sign up to verify users are creating their accounts with the intended credentials. You can use a validation confirm many things like email or phone numbers.

`app/models/user.rb`

```
require 'bcrypt'

class User < ActiveRecord::Base
  BCrypt::Engine.cost = 12

  attr_reader :password
  
  validates_confirmation_of :password
  validates_presence_of :password_digest

  def authenticate(unencrypted_password)
    if BCrypt::Password.new(password_digest) == unencrypted_password
      self
    else
      false
    end
  end

  def password=(unencrypted_password)
    if unencrypted_password.nil?
      self.password_digest = nil
    else 
      @password = unencrypted_password
      self.password_digest = BCrypt::Password.create(@password)
    end
  end

end


```

Now once we `save` a user with their hashed password their is only one way to confirm them again. Let's do this manually in Rails console.

```
Loading development environment (Rails 4.1.6)
2.1.0 :001 > user = User.create({email: "a@a.com", password: "a", password_confirmation: "a"})
   (0.1ms)  BEGIN
  SQL (0.7ms)  INSERT INTO "users" ("created_at", "email", "password_digest", "updated_at") VALUES ($1, $2, $3, $4) RETURNING "id"  [["created_at", "2015-01-12 10:58:25.146276"], ["email", "a@a.com"], ["password_digest", "$2a$12$lY2Vu5y1cOPCyDsVd3nZs.tLwyYXpOvwElBqhWIgH7WBJUMrwQdgq"], ["updated_at", "2015-01-12 10:58:25.146276"]]
   (1.0ms)  COMMIT
 => #<User id: 2, email: "a@a.com", password_digest: "$2a$12$lY2Vu5y1cOPCyDsVd3nZs.tLwyYXpOvwElBqhWIgH7W...", created_at: "2015-01-12 10:58:25", updated_at: "2015-01-12 10:58:25"> 

 ### Let's look up the user we just created by their email.
 2.1.0 :003 > friend = User.find_by({email: "a@a.com"})
 
  User Load (1.2ms)  SELECT  "users".* FROM "users"  WHERE "users"."email" = 'a@a.com' LIMIT 1
 => #<User id: 2, email: "a@a.com", password_digest: "$2a$12$lY2Vu5y1cOPCyDsVd3nZs.tLwyYXpOvwElBqhWIgH7W...", created_at: "2015-01-12 10:58:25", updated_at: "2015-01-12 10:58:25">
 
 ### Let's autheticate their password
 2.1.0 :004 > friend.authenticate("a")
 => #<User id: 2, email: "a@a.com", password_digest: "$2a$12$lY2Vu5y1cOPCyDsVd3nZs.tLwyYXpOvwElBqhWIgH7W...", created_at: "2015-01-12 10:58:25", updated_at: "2015-01-12 10:58:25">
 
 2.1.0 :005 > friend.authenticate("b")
 => false
 
```


Hence we now have the motivation for our lovely `confirm` method, which will take care of doing the above steps for us.



`app/models/user.rb`

```
require 'bcrypt'

class User < ActiveRecord::Base
  BCrypt::Engine.cost = 12

  attr_reader :password
  validates_confirmation_of :password
  validates_presence_of :password_digest

  def authenticate(unencrypted_password)
    if BCrypt::Password.new(password_digest) == unencrypted_password
      self
    else
      false
    end
  end

  def password=(unencrypted_password)
    if unencrypted_password.nil?
      self.password_digest = nil
    else 
      @password = unencrypted_password
      self.password_digest = BCrypt::Password.create(@password)
    end
  end

  def self.confirm(email_param, password_param)
    user = User.find_by({email: email_param})
    user.authenticate(password_param)
  end


end

```


## Controller and Route Setup For Auth



### On Route

Let's erase everything in our `config/routes.rb` file.


```
Rails.application.routes.draw do
  get "/login", to: "sessions#new"

  post "/sessions", to: "sessions#create"

  get "/sign_up", to: "users#new", as: "sign_up"

  resources :users

end


```


The above is the equivalent of writing the following:

```
Rails.application.routes.draw do
  get "/login", to: "sessions#new"

  post "/sessions", to: "sessions#create"

  get "/sign_up", to: "users#new", as: "sign_up"
  
  ## or write the following

  get "/users", to: "users#index", as: "users"

  get "/users/new", to: "users#new", as: "new_user"

  get "/users/:id", to: "users#show", as: "user"

  get "/users/:id/edit", to: "users#edit", as: "edit_user"

  post "/users", to: "users#create"

  patch "/users/:id", to: "users#update"

  delete "/users/:id", to: "users#destroy"
end


```

You can choose your own style here, but I won't write the routes out anymore, and you'll be expected to know what is meant by `resources`.


### A Simple Sign Up


Let's write your `UsersController` in order to work toward functional sign up page, because the `UsersController` should handle the creation of any `user`.


```
class UsersController < ApplicationController
  

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    redirect_to user_path(@user.id)
  end

  def show
  end


  private

    def user_params
      	params.require(:user).permit(:email, :password, :password_confirmation)
    end


end


```


A `/sign_up` view would like a typical `form_for` for a user.



`app/views/users/new.html.erb`


```

	  <h1>Users#new</h1>
	  <p>Find me in app/views/users/new.html.erb</p>
	
	  <%= form_for @user do |f| %>
		  <div>
		  <%= f.text_field :email %>
		  </div>
		  <div>
		    <%= f.text_field :password %>
		  </div>
		  <div>
		    <%= f.text_field :password_confirmation %>
		  </div>
		  <div>
		    <%= f.submit %>
		  </div>
	  <% end %>

```


### A Simple Login

Since creating a session is essentially what we mean when want to login, and logging out is destroying a session. We have a single controller dedicated to session managment, `SessionsController`.



`app/controllers/sessions_controller.rb`



```
class SessionsController < ApplicationController
  def new
  end

  def create
    user_params = params.require(:user)
    user = User.confirm(user_params[:email], user_params[:password])
    if user
      redirect_to user_path(user.id)
    else
      redirect_to "/login"
    end
  end
end

```

Note here how our create is just using our `User.confirm` method we created earlier to authenticate login attempts. If the method fails to confirm it will return `false` and it will re-attempt login. Otherwise, it will return a `valid` user, and we will `redirect_to` the `user_path`.

 **Note: at this point we've just used what we've created in the model, and we have not actually logged in a user.** We've only authenticated them.
 
 
## Session Creation


 
 In order to actually login a user we need to store some relevant information in a session cookie. We can do this by interacting with the Rails `session` object, which functions much like a hash.
 
 

`app/controllers/sessions_controller.rb`


```
class SessionsController < ApplicationController

  def create
    user_params = params.require(:user)
    user = User.confirm(user_params[:email], user_params[:password])
    if user
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      redirect_to "/login"
    end
  end
end

 ```
 
 
 In the above schemee when after we authenticate someone we  set `session[:user_id] = user.id`. This allows the `user.id` to be stored in a cookie for lookup later. Of course, then we have to go find they the user in our DB everytime using the `user_id` in the session. With all of this in mind we separate out a lot of the logic related to `sessions` into a list of very helpful methods in `SessionsHelper`.
 
 
 `app/helpers/sessions_helper.rb`
 
 
 ```
 
module SessionsHelper

  def login(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def logout
    @current_user = session[:user_id] = nil
  end
  
  
  def logged_in?
    if current_user == nil
      redirect_to "/login"
    end
  end
  
  def current_user
    @current_user = @current_user || User.find_by(id: session[:user_id])
  end
end

 ```
 
 
 
 
 Let's take a look at the `login` method.
 
 
 
 ```
 
  # takes in a user object
  def login(user)
  	# stores their id in the session
    session[:user_id] = user.id
    # stores the user in an instance variable
    @current_user = user
  end
 ```
 
 
 
 
 Let's take a look at the `logout` method.
 
 
 ```
 
  def logout
  	# set @current_user and session to nil
  	# 	this effectively forgets the user
    @current_user = session[:user_id] = nil
  end
  
 
 
 ```
 
 Let's take a look at the `logged_in?` method, which will redirect to `login` if `current_user` returns `nil`. This will be used as a before action on routes that require login before accessing.
 
 
 ```
   def logged_in?
    if current_user == nil
      redirect_to "/login"
    end
  end
 
 ```
 
 
 Let's take a look at the `current_user` method.
 
 
 ```
  def current_user
  	# finds a logged in user using the session[:user_id]
    @current_user = @current_user || User.find_by(id: session[:user_id])
  end
 ```
 
 
### Using SessionsHelper

The `SessionsHelper` module is a list of methods that can be included into any part of application using the `include` keyword. This is kind of like inheritance, and is rightly called composition, because we are just adding functionality.


We will want these methods throughout our entire program and not just in the `SessionsController`. Luckily, we can easily do this using `inheritance`, by just including `SessionsHelper` in the `ApplicationController`.


`app/controllers/application_controller.rb`


```

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper
end

```


Let's refactor our `SessionsController` to use our new methods.


```
class SessionsController < ApplicationController
  def new
  end

  def create
    user_params = params.require(:user)
    user = User.confirm(user_params[:email], user_params[:password])
    if user
      # use our handy login method
      login(user)
      redirect_to user_path(user.id)
    else
      redirect_to "/login"
    end

  end
end


```


Let's refactor our `users#show` to require `logged_in?` using a `before_action`.


`app/controllers/users_controller.rb`

```
class UsersController < ApplicationController
  before_action :logged_in?, only: [:show]
  
  ...
end

```

Then let's create our `show.html.erb` using our `current_user` helper.

`app/views/users/show.html.erb`


```

Welcome, <%= current_user.email %>!.


```

If you fire up `rails server` and you go to `localhost:3000/users/1` then you should now be redirected.


## Adding Flash Errors

If someone fails to login we want to notify them, because the situation is much different than if they tried to go to `localhost:3000/users/1` and weren't logged in. The flash storage is a type of session storage that is stored between requests and then cleared each time.



```
class SessionsController < ApplicationController
  def new
  end

  def create
    user_params = params.require(:user)
    user = User.confirm(user_params[:email], user_params[:password])
    if user
      # use our handy login method
      login(user)
      redirect_to user_path(user.id)
    else
       # Flash an error message
      flash[:error] = "Failed To Authenticate. Please try again."
      redirect_to "/login"
    end

  end
end
```


We can then render these errors in our `sessions/new.html.erb`.


```
<%= form_for :user, url: "/sessions", method: "post" do |f| %>
    <% flash.each do |name, msg| %>
      <%= content_tag :div, msg, class: name %>
    <% end %>
  <div>
    <%= f.text_field :email %>
  </div>
  <div>
    <%= f.text_field :password %>
  </div>
  <div>
    <%= f.submit %>
  </div>
<% end %>

```

#### Exercises:

* Add flash errors to sign up.
* Login a user after successful sign up.


## Refactoring To Use Rails Magic

The last time we saw our `user` model it looked like the following:


`app/models/user.rb`

```
require 'bcrypt'

class User < ActiveRecord::Base
  BCrypt::Engine.cost = 12

  attr_reader :password
  validates_confirmation_of :password
  validates_presence_of :password_digest

  def authenticate(unencrypted_password)
    if BCrypt::Password.new(password_digest) == unencrypted_password
      self
    else
      false
    end
  end

  def password=(unencrypted_password)
    if unencrypted_password.nil?
      self.password_digest = nil
    else 
      @password = unencrypted_password
      self.password_digest = BCrypt::Password.create(@password)
    end
  end

  def self.confirm(email_param, password_param)
    user = User.find_by({email: email_param})
    if user
    	user.authenticate(password_param)
    end
  end


end

```

Fortunately, this authentication scheme is so common in Rails they actually implemented a method that will do this for you, but be warned people will expect you to know what it does if you use it.




`app/models/user.rb`

```
class User < ActiveRecord::Base
  has_secure_password
  
  def self.confirm(email_param, password_param)
    user = User.find_by({email: email_param})
    user.authenticate(password_param)
  end

end

```







