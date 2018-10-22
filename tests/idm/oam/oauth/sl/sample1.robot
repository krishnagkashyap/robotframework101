#*** Settings ***
#Library    Collections
#Library		OperatingSystem
#
#*** Test Cases ***
#Example
#    ${json_string}=    catenate
#    ...  {
#    ...       "cloudgateConfig": {
#    ...             "bootstrap": {
#    ...               "oauthClientId": "",
#    ...               "callbackPrefix": "http://den02mpu.us.oracle.com:7777/oauth/callback",
#    ...               "externalIdUrl": "https://idcs-7b8fa955e5b74490b65e1a967f9b1848.identity.c9dev1.oc9qadev.com",
#    ...               "19c": "12.2.1.3.1"
#    ...               "12cps3": "12.2.1.3.1"
#    ...             },
#    ...             "rest": {
#    ...               "httpsVerifyServer": true,
#    ...               "httpsVerifyHost": true,
#    ...               "httpsCertAuthFile": "/net/den02mpu/scratch/kgurupra/A1/ohs3941/user_projects/domains/OHSDomain_standa2/config/fmwconfig/components/OHS/ohs1/idcscerts/cacert.pem",
#    ...               "httpsCrlFile": ""
#    ...             }
#    ...           }
#    ...         }
#
#    ${json_string}=    catenate  {"cloudgateConfig": {"bootstrap": {"oauthClientId": "","callbackPrefix": "http://den02mpu.us.oracle.com:7777/oauth/callback","externalIdUrl":"https://idcs-7b8fa955e5b74490b65e1a967f9b1848.identity.c9dev1.oc9qadev.com","oauthSecret": "816f48dc-df93-47f2-ae7b-ec9bf69f92d7"},"rest": {"httpsVerifyServer": true,"httpsVerifyHost": true,"httpsCertAuthFile": "/net/den02mpu/scratch/kgurupra/A1/ohs3941/user_projects/domains/OHSDomain_standa2/config/fmwconfig/components/OHS/ohs1/idcscerts/cacert.pem","httpsCrlFile": ""}}}
#
#    log to console       \nOriginal JSON:\n${json_string}
#    ${json}=             evaluate        json.loads('''${json_string}''')    json
#    LOG TO CONSOLE      HERE
#    LOG TO CONSOLE      ${json["cloudgateConfig"]["bootstrap"]}
#    set to dictionary    ${json["cloudgateConfig"]["bootstrap"]}    oauthClientId=67f6f89271294206ac10efedc3b972ce
##    set to dictionary    ${json["oauthClientId"]}    oauthClientId=67f6f89271294206ac10efedc3b972ce
#    ${json_string}=      evaluate        json.dumps(${json})                 json
#    log to console       \nNew JSON string:\n${json_string}
#    Create File    cloud.config      ${json_string}
#
#
#
