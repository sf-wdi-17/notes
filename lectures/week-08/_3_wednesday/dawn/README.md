#Rspec in Rails



### Part I: Setup

| Objectives |
| :---- |
| install rspec in rails app |
| create unit tests for our model validations |
| create controller specs to test blog routes |



### Terms

* `System Under Test`: some application component being tested or "what's being tested."
* `Dependent-On Component`: some application component connected to the **SUT**, but not really the subject of the test.
* [`Four Phase Test`](http://robots.thoughtbot.com/four-phase-test): is a methodology of setting up tests that breaks down a test into four phases: `setup`, `exercise`, `verify`, and `teardown`.





### `Rspec - Rails` Installation
_____________________________


### Clone this application

(It's always best to refer to offical documentation, see Resource#1,
in case these instructions go out of date eventually.)

**Step 1:**  

Add rspec rails to your Gemfile in the development, test group and bundle install  

*Gemfile*

        group :development, :test do
          gem 'rspec-rails', '~> 3.0.0'
        end

*Terminal*  
`bundle install`  

**Step 2:**  

Create spec directory, and necessary configurations  

*Terminal*  
`rails generate rspec:install`  

and go to the `.rspec` file and remove the line that says

```
--warnings
```

This adds `spec/spec_helper.rb` and `.rspec` files that are used for configuration. See those files for more information.  

**Step 3:**  

Create a spec file for our model.  
This is only necessary if you had a model created before you installed rspec.  

*Terminal*  
`rails generate rspec:model article`  

**Step 4:**  

Run your rspec tests (they should all pass as you don't have any)  

*Terminal*  
`rspec` or `bundle exec rspec`

To run specific specs

```
	# Run only model specs
	rspec spec/models
	
	# Run only specs for ArticlesController
	rspec spec/controllers/articles_controller_spec.rb
```



## Rspec Rails Part II

| Objectives |
| :---- |
| Identify the **RSpsec** directory structure and the purpose of each folder |
| Identify the purpose and give examples of **Controller Specs** and related structures **stubs** |
| Employ **stubs** to solve common testing problems |

## RSpec Directory 

Typical Spec Folders 

* Model 
* Controller


### Model Specs

The point of a model spec is to test data validations and expected model behaviors.


### Setup FFaker

It would be better if your Factories didn't always create the same kind of objects and had more interesting our more *realistic* test data.

Thus we use a gem called **FFaker** to give us better test data.


### Setup Gemfile

```
  group :development, :test do
	...
    gem 'ffaker'
  end
```


## Controller Specs

In a controller we might have not yet implemented the model details we would expect to be testing our application, but we still need to write valid tests that describe the behavior of our controller. The helps others focus on reading our specs to work toward implementing the controller.


### Stub

A stub is a method on an object that we wish to have some control over for testing purposes and whose true functionality is of little value to the test being written.


### Stubbing In Our Rails Application 

The most common thing to go stubbing is the `current_user`, which is something we will not care to test directly. Nevertheless you will still test the `current_user` method in a helper test for example.
require 'rails_helper'


```
require 'rails_helper'

RSpec.describe ArticlesController, :type => :controller do
  before do
    user_params = Hash.new
    user_params[:email] = Faker::Internet.email
    user_params[:email_confirmation] = user_params[:email]
    user_params[:password]  = "blah"
    user_params[:password_confirmation] = user_params[:password]
    @current_user = User.create(user_params)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@current_user)
  end

  describe "Get #index" do
    it "should render the :index view" do 
      get :index
      expect(response).to render_template(:index)
    end

    it "should assign @articles" do
     all_articles = Article.all
     get :index
     expect(assigns(:articles)).to eq(all_articles)
    end
  end
  
  describe "Get #new" do
    it "should assign @article" do
      get :new
      expect(assigns(:article)).to be_instance_of(Article)
    end

    it "should render the :new view" do
      get :new
      expect(response).to render_template(:new)
    end 
  end
  
  describe "Post #create" do
    it "should redirect_to 'article_path' after successful create" do
      post :create, article: {title: "blah", content: "blah"}
      expect(response.status).to be(302)
      expect(response.location).to match(/\/articles\/\d+/)
    end

    it "should add article to current_user" do
      count = @current_user.articles.all.count
      post :create, article: {title: "blah", content: "blah"}
      expect(@current_user.articles.count).to be > count
    end

    it "should redirect when create fails" do
      # a stub on the create method
      allow(@current_user.articles).to receive(:create).and_return(false)
      post :create, article: { title: "blah", content: "blah"}
      expect(response).to redirect_to(new_article_path)
    end
  end
end
```







### Stub Resources

- **Rspec Stubs:** https://www.relishapp.com/rspec/rspec-mocks/v/2-3/docs/method-stubs  

- **Rspec Stubs Examples:** http://old.rspec.info/documentation/mocks/stubs.html  

### Resources
______________

1. **Rspec-Rails Documentation** https://github.com/rspec/rspec-rails  
2. **Model Specs** https://www.relishapp.com/rspec/rspec-rails/docs/model-specs  
3. **Request Specs** https://www.relishapp.com/rspec/rspec-rails/docs/request-specs/request-spec  
4. **Matchers**  https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
5. **Matchers** https://www.relishapp.com/rspec/rspec-expectations/v/3-1/docs/built-in-matchers
5. **Model Specs Example** https://github.com/wdi-sf-july/validation_tests
6. **Controller Specs** https://www.relishapp.com/rspec/rspec-rails/docs/controller-specs


