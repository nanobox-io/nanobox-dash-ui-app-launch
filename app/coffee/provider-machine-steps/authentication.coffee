Step = require 'step'
authentication = require 'jade/provider-machine/authentication'

module.exports = class Authentication extends Step

  constructor: (@$el, @nextStepCb, @getProvider, @getEndpoint, @verifyAccount) ->
    @$node = $ "<div class='launch-step authentication' />"
    @$el.append @$node

  activate : () ->
    @provider = @getProvider()
    if @$content?
      $('#verify-proceed', @$content).off 'click'
      @$content.remove()
    @$content = $ authentication( @provider )
    @$node.append @$content

    $verifyBtn = $('#verify-proceed', @$node)
    $verifyBtn.on 'click', ()=>
      $verifyBtn.addClass 'ing'
      $rows = $("tr", @$node)
      @authenticationFields = {}
      for row in $rows
        $row   = $(row)
        key = $( ".field", $row).attr "data-key"
        @authenticationFields[key] = $( "input", $row).val()
      @verifyAccount @provider, @authenticationFields, @getEndpoint(), (results)=>
        $verifyBtn.removeClass 'ing'
        if !results.error
          @nextStepCb()
          @clearError()
        else
          @showErrors results.error

  getAuthentication : ()-> @authenticationFields
  getTitle : () -> "Enter your #{@provider.name} credentials"
