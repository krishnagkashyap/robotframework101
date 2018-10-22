*** Settings ***
Documentation  OAM OAuth TestSuite
Library		com.oracle.test.robot.rest.RestLibrary
Library		com.oracle.test.robot.rest.JSONLibrary
Library		com.oracle.test.robot.common.SystemLibrary
Library		com.oracle.test.robot.common.SSOLinking
Library		Selenium2Library
Library		String
Library		com.oracle.test.robot.common.LogLibrary
Library		com.oracle.test.robot.common.LogCompareLibrary
Library     Process
Library     Collections
Library		com.oracle.test.robot.common.URLEncoder
Resource    ../../../../../resources/keywords/idm/oam/common/ui_keywords.robot
Resource	../../../../../resources/keywords/common/init.robot
Resource    ../../../../../resources/keywords/idm/oam/oauth/oam_oauth_common.robot

*** Keywords ***

MODIFY OAM SESSION ATTRIBUTES
    [Arguments]  ${reqbody}     ${baseURL}      ${expected}
    [Tags]      KW_MODIFY_OAM_SESSION
    [Documentation]		This Keyword creates Iddomain artifact
    LOG TO CONSOLE      ${reqbody}
    Set Base URL        ${baseURL}
    Set Basic Auth      &{Init}[oam.admin.username]     &{Init}[oam.admin.pass]
    Set Content Type    &{test_data}[common.xml.contenttype]
    Set Request Body    ${reqbody}
    ${responseBody}     PUT     &{test_data}[common.oam.sessionattrs.endpoint]
    ${status}   Get Status
    ${actual}   Convert To String   ${status}
    Should Be Equal     ${actual}   ${expected}

PRINT PARAMS
    [Arguments]  ${params}
    [Tags]      printparams
    [Documentation]		This is the keyword which just prints passed parameters
    @{MyList}=    Create List    ${testname}     ${requestHeader}    ${queryParamAccesstoken}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testname}     ${requestHeader}    ${queryParamAccesstoken}


VALIDATE ACCESSTOKEN CLAIMS
    [Arguments]  ${response}
    Should Contain      ${response}     &{iddomaindetails}[name]
    Should Contain      ${response}     &{clientdetails}[name]
    Should Contain      ${response}     RServer0

VALIDATE USERINFO
    [Arguments]  ${response}    ${container}
    Should Not Be Empty     ${response}
    Should Contain      ${response}     ${container}


MODIFY COMMON SETTINGS
    [Arguments]  ${sessionlifetime}    ${idlesession}  ${maxsession}
    SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
    Goto Common Settings Page
    Set Session Lifetime   ${sessionlifetime}
    Set Idle Timeout     ${idlesession}
	Set Number of sessions per user    ${maxsession}
    OAMConsole Logout

VALIDATE CLAIMS FROM RESPONSE
    [Arguments]     ${response}     ${claimtype}
    [Tags]      validateresponse
    [Documentation]		Validates Responses received from OAuth Server

    &{validateresponse}=        VALIDATETOKENRESPONSE        ${response}         &{validaccesstokenclaims}
    LOG TO CONSOLE      &{validateresponse}[aud]
    LOG TO CONSOLE      &{validateresponse}[sub]
    LOG TO CONSOLE      &{validateresponse}[domain]
    LOG TO CONSOLE      &{validateresponse}[isClaimsValidFlag]
    [return]  &{validateresponse}[isClaimsValidFlag]

OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${resource_url}    ${oam.admin.username}  ${oam.admin.pass}     ${waittime}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${resource_url}    ${oam.admin.username}  ${oam.admin.pass}
    LOG TO CONSOLE  ${\n}INPUT
    asdasdp
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${resource_url}    ${oam.admin.username}  ${oam.admin.pass}
    Set Test Variable	${testName}    ${logfile_name}
	SSO Resource Login    ${resource_url}    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
    Response Not Found
    Close All Browsers
	[Return]  ${authz_code}

OAUTHRUNTIME FETCH AUTHORIZATION CODE DENY
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${resource_url}    ${oam.admin.username}  ${oam.admin.pass}     ${waittime}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${resource_url}    ${oam.admin.username}  ${oam.admin.pass}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${resource_url}    ${oam.admin.username}  ${oam.admin.pass}
    Set Test Variable	${testName}    ${logfile_name}
	SSO Resource Login    ${resource_url}    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]

	#CLICK ON ALLOW wait for few mins
    WAIT UNTIL ELEMENT IS VISIBLE       &{oamconsole}[oauth.client.consent.deny]
    Click Element       &{oamconsole}[oauth.client.consent.deny]
	Close All Browsers

OAUTH MODIFY IDENTITYDOMAIN PARAMETERS
    [Arguments]  ${reqbody}
    [Documentation]  This Keyword modifies consentpageurl,errorpageurl,name and identityProvider according to testdatafile
#    LOG     ${reqbody}
#	LOG TO CONSOLE  ${idparameters}
    ${updatedjson}      UPDATE JSON     ${reqbody}     &{idparameters}
