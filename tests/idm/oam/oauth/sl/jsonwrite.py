import json

data = {
    "cloudgateConfig": {
        "bootstrap": {
            "externalIdUrl": "https://idcs-7b8fa955e5b74490b65e1a967f9b1848.identity.c9dev1.oc9qadev.com",
            "callbackPrefix": "http://den02mpu.us.oracle.com:7777/oauth/callback",
            "oauthClientId": "67f6f89271294206ac10efedc3b972ce",
            "oauthSecret": "816f48dc-df93-47f2-ae7b-ec9bf69f92d7"
        },
        "rest": {
            "httpsVerifyServer": True,
            "httpsVerifyHost": True,
            "httpsCertAuthFile": "/net/den02mpu/scratch/kgurupra/A1/ohs3941/user_projects/domains/OHSDomain_standa2/config/fmwconfig/components/OHS/ohs1/idcscerts/cacert.pem",
            "httpsCrlFile": ""
        }
    }
}

with open('cloud.json', 'w') as outfile:
    json.dump(data, outfile)


data1 = json.load('cloud.json') # Read the JSON into the buffer
