StepManager = require 'step-manager'
noProvider  = require 'jade/no-provider'

class AppLaunch

  constructor: ($el, config) ->
    if @userHasAtLeastOneAccount(config)
      @stepManager = new StepManager $el, config.providers, config.appLaunchCb, config.onCancel
    else
      $node = $ noProvider( {} )
      $el.append $node


  userHasAtLeastOneAccount : (config) ->
    hasAccount = false
    for i in [config.providers.length-1..0]
      # If there is no account for a certain provider, remove it from the array
      if config.providers[i].accounts.length == 0
        config.providers.splice i, 1
      # else, note that there is at least one account
      else
        hasAccount = true
    return hasAccount


window.nanobox ||= {}
nanobox.AppLaunch = AppLaunch
