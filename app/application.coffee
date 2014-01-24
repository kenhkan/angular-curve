module = angular.module window.CURVE_APP.name

# Root controller. Do NOT change the name as the loaderexpects the root controller to be `ApplicationController`
module.controller 'ApplicationController', ($scope, $location) ->
  $scope.message = 'Hello World!'
