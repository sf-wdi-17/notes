#Angular Services


> **Objective**: to be able to write AngularJS services to mock data,  dry up code, and connect to external or internal APIs.

## What is an AngularJS Service?

#### Separation of Concerns & Segregation of Duties

Angular is really good at helping you safely and rationally **separate concerns** and **segregate duties**. In addition to **Controllers** and **Templates** (as we saw in Rails and Express) AngularJS has **Directives** for complex manipulation of the DOM, **Filters** for manipulating sets of data, and **Services** for getting, storing, and syncronizing data across controllers and views.

#### Syncronizing Data Across Controllers

Controllers in Angular (and other apps!) are for single use only and they don't communicate with each other. E.g. when you change routes you will lose the data you've loaded up into your present controller, or if you have two controllers running to mananage two suptemplates, they don't be able to share data. Unless. . . you use a service to get, store, and sycronize data!

> **Services** are for getting, storing, and syncronizing data across your apps controllers and views.

Services can be used to. . .

*  Interact with an external APIs
*  Share objects/data across views and controllers
*  Interact with a device API (localstorage, push notifications, etc)
*  Abstract repeated methods (to dry up code)

There are native Angular services, angular-plugin services, and your own custom services.

#####Some Native Angular Services
* $http - for ajax calls
* $timeout - for setting timeouts
* $location - for manipulating urls and paths
* $window - for accessing attributes of the browser window

#####Some Common Angular Plugin Services
* $resource (ngResource)
* $state (ui-router)
* $filter

#####Examples of Custom Services
* Post (to interact with your API '/posts/:id' url)
* AuthService (to abstract some repeated methods concering authentication)
* MapService (manage methods related to geolocation objects)
* ...

## Challenge 1: Setup Mock API Data Service - 30 min

1. Setup a basic angular app (index.html and app.js).
2. Implement a service (code below) to inject some mock movie test data into a view.
3. Use ng-repeat to display a list or table of movies in a view
4. If you get done, brainstorm a list of what else could you do.

```JS
/*
 * SERVICES.JS
 */
 
angular.module('myApp', [])

.factory('Movie', function() {

  // Some fake testing data
  var movies = [{
    id: 0,
    title: 'Pirates of the Carribean',
    poster_url: 'http://images.vcpost.com/data/images/full/48799/pirates-of-the-carribean-dead-men-tell-no-tales.jpg'
  }, {
    id: 1,
    title: 'Pirates of the Carribean',
    poster_url: 'http://images.vcpost.com/data/images/full/48799/pirates-of-the-carribean-dead-men-tell-no-tales.jpg'
  },{
    id: 2,
    title: 'Pirates of the Carribean',
    poster_url: 'http://images.vcpost.com/data/images/full/48799/pirates-of-the-carribean-dead-men-tell-no-tales.jpg'
  }, {
    id: 3,
    title: 'Pirates of the Carribean',
    poster_url: 'http://images.vcpost.com/data/images/full/48799/pirates-of-the-carribean-dead-men-tell-no-tales.jpg'
  }, {
    id: 4,
    title: 'Pirates of the Carribean',
    poster_url: 'http://images.vcpost.com/data/images/full/48799/pirates-of-the-carribean-dead-men-tell-no-tales.jpg'
  }];

  return {
    all: function() {
      return movies;
    },
    remove: function(chat) {
      movies.splice(movies.indexOf(movie), 1);
    },
    get: function(movieId) {
      for (var i = 0; i < movies.length; i++) {
        if (movies[i].id === parseInt(movieId)) {
          return movies[i];
        }
      }
      return null;
    }
  };
});

```

## Challenge 2: Make an $http to call an API

Take the following controller code and abstract it into a Movie service method called ```search()```. Can you see the OMDBapi data in your view? Can you extend the Movie service to take arguments and respond with the OMDBapi specifically? Can you display an error message if it fails with alert()? Can you do the same with ng-show?

```html
<form ng-submit="searchMovies">
  <input ng-model='search'>
  <button type="submit">
</form>
```

