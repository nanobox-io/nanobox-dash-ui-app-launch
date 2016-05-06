module.exports = class DataShim

  constructor: () ->


  getProviders : () -> [
    {
      name : "Digital Ocean"
      icon: "digital-ocean"
      regions  : [
        {name: "New York 1", id: "nyc1"}
        {name: "New York 2", id: "nyc2"}
        {name: "New York 3", id: "nyc3"}
        {name: "Amsterdam 2", id: "am2"}
        {name: "Amsterdam 3", id: "am3"}
        {name: "San Francisco", id: "sf1"}
        {name: "Singapore", id: "s1"}
        {name: "London", id: "l1"}
        {name: "Frankfurt", id: "f1"}
        {name: "Toronto", id: "t1"}
      ]
    },
    {
      name : "AWS (Amazon Web Services)"
      icon: "aws-ocean"
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
      name : "Google Compute Engine"
      icon: "google-compute"
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
