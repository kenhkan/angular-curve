# Define the module and dependencies
dependencies = [
  'titleService'
]

# Only include templates if it exists
try
  angular.module 'appTemplates'
  dependencies.push 'appTemplates'
catch err

# Define the module and dependencies
module = angular.module 'myApplication', dependencies

# Routing
module.config ($locationProvider) ->
  # Use HTML5 mode
  $locationProvider.html5Mode true

# Entry point
module.run (titleService) ->
  titleService.setSuffix " | #{'myApplication'}"
