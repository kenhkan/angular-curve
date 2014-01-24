module = angular.module 'MyApplication'

# Root controller
module.controller 'MyApplicationController', ($scope, $location) ->
  $scope.message = 'Hello World!'
