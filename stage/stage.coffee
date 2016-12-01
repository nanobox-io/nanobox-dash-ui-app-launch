AppLaunchShim       = require './shims/app-launch-shim'
ProviderMachineShim = require './shims/add-provider-shim'

appLaunchShim = new AppLaunchShim()
providerShim  = new ProviderMachineShim()

app = new nanobox.AppLaunch $(".steps-wrapper")

   ##   #####  #####     #        ##   #    # #    #  ####  #    #
  #  #  #    # #    #    #       #  #  #    # ##   # #    # #    #
 #    # #    # #    #    #      #    # #    # # #  # #      ######
 ###### #####  #####     #      ###### #    # #  # # #      #    #
 #    # #      #         #      #    # #    # #   ## #    # #    #
 #    # #      #         ###### #    #  ####  #    #  ####  #    #

# Example of launching an app

# Called on 'App Launch'
onLaunchApp = (data, cb)->
  console.log "Launching a new app with these specs:"
  console.log data
  setTimeout ()=>
    cb {error:"That name was just taken, sorry. "}
  ,
    1800 * Math.random()
  # example output :  {provider: 'aws', region:'us_east'}

# Called on 'cancel'
onCancelAppCreate = ()-> console.log "Canceling app creation"

# Used to validate if name isn't taken and is using valid characters
fakeNameValidator = (appName, cb)->
  setTimeout ()=>
    if Math.random() > 0.5 then cb({}) else cb {error:"App name '#{appName}' already exists"}
  ,
    Math.random()*2000

appCreateConfig =
  providers      : appLaunchShim.getProviders()
  appLaunchCb    : onLaunchApp
  onCancel       : onCancelAppCreate
  validateNameCb : fakeNameValidator
  # TODO : add the regex to the app launch name

# app.createAppLauncher appCreateConfig


   ##   #####  #####     #####  #####   ####  #    # # #####  ###### #####
  #  #  #    # #    #    #    # #    # #    # #    # # #    # #      #    #
 #    # #    # #    #    #    # #    # #    # #    # # #    # #####  #    #
 ###### #    # #    #    #####  #####  #    # #    # # #    # #      #####
 #    # #    # #    #    #      #   #  #    #  #  #  # #    # #      #   #
 #    # #####  #####     #      #    #  ####    ##   # #####  ###### #    #

# Example of adding a provider

# On Cancel
onCancelProviderAdd = ()-> console.log "Canceling provider add"

# Provided to test an endpoint
endpointTester = (endpoint, cb) ->
  console.log "Testing endpoint : #{endpoint} (fake)"
  setTimeout ()=>
    data =
      error    : "Unable to reach endpoint."
      provider : providerShim.getUnofficialProvider()
    if Math.random() > 0.6 then data.error = false
    cb data

  ,
    1200 * Math.random()

# Called to test the user credentials and make sure
# we can access their account
verifyAccount = (provider, fields, endpoint, cb)->
  console.log "Verifying Account:"
  console.log "  fields:"
  console.log fields
  console.log "  provider:"
  console.log provider
  console.log "  endpoint:\n  #{endpoint}"
  setTimeout ()->
    data =
      error: "Unable to connect with your credentials"
    if Math.random() < 0.6 then data.error = false
    cb data
  ,
    1200 * Math.random()

addProvider = (data) ->
  console.log "Finalize - Adding provider:"
  console.log data


providerConfig =
  onCancel          : onCancelProviderAdd
  officialProviders : providerShim.getOfficialProviders()
  customProviders   : providerShim.getCustomProviders()
  endpointTester    : endpointTester
  verifyAccount     : verifyAccount
  addProviderCb     : addProvider


app.addProvider providerConfig
