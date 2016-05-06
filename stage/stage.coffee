DataShim = require './shims/data-shim'

dataShim = new DataShim()

app = new nanobox.AppLaunch $(".steps-wrapper"), dataShim.getProviders()
