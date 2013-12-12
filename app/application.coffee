module = angular.module window.__APP_CONTROLLER_NAME

# Root controller
module.controller 'ApplicationController', ($scope, $location) ->
  $scope.message = 'Hello World!'
