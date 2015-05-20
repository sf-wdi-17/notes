var CustomerApp = angular.module('customerApp', []);

CustomerApp.controller('CustomerCtrl', ['$scope', function ($scope) {
	$scope.customers = [
		{ name: "Brett Levenson", address: "123 Main St."},
	 	{ name: "Sydney Arkin", address: "567 Broadway"}
	 	];


}]);


CustomerApp.directive('wdiCustomer', function() {
	return {
		templateUrl: "wdi-customer.html"
	}
})




