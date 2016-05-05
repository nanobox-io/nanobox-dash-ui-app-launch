StepManager = require 'step-manager'

class AppLaunch

  constructor: ($el) ->
    @stepManager = new StepManager $el

window.nanobox ||= {}
nanobox.AppLaunch = AppLaunch
