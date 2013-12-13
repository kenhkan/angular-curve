describe window.__APP_CONTROLLER_NAME, ->
  controller = null
  scope = null

  beforeEach angular.mock.module window.__APP_NAME

  beforeEach inject ($rootScope, $controller) ->
    scope = $rootScope.$new()
    controller = $controller window.__APP_CONTROLLER_NAME,
      $scope: scope

  it 'says hello', ->
    expect(scope.message).toEqual 'Hello World!'
