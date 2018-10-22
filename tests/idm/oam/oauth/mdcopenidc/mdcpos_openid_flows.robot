*** Settings ***
Documentation  MDC With OIDCTestSuite
Library		Selenium2Library
Library		String
Library     Process
Library     Collections
Library     json
Resource    	../../../../../resources/keywords/common/init.robot
Resource    ../../../../../resources/keywords/idm/oam/oauth/threelegopenid_common.robot

Suite Setup	3L_Setup Env
Test Teardown  CleanUp

*** Variables ***
${waittime}=    10s
${app0_url}=     /index.html
${app1_url}=     /index_de.html

*** Keywords ***
3L_Setup Env
    Initialize MDC Settings
    Initialize Test Data	 idm/oam/oauth/oam_oauth_policyadmin_testsuite.properties
    Initialize oamconsole xpaths    oamconsole.properties
    Set Common Test Variables
#    Set Base URL	&{Init}[oam.runtime.baseurl]
    Set Selenium Speed  2 seconds
    MDCPREQ_CREATE ADMIN ARTIFACTS REQUIRED FOR THREELEGGED CASES

SETUP COMMON VARIABLES
    &{3ldict}     create dictionary
    Set To Dictionary       ${3ldict}     oam.3l.vars.consentPageURL=&{Init}[dc1.oam.3l.adminhost.ohsport]/oam/pages/consent.jsp
    Set To Dictionary       ${3ldict}     oam.3l.vars.errorPageURL=&{Init}[dc1.oam.3l.adminhost.ohsport]/oam/pages/error.jsp
    Set To Dictionary       ${3ldict}     oam.3l.vars.redirectURI0=&{Init}[dc1.oam.3l.adminhost.adminport]${app0_url}
    Set To Dictionary       ${3ldict}     oam.3l.vars.redirectURI1=&{Init}[dc1.oam.3l.adminhost.ohsport]${app1_url}

#########################################################################################################################
#The following variables are required for Positive Three-Legged flows response_type=code
#########################################################################################################################
    Set To Dictionary       ${3ldict}     3l.code.resource1_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=code&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&{test_data}[3l.scope.seperator]email&{test_data}[3l.scope.seperator]phone&{test_data}[3l.scope.seperator]address&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]
    Set To Dictionary       ${3ldict}     3l.code.resource2_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=code&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.searchsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]
   Set To Dictionary       ${3ldict}     3l.code.resource3_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=code&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]
   Set To Dictionary       ${3ldict}     3l.code.resource4_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=code&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]RServer0.searchsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]
    Set To Dictionary       ${3ldict}     3l.code.resource5_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=code&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]openid&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]
    Set To Dictionary       ${3ldict}     3l.code.resource6_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=code&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]RServer0.searchsong&{test_data}[3l.scope.seperator]RServer0.uploadsong&{test_data}[3l.scope.seperator]RServer0.downloadsongs&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]
    Set To Dictionary       ${3ldict}     3l.code.resource7_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=code&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=openid&{test_data}[3l.scope.seperator]profile&{test_data}[3l.scope.seperator]email&{test_data}[3l.scope.seperator]address&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]

#########################################################################################################################
################The following variables are required for Positive Three-Legged flows response_type=token################
#########################################################################################################################
    Set To Dictionary       ${3ldict}     3l.token.resource1_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&{test_data}[3l.scope.seperator]email&{test_data}[3l.scope.seperator]phone&{test_data}[3l.scope.seperator]address&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]
    Set To Dictionary       ${3ldict}     3l.token.resource2_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.searchsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]
   Set To Dictionary       ${3ldict}     3l.token.resource3_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]
   Set To Dictionary       ${3ldict}     3l.token.resource4_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]RServer0.searchsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]
    Set To Dictionary       ${3ldict}     3l.token.resource5_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]openid&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]
    Set To Dictionary       ${3ldict}     3l.token.resource6_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]RServer0.searchsong&{test_data}[3l.scope.seperator]RServer0.uploadsong&{test_data}[3l.scope.seperator]RServer0.downloadsongs&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]
    Set To Dictionary       ${3ldict}     3l.token.resource7_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=openid&{test_data}[3l.scope.seperator]profile&{test_data}[3l.scope.seperator]email&{test_data}[3l.scope.seperator]address&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]

#########################################################################################################################
#The following variables are required for Positive Three-Legged flows response_type=id_token
#########################################################################################################################
    Set To Dictionary       ${3ldict}     3l.idtoken.resource1_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&{test_data}[3l.scope.seperator]email&{test_data}[3l.scope.seperator]phone&{test_data}[3l.scope.seperator]address&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken
    Set To Dictionary       ${3ldict}     3l.idtoken.resource2_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.searchsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken
   Set To Dictionary       ${3ldict}     3l.idtoken.resource3_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken
   Set To Dictionary       ${3ldict}     3l.idtoken.resource4_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]RServer0.searchsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken
    Set To Dictionary       ${3ldict}     3l.idtoken.resource5_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]openid&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken
    Set To Dictionary       ${3ldict}     3l.idtoken.resource6_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]RServer0.searchsong&{test_data}[3l.scope.seperator]RServer0.uploadsong&{test_data}[3l.scope.seperator]RServer0.downloadsongs&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken
    Set To Dictionary       ${3ldict}     3l.idtoken.resource7_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=openid&{test_data}[3l.scope.seperator]profile&{test_data}[3l.scope.seperator]email&{test_data}[3l.scope.seperator]address&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken

