#*** Settings ***
#Documentation  OAM OAuth TestSuite
#Library		Selenium2Library
#Library		String
#Library     Process
#Library     Collections
#Library     json
##Resource	../../../../../resources/keywords/common/init.robot
##Resource    ../../../../../resources/keywords/idm/oam/oauth/threelegopenid_common.robot
#Resource    ../../../../../resources/keywords/idm/oam/common/ui_keywords.robot
#
##Suite Setup	3L_Setup Env
##Test Teardown  CleanUp
#
#*** Variables ***
#${waittime}=    10s
#
#*** Keywords ***
#SSO Login
#	[Documentation]    Performs SSO log in for oamconsole and return window id which hepls in switching b/w various oamconsole windows
#	[Arguments]    ${url}    ${username}    ${password}
#
##	Set Selenium Implicit Wait	20 seconds
##	Set Selenium Timeout     20 seconds
#	${id}=    Open Browser     ${url}
##	Create Webdriver    ${url}
##    Set Selenium Speed  2 seconds
##	Sleep    10s
#	Wait Until Element Is Visible    &{oamconsole}[oamconsole.login.username]
#	Wait Until Element Is Visible    &{oamconsole}[oamconsole.login.password]
##	Wait Until Element Is Enabled    &{oamconsole}[oamconsole.login.username]   timeout=5
##	Wait Until Element Is Enabled    &{oamconsole}[oamconsole.login.password]   timeout=5
#	Input Text	&{oamconsole}[oamconsole.login.username]	${username}
#	Input Text	&{oamconsole}[oamconsole.login.password]	${password}
#	Click Button    Sign In
#	Sleep    5s
#	[return]    ${id}
#
#
#3L_Setup Env
#    Initialize Settings For ThreeLegged
#    Initialize Test Data	 idm/oam/oauth/oam_oauth_policyadmin_testsuite.properties
#    Initialize oamconsole xpaths    oamconsole.properties
#    Set Common Test Variables
#    Set Base URL	&{Init}[oam.runtime.baseurl]
#    Set Selenium Speed  2 seconds
#    PREQ_CREATE ADMIN ARTIFACTS REQUIRED FOR THREELEGGED CASES
#
#SETUP COMMON VARIABLES
#    &{3ldict}     create dictionary
#    Set To Dictionary       ${3ldict}     oam.3l.vars.consentPageURL=&{Init}[oam.3l.adminhost.ohsport]/oam/pages/consent.jsp
#    Set To Dictionary       ${3ldict}     oam.3l.vars.errorPageURL=&{Init}[oam.3l.adminhost.ohsport]/oam/pages/error.jsp
#    Set To Dictionary       ${3ldict}     oam.3l.vars.redirectURI0=&{Init}[oam.3l.adminhost.adminport]${app1_url}
#    Set To Dictionary       ${3ldict}     oam.3l.vars.redirectURI1=&{Init}[oam.3l.adminhost.ohsport]${app1_url}
#
##########################################################################################################################
##The following variables are required for Positive Three-Legged flows response_type=code
##########################################################################################################################
#    Set To Dictionary       ${3ldict}     3l.code.resource1_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=code&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&{test_data}[3l.scope.seperator]email&{test_data}[3l.scope.seperator]phone&{test_data}[3l.scope.seperator]address&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]
#    Set To Dictionary       ${3ldict}     3l.code.resource2_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=code&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.searchsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]
#   Set To Dictionary       ${3ldict}     3l.code.resource3_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=code&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]
#   Set To Dictionary       ${3ldict}     3l.code.resource4_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=code&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]RServer0.searchsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]
#    Set To Dictionary       ${3ldict}     3l.code.resource5_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=code&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]openid&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]
#    Set To Dictionary       ${3ldict}     3l.code.resource6_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=code&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]RServer0.searchsong&{test_data}[3l.scope.seperator]RServer0.uploadsong&{test_data}[3l.scope.seperator]RServer0.downloadsongs&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]
#    Set To Dictionary       ${3ldict}     3l.code.resource7_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=code&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=openid&{test_data}[3l.scope.seperator]profile&{test_data}[3l.scope.seperator]email&{test_data}[3l.scope.seperator]address&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]
#
##########################################################################################################################
#################The following variables are required for Positive Three-Legged flows response_type=token################
##########################################################################################################################
#    Set To Dictionary       ${3ldict}     3l.token.resource1_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&{test_data}[3l.scope.seperator]email&{test_data}[3l.scope.seperator]phone&{test_data}[3l.scope.seperator]address&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]
#    Set To Dictionary       ${3ldict}     3l.token.resource2_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.searchsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]
#   Set To Dictionary       ${3ldict}     3l.token.resource3_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]
#   Set To Dictionary       ${3ldict}     3l.token.resource4_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]RServer0.searchsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]
#    Set To Dictionary       ${3ldict}     3l.token.resource5_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]openid&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]
#    Set To Dictionary       ${3ldict}     3l.token.resource6_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]RServer0.searchsong&{test_data}[3l.scope.seperator]RServer0.uploadsong&{test_data}[3l.scope.seperator]RServer0.downloadsongs&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]
#    Set To Dictionary       ${3ldict}     3l.token.resource7_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=openid&{test_data}[3l.scope.seperator]profile&{test_data}[3l.scope.seperator]email&{test_data}[3l.scope.seperator]address&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]
#
##########################################################################################################################
##The following variables are required for Positive Three-Legged flows response_type=id_token
##########################################################################################################################
#    Set To Dictionary       ${3ldict}     3l.idtoken.resource1_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&{test_data}[3l.scope.seperator]email&{test_data}[3l.scope.seperator]phone&{test_data}[3l.scope.seperator]address&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken
#    Set To Dictionary       ${3ldict}     3l.idtoken.resource2_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.searchsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken
#   Set To Dictionary       ${3ldict}     3l.idtoken.resource3_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken
#   Set To Dictionary       ${3ldict}     3l.idtoken.resource4_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]RServer0.searchsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken
#    Set To Dictionary       ${3ldict}     3l.idtoken.resource5_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]openid&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken
#    Set To Dictionary       ${3ldict}     3l.idtoken.resource6_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]RServer0.searchsong&{test_data}[3l.scope.seperator]RServer0.uploadsong&{test_data}[3l.scope.seperator]RServer0.downloadsongs&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken
#    Set To Dictionary       ${3ldict}     3l.idtoken.resource7_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=openid&{test_data}[3l.scope.seperator]profile&{test_data}[3l.scope.seperator]email&{test_data}[3l.scope.seperator]address&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken
#
##########################################################################################################################
##The following variables are required for Positive Three-Legged flows response_type=token id_token
##########################################################################################################################
#    Set To Dictionary       ${3ldict}     3l.tokenidtoken.resource1_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&{test_data}[3l.scope.seperator]email&{test_data}[3l.scope.seperator]phone&{test_data}[3l.scope.seperator]address&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken
#    Set To Dictionary       ${3ldict}     3l.tokenidtoken.resource2_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.searchsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken
#   Set To Dictionary       ${3ldict}     3l.tokenidtoken.resource3_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken
#   Set To Dictionary       ${3ldict}     3l.tokenidtoken.resource4_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]RServer0.searchsong&{test_data}[3l.scope.seperator]openid&{test_data}[3l.scope.seperator]profile&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken
#    Set To Dictionary       ${3ldict}     3l.tokenidtoken.resource5_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]openid&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken
#    Set To Dictionary       ${3ldict}     3l.tokenidtoken.resource6_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=RServer0.playsong&{test_data}[3l.scope.seperator]RServer0.searchsong&{test_data}[3l.scope.seperator]RServer0.uploadsong&{test_data}[3l.scope.seperator]RServer0.downloadsongs&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken
#    Set To Dictionary       ${3ldict}     3l.tokenidtoken.resource7_url=&{Init}[oam.3l.ohshost.ohsport]/oauth2/rest/authorize?response_type=id_token token&domain=&{iddomaindetails}[name]&client_id=&{clientdetails}[name]&scope=openid&{test_data}[3l.scope.seperator]profile&{test_data}[3l.scope.seperator]email&{test_data}[3l.scope.seperator]address&state=code1234&redirect_uri=&{3ldict}[oam.3l.vars.redirectURI0]&nonce=testidtoken
#
#    &{idparameters}     create dictionary
#    Set To Dictionary       ${idparameters}     consentPageURL=&{3ldict}[oam.3l.vars.consentPageURL]
#    Set To Dictionary       ${idparameters}     errorPageURL=&{3ldict}[oam.3l.vars.errorPageURL]
#    Set To Dictionary       ${idparameters}     name=&{test_data}[3l.idDomain.name]
#    Set To Dictionary       ${idparameters}     identityProvider=&{test_data}[3l.identityProvider]
#
#    &{rsparameters}     create dictionary
#    Set To Dictionary       ${rsparameters}     idDomain=&{test_data}[3l.idDomain.name]
#
#    &{cpparameters}     create dictionary
#    Set To Dictionary       ${cpparameters}     name=&{test_data}[3l.client.name]
#    Set To Dictionary       ${cpparameters}     id=&{test_data}[3l.client.id]
#    Set To Dictionary       ${cpparameters}     secret=&{test_data}[3l.client.secret]
#    Set To Dictionary       ${cpparameters}     idDomain=&{test_data}[3l.idDomain.name]
#
#    &{redirecturis}     create dictionary
#    Set To Dictionary       ${redirecturis}     redirectURI0=&{3ldict}[oam.3l.vars.redirectURI0]
#    Set To Dictionary       ${redirecturis}     redirectURI1=&{3ldict}[oam.3l.vars.redirectURI1]
#
#    Log Dictionary    ${idparameters}
#	Log Dictionary    ${redirecturis}
#	Log Dictionary    ${3ldict}
#
#	Set Suite Variable  &{idparameters}
#	Set Suite Variable  &{rsparameters}
#	Set Suite Variable  &{cpparameters}
#	Set Suite Variable  &{redirecturis}
#	Set Suite Variable  &{3ldict}
#
#	LOG TO CONSOLE      *****************************************************************${\n}
#	LOG TO CONSOLE      ALL OPENIDC URLS USED${\n}
#	LOG TO CONSOLE      *****************************************************************${\n}
#    ${items}=    Get Dictionary Items    ${3ldict}
#    :FOR    ${key}    ${value}    IN    @{items}
#    \    LOG TO CONSOLE     ${key} : ${value}
#
#	LOG TO CONSOLE      *****************************************************************${\n}
#    LOG TO CONSOLE      ${\n}
#
#Set Common Test Variables
#
#    &{clientdetails}    create dictionary
#    Set To Dictionary       ${clientdetails}     name=&{test_data}[3l.client.name]
#    Set To Dictionary       ${clientdetails}     id=&{test_data}[3l.client.id]
#    Set To Dictionary       ${clientdetails}     secret=&{test_data}[3l.client.secret]
#
#    &{iddomaindetails}      create dictionary
#    Set To Dictionary       ${iddomaindetails}     name=&{test_data}[3l.idDomain.name]
#
#	Set Suite Variable	&{clientdetails}
#    Set Suite Variable	&{iddomaindetails}
#
#    SETUP COMMON VARIABLES
#
##############################################################################################################################
###################################THREE-LEGGED STARTS FROM HERE FOR response_type=code#######################################
##############################################################################################################################
#*** Test Cases ***
#3L_AuthzCode_CL0_Request_Scope_FullList_1
#    [Tags]  authzcode
#    [Documentation]     AUTHZ CODE FLOW WITH ALL OPENID SCOPES AND ONE CUSTOM SCOPE ACCESS_TOKEN VALIDATION,scope=RServer0.playsong openid profile email phone address
#
#    SSO Login       http://slc03sfc.us.oracle.com:16006/oamconsole      weblogic        weblogic1
#    Goto Common Settings Page
#    Set Session Lifetime   ${sessionlifetime}
#    Set Idle Timeout     ${idlesession}
#	Set Number of sessions per user    ${maxsession}
#    OAMConsole Logout
