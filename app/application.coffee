module = angular.module window.__APP_NAME

# Root controller
module.controller window.__APP_CONTROLLER_NAME, ($scope, $location) ->
  $scope.message = 'Hello World!'