#########################################################################################################################
#The following variables are required for Positive Three-Legged flows response_type=token id_token
#########################################################################################################################
    Set To Dictionary       ${3ldict}     3l.tokenidtoken.resource1_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&{test_data}[3l.scope.seperator]email&{test_data}[3l.scope.seperator]phone&{test_data}[3l.scope.seperator]address&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken
    Set To Dictionary       ${3ldict}     3l.tokenidtoken.resource2_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.searchsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken
   Set To Dictionary       ${3ldict}     3l.tokenidtoken.resource3_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken
   Set To Dictionary       ${3ldict}     3l.tokenidtoken.resource4_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]RServer0.searchsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken
    Set To Dictionary       ${3ldict}     3l.tokenidtoken.resource5_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]openid&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken
    Set To Dictionary       ${3ldict}     3l.tokenidtoken.resource6_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]RServer0.searchsong&{test_data}[3l.scope.seperator]RServer0.uploadsong&{test_data}[3l.scope.seperator]RServer0.downloadsongs&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken
    Set To Dictionary       ${3ldict}     3l.tokenidtoken.resource7_url=&{Init}[dc1.oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=openid&{test_data}[3l.scope.seperator]profile&{test_data}[3l.scope.seperator]email&{test_data}[3l.scope.seperator]address&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken

    &{idparameters}     create dictionary
    Set To Dictionary       ${idparameters}     consentPageURL=&{3ldict}[oam.3l.vars.consentPageURL]
    Set To Dictionary       ${idparameters}     errorPageURL=&{3ldict}[oam.3l.vars.errorPageURL]
    Set To Dictionary       ${idparameters}     name=&{test_data}[3l.idDomain.name]
    Set To Dictionary       ${idparameters}     identityProvider=&{Init}[dc1.oam.3l.identityProvider]

    &{rsparameters}     create dictionary
    Set To Dictionary       ${rsparameters}     idDomain=&{test_data}[3l.idDomain.name]

    &{cpparameters}     create dictionary
    Set To Dictionary       ${cpparameters}     name=&{test_data}[3l.client.name]
    Set To Dictionary       ${cpparameters}     id=&{test_data}[3l.client.id]
    Set To Dictionary       ${cpparameters}     secret=&{test_data}[3l.client.secret]
    Set To Dictionary       ${cpparameters}     idDomain=&{test_data}[3l.idDomain.name]

    &{redirecturis}     create dictionary
    Set To Dictionary       ${redirecturis}     redirectURI0=&{3ldict}[oam.3l.vars.redirectURI0]
    Set To Dictionary       ${redirecturis}     redirectURI1=&{3ldict}[oam.3l.vars.redirectURI1]

    Log Dictionary    ${idparameters}
	Log Dictionary    ${redirecturis}
	Log Dictionary    ${3ldict}

	Set Suite Variable  &{idparameters}
	Set Suite Variable  &{rsparameters}
	Set Suite Variable  &{cpparameters}
	Set Suite Variable  &{redirecturis}
	Set Suite Variable  &{3ldict}

	LOG TO CONSOLE      *****************************************************************${\n}
	LOG TO CONSOLE      ALL OPENIDC URLS USED${\n}
	LOG TO CONSOLE      *****************************************************************${\n}
    ${items}=    Get Dictionary Items    ${3ldict}
    :FOR    ${key}    ${value}    IN    @{items}
    \    LOG TO CONSOLE     ${key} : ${value}

	LOG TO CONSOLE      *****************************************************************${\n}
    LOG TO CONSOLE      ${\n}

Set Common Test Variables

    &{clientdetails}    create dictionary
    Set To Dictionary       ${clientdetails}     name=&{test_data}[3l.client.name]
    Set To Dictionary       ${clientdetails}     id=&{test_data}[3l.client.id]
    Set To Dictionary       ${clientdetails}     secret=&{test_data}[3l.client.secret]

    &{iddomaindetails}      create dictionary
    Set To Dictionary       ${iddomaindetails}     name=&{test_data}[3l.idDomain.name]

	Set Suite Variable	&{clientdetails}
    Set Suite Variable	&{iddomaindetails}

    SETUP COMMON VARIABLES

#############################################################################################################################
##################################THREE-LEGGED STARTS FROM HERE FOR response_type=code#######################################
#############################################################################################################################
*** Test Cases ***
3L_AuthzCode_CL0_Request_Scope_FullList_1
    [Tags]  authzcode
    [Documentation]     AUTHZ CODE FLOW WITH ALL OPENID SCOPES AND ONE CUSTOM SCOPE ACCESS_TOKEN VALIDATION,scope=RServer0.playsong openid profile email phone address

    ${authzcode}=      OAUTHRUNTIME FETCH AUTHORIZATION CODE    &{3ldict}[3l.code.resource1_url]         ${waittime}

    ${accesstoken}      ${refreshtoken}=     MDCOAUTHRUNTIME AUTHORIZATION_CODE GET ACCESSTOKEN AND REFERSHTOKEN      &{Init}[dc1.oam.runtime.baseurl]      &{iddomaindetails}[name]     &{clientdetails}[id]     &{clientdetails}[secret]     ${authzcode}      &{3ldict}[oam.3l.vars.redirectURI0]

    ${response}=        MDCACCESS TOKEN VALIDATION FLOW    &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${accesstoken}

    &{validclaims}      create dictionary
    Set To Dictionary       ${validclaims}     iss=&{Init}[oam.3l.iss]
    Set To Dictionary       ${validclaims}     aud=&{test_data}[3l.client.name]
    Set To Dictionary       ${validclaims}     sub=&{Init}[oam.admin.username]
    Set To Dictionary       ${validclaims}     client=&{test_data}[3l.client.name]
    Set To Dictionary       ${validclaims}     scope=RServer0.playsong,openid,profile,email,phone,address
    Set To Dictionary       ${validclaims}     domain=&{iddomaindetails}[name]
#    Set To Dictionary       ${validclaims}     customAttrNames=&{test_data}[3l.custom.attrNames]

    &{validatedresponse}=   VALIDATETOKENRESPONSE    ${response}     ${validclaims}
    LOG DICTIONARY      ${validatedresponse}
    LOG TO CONSOLE      &{validatedresponse}[isClaimsValidFlag]
    Run Keyword And Ignore Error    SHOULD NOT BE EMPTY     &{validatedresponse}[isClaimsValidFlag]

    ${response_userinfo}=        MDCACCESS TOKEN VALIDATION USERINFO FLOW  &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${accesstoken}
    &{validUserInfoclaims}      create dictionary
    Set To Dictionary       ${validUserInfoclaims}     profile=null
    Set To Dictionary       ${validUserInfoclaims}     phone=null
    Set To Dictionary       ${validUserInfoclaims}     address=null
    Set To Dictionary       ${validUserInfoclaims}     email=null

    &{validatedUserInfoResponse}=   VALIDATEUSERINFORESPONSE    ${response_userinfo}     ${validUserInfoclaims}
    LOG DICTIONARY      ${validatedUserInfoResponse}

    ${profileItems}=    Get From Dictionary    ${validatedUserInfoResponse}     profile
    ${addressItems}=    Get From Dictionary    ${validatedUserInfoResponse}     address
    ${phoneItems}=    Get From Dictionary    ${validatedUserInfoResponse}     phone
    ${emailItems}=    Get From Dictionary    ${validatedUserInfoResponse}     email
    LOG     ${profileItems}
    LOG     ${addressItems}
    LOG     ${phoneItems}
    LOG     ${emailItems}

    ${profileDict}=    evaluate    json.loads('''${profileItems}''')    json
    ${addressDict}=    evaluate    json.loads('''${addressItems}''')    json
    ${phoneDict}=    evaluate    json.loads('''${phoneItems}''')    json
    ${emailDict}=    evaluate    json.loads('''${emailItems}''')    json
    LOG DICTIONARY      ${profileDict}

    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${profileDict}    name    &{Init}[oam.admin.username]
    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${addressDict}    country    &{Init}[oam.admin.username]
    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${phoneDict}    phone_number_verified    N
    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${emailDict}    email_verified    N

3L_AuthzCode_CL0_Request_Scope_FullList_2
    [Tags]  authzcode
    [Documentation]     AUTHZ CODE FLOW WITH OPENID SCOPE AND ONE CUSTOM SCOPE ACCESS_TOKEN VALIDATION,verify scope=RServer0.searchsong openid profile searchsong is not defined in client and is in resource server scope list

    ${authzcode}=      OAUTHRUNTIME FETCH AUTHORIZATION CODE     &{3ldict}[3l.code.resource2_url]     ${waittime}

    ${accesstoken}      ${refreshtoken}=     MDCOAUTHRUNTIME AUTHORIZATION_CODE GET ACCESSTOKEN AND REFERSHTOKEN      &{Init}[dc1.oam.runtime.baseurl]     &{iddomaindetails}[name]     &{clientdetails}[id]     &{clientdetails}[secret]    ${authzcode}      &{3ldict}[oam.3l.vars.redirectURI0]

    ${response}=        MDCACCESS TOKEN VALIDATION FLOW    &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${accesstoken}
    &{validclaims}      create dictionary
    Set To Dictionary       ${validclaims}     iss=&{Init}[oam.3l.iss]
    Set To Dictionary       ${validclaims}     aud=&{test_data}[3l.client.name]
    Set To Dictionary       ${validclaims}     sub=&{Init}[oam.admin.username]
    Set To Dictionary       ${validclaims}     client=&{test_data}[3l.client.name]
    Set To Dictionary       ${validclaims}     scope=RServer0.playsong,openid,profile,email,phone,address
    Set To Dictionary       ${validclaims}     domain=&{iddomaindetails}[name]
#    Set To Dictionary       ${validclaims}     customAttrNames=&{test_data}[3l.custom.attrNames]

    &{validatedresponse}=   VALIDATETOKENRESPONSE    ${response}     ${validclaims}
    LOG DICTIONARY      ${validatedresponse}
    LOG TO CONSOLE      &{validatedresponse}[isClaimsValidFlag]
    Run Keyword And Ignore Error    SHOULD NOT BE EMPTY     &{validatedresponse}[isClaimsValidFlag]

    ${response_userinfo}=        MDCACCESS TOKEN VALIDATION USERINFO FLOW  &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${accesstoken}
    &{validUserInfoclaims}      create dictionary
    Set To Dictionary       ${validUserInfoclaims}     profile=null

    &{validatedUserInfoResponse}=   VALIDATEUSERINFORESPONSE    ${response_userinfo}     ${validUserInfoclaims}
    LOG DICTIONARY      ${validatedUserInfoResponse}
    ${profileItems}=    Get From Dictionary    ${validatedUserInfoResponse}     profile
    LOG     ${profileItems}
    ${profileDict}=    evaluate    json.loads('''${profileItems}''')    json
    LOG DICTIONARY      ${profileDict}
    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${profileDict}    name    &{Init}[oam.admin.username]

3L_AuthzCode_CL0_Request_Scope_profile
    [Tags]  authzcode
    [Documentation]     AUTHZ CODE FLOW WITH OPENID SCOPE AND ONE CUSTOM SCOPE ACCESS_TOKEN VALIDATION,verifyscope=RServer0.playsong openid profile

    ${authzcode}=      OAUTHRUNTIME FETCH AUTHORIZATION CODE     &{3ldict}[3l.code.resource3_url]     ${waittime}

    ${accesstoken}      ${refreshtoken}=     MDCOAUTHRUNTIME AUTHORIZATION_CODE GET ACCESSTOKEN AND REFERSHTOKEN      &{Init}[dc1.oam.runtime.baseurl]     &{iddomaindetails}[name]     &{clientdetails}[id]     &{clientdetails}[secret]    ${authzcode}      &{3ldict}[oam.3l.vars.redirectURI0]

    ${response}=        MDCACCESS TOKEN VALIDATION FLOW    &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${accesstoken}
    Run Keyword And Ignore Error    Should Contain      ${response}     &{iddomaindetails}[name]    ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{clientdetails}[name]      ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{Init}[oam.admin.username]     ignore_case=True

    ${response_userinfo}=        MDCACCESS TOKEN VALIDATION USERINFO FLOW  &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${accesstoken}
    &{validUserInfoclaims}      create dictionary
    Set To Dictionary       ${validUserInfoclaims}     profile=null

    &{validatedUserInfoResponse}=   VALIDATEUSERINFORESPONSE    ${response_userinfo}     ${validUserInfoclaims}
    LOG DICTIONARY      ${validatedUserInfoResponse}
    ${profileItems}=    Get From Dictionary    ${validatedUserInfoResponse}     profile
    LOG     ${profileItems}
    ${profileDict}=    evaluate    json.loads('''${profileItems}''')    json
    LOG DICTIONARY      ${profileDict}
    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${profileDict}    name    &{Init}[oam.admin.username]
#
3L_AuthzCode_CL0_Request_Scope_profile_noOpenID
    [Tags]  authzcode
    [Documentation]     AUTHZ CODE FLOW WITH ONLY CUSTOM SCOPE ACCESS_TOKEN VALIDATION,verifyscope=RServer0.playsong profile

    ${authzcode}=      OAUTHRUNTIME FETCH AUTHORIZATION CODE     &{3ldict}[3l.code.resource4_url]    ${waittime}

    ${accesstoken}      ${refreshtoken}=     MDCOAUTHRUNTIME AUTHORIZATION_CODE GET ACCESSTOKEN AND REFERSHTOKEN      &{Init}[dc1.oam.runtime.baseurl]     &{iddomaindetails}[name]  &{clientdetails}[id]     &{clientdetails}[secret]    ${authzcode}      &{3ldict}[oam.3l.vars.redirectURI0]

    ${response}=        MDCACCESS TOKEN VALIDATION FLOW    &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${accesstoken}
    Run Keyword And Ignore Error    Should Contain      ${response}     &{iddomaindetails}[name]    ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{clientdetails}[name]      ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{Init}[oam.admin.username]     ignore_case=True

    ${response_userinfo}=        MDCACCESS TOKEN VALIDATION USERINFO FLOW  &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${accesstoken}
    &{validUserInfoclaims}      create dictionary
    Set To Dictionary       ${validUserInfoclaims}     profile=null

    &{validatedUserInfoResponse}=   VALIDATEUSERINFORESPONSE    ${response_userinfo}     ${validUserInfoclaims}
    LOG DICTIONARY      ${validatedUserInfoResponse}
    ${profileItems}=    Get From Dictionary    ${validatedUserInfoResponse}     profile
    LOG     ${profileItems}
    ${profileDict}=    evaluate    json.loads('''${profileItems}''')    json
    LOG DICTIONARY      ${profileDict}
    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${profileDict}    name    &{Init}[oam.admin.username]

3L_AuthzCode_CL0_Request_Scope_onlyOpenID
    [Tags]  authzcode
    [Documentation]  AUTHZ CODE FLOW WITH ONE OPENID SCOPE ACCESS_TOKEN VALIDATION,verifyscope=RServer0.playsong openid

    ${authzcode}=      OAUTHRUNTIME FETCH AUTHORIZATION CODE     &{3ldict}[3l.code.resource5_url]    ${waittime}

    ${accesstoken}      ${refreshtoken}=     MDCOAUTHRUNTIME AUTHORIZATION_CODE GET ACCESSTOKEN AND REFERSHTOKEN      &{Init}[dc1.oam.runtime.baseurl]     &{iddomaindetails}[name]     &{clientdetails}[id]     &{clientdetails}[secret]    ${authzcode}      &{3ldict}[oam.3l.vars.redirectURI0]

    ${response}=        MDCACCESS TOKEN VALIDATION FLOW    &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${accesstoken}
    Run Keyword And Ignore Error    Should Contain      ${response}     &{iddomaindetails}[name]    ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{clientdetails}[name]      ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{Init}[oam.admin.username]     ignore_case=True

    ${response_userinfo}=        MDCACCESS TOKEN VALIDATION USERINFO FLOW  &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${accesstoken}
    Should Not Be Empty     ${response_userinfo}

3L_AuthzCode_CL0_Request_Scope_noOPenID
    [Tags]  authzcode
    [Documentation]  AUTHZ CODE FLOW WITH ONLY CUSTOM SCOPE ACCESS_TOKEN VALIDATION,verifyscope=RServer0.playsong
    ${authzcode}=      OAUTHRUNTIME FETCH AUTHORIZATION CODE     &{3ldict}[3l.code.resource6_url]    ${waittime}

    ${accesstoken}      ${refreshtoken}=     MDCOAUTHRUNTIME AUTHORIZATION_CODE GET ACCESSTOKEN AND REFERSHTOKEN      &{Init}[dc1.oam.runtime.baseurl]     &{iddomaindetails}[name]    &{clientdetails}[id]     &{clientdetails}[secret]    ${authzcode}      &{3ldict}[oam.3l.vars.redirectURI0]

    ${response}=        MDCACCESS TOKEN VALIDATION FLOW    &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${accesstoken}
    Run Keyword And Ignore Error    Should Contain      ${response}     &{iddomaindetails}[name]    ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{clientdetails}[name]      ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{Init}[oam.admin.username]     ignore_case=True

3L_AuthzCode_CL0_Request_Scope_AllOPenID
    [Tags]  authzcode
    [Documentation]  AUTHZ CODE FLOW WITH ONE OPENID SCOPE ACCESS_TOKEN VALIDATION,verifyscope=openid profile address phone email

    ${authzcode}=      OAUTHRUNTIME FETCH AUTHORIZATION CODE     &{3ldict}[3l.code.resource7_url]    ${waittime}

    ${accesstoken}      ${refreshtoken}=     MDCOAUTHRUNTIME AUTHORIZATION_CODE GET ACCESSTOKEN AND REFERSHTOKEN      &{Init}[dc1.oam.runtime.baseurl]     &{iddomaindetails}[name]     &{clientdetails}[id]     &{clientdetails}[secret]    ${authzcode}      &{3ldict}[oam.3l.vars.redirectURI0]

    ${response}=        MDCACCESS TOKEN VALIDATION FLOW    &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${accesstoken}
    Run Keyword And Ignore Error    Should Contain      ${response}     &{iddomaindetails}[name]    ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{clientdetails}[name]      ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{Init}[oam.admin.username]     ignore_case=True

    ${response_userinfo}=        MDCACCESS TOKEN VALIDATION USERINFO FLOW  &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${accesstoken}
    &{validUserInfoclaims}      create dictionary
    Set To Dictionary       ${validUserInfoclaims}     profile=null
    Set To Dictionary       ${validUserInfoclaims}     address=null
    Set To Dictionary       ${validUserInfoclaims}     email=null

    &{validatedUserInfoResponse}=   VALIDATEUSERINFORESPONSE    ${response_userinfo}     ${validUserInfoclaims}
    LOG DICTIONARY      ${validatedUserInfoResponse}

    ${profileItems}=    Get From Dictionary    ${validatedUserInfoResponse}     profile
    ${addressItems}=    Get From Dictionary    ${validatedUserInfoResponse}     address
    ${emailItems}=    Get From Dictionary    ${validatedUserInfoResponse}     email
    LOG     ${profileItems}
    LOG     ${addressItems}
    LOG     ${emailItems}

    ${profileDict}=    evaluate    json.loads('''${profileItems}''')    json
    ${addressDict}=    evaluate    json.loads('''${addressItems}''')    json
    ${emailDict}=    evaluate    json.loads('''${emailItems}''')    json
    LOG DICTIONARY      ${profileDict}

    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${profileDict}    name    &{Init}[oam.admin.username]
    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${addressDict}    country    &{Init}[oam.admin.username]
    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${emailDict}    email_verified    N

############################################################################################################################
####################################THREE-LEGGED ENDS HERE FOR response_type=code###########################################
############################################################################################################################

############################################################################################################################
#############################REFRESH TOKEN THREE-LEGGED STARTS FROM HERE FORresponse_type=code##############################
############################################################################################################################
3L_AuthzCode_CL0_Request_Scope_FullList_1_RT
    [Tags]  authzcodeRT
    [Documentation]     AUTHZ CODE FLOW WITH ALL OPENID SCOPES AND ONE CUSTOM SCOPE ACCESS_TOKEN VALIDATION,scope=RServer0.playsong openid profile email phone address

    ${authzcode}=      OAUTHRUNTIME FETCH AUTHORIZATION CODE    &{3ldict}[3l.code.resource1_url]         ${waittime}

    ${accesstoken}      ${refreshtoken}=     MDCOAUTHRUNTIME AUTHORIZATION_CODE GET ACCESSTOKEN AND REFERSHTOKEN      &{Init}[dc1.oam.runtime.baseurl]      &{iddomaindetails}[name]     &{clientdetails}[id]     &{clientdetails}[secret]     ${authzcode}      &{3ldict}[oam.3l.vars.redirectURI0]

    ${accesstoken_from_refreshtoken}=       MDCFETCH ACCESSTOKEN FROM REFRESH TOKEN FLOW   &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]      &{clientdetails}[id]     &{clientdetails}[secret]    RServer0.playsong   ${refreshtoken}

    ${response}=        MDCACCESS TOKEN VALIDATION FLOW    &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${accesstoken_from_refreshtoken}
    Run Keyword And Ignore Error    Should Contain      ${response}     &{iddomaindetails}[name]    ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{clientdetails}[name]      ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{Init}[oam.admin.username]     ignore_case=True