#    LOG     ${updatedjson}
#    Log To Console  ${updatedjson}${\n}
    [Return]    ${updatedjson}

OAUTH MODIFY RESOURCESERVER PARAMETERS
    [Arguments]  ${reqbody}
    [Documentation]  This Keyword modifies name,resourceServerNameSpacePrefix and idDomain according to testdatafile
#    LOG     ${reqbody}
#	LOG TO CONSOLE  ${rsparameters}
    ${updatedjson}      UPDATE JSON     ${reqbody}     &{rsparameters}
#    LOG     ${updatedjson}
#    Log To Console  ${updatedjson}${\n}
    [Return]    ${updatedjson}

OAUTH MODIFY CLIENT PARAMETERS
    [Arguments]  ${reqbody}
    [Documentation]  This Keyword modifies name,resourceServerNameSpacePrefix and idDomain according to testdatafile
#    LOG     ${reqbody}
#	LOG TO CONSOLE  ${rsparameters}
    ${updatedjson}      UPDATE JSON     ${reqbody}     &{cpparameters}
#    LOG     ${updatedjson}
#    Log To Console  ${updatedjson}${\n}
    [Return]    ${updatedjson}

OAUTH MODIFY CLIENT REDIRECTURLS
    [Arguments]  ${reqbody}
    LOG     ${reqbody}
    LOG     &{Init}[oam.3l.vars.redirectURI0]
    LOG     &{Init}[oam.3l.vars.redirectURI1]
	Log Dictionary    ${redirecturis}
    ${updatedjson}      updateArrayInJson   ${reqbody}  &{redirecturis}
    LOG     ${updatedjson}
    [Return]    ${updatedjson}

OAUTHRUNTIME FETCH ACCESSTOKEN FROM IMPLICIT GRANT FLOW
    [Arguments]  ${resource_url}    ${waittime}
    [Tags]      KW_FETCH_ACCESSTOKEN
    [Documentation]		This keyword returns accesstoken
    @{MyList}=    Create List    ${resource_url}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${resource_url}
    SSO Resource Login    ${resource_url}    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
    #CLICK ON ALLOW wait for few mins
    Sleep    20s
    WAIT UNTIL ELEMENT IS VISIBLE       &{oamconsole}[oauth.client.consent.allow]
    Click Element       &{oamconsole}[oauth.client.consent.allow]
    #LOOK FOR CODE=VALUE
#    WAIT UNTIL ELEMENT IS VISIBLE       &{oamconsole}[oauth.client.code.full.text]
    #        ${code_content}=     GET TEXT        &{oamconsole}[oauth.client.code.full.text]
    ${code_content}=    Selenium2Library.Get Location
    LOG TO CONSOLE      ${code_content}
    ${implicit_accesstoken}=      GETACCESSTOKEN FROM IMPLICIT GRANTFLOW      ${code_content}
    SLEEP   ${waittime}
    LOG     ${implicit_accesstoken}
    LOG TO CONSOLE  ${implicit_accesstoken}${\n}
    Close All Browsers
    [Return]  ${implicit_accesstoken}

OAUTHRUNTIME FETCH IDTOKEN FROM IMPLICIT GRANT FLOW
    [Arguments]  ${resource_url}    ${waittime}
    [Tags]      KW_FETCH_ACCESSTOKEN
    [Documentation]		This keyword returns accesstoken
    @{MyList}=    Create List    ${resource_url}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${resource_url}
    SSO Resource Login    ${resource_url}    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
    #CLICK ON ALLOW wait for few mins
    WAIT UNTIL ELEMENT IS VISIBLE       &{oamconsole}[oauth.client.consent.allow]
    Click Element       &{oamconsole}[oauth.client.consent.allow]
    #LOOK FOR CODE=VALUE
    WAIT UNTIL ELEMENT IS VISIBLE       &{oamconsole}[oauth.client.code.full.text]
    #        ${code_content}=     GET TEXT        &{oamconsole}[oauth.client.code.full.text]
    ${code_content}=    Selenium2Library.Get Location
    LOG TO CONSOLE      ${code_content}
    ${implicit_idtoken}=      GETIDTOKEN FROM URL      ${code_content}
    SLEEP   ${waittime}
    LOG     ${implicit_idtoken}
    LOG TO CONSOLE  ${implicit_idtoken}${\n}
    Close All Browsers
    [Return]  ${implicit_idtoken}