```JS
/*
 *  MOVIECtrl.js
 */

...

$scope.searchMovies = $http.get('http://www.omdbapi.com/?s=' + $scope.search)
  .success(function(data) {
    console.log(data);
    // $scope.movies = data.Search
  }).failure(function(data) {
    $scope.movies = [];
  })

...

```

## Other Ways to Use Services

#### Using Services to Dry Up Code

You can also abstract random methods and objects into your services to dry up your code. 

```JS
.factory('AuthService', function ($rootScope, User) {
    return {
      checkLogin: function() {
        // Check if logged in and fire events
        if(this.isLoggedIn()) {
          $rootScope.$broadcast('app.loggedIn'); 
        } else {
          $rootScope.$broadcast('app.loggedOut'); 
        }
      },
      isLoggedIn: function() {
        // Check auth token here from localStorage
        if (localStorage.getItem("auth_token") === null || localStorage.getItem("auth_token") === "undefined") {
          return false
        } else {
          return true
        };
      },
      logout: function(email, pass) {
       // Same thing, log out user
       $rootScope.$broadcast('app.loggedOut');
      }
    }
  })
```

#### How to Consume Your Own RESTful API: $resource (ngResource)

Most APIs and all that you build should be RESTful and respond to the basic

| URL           | HTTP     | CONTROLLER        |
| ------------- |:--------:| -----------------:|
| /articles     | GET      | articles#index    |
| /articles     | POST     | articles#create   |
| /articles/:id | GET      | articles#show     |
| /articles/:id | PUT      | articles#update   |
| /articles/:id | DELETE   | articles#destroy  |

And for this a nice bunch of Angular developers made **ngResource** which gives you the custom service **$resource** that exposes 5 routes.

```JS
{ 'get':    {method:'GET'},
  'save':   {method:'POST'},
  'query':  {method:'GET', isArray:true},
  'remove': {method:'DELETE'},
  'delete': {method:'DELETE'} };
```
$resource can very quickly dry up lots of code and it forces you to be **very RESTful** in your API design.

```JS
// services.js

  .factory('Post', function ($resource) {
    return $resource('http://yourdomain.com/posts/:id', { id: '@id' })
  })
```

So a long ```$http.get``` call can be reduced to one line:

```JS
// controller.js

$scope.post = Post.get($scope.postId)
```

<br>
##Good to Know

### Sample Folder Structure
Sample Angular folder structure

```
|app
  |images  
  |js
    |controllers
      |--mainCtrl.js
      |--chatCtrl.js
      |--...
    |vendor
      |--angular.js
      |--angular-resource.js
      |--...
    |--app.js
    |--services.js
    |--...(directives.js, filters.js, interceptors.js, etc)
  |styles
  |templates
    |movies
    |site
  |--index.html
```

### Good to Know: Services vs. Factory (vs. Provider)

These are just two flavors of services. Use service() when you want to return a function with methods. Use factory() when you want to return an object or array of objects.

```JS
app.service('myService', function() {
  // service is just a constructor function that will be called with 'new'

  this.sayHello = function(name) {
     return "Hi " + name + "!";
  }
});

app.factory('myFactory', function() {
  // factory returns an object you can run some code before

  return {
    sayHello : function(name) {
      return "Hi " + name + "!";
    }
  }
});
```

>**Note**: Services and Factories are built on Providers. Providers are instantiated before configuration meaning they can't receive other injected services and you use providers if you want to instantiate something before the app runs

### Q&A
How would you make your data persistent? 

* Parse
* Firebase
* localStorage
* Two way API
* Your own server

#Lab Challenge

####Hack Onward!
1. Find a teammate or work on your own.
2. Decide how you want to enhance your search API and improve your OMDBAPI app. You could:
* Display a search input and below it search results.
* Display a filter input and below it your list of movies
* Use a 'Movie' service that has a method 'search()' that lets you search omdbapi.com by movie title.
* Use a 'List' service to have methods that add and remove movies to a list.

####Extra Credit
1. For "Extra Credit":
* Use "|filter" to filter your list of movies 
* Add another field to your search of omdbapi.com
* Create a list of "favorited movies" - controller code getting fat? Need another service!