#
    ${response_userinfo}=        MDCACCESS TOKEN VALIDATION USERINFO FLOW  &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${accesstoken}
    &{validUserInfoclaims}      create dictionary
    Set To Dictionary       ${validUserInfoclaims}     profile=null
    Set To Dictionary       ${validUserInfoclaims}     phone=null
    Set To Dictionary       ${validUserInfoclaims}     address=null
    Set To Dictionary       ${validUserInfoclaims}     email=null

    &{validatedUserInfoResponse}=   VALIDATEUSERINFORESPONSE    ${response_userinfo}     ${validUserInfoclaims}
    LOG DICTIONARY      ${validatedUserInfoResponse}

    ${profileItems}=    Get From Dictionary    ${validatedUserInfoResponse}     profile
    ${addressItems}=    Get From Dictionary    ${validatedUserInfoResponse}     address
    ${phoneItems}=    Get From Dictionary    ${validatedUserInfoResponse}     phone
    ${emailItems}=    Get From Dictionary    ${validatedUserInfoResponse}     email
    LOG     ${profileItems}
    LOG     ${addressItems}
    LOG     ${phoneItems}
    LOG     ${emailItems}

    ${profileDict}=    evaluate    json.loads('''${profileItems}''')    json
    ${addressDict}=    evaluate    json.loads('''${addressItems}''')    json
    ${phoneDict}=    evaluate    json.loads('''${phoneItems}''')    json
    ${emailDict}=    evaluate    json.loads('''${emailItems}''')    json
    LOG DICTIONARY      ${profileDict}

    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${profileDict}    name    &{Init}[oam.admin.username]
    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${addressDict}    country    &{Init}[oam.admin.username]
    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${phoneDict}    phone_number_verified    N
    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${emailDict}    email_verified    N

