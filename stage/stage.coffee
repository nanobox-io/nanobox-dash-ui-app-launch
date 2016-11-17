DataShim = require './shims/data-shim'

dataShim = new DataShim()

app = new nanobox.AppLaunch $(".steps-wrapper")

# ------------------------------------ App Cretae

onLaunchApp = (data)=>
  console.log "Launching a new app with these specs:"
  console.log data
  # example output :  {provider: 'aws', region:'us_east'}

onCancelAppCreate = ()=> console.log "Canceling app creation"

appCreateConfig =
  providers    : dataShim.getProviders()
  appLaunchCb  : onLaunchApp
  onCancel     : onCancelAppCreate

# app.createAppLauncher appCreateConfig

# ------------------------------------ Add Provider

onCancelProviderAdd = ()-> console.log "Canceling provider add"
providerConfig = {
  onCancel : onCancelProviderAdd
}
app.addProvider providerConfig
