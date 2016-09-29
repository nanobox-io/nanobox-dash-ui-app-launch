module.exports = class DataShim

  constructor: () ->


  getProviders : () -> [
    {
      id: 'do'
      name : "Digital Ocean"
      accounts: [
        # {
        #   id             : "bd3ec1d3-91b7-4b5a-b6a9-86871f132304"
        #   name           : "test-provider-account"
        #   provider_id    : "do"
        #   default_region : "sfo1"
        # },{
        #   id             : "asdf090n"
        #   name           : "test-provider-account"
        #   provider_id    : "do"
        #   default_region : "sfo1"
        # }
      ]
      meta:
        icon: "digital-ocean"
        serverNickName: "Droplet"
        specs: [
          {metric:"ram", val: "512 MB"}
          {metric:"cpu", val: "0.5 Core"}
          {metric:"disk",val: "1 GB"}
          {metric:"transfer", val: "2 TB"}
        ]
      regions  : [
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
    },
    {
      id: 'aws'
      name : "AWS"
      accounts: [
        # id             : "iv103n"
        # name           : "main"
        # provider_id    : "aws"
        # default_region : "us-east-1"
      ]
      meta:
        icon: "aws"
        serverNickName: "EC2 Instance"
        specs: [
          {metric:"ram", val: "512 MB"}
          {metric:"cpu", val: "0.5 Core"}
          {metric:"disk",val: "1 GB"}
          {metric:"transfer", val: "2 TB"}
        ]
      regions  : [
        {name:"US East", isLabel:true}
        {name:"N. Virginia", id:"us-east-1"}
        {name:"US West", isLabel:true}
        {name:"Oregon", id:"us-west-2"}
        {name:"N. California", id:"us-west-1"}
        {name:"AWS GovCloud", id:"us-gov-west-1"}
        {name:"EU", isLabel:true}
        {name:"Ireland", id:"eu-west-1"}
        {name:"Frankfurt", id:"eu-central-1"}
        {name:"Asia Pacific", isLabel:true}
        {name:"Singapore", id:"ap-southeast-1"}
        {name:"Tokyo", id:"ap-northeast-1"}
        {name:"Seoul", id:"ap-northeast-2"}
        {name:"Sydney", id:"ap-southeast-2"}
        {name:"South America", isLabel:true}
        {name:"São Paulo", id:"sa-east-1"}
        {name:"China", isLabel:true}
        {name:"Beijing", id:"cn-north-1"}
      ]
    },
    {
      id: 'gc'
      name : "Google Compute Engine"
      accounts: [
        # id             : "onf49wb"
        # name           : "work"
        # provider_id    : "gc"
        # default_region : "us-central1-a"
      ]
      meta:
        icon: "google-compute"
        serverNickName: "VM"
        specs: [
          {metric:"ram", val: "512 MB"}
          {metric:"cpu", val: "0.5 Core"}
          {metric:"disk",val: "1 GB"}
          {metric:"transfer", val: "2 TB"}
        ]
      regions : [
        {name:"Easter United States", isLabel:true}
        {name:"South Carolina - B", id: "us-east1-b"}
        {name:"South Carolina - C", id: "us-east1-c"}
        {name:"South Carolina - D", id: "us-east1-d"}
        {name:"Central United States", isLabel:true}
        {name:"Iowa - A", id: "us-central1-a"}
        {name:"Iowa - B", id: "us-central1-b"}
        {name:"Iowa - C", id: "us-central1-c"}
        {name:"Iowa - F", id: "us-central1-f"}
        {name:"Western Europe", isLabel:true}
        {name:"Belgium - B", id: "europe-west1-b"}
        {name:"Belgium - C", id: "europe-west1-c"}
        {name:"Belgium - D", id: "europe-west1-d"}
        {name:"East Asia", isLabel:true}
        {name:"Taiwan - A", id: "asia-east1-a"}
        {name:"Taiwan - B", id: "asia-east1-b"}
        {name:"Taiwan - C", id: "asia-east1-c"}
      ]
    }
  ]

  # [
#   {
#     "id": "do",
#     "name": "DigitalOcean",
#     "regions": [
#       {
#         "id": "nyc1",
#         "name": "New York 1"
#       },
#       {
#         "id": "sfo1",
#         "name": "San Francisco 1"
#       }
#     ],
#     "meta": {
#       "icon": "digital-ocean",
#       "serverNickName": "Droplet",
#       "credentialFields": [
#         "access_token"
#       ],
#       "specs": [
#         {
#           "metric": "memory",
#           "val": "512"
#         },
#         {
#           "metric": "vcpus",
#           "val": "1"
#         },
#         {
#           "metric": "disk",
#           "val": "20"
#         },
#         {
#           "metric": "transfer",
#           "val": "1.0"
#         }
#       ]
#     },
#     "accounts": [
#       {
#         "id": "bd3ec1d3-91b7-4b5a-b6a9-86871f132304",
#         "name": "test-provider-account",
#         "provider_id": "do",
#         "default_region": "sfo1"
#       }
#     ]
#   }
# ]