3L_AuthzCode_CL0_Request_Scope_FullList_2_RT
    [Tags]  authzcodeRT     failed
    [Documentation]     AUTHZ CODE FLOW WITH OPENID SCOPE AND ONE CUSTOM SCOPE ACCESS_TOKEN VALIDATION,verify scope=RServer0.searchsong openid profile searchsong is not defined in client and is in resource server scope list

    ${authzcode}=      OAUTHRUNTIME FETCH AUTHORIZATION CODE     &{3ldict}[3l.code.resource2_url]     ${waittime}

    ${accesstoken}      ${refreshtoken}=     MDCOAUTHRUNTIME AUTHORIZATION_CODE GET ACCESSTOKEN AND REFERSHTOKEN      &{Init}[dc1.oam.runtime.baseurl]     &{iddomaindetails}[name]     &{clientdetails}[id]     &{clientdetails}[secret]    ${authzcode}      &{3ldict}[oam.3l.vars.redirectURI0]

    ${accesstoken_from_refreshtoken}=       MDCFETCH ACCESSTOKEN FROM REFRESH TOKEN FLOW   &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]      &{clientdetails}[id]     &{clientdetails}[secret]    RServer0.searchsong   ${refreshtoken}

    ${response}=        MDCACCESS TOKEN VALIDATION FLOW    &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${accesstoken_from_refreshtoken}
    Run Keyword And Ignore Error    Should Contain      ${response}     &{iddomaindetails}[name]    ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{clientdetails}[name]      ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{Init}[oam.admin.username]     ignore_case=True

    ${response_userinfo}=        MDCACCESS TOKEN VALIDATION USERINFO FLOW  &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${accesstoken}
    &{validUserInfoclaims}      create dictionary
    Set To Dictionary       ${validUserInfoclaims}     profile=null

    &{validatedUserInfoResponse}=   VALIDATEUSERINFORESPONSE    ${response_userinfo}     ${validUserInfoclaims}
    LOG DICTIONARY      ${validatedUserInfoResponse}
    ${profileItems}=    Get From Dictionary    ${validatedUserInfoResponse}     profile
    LOG     ${profileItems}
    ${profileDict}=    evaluate    json.loads('''${profileItems}''')    json
    LOG DICTIONARY      ${profileDict}
    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${profileDict}    name    &{Init}[oam.admin.username]

3L_AuthzCode_CL0_Request_Scope_profile_RT
    [Tags]  authzcodeRT
    [Documentation]     AUTHZ CODE FLOW WITH OPENID SCOPE AND ONE CUSTOM SCOPE ACCESS_TOKEN VALIDATION,verifyscope=RServer0.playsong openid profile

    ${authzcode}=      OAUTHRUNTIME FETCH AUTHORIZATION CODE     &{3ldict}[3l.code.resource3_url]     ${waittime}

    ${accesstoken}      ${refreshtoken}=     MDCOAUTHRUNTIME AUTHORIZATION_CODE GET ACCESSTOKEN AND REFERSHTOKEN      &{Init}[dc1.oam.runtime.baseurl]     &{iddomaindetails}[name]     &{clientdetails}[id]     &{clientdetails}[secret]    ${authzcode}      &{3ldict}[oam.3l.vars.redirectURI0]

    ${accesstoken_from_refreshtoken}=       MDCFETCH ACCESSTOKEN FROM REFRESH TOKEN FLOW   &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]      &{clientdetails}[id]     &{clientdetails}[secret]    RServer0.playsong   ${refreshtoken}

    ${response}=        MDCACCESS TOKEN VALIDATION FLOW    &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${accesstoken_from_refreshtoken}
    Run Keyword And Ignore Error    Should Contain      ${response}     &{iddomaindetails}[name]    ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{clientdetails}[name]      ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{Init}[oam.admin.username]     ignore_case=True

#
    ${response_userinfo}=        MDCACCESS TOKEN VALIDATION USERINFO FLOW  &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${accesstoken}
    &{validUserInfoclaims}      create dictionary
    Set To Dictionary       ${validUserInfoclaims}     profile=null

    &{validatedUserInfoResponse}=   VALIDATEUSERINFORESPONSE    ${response_userinfo}     ${validUserInfoclaims}
    LOG DICTIONARY      ${validatedUserInfoResponse}
    ${profileItems}=    Get From Dictionary    ${validatedUserInfoResponse}     profile
    LOG     ${profileItems}
    ${profileDict}=    evaluate    json.loads('''${profileItems}''')    json
    LOG DICTIONARY      ${profileDict}
    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${profileDict}    name    &{Init}[oam.admin.username]
#
3L_AuthzCode_CL0_Request_Scope_profile_noOpenID_RT
    [Tags]  authzcodeRT
    [Documentation]     AUTHZ CODE FLOW WITH ONLY CUSTOM SCOPE ACCESS_TOKEN VALIDATION,verifyscope=RServer0.playsong profile

    ${authzcode}=      OAUTHRUNTIME FETCH AUTHORIZATION CODE     &{3ldict}[3l.code.resource4_url]    ${waittime}

    ${accesstoken}      ${refreshtoken}=     MDCOAUTHRUNTIME AUTHORIZATION_CODE GET ACCESSTOKEN AND REFERSHTOKEN      &{Init}[dc1.oam.runtime.baseurl]     &{iddomaindetails}[name]     &{clientdetails}[id]     &{clientdetails}[secret]    ${authzcode}      &{3ldict}[oam.3l.vars.redirectURI0]

    ${accesstoken_from_refreshtoken}=       MDCFETCH ACCESSTOKEN FROM REFRESH TOKEN FLOW   &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]      &{clientdetails}[id]     &{clientdetails}[secret]    RServer0.playsong   ${refreshtoken}

    ${response}=        MDCACCESS TOKEN VALIDATION FLOW    &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${accesstoken_from_refreshtoken}
    Run Keyword And Ignore Error    Should Contain      ${response}     &{iddomaindetails}[name]    ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{clientdetails}[name]      ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{Init}[oam.admin.username]     ignore_case=True


    ${response_userinfo}=        MDCACCESS TOKEN VALIDATION USERINFO FLOW  &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${accesstoken}
    &{validUserInfoclaims}      create dictionary
    Set To Dictionary       ${validUserInfoclaims}     profile=null

    &{validatedUserInfoResponse}=   VALIDATEUSERINFORESPONSE    ${response_userinfo}     ${validUserInfoclaims}
    LOG DICTIONARY      ${validatedUserInfoResponse}
    ${profileItems}=    Get From Dictionary    ${validatedUserInfoResponse}     profile
    LOG     ${profileItems}
    ${profileDict}=    evaluate    json.loads('''${profileItems}''')    json
    LOG DICTIONARY      ${profileDict}
    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${profileDict}    name    &{Init}[oam.admin.username]
