# Define the module and dependencies
module = angular.module 'myApplication'

# Root controller
module.controller 'ApplicationController', ($scope, $location) ->
  $scope.message = 'Hello World!'
