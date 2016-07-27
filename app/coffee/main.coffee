StepManager = require 'step-manager'

class AppLaunch

  constructor: ($el, config) ->
    @stepManager = new StepManager $el, config.providers, config.appLaunchCb, config.onCancel

window.nanobox ||= {}
nanobox.AppLaunch = AppLaunch
