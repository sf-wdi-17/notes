#Authentication in Rails from scratch

##Learning Objectives
By the end of today you should be able to...

* Sign up a user
* Securely store their password
* Log in a user
* Log out a user

##Terminology

####Password Hashing & Digest
Passwords are [hashed](http://en.wikipedia.org/wiki/Cryptographic_hash_function) so that we can avoid storing plain-text passwords in our database. Digesting a password runs the password through a one-way hash. This means anyone with database access cannot produce the password from the hash. However someone with the password can produce the hash. One way! This is very similar to how [RSA](http://en.wikipedia.org/wiki/RSA_%28cryptosystem%29) encryption works, which was the world's first one-way crypto-system.

####Authorization
[Authorization](http://en.wikipedia.org/wiki/Authorization_%28computer_access_control%29) is the function of specifying access rights to resources. More formally, "to authorize" is to define an access policy.

  "Having been elected the president, Kenedy was now **authorized** to read classified documents."

####Authentication
[Authentication](http://searchsecurity.techtarget.com/definition/authentication) is the process of determining whether someone or something is, in fact, who or what it is declared to be.

  "Whenever I board a flight, the security officer checks my passport photo against my face to ensure that I am **authenticated** as the person who paid for the ticket."

####Sessions
[Sessions](http://guides.rubyonrails.org/security.html#what-are-sessions-questionmark) make HTTP stateful and help us avoid having to reauthenticate the user for every request made. Sessions are preserved on the server side. A session cookie is used to pass data back and forth between the client and server about the session. Typical data stored in the session cookie includes the session id and the user id if the user is logged in.

##Step 1 — App setup

* Start a new rails app with `rails new learn_authentication`
* Uncomment the `bcrypt-ruby` gem in your `Gemfile` and run `bundle`
* Generate a user model with three attributes (username, password_digest)
  * Note, if we don't specify a datatype it defaults to a string

```
rails g model user username password_digest
```
  
* Migrate with `rake db:migrate` (since we are using Sqlite, the db will automatically be created the first time we run a migration)
* Create a validation that ensures a username is present
* Finally create a `welcome#index` controller action that displays a welcome message (note this requires a welcome controller and associated view folder)

##Step 2 — Securley storing passwords

* Add `has_secure_password` to your user model.

```ruby
class User < ActiveRecord::Base
    # enable password encryption
    has_secure_password 
end
```

* What does `has_secure_password` do?
  * Creates virtual `password` & `password_confirmation` attributes on your model, which are not stored in the database (that would be very insecure)
  * Validates that password & password_confirmation attributes match
  * Uses bcrypt to hash the password and store it in the model's `password_digest` attribute

* Add a validation to the user model that ensures the password is between 6 and 40 characters. `validates :password, length: { within: 6..40 }`

##Step 3 — Testing your validations

* Enter the `rails console`
* Make sure the validation are working correctly and the user is not saved to the database in these three conditions when the user:
  * has no username
  * has password & password_confirmation fields that do not match.
  * has a password that is less than 6 characters
* Once you've ensured your validations are working properly, save a valid user to the database.

```
user = User.create(username: 'batman', password: 'nanana', password_confirmation: 'nanana')
```

##Step 4 — Signing up a new user: controller & routes

* Generate a users controller with the methods new & create. Run: `rails g controller users`
* Modify your routes.rb file for a restful setup. Add the following routes:
  ```
    resources :users, only: [:new, :create] 
  ```
* Run `rake routes` to ensure your new routes are properly registered.

##Step 5 — Signing up a new user: forms, login, and error msgs

* Create a `form_for` a new user that sends a `post` request to your `user#create` action.

```erb
<%= form_for @user do |f| %>

    <%= f.label :username %><br>
    <%= f.text_field :username %><br>
    
    <%= f.label :password %><br>
    <%= f.password_field :password %><br>
    
    <%= f.label :password_confirmation %><br>
    <%= f.password_field :password_confirmation %><br>
    
    <%= f.submit "Signup" %>
    
<% end %>
```

* Test that everything is working properly by throwing `byebug` into your `users#create`, posting the form, and inspecting the params
* Modify your create action so that if the user can be saved, it redirects home, otherwise it will render the :new page again. Your controller will look like:

```ruby
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
        redirect_to root_path
    else #saving the user is unsuccessful
        #populate the flash hash with the errors present in active record
        flash[:error] = @user.errors.full_messages.to_sentence 
        render :new
    end
  end

private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
```

* Display flash messages to your users by iterating through the flash hash in your view. Do this somewhere in your `users/new.html.erb`

```erb
<% flash.each do |key, value| %>
   <%= content_tag :div, value, class: "flash #{key}" %>
<% end %>
```
  
* Style the error messages in your `users.scss`

```css
.flash.error {
    color: red;
    font-weight: 900;
}
```

##Step 6 — Logging in a user

* Create an `sessions_controller.rb` with the actions `new`, `create`, and `destroy`
* Link these actions to specific routes.

```ruby
  get    'sessions/new' => 'sessions#new'
  post   'sessions'     => 'sessions#create'
  delete 'sessions'     => 'sessions#destroy'
```

* Get your `sessions#new` to display a `form_tag` allowing the user to login. Also pass in a blank user that we can use later by declaring `@user = User.new` in the controller.

```erb
<%= form_tag action: :create do %>

    <%= label_tag :username, 'Username: ' %><br>
    <%= text_field_tag :username, @user.username %><br>

    <%= label_tag :password, 'Password: ' %><br>
    <%= password_field_tag :password %><br>

    <%= submit_tag 'Login' %>
  
<% end %>
```
  
* Using the `params` object, our `sessions#create` should find the user that a new session is trying to be created for and then try to authenticate them based on the password that has provided. In case there is no match, provide the user with a flash message.

```ruby
def create
  @user = User.find_by_username(params[:username])
  
  if @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect_to root_path
  else
    flash[:error] = "Invalid username & password combination"
    render :new
  end
end
```

##Step 7 — Showing content only to an authenticated user

* It will be helpful to have a method usable across our entire application that gives us the current user, given this is something we'll want access to frequently. In your application controller, let's create a private method that does this. Make sure to share it with the rest of the application by using a helper method. Let's also add a method that checks if a user is logged in or not.

```ruby
private
  def current_user
    #if @current_user is not defined set it equal to the result using the session hash given that exists
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def user_signed_in?
    current_user.present?
  end

  helper_method :current_user, :user_signed_in?
```

`helper_method` makes given controller methods available in your views.

* In your `welcome/index.html.erb` user this new helper method to show a specific message to logged in users.

```erb
<% if user_signed_in? %>
  <h3>Congrats! You are successfully logged in <%= current_user.username %>!</h3>
<% else %>
  <%= link_to "Signup", new_user_path %>
<% end %>
```

##Step 8 — Logging out your user

* In your `sessions#destroy`, you must clear out part of your session hash, since that is what we are using to determine whether or not someone is logged in.

```ruby
def destroy
  session[:user_id] = nil
  redirect_to root_path
end
```
  
* **Challenge**: Create a link/button that toggles state between `login` and `logout` depending on if there is a `current_user`. Make sure it is present on every page.

##Tonight's Lab

* Finish the in-class exercise if you didn't get a chance
* **Add a login system to one of your existing projects manually or using [devise](https://github.com/plataformatec/devise)**

##Some Further Resources
* *NB: these may be slightly older ways of doing things*
* [User Auth Rails Cast Video](https://www.youtube.com/watch?v=23JoO_R8SMs)
* [User Authentication with Tests](http://www.emilyplatzer.io/2014/06/29/user-authentication.html)
