describe 'MyApplicationController', ->
  controller = null
  scope = null

  beforeEach angular.mock.module 'MyApplication'

  beforeEach inject ($rootScope, $controller) ->
    scope = $rootScope.$new()
    controller = $controller 'MyApplicationController',
      $scope: scope

  it 'says hello', ->
    expect(scope.message).toEqual 'Hello World!'
