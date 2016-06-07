DataShim = require './shims/data-shim'

dataShim = new DataShim()


onLaunchApp = (data) ->
  console.log "Launching a new app with these specs:"
  console.log data
  # example output :  {provider: 'aws', region:'us_east'}

config =
  providers    : dataShim.getProviders()
  appLaunchCb  : onLaunchApp

app = new nanobox.AppLaunch $(".steps-wrapper"), config