#
3L_AuthzCode_CL0_Request_Scope_onlyOpenID_RT
    [Tags]  authzcodeRT
    [Documentation]  AUTHZ CODE FLOW WITH ONE OPENID SCOPE ACCESS_TOKEN VALIDATION,verifyscope=RServer0.playsong openid

    ${authzcode}=      OAUTHRUNTIME FETCH AUTHORIZATION CODE     &{3ldict}[3l.code.resource5_url]    ${waittime}

    ${accesstoken}      ${refreshtoken}=     MDCOAUTHRUNTIME AUTHORIZATION_CODE GET ACCESSTOKEN AND REFERSHTOKEN      &{Init}[dc1.oam.runtime.baseurl]     &{iddomaindetails}[name]     &{clientdetails}[id]     &{clientdetails}[secret]    ${authzcode}      &{3ldict}[oam.3l.vars.redirectURI0]

    ${accesstoken_from_refreshtoken}=       MDCFETCH ACCESSTOKEN FROM REFRESH TOKEN FLOW   &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]      &{clientdetails}[id]     &{clientdetails}[secret]    RServer0.playsong   ${refreshtoken}

    ${response}=        MDCACCESS TOKEN VALIDATION FLOW    &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]     ${accesstoken_from_refreshtoken}
    Run Keyword And Ignore Error    Should Contain      ${response}     &{iddomaindetails}[name]    ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{clientdetails}[name]      ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{Init}[oam.admin.username]     ignore_case=True

    ${response_userinfo}=        MDCACCESS TOKEN VALIDATION USERINFO FLOW  &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${accesstoken}
    Run Keyword And Ignore Error    Should Not Be Empty     ${response_userinfo}

3L_AuthzCode_CL0_Request_Scope_noOPenID_RT
    [Tags]  authzcodeRT
    [Documentation]  AUTHZ CODE FLOW WITH ONLY CUSTOM SCOPE ACCESS_TOKEN VALIDATION,verifyscope=RServer0.playsong

    ${authzcode}=      OAUTHRUNTIME FETCH AUTHORIZATION CODE     &{3ldict}[3l.code.resource6_url]    ${waittime}

    ${accesstoken}      ${refreshtoken}=     MDCOAUTHRUNTIME AUTHORIZATION_CODE GET ACCESSTOKEN AND REFERSHTOKEN      &{Init}[dc1.oam.runtime.baseurl]     &{iddomaindetails}[name]     &{clientdetails}[id]     &{clientdetails}[secret]    ${authzcode}      &{3ldict}[oam.3l.vars.redirectURI0]

    ${accesstoken_from_refreshtoken}=       MDCFETCH ACCESSTOKEN FROM REFRESH TOKEN FLOW   &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]      &{clientdetails}[id]     &{clientdetails}[secret]    RServer0.playsong   ${refreshtoken}

    ${response}=        MDCACCESS TOKEN VALIDATION FLOW    &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${accesstoken_from_refreshtoken}
    Run Keyword And Ignore Error    Should Contain      ${response}     &{iddomaindetails}[name]    ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{clientdetails}[name]      ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{Init}[oam.admin.username]     ignore_case=True

3L_REFRESHTOKENAuthzCode_CL0_Request_Scope_AllOPenID_RT
    [Tags]  authzcodeRT     failed
    [Documentation]  AUTHZ CODE FLOW WITH ONE OPENID SCOPE ACCESS_TOKEN VALIDATION,verifyscope=openid profile address phone email

    ${authzcode}=      OAUTHRUNTIME FETCH AUTHORIZATION CODE     &{3ldict}[3l.code.resource4_url]    ${waittime}

    ${accesstoken}      ${refreshtoken}=     MDCOAUTHRUNTIME AUTHORIZATION_CODE GET ACCESSTOKEN AND REFERSHTOKEN      &{Init}[dc1.oam.runtime.baseurl]     &{iddomaindetails}[name]     &{clientdetails}[id]     &{clientdetails}[secret]    ${authzcode}      &{3ldict}[oam.3l.vars.redirectURI0]

    ${accesstoken_from_refreshtoken}=       MDCFETCH ACCESSTOKEN FROM REFRESH TOKEN FLOW   &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]      &{clientdetails}[id]     &{clientdetails}[secret]    RServer0.searchsong   ${refreshtoken}

    ${response}=        MDCACCESS TOKEN VALIDATION FLOW    &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${accesstoken_from_refreshtoken}
    Run Keyword And Ignore Error    Should Contain      ${response}     &{iddomaindetails}[name]    ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{clientdetails}[name]      ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{Init}[oam.admin.username]     ignore_case=True

##############################################################################################################################
###############################REFRESH TOKEN THREE-LEGGED ENDS HERE FORresponse_type=code#####################################
##############################################################################################################################
#
##############################################################################################################################
###################################THREE-LEGGED STARTS FROM HERE FOR response_type=token######################################
##############################################################################################################################
3L_Implicit_Token_Request_Scope_FullList_1
    [Tags]  3ltokens
    [Documentation]     TOKEN CODE FLOW WITH ALL OPENID SCOPES AND ONE CUSTOM SCOPE ACCESS_TOKEN VALIDATION,scope=RServer0.playsong openid profile email phone address
    ${implicit_accesstoken}=      OAUTHRUNTIME FETCH ACCESSTOKEN FROM IMPLICIT GRANT FLOW    &{3ldict}[3l.token.resource1_url]         ${waittime}

    ${response}=        MDCACCESS TOKEN VALIDATION FLOW    &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${implicit_accesstoken}
    Run Keyword And Ignore Error    Should Contain      ${response}     &{iddomaindetails}[name]    ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{clientdetails}[name]      ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{Init}[oam.admin.username]     ignore_case=True

    ${response_userinfo}=        MDCACCESS TOKEN VALIDATION USERINFO FLOW  &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${implicit_accesstoken}
    &{validUserInfoclaims}      create dictionary
    Set To Dictionary       ${validUserInfoclaims}     profile=null
    Set To Dictionary       ${validUserInfoclaims}     address=null
    Set To Dictionary       ${validUserInfoclaims}     email=null

    &{validatedUserInfoResponse}=   VALIDATEUSERINFORESPONSE    ${response_userinfo}     ${validUserInfoclaims}
    LOG DICTIONARY      ${validatedUserInfoResponse}

    ${profileItems}=    Get From Dictionary    ${validatedUserInfoResponse}     profile
    ${addressItems}=    Get From Dictionary    ${validatedUserInfoResponse}     address
    ${emailItems}=    Get From Dictionary    ${validatedUserInfoResponse}     email
    LOG     ${profileItems}
    LOG     ${addressItems}
    LOG     ${emailItems}

    ${profileDict}=    evaluate    json.loads('''${profileItems}''')    json
    ${addressDict}=    evaluate    json.loads('''${addressItems}''')    json
    ${emailDict}=    evaluate    json.loads('''${emailItems}''')    json
    LOG DICTIONARY      ${profileDict}

    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${profileDict}    name    &{Init}[oam.admin.username]
    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${addressDict}    country    &{Init}[oam.admin.username]
    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${emailDict}    email_verified    N

