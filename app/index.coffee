# Define the module and dependencies
module = angular.module '$APP_NAME', [
  'appTemplates'
  'titleService'
]

# Routing
module.config ($locationProvider) ->
  # Use HTML5 mode
  $locationProvider.html5Mode true

# Entry point
module.run (titleService) ->
  titleService.setSuffix " | #{'$APP_NAME'}"
