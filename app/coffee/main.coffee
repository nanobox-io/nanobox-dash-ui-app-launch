StepManager = require 'step-manager'

class AppLaunch

  constructor: ($el, providers) ->
    @stepManager = new StepManager $el, providers

window.nanobox ||= {}
nanobox.AppLaunch = AppLaunch