3L_Implicit_Token_CL0_Request_Scope_FullList_2
    [Tags]  3ltokens
    [Documentation]     TOKEN CODE FLOW WITH OPENID SCOPE AND ONE CUSTOM SCOPE ACCESS_TOKEN VALIDATION,verify scope=RServer0.searchsong openid profile searchsong is not defined in client and is in resource server scope list

    ${implicit_accesstoken}=      OAUTHRUNTIME FETCH ACCESSTOKEN FROM IMPLICIT GRANT FLOW     &{3ldict}[3l.token.resource2_url]   ${waittime}

    ${response}=        MDCACCESS TOKEN VALIDATION FLOW    &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${implicit_accesstoken}
    Run Keyword And Ignore Error    Should Contain      ${response}     &{iddomaindetails}[name]    ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{clientdetails}[name]      ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{Init}[oam.admin.username]     ignore_case=True

    ${response_userinfo}=        MDCACCESS TOKEN VALIDATION USERINFO FLOW  &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${implicit_accesstoken}
    &{validUserInfoclaims}      create dictionary
    Set To Dictionary       ${validUserInfoclaims}     profile=null

    &{validatedUserInfoResponse}=   VALIDATEUSERINFORESPONSE    ${response_userinfo}     ${validUserInfoclaims}
    LOG DICTIONARY      ${validatedUserInfoResponse}
    ${profileItems}=    Get From Dictionary    ${validatedUserInfoResponse}     profile
    LOG     ${profileItems}
    ${profileDict}=    evaluate    json.loads('''${profileItems}''')    json
    LOG DICTIONARY      ${profileDict}
    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${profileDict}    name    &{Init}[oam.admin.username]

#
3L_Implicit_Token_CL0_Request_Scope_profile
    [Tags]  3ltokens
    [Documentation]     TOKEN CODE FLOW WITH OPENID SCOPE AND ONE CUSTOM SCOPE ACCESS_TOKEN VALIDATION,verifyscope=RServer0.playsong openid profile

    ${implicit_accesstoken}=      OAUTHRUNTIME FETCH ACCESSTOKEN FROM IMPLICIT GRANT FLOW     &{3ldict}[3l.token.resource3_url]    ${waittime}

    ${response}=        MDCACCESS TOKEN VALIDATION FLOW    &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${implicit_accesstoken}
    Run Keyword And Ignore Error    Should Contain      ${response}     &{iddomaindetails}[name]    ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{clientdetails}[name]      ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{Init}[oam.admin.username]     ignore_case=True

    ${response_userinfo}=        MDCACCESS TOKEN VALIDATION USERINFO FLOW  &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${implicit_accesstoken}
    &{validUserInfoclaims}      create dictionary
    Set To Dictionary       ${validUserInfoclaims}     profile=null

    &{validatedUserInfoResponse}=   VALIDATEUSERINFORESPONSE    ${response_userinfo}     ${validUserInfoclaims}
    LOG DICTIONARY      ${validatedUserInfoResponse}
    ${profileItems}=    Get From Dictionary    ${validatedUserInfoResponse}     profile
    LOG     ${profileItems}
    ${profileDict}=    evaluate    json.loads('''${profileItems}''')    json
    LOG DICTIONARY      ${profileDict}
    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${profileDict}    name    &{Init}[oam.admin.username]

3L_Implicit_Token_CL0_Request_Scope_profile_noOpenID
    [Tags]  3ltokens
    [Documentation]     TOKEN CODE FLOW WITH ONLY CUSTOM SCOPE ACCESS_TOKEN VALIDATION,verifyscope=RServer0.playsong profile
    ${implicit_accesstoken}=      OAUTHRUNTIME FETCH ACCESSTOKEN FROM IMPLICIT GRANT FLOW     &{3ldict}[3l.token.resource4_url]    ${waittime}

    ${response}=        MDCACCESS TOKEN VALIDATION FLOW    &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${implicit_accesstoken}
    Run Keyword And Ignore Error    Should Contain      ${response}     &{iddomaindetails}[name]    ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{clientdetails}[name]      ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{Init}[oam.admin.username]     ignore_case=True

    ${response_userinfo}=        MDCACCESS TOKEN VALIDATION USERINFO FLOW  &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${implicit_accesstoken}
    &{validUserInfoclaims}      create dictionary
    Set To Dictionary       ${validUserInfoclaims}     profile=null

    &{validatedUserInfoResponse}=   VALIDATEUSERINFORESPONSE    ${response_userinfo}     ${validUserInfoclaims}
    LOG DICTIONARY      ${validatedUserInfoResponse}
    ${profileItems}=    Get From Dictionary    ${validatedUserInfoResponse}     profile
    LOG     ${profileItems}
    ${profileDict}=    evaluate    json.loads('''${profileItems}''')    json
    LOG DICTIONARY      ${profileDict}
    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${profileDict}    name    &{Init}[oam.admin.username]

3L_Implicit_Token_CL0_Request_Scope_onlyOpenID
    [Tags]  3ltokens
    [Documentation]  TOKEN CODE FLOW WITH ONE OPENID SCOPE ACCESS_TOKEN VALIDATION,verifyscope=RServer0.playsong openid
    ${implicit_accesstoken}=      OAUTHRUNTIME FETCH ACCESSTOKEN FROM IMPLICIT GRANT FLOW     &{3ldict}[3l.token.resource5_url]    ${waittime}

    ${response}=        MDCACCESS TOKEN VALIDATION FLOW    &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${implicit_accesstoken}
    Run Keyword And Ignore Error    Should Contain      ${response}     &{iddomaindetails}[name]    ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{clientdetails}[name]      ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{Init}[oam.admin.username]     ignore_case=True

    ${response_userinfo}=        MDCACCESS TOKEN VALIDATION USERINFO FLOW  &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${implicit_accesstoken}
    Run Keyword And Ignore Error    Should Not Be Empty    ${response_userinfo}

3L_Implicit_Token_CL0_Request_Scope_noOPenID
    [Tags]  3ltokens
    [Documentation]  TOKEN CODE FLOW WITH ONLY CUSTOM SCOPE ACCESS_TOKEN VALIDATION,verifyscope=RServer0.playsong

    ${implicit_accesstoken}=      OAUTHRUNTIME FETCH ACCESSTOKEN FROM IMPLICIT GRANT FLOW     &{3ldict}[3l.token.resource6_url]    ${waittime}

    ${response}=        MDCACCESS TOKEN VALIDATION FLOW    &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${implicit_accesstoken}
    Run Keyword And Ignore Error    Should Contain      ${response}     &{iddomaindetails}[name]    ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{clientdetails}[name]      ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{Init}[oam.admin.username]     ignore_case=True

3L_Implicit_Token_CL0_Request_Scope_AllOPenID
    [Tags]  3l  3ltokens
    [Documentation]  TOKEN CODE FLOW WITH ONE OPENID SCOPE ACCESS_TOKEN VALIDATION,verifyscope=RServer0.playsong openid profile address
    ${implicit_accesstoken}=      OAUTHRUNTIME FETCH ACCESSTOKEN FROM IMPLICIT GRANT FLOW     &{3ldict}[3l.token.resource7_url]    ${waittime}

    ${response}=        MDCACCESS TOKEN VALIDATION FLOW    &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${implicit_accesstoken}
    Run Keyword And Ignore Error    Should Contain      ${response}     &{iddomaindetails}[name]    ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{clientdetails}[name]      ignore_case=True
    Run Keyword And Ignore Error    Should Contain      ${response}     &{Init}[oam.admin.username]     ignore_case=True

    ${response_userinfo}=        MDCACCESS TOKEN VALIDATION USERINFO FLOW  &{Init}[dc1.oam.runtime.baseurl]    &{iddomaindetails}[name]       ${implicit_accesstoken}
    &{validUserInfoclaims}      create dictionary
    Set To Dictionary       ${validUserInfoclaims}     profile=null
    Set To Dictionary       ${validUserInfoclaims}     address=null
    Set To Dictionary       ${validUserInfoclaims}     email=null

    &{validatedUserInfoResponse}=   VALIDATEUSERINFORESPONSE    ${response_userinfo}     ${validUserInfoclaims}
    LOG DICTIONARY      ${validatedUserInfoResponse}

    ${profileItems}=    Get From Dictionary    ${validatedUserInfoResponse}     profile
    ${addressItems}=    Get From Dictionary    ${validatedUserInfoResponse}     address
    ${emailItems}=    Get From Dictionary    ${validatedUserInfoResponse}     email
    LOG     ${profileItems}
    LOG     ${addressItems}
    LOG     ${emailItems}

    ${profileDict}=    evaluate    json.loads('''${profileItems}''')    json
    ${addressDict}=    evaluate    json.loads('''${addressItems}''')    json
    ${emailDict}=    evaluate    json.loads('''${emailItems}''')    json
    LOG DICTIONARY      ${profileDict}

    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${profileDict}    name    &{Init}[oam.admin.username]
    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${addressDict}    country    &{Init}[oam.admin.username]
    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${emailDict}    email_verified    N