OAUTHRUNTIME FETCH IDTOKEN AND ACCESSTOKEN FROM IMPLICIT GRANT FLOW
    [Arguments]  ${resource_url}    ${waittime}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${resource_url}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${resource_url}
    SSO Resource Login    ${resource_url}    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]

    #CLICK ON ALLOW wait for few mins
    WAIT UNTIL ELEMENT IS VISIBLE       &{oamconsole}[oauth.client.consent.allow]
    Click Element       &{oamconsole}[oauth.client.consent.allow]
    #LOOK FOR CODE=VALUE
    WAIT UNTIL ELEMENT IS VISIBLE       &{oamconsole}[oauth.client.code.full.text]
    #        ${code_content}=     GET TEXT        &{oamconsole}[oauth.client.code.full.text]
    ${code_content}=    Selenium2Library.Get Location
    LOG TO CONSOLE      ${code_content}
    ${implicit_accesstoken}=      GETACCESSTOKEN FROM URL      ${code_content}
    ${implicit_idtoken}=      GETIDTOKEN FROM URL      ${code_content}
    SLEEP   ${waittime}
    LOG     ${implicit_accesstoken}
    LOG     ${implicit_idtoken}
    Log To Console  ${implicit_accesstoken}${\n}
    Log To Console  ${implicit_idtoken}${\n}
    Close All Browsers
    [Return]  ${implicit_accesstoken}   ${implicit_idtoken}

GETACCESSTOKEN FROM URL
    [Arguments]     ${code_content}
    ${accesstoken}=      GET ACCESSTOKEN FROM IMPLICIT GRANTFLOW      ${code_content}
    LOG     ${accesstoken}
    [Return]    ${accesstoken}

GETIDTOKEN FROM URL
    [Arguments]     ${code_content}
    ${idtoken}=      GET IDTOKEN FROM IMPLICIT GRANTFLOW      ${code_content}
    LOG     ${idtoken}
    [Return]    ${idtoken}

OPENID OAUTHRUNTIME AUTHORIZATION_CODE GET ACCESSTOKEN AND REFERSHTOKEN
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${requestHeader}    ${url}  ${clientid}     ${clientsecret}     ${contentType}   ${authztoken}  ${redirecturi}  ${endpoint}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    PRINT PARAMS    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${requestHeader}    ${url}  ${clientid}     ${clientsecret}     ${contentType}   ${authztoken}  ${redirecturi}  ${endpoint}
    Set Test Variable	${testName}    ${logfile_name}
    Set Request Header	X-OAUTH-IDENTITY-DOMAIN-NAME    ${requestHeader}
    Set Base URL    ${url}
	Set Basic Auth	${clientid}    ${clientsecret}
    Create Logger	${testName}
    Set Content Type    ${contentType}
 	${payload} =    KW_AUTHZCODE_PAYLOAD    &{test_data}[test.runtime.0001.input.8]     ${authztoken}   ${redirecturi}
	Set Request Body	${payload}
	${responseBody}	post	${endpoint}
	Write To Log	${responseBody}
	Response OK
	${cc1_at}    Get String    ${responseBody}    access_token
	${cc1_rt}    Get String    ${responseBody}    refresh_token
	${cc1_idt}    Get String    ${responseBody}    id_token
	Should Not Be Empty    ${cc1_at}
	Should Not Be Empty    ${cc1_rt}
	Should Not Be Empty    ${cc1_idt}
	LOG     ${cc1_at}
	LOG     ${cc1_rt}
	LOG     ${cc1_idt}
    [Return]    ${cc1_at}   ${cc1_rt}   ${cc1_idt}


OAUTHRUNTIME FETCH AUTHORIZATION CODE
    [Arguments]     ${resource_url}    ${waittime}
    [Tags]      KW_RETURN_AUTHZCODE
    [Documentation]		This keyword is used to obtain Authz Code from Authz Server
    @{MyList}=    Create List    ${resource_url}    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${resource_url}    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	SSO Resource Login    ${resource_url}    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	#CLICK ON ALLOW wait for few mins
	Sleep    20s
    WAIT UNTIL ELEMENT IS VISIBLE       &{oamconsole}[oauth.client.consent.allow]
    Click Element       &{oamconsole}[oauth.client.consent.allow]
    #LOOK FOR CODE=VALUE
#    WAIT UNTIL ELEMENT IS VISIBLE       &{oamconsole}[oauth.client.code.full.text]
#    ${code_content}=     GET TEXT        &{oamconsole}[oauth.client.code.full.text]
    ${code_content}=    Selenium2Library.Get Location
    ${authz_code}=      GET AUTHZ CODE      ${code_content}
	SLEEP   ${waittime}
	LOG     ${authz_code}
	LOG TO CONSOLE  ${authz_code}${\n}
	Close All Browsers
	[Return]  ${authz_code}


OAUTHRUNTIME FETCH ACCESSTOKEN AUTHORIZATION CODE
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${resource_url}    ${oam.admin.username}  ${oam.admin.pass}     ${waittime}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${resource_url}    ${oam.admin.username}  ${oam.admin.pass}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${resource_url}    ${oam.admin.username}  ${oam.admin.pass}
    Set Test Variable	${testName}    ${logfile_name}
	SSO Resource Login    ${resource_url}    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]

	#CLICK ON ALLOW wait for few mins
    WAIT UNTIL ELEMENT IS VISIBLE       &{oamconsole}[oauth.client.consent.allow]
    Click Element       &{oamconsole}[oauth.client.consent.allow]
    #LOOK FOR CODE=VALUE
    WAIT UNTIL ELEMENT IS VISIBLE       &{oamconsole}[oauth.client.code.full.text]
    ${code_content}=     GET TEXT        &{oamconsole}[oauth.client.code.full.text]
    ${authz_code}=      GET AUTHZ CODE      ${code_content}
	SLEEP   ${waittime}
	LOG     ${authz_code}
	Log To Console  ${authz_code}${\n}
	Close All Browsers
	[Return]  ${authz_code}

