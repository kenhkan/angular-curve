# Define the module and dependencies
module = angular.module '$APP_NAME'

# Root controller
module.controller 'ApplicationController', ($scope, $location) ->
  $scope.message = 'Hello World!'
