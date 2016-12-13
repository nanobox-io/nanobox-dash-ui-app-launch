module.exports = class AddProviderShim

  constructor: () ->
  getCustomProviders : ()->
    [
      @getUnofficialProvider("Custom Provider")
    ]

  getOfficialProviders : ()->
    [
      {
        name:'Digital Ocean'
        icon:'digital-ocean'
        id:'do'
        coming:true
        authFields:[
          {label:'API Key', key:'api_key'}
          {label:'User Name', key:'user'}
          {label:'Password', key:'pass'}
        ]
        regions:[
          {name: "New York 1", id: "nyc1"}
          {name: "New York 2", id: "nyc2"}
          {name: "New York 3", id: "nyc3"}
          {name: "Amsterdam 2", id: "am2"}
          {name: "Amsterdam 3", id: "am3"}
          {name: "San Francisco", id: "sfo1"}
          {name: "Singapore", id: "s1"}
          {name: "London", id: "l1"}
          {name: "Frankfurt", id: "f1"}
          {name: "Toronto", id: "t1"}
        ]
        meta:
          instructions:'Create an API key on your <a href="#">Digital Ocean Account page</a>, or view the <a href="//docs.nanobox.io">full guide</a>.'
      },
      {
        name:'Google Compute'
        icon:'google-compute'
        id:'google'
        authFields:[
          {label:'API Key', key:'api_key'}
        ]
        regions:[
          {name: "New York 1", id: "nyc1"}
        ]
        meta:
          instructions:'Create an API key on your <a href="#">Google Compute API page</a>, or view the <a href="//docs.nanobox.io">full guide</a>.'
      },
      {
        name:'Amazon'
        icon:'aws'
        id:'aws'
        authFields:[
          {label:'API Key', key:'api_key'}
        ]
        regions:[
          {name: "New York 1", id: "nyc1"}
        ]
        meta:
          instructions:'Create an API key on your <a href="#">Google Compute API page</a>, or view the <a href="//docs.nanobox.io">full guide</a>.'
      },
      {
        name:'Joyent'
        icon:'joyent'
        id:'joyent'
        coming:true
        authFields:[
          {label:'API Key', key:'api_key'}
        ]
        regions:[
          {name: "New York 1", id: "nyc1"}
        ]
        meta:
          instructions:'Create an API key on your <a href="#">Google Compute API page</a>, or view the <a href="//docs.nanobox.io">full guide</a>.'
      }
    ]

  getUnofficialProvider : (name="Ted's Hosting") ->
    {
      name:name
      icon:'custom'
      id:'do'
      authFields:[
        {label:'User Name', key:'user_name'}
        {label:'Password', key:'pass'}
      ]
      regions:[
        {name: "Ted's House", id: "ted1"}
        {name: "Ted's Basement", id: "ted2"}
        {name: "Ted's Attic", id: "ted3"}
      ]
      meta:
        instructions:'Grab your credentials on <a href="#">Ted\'s main site</a> , or view Ted\'s<a href="#">full guide</a>.'
    }
