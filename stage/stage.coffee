AppLaunchShim       = require './shims/app-launch-shim'
ProviderMachineShim = require './shims/add-provider-shim'

appLaunchShim = new AppLaunchShim()
providerShim  = new ProviderMachineShim()

app = new nanobox.AppLaunch $(".steps-wrapper")

# ------------------------------------ App Cretae

onLaunchApp = (data)=>
  console.log "Launching a new app with these specs:"
  console.log data
  # example output :  {provider: 'aws', region:'us_east'}

onCancelAppCreate = ()=> console.log "Canceling app creation"

appCreateConfig =
  providers    : appLaunchShim.getProviders()
  appLaunchCb  : onLaunchApp
  onCancel     : onCancelAppCreate

# app.createAppLauncher appCreateConfig

# ------------------------------------ Add Provider



onCancelProviderAdd = ()-> console.log "Canceling provider add"

endpointTester = (endpoint, cb) ->
  console.log "Testing endpoint : #{endpoint} (fake)"
  setTimeout ()=>
    cb
      verified : true
      error    : false
      provider : providerShim.getUnofficialProvider()
  ,
    1200 * Math.random()

verifyAccount = (provider, fields, cb)->
  console.log "fields:"
  console.log fields
  console.log "provider:"
  console.log provider
  setTimeout ()->
    cb
      verified: true
      error: false
  ,
    1200 * Math.random()

addProvider = (data) ->
  console.log data.provider
  console.log data.authentication
  console.log data.name
  console.log data.defaultRegion

providerConfig =
  onCancel          : onCancelProviderAdd
  officialProviders : providerShim.getOfficialProviders()
  endpointTester    : endpointTester
  verifyAccount     : verifyAccount
  addProviderCb     : addProvider


app.addProvider providerConfig
