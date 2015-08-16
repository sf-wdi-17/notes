
var myApp = angular.module("myApp", []);

myApp.controller("MainCtrl", [ '$scope', 
	function($scope) {
		$scope.friends = [
			{name: 'Moe', votes: 12},
			{name: 'Larry', votes: 2},
			{name: 'Curly', votes: 11}
		];


}]);