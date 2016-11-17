AppLauncher     = require 'app-launcher'
ProviderMachine = require 'provider-machine'

class HostMachine

  constructor: (@$el) ->

  createAppLauncher : (config) ->
    @appLauncher = new AppLauncher @$el, config

  addProvider : (config) ->
    @providerMachine = new ProviderMachine @$el, config

window.nanobox ||= {}
nanobox.AppLaunch = HostMachine
