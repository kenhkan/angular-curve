# Define the module and dependencies
module = angular.module 'myApplication', [
  'appTemplates'
  'titleService'
]

# Routing
module.config ($locationProvider) ->
  # Use HTML5 mode
  $locationProvider.html5Mode true

# Entry point
module.run (titleService) ->
  titleService.setSuffix " | #{'myApplication'}"
