#Angular Services

> Objective: Students will be able to write AngularJS services to dry up code, mock data, and connect to external or internal APIs.

Angular is really good at helping you safely and rationally **separate concerns** and **segregate duties**. In addition to **Controllers** and **Templates** (as we saw in Rails and Express) AngularJS has **Directives** for complex manipulation of the DOM, **Filters** for manipulating sets of data, and **Services** for getting, storing, and syncronizing data across controllers and views.

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


### 1. Mock API Data Service

```
/*
 * APP.JS
 */
 
angular.module('myApp', ['myApp.controllers', 'myApp.services'])


.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'templates/room-show'
      , controller: 'RoomIndexCtrl'
      })

      .when('/:room_name', {
        templateUrl: 'templates/post-index'
      , controller: 'PostIndexCtrl'
      })

  // if none of the above states are matched, use this as the fallback
  $urlRouterProvider.otherwise('/tab/dash');

});
```


```
/*
 * CONTROLLERS.JS
 */
 
angular.module('myApp.controllers', [])

.controller('DashCtrl', function($scope) {})

.controller('ChatsCtrl', function($scope, Chats) {
  $scope.chats = Chats.all();
  $scope.remove = function(chat) {
    Chats.remove(chat);
  }
})

.controller('ChatDetailCtrl', function($scope, $stateParams, Chats) {
  $scope.chat = Chats.get($stateParams.chatId);
})
;

```
```
/*
 * SERVICES.JS
 */
 
angular.module('myApp.services', [])

.factory('Messages', function() {
  // Might use a resource here that returns a JSON array

  // Some fake testing data
  var chats = [{
    id: 0,
    name: 'Ben Sparrow',
    lastText: 'You on your way?',
    face: 'https://pbs.twimg.com/profile_images/514549811765211136/9SgAuHeY.png'
  }, {
    id: 1,
    name: 'Max Lynx',
    lastText: 'Hey, it\'s me',
    face: 'https://avatars3.githubusercontent.com/u/11214?v=3&s=460'
  },{
    id: 2,
    name: 'Adam Bradleyson',
    lastText: 'I should buy a boat',
    face: 'https://pbs.twimg.com/profile_images/479090794058379264/84TKj_qa.jpeg'
  }, {
    id: 3,
    name: 'Perry Governor',
    lastText: 'Look at my mukluks!',
    face: 'https://pbs.twimg.com/profile_images/491995398135767040/ie2Z_V6e.jpeg'
  }, {
    id: 4,
    name: 'Mike Harrington',
    lastText: 'This is wicked good ice cream.',
    face: 'https://pbs.twimg.com/profile_images/578237281384841216/R3ae1n61.png'
  }];

  return {
    all: function() {
      return chats;
    },
    remove: function(chat) {
      chats.splice(chats.indexOf(chat), 1);
    },
    get: function(chatId) {
      for (var i = 0; i < chats.length; i++) {
        if (chats[i].id === parseInt(chatId)) {
          return chats[i];
        }
      }
      return null;
    }
  };
});

```


### 2. $http to call an API

Take the following controller code and abstract it into a MovieService method called ```search()```.

```
<form ng-submit="searchMovies">
  <input ng-model='search'>
  <button type="submit">
</form>
```

```
$scope.searchMovies = $http.get('http://www.omdbapi.com/?s=' + $scope.search)
  .success(function(data) {
      $scope.movies = data.Search
  }).failure(function(data) {
    $scope.movies = [];
  })
```

### Using Services to Dry Up Code

You can also abstract random methods and objects into your services to dry up your code. 

```
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

### How to Consume Your Own RESTful API: $resource (ngResource)

Most APIs and all that you build should be RESTful and respond to the basic

| URL           | HTTP     | CONTROLLER        |
| ------------- |:--------:| -----------------:|
| /articles     | GET      | articles#index    |
| /articles     | POST     | articles#create   |
| /articles/:id | GET      | articles#show     |
| /articles/:id | PUT      | articles#update   |
| /articles/:id | DELETE   | articles#destroy  |

And for this a nice bunch of Angular developers made **ngResource** which gives you the custom service **$resource** that exposes 5 routes.

```
{ 'get':    {method:'GET'},
  'save':   {method:'POST'},
  'query':  {method:'GET', isArray:true},
  'remove': {method:'DELETE'},
  'delete': {method:'DELETE'} };
```
$resource can very quickly dry up lots of code and it forces you to be **very RESTful** in your API design.

```
// services.js

  .factory('Post', function ($resource) {
    return $resource('http://yourdomain.com/posts/:id', { id: '@id' })
  })
```


So a long ```$http.get``` call can be reduced to one line:

```
// controller.js

$scope.post = Post.get($scope.postId)
```

<br>
#Good to Know

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
    |chats
    |site
  |--index.html
```

### Good to Know: Services vs. Factory (vs. Provider)

These are just two flavors of services. Use service() when you want to return a function with methods. Use factory() when you want to return an object or array of objects.

```
app.service('myService', function() {

  // service is just a constructor function
  // that will be called with 'new'

  this.sayHello = function(name) {
     return "Hi " + name + "!";
  }
});

app.factory('myFactory', function() {

  // factory returns an object
  // you can run some code before

  return {
    sayHello : function(name) {
      return "Hi " + name + "!";
    }
  }
});
```

**Note: Services and Factories are built on Providers. Providers are insantiated before configuration meaning they can't recieve other injected services and you use providers if you want to instantiate something before the app runs**

### Q&A
How would you make your data persistent? 

* Parse
* Firebase
* localstorage
* Two way API
* Your own server

<br>
#Lab

###Requirements
* Display a search input and below it search results.
* Display a filter input and below it your list of movies
* Use a 'Movie' service that has a method 'search()' that lets you search omdbapi.com by movie title.
* Use a 'List' service to have methods that add and remove movies to a list.

Extra Credit

* Use "|filter" to filter your list of movies 
* Add another field to your search of omdbapi.com