OAUTHRUNTIME AUTHORIZATION_CODE GET ACCESSTOKEN AND REFERSHTOKEN
    [Arguments]  ${requestHeader}    ${clientid}     ${clientsecret}     ${authztoken}  ${redirecturi}
    [Tags]      KW_FETCH_ACCESSTOKEN_REFRESHTOKEN
    [Documentation]		This is the keyword which is used to retrieve Access token and Refresh Token
    @{MyList}=    Create List    ${requestHeader}    ${clientid}     ${clientsecret}   ${authztoken}  ${redirecturi}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${requestHeader}    ${clientid}     ${clientsecret}   ${authztoken}  ${redirecturi}
    Set Request Header	X-OAUTH-IDENTITY-DOMAIN-NAME    ${requestHeader}
    Set Base URL    &{Init}[oam.runtime.baseurl]
	Set Basic Auth	${clientid}    ${clientsecret}
    Set Content Type    &{test_data}[test109.input.1]
 	${payload} =    KW_AUTHZCODE_PAYLOAD    &{test_data}[test.runtime.0001.input.8]     ${authztoken}   ${redirecturi}
	Set Request Body	${payload}
	${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
	Response OK
	${cc1_at}    Get String    ${responseBody}    access_token
	${cc1_rt}    Get String    ${responseBody}    refresh_token
	Should Not Be Empty    ${cc1_at}
	Should Not Be Empty    ${cc1_rt}
	LOG     ${cc1_at}
	LOG     ${cc1_rt}
	LOG TO CONSOLE  ${cc1_at}
	LOG TO CONSOLE  ${cc1_rt}
    [Return]  ${cc1_at}     ${cc1_rt}

MDCOAUTHRUNTIME AUTHORIZATION_CODE GET ACCESSTOKEN AND REFERSHTOKEN
    [Arguments]  ${baseURL}     ${requestHeader}    ${clientid}     ${clientsecret}     ${authztoken}  ${redirecturi}
    [Tags]      KW_FETCH_ACCESSTOKEN_REFRESHTOKEN
    [Documentation]		This is the keyword which is used to retrieve Access token and Refresh Token
    @{MyList}=    Create List    ${requestHeader}    ${clientid}     ${clientsecret}   ${authztoken}  ${redirecturi}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${requestHeader}    ${clientid}     ${clientsecret}   ${authztoken}  ${redirecturi}
    Set Request Header	X-OAUTH-IDENTITY-DOMAIN-NAME    ${requestHeader}
    Set Base URL    ${baseURL}
	Set Basic Auth	${clientid}    ${clientsecret}
    Set Content Type    &{test_data}[test109.input.1]
 	${payload} =    KW_AUTHZCODE_PAYLOAD    &{test_data}[test.runtime.0001.input.8]     ${authztoken}   ${redirecturi}
	Set Request Body	${payload}
	${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
	Response OK
	${cc1_at}    Get String    ${responseBody}    access_token
	${cc1_rt}    Get String    ${responseBody}    refresh_token
	Should Not Be Empty    ${cc1_at}
	Should Not Be Empty    ${cc1_rt}
	LOG     ${cc1_at}
	LOG     ${cc1_rt}
	LOG TO CONSOLE  ${cc1_at}
	LOG TO CONSOLE  ${cc1_rt}
    [Return]  ${cc1_at}     ${cc1_rt}

MDCACCESS TOKEN VALIDATION USERINFO FLOW
    [Arguments]     ${baseURL}      ${requestHeader}    ${queryParamAccesstoken}
    [Tags]      KW_USERINFO_VALIDATION
    [Documentation]		This Keyword is used to validate against userinfo using accesstoken
    @{MyList}=    Create List    ${baseURL}     ${requestHeader}    ${queryParamAccesstoken}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${baseURL}      ${requestHeader}    ${queryParamAccesstoken}
    Reset Basic Auth
    Set Base URL    ${baseURL}
    Set Request Header	X-OAUTH-IDENTITY-DOMAIN-NAME    ${requestHeader}
    Set Request Header    Authorization    Bearer ${queryParamAccesstoken}
    ${responseBody}	get	&{test_data}[common.oauth.runtime.userinfo.endpoint]
    LOG TO CONSOLE  ${responseBody}
    LOG     ${responseBody}
    Response OK
	Should Not Be Empty    ${responseBody}
	[Return]  ${responseBody}

MDCACCESS TOKEN VALIDATION FLOW
    [Arguments]  ${baseURL}     ${requestHeaderIDDomain}    ${queryParamAccesstoken}
    [Tags]      KW_ACCESSTOKEN_VALIDATION
    [Documentation]		This is the keyword to invoke Access token validation from any testcase
    Set Base URL    ${baseURL}
    Set Request Header	X-OAUTH-IDENTITY-DOMAIN-NAME    ${requestHeaderIDDomain}
    Set Query Param    access_token    ${queryParamAccesstoken}
    ${responseBody}     get     &{test_data}[common.oauth.runtime.token.endpoint]/info
    LOG TO CONSOLE  ${responseBody}
    Response OK
	${r_cl}    Get String    ${responseBody}    client
	${r_user}    Get String    ${responseBody}    sub
	Should Not Be Empty    ${r_cl}
	Should Not Be Empty    ${r_user}
	[Return]  ${responseBody}


ACCESS TOKEN VALIDATION USERINFO FLOW
    [Arguments]     ${requestHeader}    ${queryParamAccesstoken}
    [Tags]      KW_USERINFO_VALIDATION
    [Documentation]		This Keyword is used to validate against userinfo using accesstoken
    @{MyList}=    Create List    ${requestHeader}    ${queryParamAccesstoken}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${requestHeader}    ${queryParamAccesstoken}
    Reset Basic Auth
    Set Base URL    &{Init}[oam.runtime.baseurl]
    Set Request Header	X-OAUTH-IDENTITY-DOMAIN-NAME    ${requestHeader}
    Set Request Header    Authorization    Bearer ${queryParamAccesstoken}
    ${responseBody}	get	&{test_data}[common.oauth.runtime.userinfo.endpoint]
    LOG TO CONSOLE  ${responseBody}
    LOG     ${responseBody}
    Response OK
	Should Not Be Empty    ${responseBody}
	[Return]  ${responseBody}

ACCESS TOKEN VALIDATION FLOW
    [Arguments]  ${requestHeaderIDDomain}    ${queryParamAccesstoken}
    [Tags]      KW_ACCESSTOKEN_VALIDATION
    [Documentation]		This is the keyword to invoke Access token validation from any testcase
    Set Base URL    &{Init}[oam.runtime.baseurl]
    Set Request Header	X-OAUTH-IDENTITY-DOMAIN-NAME    ${requestHeaderIDDomain}
    Set Query Param    access_token    ${queryParamAccesstoken}
    ${responseBody}     get     &{test_data}[common.oauth.runtime.token.endpoint]/info
    LOG TO CONSOLE  ${responseBody}
    Response OK
	${r_cl}    Get String    ${responseBody}    client
	${r_user}    Get String    ${responseBody}    sub
	Should Not Be Empty    ${r_cl}
	Should Not Be Empty    ${r_user}
	[Return]  ${responseBody}


MDCFETCH ACCESSTOKEN FROM REFRESH TOKEN FLOW
    [Arguments]     ${baseURL}  ${requestHeader}    ${clientid}     ${clientsecret}      ${scope}        ${queryParamRefreshtoken}
    [Tags]      KW_ACCESSTOKEN_FROM_REFRESHTOKEN
    [Documentation]		This is the keyword used to get accesstoken from refreshtoken
    @{MyList}=    Create List    ${requestHeader}    ${baseURL}     ${queryParamRefreshtoken}    ${scope}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${baseURL}      ${requestHeader}    ${queryParamRefreshtoken}   ${scope}
    Set Base URL    ${baseURL}
    Set Request Header	X-OAUTH-IDENTITY-DOMAIN-NAME    ${requestHeader}
	Set Basic Auth	${clientid}    ${clientsecret}
	${getencodedtoken} =    encode      ${queryParamRefreshtoken}   UTF-8
#	${getencodedtoken} =    GET BASE64 ENCODED STRING      ${queryParamRefreshtoken}
	${payload} =    KW_REFERSH_TOKEN_PAYLOAD    &{test_data}[test.runtime.0001.input.7]     ${getencodedtoken}      ${scope}
	Set Request Body	${payload}
	${responseBody}     POST	&{test_data}[common.oauth.runtime.token.endpoint]
	Response OK
	${at_from_rt}    Get String    ${responseBody}    access_token
	Should Not Be Empty    ${at_from_rt}
	Set Suite Variable    ${at_from_rt}
    LOG TO CONSOLE  ${at_from_rt}
	[Return]  ${at_from_rt}


FETCH ACCESSTOKEN FROM REFRESH TOKEN FLOW
    [Arguments]     ${requestHeader}    ${clientid}     ${clientsecret}      ${scope}        ${queryParamRefreshtoken}
    [Tags]      KW_ACCESSTOKEN_FROM_REFRESHTOKEN
    [Documentation]		This is the keyword used to get accesstoken from refreshtoken
    @{MyList}=    Create List    ${requestHeader}    ${queryParamRefreshtoken}    ${scope}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${requestHeader}    ${queryParamRefreshtoken}   ${scope}
    Set Base URL    &{Init}[oam.runtime.baseurl]
    Set Request Header	X-OAUTH-IDENTITY-DOMAIN-NAME    ${requestHeader}
	Set Basic Auth	${clientid}    ${clientsecret}
	${getencodedtoken} =    encode      ${queryParamRefreshtoken}   UTF-8
#	${getencodedtoken} =    GET BASE64 ENCODED STRING      ${queryParamRefreshtoken}
	${payload} =    KW_REFERSH_TOKEN_PAYLOAD    &{test_data}[test.runtime.0001.input.7]     ${getencodedtoken}      ${scope}
	Set Request Body	${payload}
	${responseBody}     POST	&{test_data}[common.oauth.runtime.token.endpoint]
	Response OK
	${at_from_rt}    Get String    ${responseBody}    access_token
	Should Not Be Empty    ${at_from_rt}
	Set Suite Variable    ${at_from_rt}
    LOG TO CONSOLE  ${at_from_rt}
	[Return]  ${at_from_rt}

OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN NEGATIVE
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${requestHeader}    ${url}  ${clientid}     ${clientsecret}     ${contentType}   ${userassertiontoken}  ${redirecturi}  ${scope}    ${endpoint}     ${errorCode}    ${errorDesc}    ${secErrorDesc}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${requestHeader}    ${url}  ${clientid}     ${clientsecret}     ${contentType}   ${userassertiontoken}  ${redirecturi}  ${scope}    ${endpoint}     ${errorCode}    ${errorDesc}    ${secErrorDesc}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${requestHeader}    ${url}  ${clientid}     ${clientsecret}     ${contentType}   ${userassertiontoken}  ${redirecturi}  ${scope}    ${endpoint}     ${errorCode}    ${errorDesc}    ${secErrorDesc}
    Set Test Variable	${testName}    ${logfile_name}
    Set Request Header	X-OAUTH-IDENTITY-DOMAIN-NAME    ${requestHeader}
    Set Base URL    ${url}
	Set Basic Auth	${clientid}    ${clientsecret}
    Create Logger	${testName}
    Set Content Type    ${contentType}
 	${payload} =    KW_JWTBEARER_CLIENTCREDS_PAYLOAD    &{test_data}[test.runtime.0001.input.4]     ${userassertiontoken}   ${redirecturi}  ${scope}
	Set Request Body	${payload}
	${responseBody}	post	${endpoint}
	Write To Log	${responseBody}
	Response Bad Request
	${e}    Get String    ${responseBody}    errorCode
	${ed}    Get String    ${responseBody}    errorDesc
	${esd}    Get String    ${responseBody}    secErrorDesc
	Should Not Be Empty    ${e}
	Should Not Be Empty    ${ed}
	Should Not Be Empty    ${esd}
	Should be equal as Strings    ${e}    ${errorCode}
	Should be equal as Strings    ${ed}    ${errorDesc}
	Should be equal as Strings    ${esd}    ${secErrorDesc}

3LOAUTH ADMIN IDENTITYDOMAIN CREATION
    [Arguments]  ${reqbody}   ${expected}
    [Tags]      KW_IDDOMAIN_CREATION
    [Documentation]		This Keyword creates Iddomain artifact
    @{MyList}=    Create List    ${reqbody}   ${expected}
#    LOG TO CONSOLE  ${\n}INPUT
#    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${reqbody}   ${expected}
    Set Base URL	&{Init}[oam.admin.server]
    Set Basic Auth	&{Init}[oam.admin.username]     &{Init}[oam.admin.pass]
    Set Content Type	&{test_data}[common.json.contenttype]
    Set Request Body	${reqbody}
    ${responseBody}     POST    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
#    LOG TO CONSOLE  OUTPUT
#    LOG TO CONSOLE  ${responseBody}
    ${status}	Get Status
    ${actual}	Convert To String	${status}
    Should Be Equal     ${actual}   ${expected}

3LOAUTH ADMIN RESOURCESERVER CREATION
    [Arguments]  ${reqbody}      ${expected}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${reqbody}   ${expected}
#    LOG TO CONSOLE  ${\n}INPUT
#    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${reqbody}   ${expected}
    Set Base URL    &{Init}[oam.admin.server]
    Set Basic Auth	&{Init}[oam.admin.username]     &{Init}[oam.admin.pass]
    Set Content Type	&{test_data}[common.json.contenttype]
    Set Request Body	${reqbody}
    ${responseBody}     POST    &{test_data}[common.oauth.admin.resource.rest.endpoint]
    ${status}	Get Status
    ${actual}	Convert To String	${status}
    Should Be Equal     ${actual}   ${expected}

3LOAUTH ADMIN CLIENT CREATION
    [Arguments]  ${reqbody}   ${expected}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${reqbody}   ${expected}
#    LOG TO CONSOLE  ${\n}INPUT
#    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${reqbody}   ${expected}
    Set Basic Auth	&{Init}[oam.admin.username]     &{Init}[oam.admin.pass]
    Set Content Type	&{test_data}[common.json.contenttype]
    Set Base URL	&{Init}[oam.admin.server]
    Set Request Body	${reqbody}
    ${responseBody}     POST    &{test_data}[common.oauth.admin.client.rest.endpoint]
	${cl_id} =    KW_GET_CLIENTID_FROM_RESP    ${responseBody}
    ${cl_sec} =    KW_GET_SECRET_FROM_RESP    ${responseBody}
    LOG     ${responseBody}
    ${status}	Get Status
    ${actual}	Convert To String	${status}
    Should Be Equal     ${actual}   ${expected}
    [Return]    ${cl_id}    ${cl_sec}

3LFETCH OAuthIdentityDomain
    [Arguments]  ${idDomain}    ${baseURL}
	[Tags]      KW_IDENTITYDOMAIN
	[Documentation]     This is a keyword to get OAuthIdentityDomain
    Set Base URL	${baseURL}
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Query Param    name    ${idDomain}
	${responseBody}	  get    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	LOG TO CONSOLE      ${responseBody}
    LOG     ${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	Should Be Equal     ${actual}   200
    [Return]    ${status}

3LFETCH OAuthResourceServer
    [Arguments]  ${idDomain}    ${resServName}      ${baseURL}
	[Tags]      KW_RESOURCESERVER
	[Documentation]     This is a keyword to get OAuthResourceServer
    Set Base URL	${baseURL}
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Query Param    identityDomainName    ${idDomain}
	Set Query Param    name    ${resServName}
	${responseBody}	  get    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	LOG TO CONSOLE      ${responseBody}
    LOG     ${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	Should Be Equal     ${actual}   200
    [Return]    ${status}

3LLFETCH OAuthClient
    [Arguments]  ${idDomain}    ${clientName}       ${baseURL}
	[Tags]      KW_RESOURCESERVER
	[Documentation]     This is a keyword to get OAuthClient
    Set Base URL	${baseURL}
    Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
    Set Content Type	&{test_data}[test8.input.1]
	Set Query Param    identityDomainName    ${idDomain}
	Set Query Param    name    ${clientName}
	${responseBody}	  get    &{test_data}[common.oauth.admin.client.rest.endpoint]
	LOG TO CONSOLE      ${responseBody}
    LOG     ${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	Should Be Equal     ${actual}   200
    [Return]    ${status}

MDC3LOAUTH ADMIN IDENTITYDOMAIN CREATION
    [Arguments]  ${reqbody}   ${baseURL}    ${expected}
    [Tags]      KW_IDDOMAIN_CREATION
    [Documentation]		This Keyword creates Iddomain artifact
    @{MyList}=    Create List    ${reqbody}   ${baseURL}    ${expected}
    REMOVE VALUES FROM LIST     ${MyList}   ${reqbody}   ${baseURL}     ${expected}
    Set Base URL	${baseURL}
    Set Basic Auth	&{Init}[oam.admin.username]     &{Init}[oam.admin.pass]
    Set Content Type	&{test_data}[common.json.contenttype]
    Set Request Body	${reqbody}
    ${responseBody}     POST    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
    ${status}	Get Status
    ${actual}	Convert To String	${status}
    Should Be Equal     ${actual}   ${expected}


MDC3LOAUTH ADMIN RESOURCESERVER CREATION
    [Arguments]  ${reqbody}      ${baseURL}     ${expected}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${reqbody}   ${baseURL}        ${expected}
    REMOVE VALUES FROM LIST     ${MyList}   ${reqbody}   ${baseURL}     ${expected}
    Set Base URL    ${baseURL}
    Set Basic Auth	&{Init}[oam.admin.username]     &{Init}[oam.admin.pass]
    Set Content Type	&{test_data}[common.json.contenttype]
    Set Request Body	${reqbody}
    ${responseBody}     POST    &{test_data}[common.oauth.admin.resource.rest.endpoint]
    ${status}	Get Status
    ${actual}	Convert To String	${status}
    Should Be Equal     ${actual}   ${expected}


MDC3LOAUTH ADMIN CLIENT CREATION
    [Arguments]  ${reqbody}   ${baseURL}        ${expected}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${reqbody}   ${baseURL}        ${expected}
    REMOVE VALUES FROM LIST     ${MyList}   ${reqbody}   ${baseURL}     ${expected}
    Set Base URL    ${baseURL}
    Set Basic Auth	&{Init}[oam.admin.username]     &{Init}[oam.admin.pass]
    Set Content Type	&{test_data}[common.json.contenttype]
    Set Request Body	${reqbody}
    ${responseBody}     POST    &{test_data}[common.oauth.admin.client.rest.endpoint]
	${cl_id} =    KW_GET_CLIENTID_FROM_RESP    ${responseBody}
    ${cl_sec} =    KW_GET_SECRET_FROM_RESP    ${responseBody}
    LOG     ${responseBody}
    ${status}	Get Status
    ${actual}	Convert To String	${status}
    Should Be Equal     ${actual}   ${expected}
    [Return]    ${cl_id}    ${cl_sec}


PREQ_CREATE ADMIN ARTIFACTS REQUIRED FOR THREELEGGED CASES
    MODIFY OAM SESSION ATTRIBUTES      &{test_data}[oam.session.modify.maxusersessions]     &{Init}[oam.admin.server]       &{test_data}[http.status.201]
    sleep  60s

    ${3lid0}=   OAUTH MODIFY IDENTITYDOMAIN PARAMETERS   &{test_data}[tests3l0000.input.id.0]
    Run Keyword And Ignore Error    3LOAUTH ADMIN IDENTITYDOMAIN CREATION     ${3lid0}    &{test_data}[test01.expected.1]

    ${3lrs0}=   OAUTH MODIFY RESOURCESERVER PARAMETERS      &{test_data}[tests3l0000.input.resserv.0]
    Run Keyword And Ignore Error    3LOAUTH ADMIN RESOURCESERVER CREATION     ${3lrs0}    &{test_data}[test00050.expected.1]

    ${3lcl0}=       OAUTH MODIFY CLIENT REDIRECTURLS    &{test_data}[test3l0000.input.client.0]
    ${modified_3lcl0}=      OAUTH MODIFY CLIENT PARAMETERS      ${3lcl0}

    ${cl_id}     ${cl_sec}=        Run Keyword And Ignore Error     3LOAUTH ADMIN CLIENT CREATION      ${modified_3lcl0}    &{test_data}[test098.expected.1]

    LOG TO CONSOLE  ${\n}FINAL JSON INPUT USED TO CREATE ADMIN ARTIFACTS${\n}
    LOG TO CONSOLE  IDDOMAIN${\n}
    LOG TO CONSOLE  ${3lid0}${\n}

    LOG TO CONSOLE  RESOURCE SERVER${\n}
    LOG TO CONSOLE  ${3lrs0}${\n}

    LOG TO CONSOLE  CLIENT PROFILE${\n}
    LOG TO CONSOLE  ${modified_3lcl0}${\n}

MDCPREQ_CREATE ADMIN ARTIFACTS REQUIRED FOR THREELEGGED CASES
    MODIFY OAM SESSION ATTRIBUTES      &{test_data}[oam.session.modify.maxusersessions]     &{Init}[master.oam.admin.server]        &{test_data}[http.status.201]
    sleep  60s

    ${3lid0}=   OAUTH MODIFY IDENTITYDOMAIN PARAMETERS   &{test_data}[tests3l0000.input.id.0]
    Run Keyword And Ignore Error    MDC3LOAUTH ADMIN IDENTITYDOMAIN CREATION     ${3lid0}    &{Init}[master.oam.admin.server]       &{test_data}[test01.expected.1]

    ${3lrs0}=   OAUTH MODIFY RESOURCESERVER PARAMETERS      &{test_data}[tests3l0000.input.resserv.0]
    Run Keyword And Ignore Error    MDC3LOAUTH ADMIN RESOURCESERVER CREATION     ${3lrs0}    &{Init}[master.oam.admin.server]       &{test_data}[test00050.expected.1]

    ${3lcl0}=       OAUTH MODIFY CLIENT REDIRECTURLS    &{test_data}[test3l0000.input.client.0]
    ${modified_3lcl0}=      OAUTH MODIFY CLIENT PARAMETERS      ${3lcl0}

    ${cl_id}     ${cl_sec}=        Run Keyword And Ignore Error     MDC3LOAUTH ADMIN CLIENT CREATION      ${modified_3lcl0}    &{Init}[master.oam.admin.server]     &{test_data}[test098.expected.1]

    LOG TO CONSOLE  ${\n}FINAL JSON INPUT USED TO CREATE ADMIN ARTIFACTS FROM DC1${\n}
    LOG TO CONSOLE  IDDOMAIN${\n}
    LOG TO CONSOLE  ${3lid0}${\n}
    LOG TO CONSOLE  RESOURCE SERVER${\n}
    LOG TO CONSOLE  ${3lrs0}${\n}
    LOG TO CONSOLE  CLIENT PROFILE${\n}
    LOG TO CONSOLE  ${modified_3lcl0}${\n}

    LOG TO CONSOLE  ${\n}FINAL JSON INPUT USED TO CREATE ADMIN ARTIFACTS FROM DC1${\n}
    3LFETCH OAuthIdentityDomain     &{test_data}[3l.idDomain.name]      &{Init}[master.oam.admin.server]
    3LFETCH OAuthResourceServer     &{test_data}[3l.idDomain.name]      RServer0        &{Init}[master.oam.admin.server]
    3LLFETCH OAuthClient        &{test_data}[3l.idDomain.name]      &{test_data}[3l.client.name]        &{Init}[master.oam.admin.server]

    sleep  60s

    LOG TO CONSOLE  ${\n}FINAL JSON INPUT USED TO CREATE ADMIN ARTIFACTS FROM DC2${\n}
    3LFETCH OAuthIdentityDomain     &{test_data}[3l.idDomain.name]      &{Init}[clone1.oam.admin.server]
    3LFETCH OAuthResourceServer     &{test_data}[3l.idDomain.name]      RServer0        &{Init}[clone1.oam.admin.server]
    3LLFETCH OAuthClient        &{test_data}[3l.idDomain.name]      &{test_data}[3l.client.name]        &{Init}[clone1.oam.admin.server]

Cleanup
    Run Keyword If Test Failed  Close All Browsers

