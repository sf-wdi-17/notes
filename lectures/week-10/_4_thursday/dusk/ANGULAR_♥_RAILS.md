#Angular ♥ Rails
>Objective: Students will build a AngularJS front end and consume their own Rails JSON API.

##How Angular and Rails Work Together

...

##Errors are Signposts not "Mistakes"

## Challenge Make a "Twitch Blog"

> **NOTE**: We're going to use an "Outside-In" methodology. With "Error Driven Development".

The goal here is to make a very simple, public, anonymous blog in rails and angular. Here is the whole process, end to end, for building this mini project.

1. Write a User Narrative (or a few)
2. Write Step-by-step a Plan in English starting with the views
3. Make Client Routing
4. Make a View
5. Make a View-Controller
6. Make some Mock Data
6. Make a Call to your API
7. Make a Server Route and Server-Controller 
8. Make a Model & Migration

#### Step 1. Write a User Narrative

"I'm Bob Law the Blogger and I want to write a blog post that is anonymous and public to the world. I land on funkyblogpost.com and I see recent posts. I can start a new post from the home page. I submit my post and see it on top of the recent posts."

#### Step 2. Write Step-by-step a Plan in English starting with the views

#####AngularJS Client

1. Make **'/'** route and point it to the **post-index.html** template
2. Make the **post-index.html** template and put in **ng-repeat="post in posts"**
3. Attatch the **PostIndexCtrl** to that template
4. Make a **Post** service with some mock data
4. Make a **$http.get('http://localhost:3000/posts')** request for posts from your server

#####Rails Server

1. Make a RESTful route to "/posts" using **resources :posts**
2. Make a **posts_controller.rb** with a **create** method that calls **Post.all** (Make sure it returns **JSON** not html).
3. Make a **Post** model in **post.rb**
4. Run a **post migration** with the attributes **title** and **body**. 

> **QUESTION:** What errors would you expect for the code to throw at each step? 

##Starting with a Template

Developers often start with a template or in an existing code base. 

> **Question**: What should you do when you first pull down a new code base? What should you look at? What should you do?

Pull down this rails-angular seed I put together called [rangular](https://github.com/ajbraus/rangular) and change the name if you like.

```
git clone
bundle install
rake bower:install
// Make sure Postgres is running
rails s
```

#### Step 3. Make Client Routing

```JS
/*
 *  APP.JS
 */

angular.module('quora', [
        'ngRoute',
        'templates'
    ]).config(function ($routeProvider, $locationProvider) {
        $routeProvider
            .when('/', {
                templateUrl: 'question-index.html',
                controller: 'QuestionIndexCtrl'
            });
            
        $locationProvider.html5Mode({
            enabled: true,
            requireBase: false
        });
    });
```
> **Expected ERROR** - No template and no controller by those names

 
#### Step 4. Make a View

```
<!-- QUESTION-INDEX.HTML -->

<div class="row">
  <div class="col-sm-6 col-sm-offset-3">
    <div class="panel panel-default">
      <div class="panel-heading">Questions</div>
        <div class="list-group">
          <a href="/questions/{{question.id}}" class="list-group-item" ng-repeat="question in questions">
            {{question.content}}
          </a>
        </div>
    </div>
  </div>
</div>
```
> **Expected BEHAVIOR** - questions is nil, so won't display questions

#### Step 5. Make a View-Controller

```
/*
 *  QUESTIONCTRLS.JS
 */

angular.module('rangular')
    .controller('QuestionIndexCtrl', ['$scope', 'Question', function ($scope, Question) {
        $scope.questions = Question.all();
    });
```

> **Expected ERROR** - haven't made the "Question" service

```
Error: [$injector:unpr] Unknown provider: QuestionProvider <- Question <- QuestionIndexCtrl
```
#### Step 6. Make Some Mock Data

```
/*
 *  SERVICES.JS
 */

angular.module('rangular')
  .factory('Question', [function() {

    var questions = [
      { id:1, content: "What is the meaning of life?" },
      { id:2, content: "Who are we? Where did we come from? Where are we going?" },
      { id:3, content: "Where is my mind?" }
    ]

    return {
      all: function() {
        return questions
      }
    }

  }]);
```
> **Expected BEHAVIOR** - displays questions content

#### Step 7. Make a Call to your API 
```
/*
 *  QUESTIONCTRLS.JS
 */

angular.module('rangular')
    .controller('QuestionIndexCtrl', ['$scope', 'Question', function ($scope, Question) {
        // $scope.questions = Question.all();

        $scope.questions = $http.get('/questions')
          .success(function (data) {
            console.log(data);
            $scope.questions = data;
          })
          .error(function (data) {
            console.log("error: " + data);
          })
    }]);
```
> **Expected ERROR** - don't forget to inject $http!
```
ReferenceError: $http is not defined
    at new <anonymous> (http://localhost:3000/assets/controllers/questionCtrls.js?body=1:10:28)
```

Fix
```
.controller('QuestionIndexCtrl', ['$scope', '$http', 'Question', function ($scope, $http, Question) {
```
> **Expected ERROR** - api is . . . not there! 
```
GET http://localhost:3000/questions.json 500 (Internal Server Error)
Template is missing in application#index
```

#### Step 8. Make a Server Route and Server Controller 

```
# routes.rb

Rails.application.routes.draw do

  root 'application#index'

  namespace :api, defaults: {format: 'json'} do 
    resources :questions, only: [:index]
  end

  get '*path' => 'application#index'

end
```
```
# ApplicationController.rb

  protect_from_forgery with: :exception

  respond_to :json
```

```
# api/questions_controller.rb

class Api::QuestionsController < ApplicationController

  def index
    respond_with Question.all
  end

  def create
    respond_with Question.create(post_params)
  end

  def show
    respond_with Question.find(params[:id])
  end

  # def upvote
  #   question = Question.find(params[:id])
  #   question.increment!(:upvotes)

  #   respond_with question
  # end

  private
  def post_params
    params.require(:question).permit(:link, :title)
  end
end
```


> **Expected ERROR** - Model is not there!

```
uninitialized constant Api::QuestionsController::Question
```

#### Step 9. Make a Model & Migration

```
rails generate model Question content:text
rake db:migrate
```

> **Expected BEHAVIOR** - $scope.questions = [];!!! 


##### Step 10. Create a question from the rails console

```
rails c
Question.create(content:"What is the meaning of life?")
```

> **BOOYA CASHA**

## Solution
The solution is on the solution branch of [rangular](https://github.com/ajbraus/rangular).

```
git clone
bundle install
rake bower:install
// Make sure Postgres is running
rails s
```




