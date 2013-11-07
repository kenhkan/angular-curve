# Define the module and dependencies
module = angular.module '$APP_NAME', [
  'app.templates'
  'ui.state'
  'ui.router'
  'titleService'
]

# Routing
module.config ($locationProvider, $stateProvider, $urlRouterProvider) ->
  # Use HTML5 mode
  $locationProvider.html5Mode true

  # Redirection rules
  $urlRouterProvider.otherwise '/'

# Entry point
module.run (titleService) ->
  titleService.setSuffix " | #{'$APP_NAME'}"
