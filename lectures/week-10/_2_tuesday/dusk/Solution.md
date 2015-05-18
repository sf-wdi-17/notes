
```
/*
 * INDEX.html
 */
 
 <!doctype html>
 <html ng-app="color-ng">
   <head>
     <title>My Angular App</title>    
     <link href="http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
   </head>
   <body ng-view="myApp"></body>
   <script src="http://cdnjs.cloudflare.com/ajax/libs/angular.js/1.1.5/angular.min.js"></script>
   <script src="http://cdnjs.cloudflare.com/ajax/libs/angular.js/1.1.5/angular-resource.min.js"></script>
   <script src="http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script>
   <script src="app.js"></script>
 </html>
```

```
/*
 * MOVIES-INDEX.html
 */
  <div class="container">
    <div class="row">
      <div class="col-sm-3">
       <div class="thumbnail" ng-repeat="movie in movies">
          <img ng-src="{{poster_url}}">
          <div class="caption">
            <h3>{{movie.title}}</h3>
            <p>
              <button ng-click="remove(movie)">remove</button>
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
```


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
      ;

  // if none of the above states are matched, use this as the fallback
  $urlRouterProvider.otherwise('/');
});
```

```
/*
 * CONTROLLERS.JS
 */
 
angular.module('myApp.controllers', [])

.controller('moviesCtrl', function($scope, Movie) {
  $scope.movies = Movie.all();

  $scope.remove = function(movie) {
    Movie.remove(movie);
  }
})

.controller('ChatDetailCtrl', function($scope, $stateParams, Movie) {
  $scope.chat = Movie.get($stateParams.movieId);
})
;

```