#
##############################################################################################################################
####################################THREE-LEGGED ENDS HERE FOR response_type=token############################################
##############################################################################################################################
#
##############################################################################################################################
########################THREE-LEGGED STARTS FROM HERE FOR response_type=id_token##############################################
##############################################################################################################################
#3L_Implicit_IDToken_Request_Scope_FullList_1
#    [Tags]  3lidtokens
#    [Documentation]     IDTOKEN FLOW WITH ALL OPENID SCOPES AND ONE CUSTOM SCOPE ACCESS_TOKEN VALIDATION,scope=RServer0.playsong openid profile email phone address
#
#    ${implicit_idtoken}=      OAUTHRUNTIME FETCH IDTOKEN FROM IMPLICIT GRANT FLOW    &{3ldict}[3l.idtoken.resource1_url]      ${waittime}
#
#3L_Implicit_IDToken_CL0_Request_Scope_FullList_2
#    [Tags]  3lidtokens
#    [Documentation]     IDTOKEN FLOW WITH OPENID SCOPE AND ONE CUSTOM SCOPE ACCESS_TOKEN VALIDATION,verify scope=RServer0.searchsong openid profile searchsong is not defined in client and is in resource server scope list
#
#    ${implicit_idtoken}=      OAUTHRUNTIME FETCH IDTOKEN FROM IMPLICIT GRANT FLOW     &{3ldict}[3l.idtoken.resource2_url]   ${waittime}
#
#3L_Implicit_IDToken_CL0_Request_Scope_profile
#    [Tags]  3lidtokens
#    [Documentation]     IDTOKEN FLOW WITH OPENID SCOPE AND ONE CUSTOM SCOPE ACCESS_TOKEN VALIDATION,verifyscope=RServer0.playsong openid profile
#
#    ${implicit_idtoken}=      OAUTHRUNTIME FETCH IDTOKEN FROM IMPLICIT GRANT FLOW     &{3ldict}[3l.idtoken.resource3_url]    ${waittime}
#
#3L_Implicit_IDToken_CL0_Request_Scope_profile_noOpenID
#    [Tags]  3lidtokens
#    [Documentation]     IDTOKEN FLOW WITH ONLY CUSTOM SCOPE ACCESS_TOKEN VALIDATION,verifyscope=RServer0.playsong profile
#
#    ${implicit_idtoken}=      OAUTHRUNTIME FETCH IDTOKEN FROM IMPLICIT GRANT FLOW     &{3ldict}[3l.idtoken.resource4_url]    ${waittime}
#
#3L_Implicit_IDToken_CL0_Request_Scope_onlyOpenID
#    [Tags]  3lidtokens
#    [Documentation]  IDTOKEN FLOW WITH ONE OPENID SCOPE ACCESS_TOKEN VALIDATION,verifyscope=RServer0.playsong openid
#
#    ${implicit_idtoken}=      OAUTHRUNTIME FETCH IDTOKEN FROM IMPLICIT GRANT FLOW     &{3ldict}[3l.idtoken.resource5_url]    ${waittime}
#
#3L_Implicit_IDToken_CL0_Request_Scope_noOPenID
#    [Tags]  3lidtokens
#    [Documentation]  IDTOKEN FLOW WITH ONLY CUSTOM SCOPE ACCESS_TOKEN VALIDATION,verifyscope=RServer0.playsong
#
#    ${implicit_idtoken}=      OAUTHRUNTIME FETCH IDTOKEN FROM IMPLICIT GRANT FLOW     &{3ldict}[3l.idtoken.resource6_url]    ${waittime}
#
#3L_Implicit_IDToken_CL0_Request_Scope_AllOPenID
#    [Tags]  3lidtokens
#    [Documentation]  IDTOKEN FLOW WITH ONLY CUSTOM SCOPE ACCESS_TOKEN VALIDATION,verifyscope=RServer0.playsong
#
#    ${implicit_idtoken}=      OAUTHRUNTIME FETCH IDTOKEN FROM IMPLICIT GRANT FLOW     &{3ldict}[3l.idtoken.resource7_url]    ${waittime}
#
##############################################################################################################################
####################################THREE-LEGGED ENDS HERE FOR response_type=id_token#########################################
##############################################################################################################################
#
##############################################################################################################################
#########################THREE-LEGGED STARTS FROM HERE FOR response_type=token id_token#######################################
##############################################################################################################################
#3L_Implicit_TwoTokens_Request_Scope_FullList_1
#    [Tags]  3ltokenidtoken
#    [Documentation]      TOKENIDTOKEN CODE FLOW WITH ALL OPENID SCOPES AND ONE CUSTOM SCOPE ACCESS_TOKEN VALIDATION,scope=RServer0.playsong openid profile email phone address
#
#    ${implicit_accesstoken}   ${implicit_idtoken}=      OAUTHRUNTIME FETCH IDTOKEN AND ACCESSTOKEN FROM IMPLICIT GRANT FLOW    &{3ldict}[3l.tokenidtoken.resource1_url]         ${waittime}
#
#    ${response}=        ACCESS TOKEN VALIDATION FLOW    &{iddomaindetails}[name]       ${implicit_accesstoken}
#    Run Keyword And Ignore Error    Should Contain      ${response}     &{iddomaindetails}[name]    ignore_case=True
#    Run Keyword And Ignore Error    Should Contain      ${response}     &{clientdetails}[name]      ignore_case=True
#    Run Keyword And Ignore Error    Should Contain      ${response}     &{Init}[oam.admin.username]     ignore_case=True
#
#    ${response_userinfo}=        ACCESS TOKEN VALIDATION USERINFO FLOW    &{iddomaindetails}[name]       ${implicit_accesstoken}
#    Run Keyword And Ignore Error    Should Contain      ${response_userinfo}     profile
#    Run Keyword And Ignore Error    Should Contain      ${response_userinfo}     address
#    Run Keyword And Ignore Error    Should Contain      ${response_userinfo}     email
#
#3L_Implicit_TwoTokens_CL0_Request_Scope_FullList_2
#    [Tags]  3ltokenidtoken
#    [Documentation]      TOKENIDTOKEN CODE FLOW WITH OPENID SCOPE AND ONE CUSTOM SCOPE ACCESS_TOKEN VALIDATION,verify scope=RServer0.searchsong openid profile searchsong is not defined in client and is in resource server scope list
#
#    ${implicit_accesstoken}   ${implicit_idtoken}=      OAUTHRUNTIME FETCH IDTOKEN AND ACCESSTOKEN FROM IMPLICIT GRANT FLOW     &{3ldict}[3l.tokenidtoken.resource2_url]   ${waittime}
#
#    ${response}=        ACCESS TOKEN VALIDATION FLOW    &{iddomaindetails}[name]       ${implicit_accesstoken}
#    Run Keyword And Ignore Error    Should Contain      ${response}     &{iddomaindetails}[name]    ignore_case=True
#    Run Keyword And Ignore Error    Should Contain      ${response}     &{clientdetails}[name]      ignore_case=True
#    Run Keyword And Ignore Error    Should Contain      ${response}     &{Init}[oam.admin.username]     ignore_case=True
#
#    ${response_userinfo}=        ACCESS TOKEN VALIDATION USERINFO FLOW    &{iddomaindetails}[name]       ${implicit_accesstoken}
#    &{validUserInfoclaims}      create dictionary
#    Set To Dictionary       ${validUserInfoclaims}     profile=null
#
#    &{validatedUserInfoResponse}=   VALIDATEUSERINFORESPONSE    ${response_userinfo}     ${validUserInfoclaims}
#    LOG DICTIONARY      ${validatedUserInfoResponse}
#    ${profileItems}=    Get From Dictionary    ${validatedUserInfoResponse}     profile
#    LOG     ${profileItems}
#    ${profileDict}=    evaluate    json.loads('''${profileItems}''')    json
#    LOG DICTIONARY      ${profileDict}
#    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${profileDict}    name    &{Init}[oam.admin.username]
##
#3L_Implicit_TwoTokens_CL0_Request_Scope_profile
#    [Tags]  3ltokenidtoken
#    [Documentation]      TOKENIDTOKEN CODE FLOW WITH OPENID SCOPE AND ONE CUSTOM SCOPE ACCESS_TOKEN VALIDATION,verifyscope=RServer0.playsong openid profile
#
#    ${implicit_accesstoken}   ${implicit_idtoken}=      OAUTHRUNTIME FETCH IDTOKEN AND ACCESSTOKEN FROM IMPLICIT GRANT FLOW     &{3ldict}[3l.tokenidtoken.resource3_url]    ${waittime}
#
#    ${response}=        ACCESS TOKEN VALIDATION FLOW    &{iddomaindetails}[name]       ${implicit_accesstoken}
#    Run Keyword And Ignore Error    Should Contain      ${response}     &{iddomaindetails}[name]    ignore_case=True
#    Run Keyword And Ignore Error    Should Contain      ${response}     &{clientdetails}[name]      ignore_case=True
#    Run Keyword And Ignore Error    Should Contain      ${response}     &{Init}[oam.admin.username]     ignore_case=True
#
#    ${response_userinfo}=        ACCESS TOKEN VALIDATION USERINFO FLOW    &{iddomaindetails}[name]       ${implicit_accesstoken}
#    &{validUserInfoclaims}      create dictionary
#    Set To Dictionary       ${validUserInfoclaims}     profile=null
#
#    &{validatedUserInfoResponse}=   VALIDATEUSERINFORESPONSE    ${response_userinfo}     ${validUserInfoclaims}
#    LOG DICTIONARY      ${validatedUserInfoResponse}
#    ${profileItems}=    Get From Dictionary    ${validatedUserInfoResponse}     profile
#    LOG     ${profileItems}
#    ${profileDict}=    evaluate    json.loads('''${profileItems}''')    json
#    LOG DICTIONARY      ${profileDict}
#    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${profileDict}    name    &{Init}[oam.admin.username]
#
#3L_Implicit_TwoTokens_CL0_Request_Scope_profile_noOpenID
#    [Tags]  3ltokenidtoken
#    [Documentation]      TOKENIDTOKEN CODE FLOW WITH ONLY CUSTOM SCOPE ACCESS_TOKEN VALIDATION,verifyscope=RServer0.playsong profile
#    ${implicit_accesstoken}   ${implicit_idtoken}=      OAUTHRUNTIME FETCH IDTOKEN AND ACCESSTOKEN FROM IMPLICIT GRANT FLOW     &{3ldict}[3l.tokenidtoken.resource4_url]    ${waittime}
#
#    ${response}=        ACCESS TOKEN VALIDATION FLOW    &{iddomaindetails}[name]       ${implicit_accesstoken}
#    Run Keyword And Ignore Error    Should Contain      ${response}     &{iddomaindetails}[name]    ignore_case=True
#    Run Keyword And Ignore Error    Should Contain      ${response}     &{clientdetails}[name]      ignore_case=True
#    Run Keyword And Ignore Error    Should Contain      ${response}     &{Init}[oam.admin.username]     ignore_case=True
#
#    ${response_userinfo}=        ACCESS TOKEN VALIDATION USERINFO FLOW    &{iddomaindetails}[name]       ${implicit_accesstoken}
#    &{validUserInfoclaims}      create dictionary
#    Set To Dictionary       ${validUserInfoclaims}     profile=null
#
#    &{validatedUserInfoResponse}=   VALIDATEUSERINFORESPONSE    ${response_userinfo}     ${validUserInfoclaims}
#    LOG DICTIONARY      ${validatedUserInfoResponse}
#    ${profileItems}=    Get From Dictionary    ${validatedUserInfoResponse}     profile
#    LOG     ${profileItems}
#    ${profileDict}=    evaluate    json.loads('''${profileItems}''')    json
#    LOG DICTIONARY      ${profileDict}
#    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${profileDict}    name    &{Init}[oam.admin.username]
#
#3L_Implicit_TwoTokens_CL0_Request_Scope_onlyOpenID
#    [Tags]  3ltokenidtoken
#    [Documentation]   TOKENIDTOKEN CODE FLOW WITH ONE OPENID SCOPE ACCESS_TOKEN VALIDATION,verifyscope=RServer0.playsong openid
#    ${implicit_accesstoken}   ${implicit_idtoken}=      OAUTHRUNTIME FETCH IDTOKEN AND ACCESSTOKEN FROM IMPLICIT GRANT FLOW     &{3ldict}[3l.tokenidtoken.resource5_url]    ${waittime}
#
#    ${response}=        ACCESS TOKEN VALIDATION FLOW    &{iddomaindetails}[name]       ${implicit_accesstoken}
#    Run Keyword And Ignore Error    Should Contain      ${response}     &{iddomaindetails}[name]    ignore_case=True
#    Run Keyword And Ignore Error    Should Contain      ${response}     &{clientdetails}[name]      ignore_case=True
#    Run Keyword And Ignore Error    Should Contain      ${response}     &{Init}[oam.admin.username]     ignore_case=True
#
#    ${response_userinfo}=        ACCESS TOKEN VALIDATION USERINFO FLOW    &{iddomaindetails}[name]       ${implicit_accesstoken}
#    Run Keyword And Ignore Error    Should Not Be Empty    ${response_userinfo}
#
#3L_Implicit_TwoTokens_CL0_Request_Scope_noOPenID
#    [Tags]  3ltokenidtoken
#    [Documentation]   TOKENIDTOKEN CODE FLOW WITH ONLY CUSTOM SCOPE ACCESS_TOKEN VALIDATION,verifyscope=RServer0.playsong
#
#    ${implicit_accesstoken}   ${implicit_idtoken}=      OAUTHRUNTIME FETCH IDTOKEN AND ACCESSTOKEN FROM IMPLICIT GRANT FLOW     &{3ldict}[3l.tokenidtoken.resource6_url]    ${waittime}
#
#    ${response}=        ACCESS TOKEN VALIDATION FLOW    &{iddomaindetails}[name]       ${implicit_accesstoken}
#    Run Keyword And Ignore Error    Should Contain      ${response}     &{iddomaindetails}[name]    ignore_case=True
#    Run Keyword And Ignore Error    Should Contain      ${response}     &{clientdetails}[name]      ignore_case=True
#    Run Keyword And Ignore Error    Should Contain      ${response}     &{Init}[oam.admin.username]     ignore_case=True
#
#3L_Implicit_TwoTokens_CL0_Request_Scope_AllOPenID
#    [Tags]  3ltokenidtoken
#    [Documentation]   TOKENIDTOKEN CODE FLOW WITH ONE OPENID SCOPE ACCESS_TOKEN VALIDATION,verifyscope=RServer0.playsong openid
#    ${implicit_accesstoken}   ${implicit_idtoken}=      OAUTHRUNTIME FETCH IDTOKEN AND ACCESSTOKEN FROM IMPLICIT GRANT FLOW     &{3ldict}[3l.tokenidtoken.resource7_url]    ${waittime}
#
#    ${response}=        ACCESS TOKEN VALIDATION FLOW    &{iddomaindetails}[name]       ${implicit_accesstoken}
#    Run Keyword And Ignore Error    Should Contain      ${response}     &{iddomaindetails}[name]    ignore_case=True
#    Run Keyword And Ignore Error    Should Contain      ${response}     &{clientdetails}[name]      ignore_case=True
#    Run Keyword And Ignore Error    Should Contain      ${response}     &{Init}[oam.admin.username]     ignore_case=True
#
#    ${response_userinfo}=        ACCESS TOKEN VALIDATION USERINFO FLOW    &{iddomaindetails}[name]       ${implicit_accesstoken}
#    &{validUserInfoclaims}      create dictionary
#    Set To Dictionary       ${validUserInfoclaims}     profile=null
#    Set To Dictionary       ${validUserInfoclaims}     address=null
#    Set To Dictionary       ${validUserInfoclaims}     email=null
#
#    &{validatedUserInfoResponse}=   VALIDATEUSERINFORESPONSE    ${response_userinfo}     ${validUserInfoclaims}
#    LOG DICTIONARY      ${validatedUserInfoResponse}
#
#    ${profileItems}=    Get From Dictionary    ${validatedUserInfoResponse}     profile
#    ${addressItems}=    Get From Dictionary    ${validatedUserInfoResponse}     address
#    ${emailItems}=    Get From Dictionary    ${validatedUserInfoResponse}     email
#    LOG     ${profileItems}
#    LOG     ${addressItems}
#    LOG     ${emailItems}
#
#    ${profileDict}=    evaluate    json.loads('''${profileItems}''')    json
#    ${addressDict}=    evaluate    json.loads('''${addressItems}''')    json
#    ${emailDict}=    evaluate    json.loads('''${emailItems}''')    json
#    LOG DICTIONARY      ${profileDict}
#
#    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${profileDict}    name    &{Init}[oam.admin.username]
#    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${addressDict}    country    &{Init}[oam.admin.username]
#    Run Keyword And Ignore Error    Dictionary Should Contain Item      ${emailDict}    email_verified    N
#
##############################################################################################################################
###############################THREE-LEGGED ENDS FOR response_type=token id_token#############################################
##############################################################################################################################