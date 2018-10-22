*** Settings ***
Documentation  OAM OAuth TestSuite
Library		com.oracle.test.robot.rest.RestLibrary
Library		com.oracle.test.robot.rest.JSONLibrary	WITH NAME	jl
Library		com.oracle.test.robot.common.SystemLibrary
Library		com.oracle.test.robot.common.SSOLinking
Library		Selenium2Library
Library		String
Library		com.oracle.test.robot.common.LogLibrary
Library		com.oracle.test.robot.common.LogCompareLibrary
Library     Process
#Test Setup    DeleteAllActiveSessions
Resource    ../../../../../resources/keywords/idm/oam/common/ui_keywords.robot
Resource	../../../../../resources/keywords/common/init.robot
Resource    ../../../../../resources/keywords/idm/oam/oauth/oam_oauth_common.robot

Suite Setup	Setup Env
#Test Teardown  Cleanup

*** Variables ***
${authnscheme_endpoint}=    /oam/services/rest/11.1.2.0.0/ssa/policyadmin/authnscheme
${WGARTIFACTS}=     /net/slc06xgk.us.oracle.com/scratch/kgurupra/rreg/output/SSOLinkWG
${OAMRREG_BIN}=		/net/slc06xgk.us.oracle.com/scratch/kgurupra/rreg/bin/oamreg.sh
${waittime}=    0s

*** Keywords ***
Setup Env
	Initialize Settings
    Initialize Test Data	 idm/oam/oauth/oam_oauth_policyadmin_testsuite.properties
	Initialize oamconsole xpaths    oamconsole.properties
    CREATE WEBGATE ARTIFACTS
    DELETE INITIAL USERSESSIONS
	MODIFY COMMON SETTINGS  &{test_data}[common.settings.0.sessionlifetime]     &{test_data}[common.settings.0.idlesession]     &{test_data}[common.settings.0.maxsession]
	Set Base URL	&{Init}[oam.runtime.baseurl]

OAUTH FETCH USERASSERTION TOKEN FROM COOKIE
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${resource_url}    ${oam.admin.username}  ${oam.admin.pass}     ${waittime}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${resource_url}    ${oam.admin.username}  ${oam.admin.pass}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${resource_url}    ${oam.admin.username}  ${oam.admin.pass}
    Set Test Variable	${testName}    ${logfile_name}
	SSO Resource Login    ${resource_url}    ${oam.admin.username}  ${oam.admin.pass}
	${oauth_token}  Get Cookie Value     OAUTH_TOKEN
	SLEEP   ${waittime}
	LOG     ${oauth_token}
	Log To Console  ${oauth_token}${\n}
	Close All Browsers
	[Return]  ${oauth_token}

OAUTH FETCH USERASSERTION TOKEN FROM HEADER
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${resource_url}    ${oam.admin.username}  ${oam.admin.pass}     ${waittime}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${resource_url}    ${oam.admin.username}  ${oam.admin.pass}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${resource_url}    ${oam.admin.username}  ${oam.admin.pass}
    Set Test Variable	${testName}    ${logfile_name}
    SSO Resource Login		${resource_appurl}    ${oam.admin.username}  ${oam.admin.pass}
    WAIT UNTIL ELEMENT IS VISIBLE         &{oamconsole}[oauth.client.respource.appurl.header.oauthtoken]        10s
    ${oauth_token}=     GET TEXT     &{oamconsole}[oauth.client.respource.appurl.header.oauthtoken]
#    ${oauth_token}  Get Cookie Value     OAUTH_TOKEN
    SLEEP   ${waittime}
    LOG     ${oauth_token}
    Log To Console  ${oauth_token}${\n}
    Close All Browsers
    [Return]  ${oauth_token}

OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${requestHeader}    ${url}  ${clientid}     ${clientsecret}     ${contentType}   ${userassertiontoken}  ${redirecturi}  ${scope}    ${endpoint}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${requestHeader}    ${url}  ${clientid}     ${clientsecret}     ${contentType}   ${userassertiontoken}  ${redirecturi}  ${scope}    ${endpoint}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${requestHeader}    ${url}  ${clientid}     ${clientsecret}     ${contentType}   ${userassertiontoken}  ${redirecturi}  ${scope}    ${endpoint}
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
	Response OK
	${cc1_at}    Get String    ${responseBody}    access_token
	Should Not Be Empty    ${cc1_at}
	LOG TO CONSOLE   ${cc1_at}
    [Return]  ${cc1_at}

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

ACCESS TOKEN VALIDATION FLOW
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${requestHeader}    ${queryParamAccesstoken}   ${endpoint}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${requestHeader}    ${queryParamAccesstoken}   ${endpoint}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${requestHeader}    ${queryParamAccesstoken}   ${endpoint}
    Set Test Variable	${testName}    ${logfile_name}
    Create Logger	${testName}
    Set Base URL    ${url}
    Set Request Header	X-OAUTH-IDENTITY-DOMAIN-NAME    ${requestHeader}
    Set Query Param    access_token    ${queryParamAccesstoken}
    ${responseBody}	get	${endpoint}
    Write To Log	${responseBody}
    LOG TO CONSOLE  OUTPUT
    LOG TO CONSOLE  ${responseBody}
    Response OK
	${r_cl}    Get String    ${responseBody}    client
	${r_user}    Get String    ${responseBody}    sub
	Should Not Be Empty    ${r_cl}
	Should Not Be Empty    ${r_user}
	[Return]  ${responseBody}

CREATE WEBGATE ARTIFACTS
    #create AuthN Scheme which is required for SSO Linking, hence, responsetype is cookie based, Down the testcases, response_type would be changed to header by passing createFlag=FALSE
    CREATEAUTHNSCHEME       &{Init}[oam.admin.server]${authnscheme_endpoint}    &{Init}[oam.admin.username]     &{Init}[oam.admin.pass]     cookie      ${True}
    ${webgateprofile}=      CREATEWEBGATEPROFILE    &{Init}[oam.admin.server]
    EXECUTERREG		${OAMRREG_BIN}		${webgateProfile}
    COPYWGARTIFACTS     ${WGARTIFACTS}      /net/slc06pvb/${RESOURCE_WG_DIR}
    executeOHSShutdown		${OHS_INSTANCE_BIN_STOP}	${OHS_COMPONENT_NAME}
    executeOHSStart		${OHS_INSTANCE_BIN_START}	${OHS_COMPONENT_NAME}

DELETE INITIAL USERSESSIONS
    SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	Click Delete All User Sessions    &{Init}[oam.admin.username]
	Sleep    5s
	Close All Browsers

SET APP DOMAIN TIMEOUT FOR WEBGATE_ID
	[Arguments]    ${appdomaintimeout}
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	Goto Application Domain Page    &{Init}[resource_appdomain]
	Set App domain Timeout    ${appdomaintimeout}       &{Init}[resource_appdomain]
	sleep    15s
	OAMConsole Logout


MODIFY COMMON SETTINGS
    [Arguments]  ${sessionlifetime}    ${idlesession}  ${maxsession}
    SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
    Goto Common Settings Page
    Set Session Lifetime   ${sessionlifetime}
    Set Idle Timeout     ${idlesession}
	Set Number of sessions per user    ${maxsession}
    OAMConsole Logout

DeleteAllActiveSessions
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	Click Delete All User Sessions    &{Init}[oam.admin.username]
	Close All Browsers

*** Test Cases ***
oauth.admin00001:: OAM Admin OAuth::IdentityDomain Creation
    OAUTH ADMIN IDENTITYDOMAIN CREATION     &{test_data}[test01.tags]       &{test_data}[test01.doc]        &{test_data}[test01.logfile.name]   sample      &{Init}[oam.admin.server]   &{Init}[oam.admin.username]     &{Init}[oam.admin.pass]       &{test_data}[common.json.contenttype]    &{test_data}[testssolinking0000.input.id.0]    &{test_data}[test01.expected.1]     &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

oauth0005:: OAM Admin OAuth::ResourceServer Creation JSON
    OAUTH ADMIN RESOURCESERVER CREATION     &{test_data}[test00050.tags]       &{test_data}[test00050.doc]        &{test_data}[test00050.logfile.name]   sample      &{Init}[oam.admin.server]     &{Init}[oam.admin.username]     &{Init}[oam.admin.pass]       &{test_data}[common.json.contenttype]    &{test_data}[testssolinking0000.input.resserv.0]    &{test_data}[test00050.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]

oauth.admin0098:: OAM Admin OAuth::OAuthClient Creation JSON
    OAUTH ADMIN CLIENT CREATION     &{test_data}[test098.tags]       &{test_data}[test098.doc]        &{test_data}[test098.logfile.name]   sample      &{Init}[oam.admin.server]    &{Init}[oam.admin.username]     &{Init}[oam.admin.pass]       &{test_data}[common.json.contenttype]    &{test_data}[testssolinking0000.input.client.0]    &{test_data}[test098.expected.1]     &{test_data}[common.oauth.admin.client.rest.endpoint]

##############################SSOLINKING FOR COOKIE STARTS FETCH FROM HERE####################################

runtime.oauth000000:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER
    #HERE SPECIFY WAITTIME AFTER FETCHING USER_ASSERTION_TOKEN
    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM COOKIE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     ${waittime}
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   ${oauthtoken}      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}

    ${response}=        ACCESS TOKEN VALIDATION FLOW    &{test_data}[test100.tags]      &{test_data}[test103.doc]       &{test_data}[test103.logfile.name]      sample      &{Init}[oam.runtime.baseurl]     ssolinkid00       ${accesstoken}       &{test_data}[common.oauth.runtime.token.endpoint]/info
#    LOG TO CONSOLE  RESPONSE    ${response}${\n}

##################TESTCASES PERTAINING TO idletime value#########################
##################TESTCASE1 - WITHIN IDLETIME OUT +VE
runtime.oauth000001:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER
    #MODIFY COMMON SETTINGS ONLY ONCE FOR THE ENTIRE CATEGORY
    MODIFY COMMON SETTINGS  &{test_data}[common.settings.1.sessionlifetime]     &{test_data}[common.settings.1.idlesession]     &{test_data}[common.settings.1.maxsession]

    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM COOKIE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     ${waittime}
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   ${oauthtoken}      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}

    ${response}=        ACCESS TOKEN VALIDATION FLOW    &{test_data}[test100.tags]      &{test_data}[test103.doc]       &{test_data}[test103.logfile.name]      sample      &{Init}[oam.runtime.baseurl]     ssolinkid00       ${accesstoken}       &{test_data}[common.oauth.runtime.token.endpoint]/info
#    LOG TO CONSOLE  RESPONSE    ${response}${\n}

##################TESTCASE2 - AFTER IDLETIME OUT +VE
runtime.oauth000002:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER:: FAILURE1
    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM COOKIE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     180s
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN NEGATIVE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   ${oauthtoken}      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]   &{test_data}[testssolinking0000.input.errorCode.0]      &{test_data}[testssolinking0000.input.errorCode.0.Desc]     &{test_data}[testssolinking0000.input.secErrorDesc.0.Desc]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}

##################TESTCASE4 - DELETE VALID SESSION FROM TESTCASE1
runtime.oauth000003:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER:: FAILURE2
    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM COOKIE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     ${waittime}
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    #DELETE the CREATED VALID SESSION FROM THE PREVIOUS STEP
    DeleteAllActiveSessions

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN NEGATIVE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   ${oauthtoken}      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]   &{test_data}[testssolinking0000.input.errorCode.0]      &{test_data}[testssolinking0000.input.errorCode.0.Desc]     &{test_data}[testssolinking0000.input.secErrorDesc.0.Desc]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}

#TESTCASE5 - DELETE INVALID SESSION FROM TESTCASE2
#TESTCASE3 - EQUALTO IDLETIME OUT +VE - not a valid testcase
#TESTCASE6 - DELETE SESSION FROM TESTCASE3 - not a valid testcase

###################TESTCASES PERTAINING TO sessiontimeout value#########################
##################TESTCASE1 - WITHIN SESSIONLIFETIMEOUT +VE
runtime.oauth000004:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER
    #MODIFY COMMON SETTINGS ONLY ONCE FOR THE ENTIRE CATEGORY
    MODIFY COMMON SETTINGS  &{test_data}[common.settings.0.sessionlifetime]     &{test_data}[common.settings.0.idlesession]     &{test_data}[common.settings.0.maxsession]

    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM COOKIE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     ${waittime}
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   ${oauthtoken}      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}

    ${response}=        ACCESS TOKEN VALIDATION FLOW    &{test_data}[test100.tags]      &{test_data}[test103.doc]       &{test_data}[test103.logfile.name]      sample      &{Init}[oam.runtime.baseurl]     ssolinkid00       ${accesstoken}       &{test_data}[common.oauth.runtime.token.endpoint]/info
#    LOG TO CONSOLE  RESPONSE    ${response}${\n}

##################TESTCASE2 - AFTER SESSIONLIFETIMEOUT OUT +VE
runtime.oauth000005:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER:: FAILURE1
    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM COOKIE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     180s
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN NEGATIVE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   ${oauthtoken}      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]   &{test_data}[testssolinking0000.input.errorCode.0]      &{test_data}[testssolinking0000.input.errorCode.0.Desc]     &{test_data}[testssolinking0000.input.secErrorDesc.0.Desc]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}

##################TESTCASE4 - DELETE VALID SESSION FROM TESTCASE1
runtime.oauth000006:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER:: FAILURE2
    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM COOKIE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     ${waittime}
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    #DELETE the CREATED VALID SESSION FROM THE PREVIOUS STEP
    DeleteAllActiveSessions

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN NEGATIVE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   ${oauthtoken}      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]   &{test_data}[testssolinking0000.input.errorCode.0]      &{test_data}[testssolinking0000.input.errorCode.0.Desc]     &{test_data}[testssolinking0000.input.secErrorDesc.0.Desc]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}

#TESTCASE5 - DELETE INVALID SESSION FROM TESTCASE2
#TESTCASE3 - EQUALTO SESSIONTIMEOUT OUT +VE - NOT A VALID TESTCASE
#TESTCASE6 - DELETE SESSION FROM TESTCASE3

###################TESTCASES PERTAINING TO maxsession value#########################
##################TESTCASE1 - WITHIN MAXSESSION +VE
runtime.oauth000007:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER
    #MODIFY COMMON SETTINGS ONLY ONCE FOR THE ENTIRE CATEGORY
    MODIFY COMMON SETTINGS  &{test_data}[common.settings.2.sessionlifetime]     &{test_data}[common.settings.2.idlesession]     &{test_data}[common.settings.2.maxsession]

    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM COOKIE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     ${waittime}
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   ${oauthtoken}      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}

    ${response}=        ACCESS TOKEN VALIDATION FLOW    &{test_data}[test100.tags]      &{test_data}[test103.doc]       &{test_data}[test103.logfile.name]      sample      &{Init}[oam.runtime.baseurl]     ssolinkid00       ${accesstoken}       &{test_data}[common.oauth.runtime.token.endpoint]/info
#    LOG TO CONSOLE  RESPONSE    ${response}${\n}

##################TESTCASE2 - AFTER MAXSESSION +VE
runtime.oauth000008:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER
    DeleteAllActiveSessions
	:FOR    ${INDEX}    IN RANGE    1    3
	\        ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM COOKIE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     ${waittime}
    SSO Resource Login    &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
   	SLEEP   20s
    Wait Until Page Contains    System error
    Page Should Contain    System error
    Close All Browsers
    SLEEP   260s
    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM COOKIE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     ${waittime}
#    MODIFY COMMON SETTINGS  &{test_data}[common.settings.2.sessionlifetime]     &{test_data}[common.settings.2.idlesession]     &{test_data}[common.settings.2.maxsession]
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

##################TESTCASE4 - DELETE VALID SESSION FROM TESTCASE1
runtime.oauth000009:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER:: FAILURE2
    DeleteAllActiveSessions
    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM COOKIE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     ${waittime}
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    #DELETE the CREATED VALID SESSION FROM THE PREVIOUS STEP
    DeleteAllActiveSessions

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN NEGATIVE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   ${oauthtoken}      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]   &{test_data}[testssolinking0000.input.errorCode.0]      &{test_data}[testssolinking0000.input.errorCode.0.Desc]     &{test_data}[testssolinking0000.input.secErrorDesc.0.Desc]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}
    MODIFY COMMON SETTINGS  &{test_data}[common.settings.00.sessionlifetime]     &{test_data}[common.settings.00.maxsession]     &{test_data}[common.settings.00.idlesession]

#TESTCASE3 - EQUALTO MAXSESSION +VE
#TESTCASE5 - DELETE SESSION FROM TESTCASE3
##################TESTCASES PERTAINING TO APPDOMAIN TIMEOUT#########################
##################SET1TESTCASE1 - AFTER SESSIONLIFETIME BEFORE APPDOMAINTIMEOUT
runtime.oauth000010:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER
    #MODIFY COMMON SETTINGS ONLY ONCE FOR THE ENTIRE CATEGORY
    MODIFY COMMON SETTINGS  &{test_data}[common.settings.3.sessionlifetime]     &{test_data}[common.settings.3.idlesession]     &{test_data}[common.settings.3.maxsession]

    SET APP DOMAIN TIMEOUT FOR WEBGATE_ID       &{test_data}[common.settings.3.appdomaintimeout]

    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM COOKIE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     180s
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   ${oauthtoken}      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}

    ${response}=        ACCESS TOKEN VALIDATION FLOW    &{test_data}[test100.tags]      &{test_data}[test103.doc]       &{test_data}[test103.logfile.name]      sample      &{Init}[oam.runtime.baseurl]     ssolinkid00       ${accesstoken}       &{test_data}[common.oauth.runtime.token.endpoint]/info
    LOG TO CONSOLE  RESPONSE    ${response}${\n}

#################SET1TESTCASE2 - AFTER SESSIONLIFETIME AFTER APPDOMAINTIMEOUT
runtime.oauth000011:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER:: Failure1
    #MODIFY COMMON SETTINGS ONLY ONCE FOR THE ENTIRE CATEGORY
    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM COOKIE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     300s
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN NEGATIVE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   ${oauthtoken}      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]   &{test_data}[testssolinking0000.input.errorCode.0]      &{test_data}[testssolinking0000.input.errorCode.0.Desc]     &{test_data}[testssolinking0000.input.secErrorDesc.0.Desc]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}

##################SET2TESTCASE1 - AFTER SESSIONLIFETIME AFTER APPDOMAINTIMEOUT VALIDCASE
runtime.oauth000012:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER
    #MODIFY COMMON SETTINGS ONLY ONCE FOR THE ENTIRE CATEGORY
    MODIFY COMMON SETTINGS  &{test_data}[common.settings.4.sessionlifetime]     &{test_data}[common.settings.4.idlesession]     &{test_data}[common.settings.4.maxsession]

    SET APP DOMAIN TIMEOUT FOR WEBGATE_ID       &{test_data}[common.settings.4.appdomaintimeout]

    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM COOKIE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     180s
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   ${oauthtoken}      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}

    ${response}=        ACCESS TOKEN VALIDATION FLOW    &{test_data}[test100.tags]      &{test_data}[test103.doc]       &{test_data}[test103.logfile.name]      sample      &{Init}[oam.runtime.baseurl]     ssolinkid00       ${accesstoken}       &{test_data}[common.oauth.runtime.token.endpoint]/info
#    LOG TO CONSOLE  RESPONSE    ${response}${\n}

##################SET2TESTCASE2 - AFTER SESSIONLIFETIME AFTER APPDOMAINTIMEOUT
runtime.oauth000013:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER:: Failure1
    #MODIFY COMMON SETTINGS ONLY ONCE FOR THE ENTIRE CATEGORY
    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM COOKIE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     300s
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN NEGATIVE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   ${oauthtoken}      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]   &{test_data}[testssolinking0000.input.errorCode.0]      &{test_data}[testssolinking0000.input.errorCode.0.Desc]     &{test_data}[testssolinking0000.input.secErrorDesc.0.Desc]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}


runtime.oauth000014:: OAM Runtime OAuth::INVALID ACCESSTOKEN granttype=JWT_BEARER:: Failure
    #MODIFY COMMON SETTINGS ONLY ONCE FOR THE ENTIRE CATEGORY
#    ${oauthtoken}=
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN NEGATIVE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   &{test_data}[test.runtime.0001.invalid.accesstoken]      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]   &{test_data}[testssolinking0000.input.errorCode.1]      &{test_data}[testssolinking0000.input.errorCode.1.Desc]     &{test_data}[testssolinking0000.input.secErrorDesc.1.Desc]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}

#USE IT FOR LATER
#sample
#    ${oauth_token}=     OAUTH FETCH USERASSERTION TOKEN FROM HEADER     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     0s
#    LOG TO CONSOLE      ${oauth_token}
##############Change AUTHNSCHEME TO CONTAIN cookie instead of header
PRE_REQUISITE MODIFY RESPONSE_TYPE TO HEADER ON AUTHNSCHEME
    CREATEAUTHNSCHEME       &{Init}[oam.admin.server]${authnscheme_endpoint}    &{Init}[oam.admin.username]     &{Init}[oam.admin.pass]     header      ${False}
	executeOHSShutdown		${OHS_INSTANCE_BIN_STOP}	${OHS_COMPONENT_NAME}
	executeOHSStart		${OHS_INSTANCE_BIN_START}	${OHS_COMPONENT_NAME}

#########################SSOLINKING FOR HEADER STARTS FETCH FROM LEFT HERE######################################
header.runtime.oauth000000:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER
    #HERE SPECIFY WAITTIME AFTER FETCHING USER_ASSERTION_TOKEN
    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM HEADER     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     ${waittime}
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   ${oauthtoken}      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}

    ${response}=        ACCESS TOKEN VALIDATION FLOW    &{test_data}[test100.tags]      &{test_data}[test103.doc]       &{test_data}[test103.logfile.name]      sample      &{Init}[oam.runtime.baseurl]     ssolinkid00       ${accesstoken}       &{test_data}[common.oauth.runtime.token.endpoint]/info
#    LOG TO CONSOLE  RESPONSE    ${response}${\n}

##################TESTCASES PERTAINING TO idletime value#########################
##################TESTCASE1 - WITHIN IDLETIME OUT +VE
header.runtime.oauth000001:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER
    #MODIFY COMMON SETTINGS ONLY ONCE FOR THE ENTIRE CATEGORY
    MODIFY COMMON SETTINGS  &{test_data}[common.settings.1.sessionlifetime]     &{test_data}[common.settings.1.idlesession]     &{test_data}[common.settings.1.maxsession]

    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM HEADER     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     ${waittime}
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   ${oauthtoken}      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}

    ${response}=        ACCESS TOKEN VALIDATION FLOW    &{test_data}[test100.tags]      &{test_data}[test103.doc]       &{test_data}[test103.logfile.name]      sample      &{Init}[oam.runtime.baseurl]     ssolinkid00       ${accesstoken}       &{test_data}[common.oauth.runtime.token.endpoint]/info
#    LOG TO CONSOLE  RESPONSE    ${response}${\n}

##################TESTCASE2 - AFTER IDLETIME OUT +VE
runtime.oauth000002:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER:: FAILURE1
    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM HEADER     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     180s
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN NEGATIVE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   ${oauthtoken}      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]   &{test_data}[testssolinking0000.input.errorCode.0]      &{test_data}[testssolinking0000.input.errorCode.0.Desc]     &{test_data}[testssolinking0000.input.secErrorDesc.0.Desc]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}

##################TESTCASE4 - DELETE VALID SESSION FROM TESTCASE1
header.runtime.oauth000003:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER:: FAILURE2
    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM HEADER     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     ${waittime}
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    #DELETE the CREATED VALID SESSION FROM THE PREVIOUS STEP
    DeleteAllActiveSessions

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN NEGATIVE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   ${oauthtoken}      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]   &{test_data}[testssolinking0000.input.errorCode.0]      &{test_data}[testssolinking0000.input.errorCode.0.Desc]     &{test_data}[testssolinking0000.input.secErrorDesc.0.Desc]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}

#TESTCASE5 - DELETE INVALID SESSION FROM TESTCASE2
#TESTCASE3 - EQUALTO IDLETIME OUT +VE - not a valid testcase
#TESTCASE6 - DELETE SESSION FROM TESTCASE3 - not a valid testcase

###################TESTCASES PERTAINING TO sessiontimeout value#########################
##################TESTCASE1 - WITHIN SESSIONLIFETIMEOUT +VE
header.runtime.oauth000004:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER
    #MODIFY COMMON SETTINGS ONLY ONCE FOR THE ENTIRE CATEGORY
    MODIFY COMMON SETTINGS  &{test_data}[common.settings.0.sessionlifetime]     &{test_data}[common.settings.0.idlesession]     &{test_data}[common.settings.0.maxsession]

    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM HEADER     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     ${waittime}
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   ${oauthtoken}      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}

    ${response}=        ACCESS TOKEN VALIDATION FLOW    &{test_data}[test100.tags]      &{test_data}[test103.doc]       &{test_data}[test103.logfile.name]      sample      &{Init}[oam.runtime.baseurl]     ssolinkid00       ${accesstoken}       &{test_data}[common.oauth.runtime.token.endpoint]/info
#    LOG TO CONSOLE  RESPONSE    ${response}${\n}

##################TESTCASE2 - AFTER SESSIONLIFETIMEOUT OUT +VE
header.runtime.oauth000005:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER:: FAILURE1
    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM HEADER     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     180s
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN NEGATIVE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   ${oauthtoken}      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]   &{test_data}[testssolinking0000.input.errorCode.0]      &{test_data}[testssolinking0000.input.errorCode.0.Desc]     &{test_data}[testssolinking0000.input.secErrorDesc.0.Desc]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}

##################TESTCASE4 - DELETE VALID SESSION FROM TESTCASE1
header.runtime.oauth000006:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER:: FAILURE2
    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM HEADER     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     ${waittime}
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    #DELETE the CREATED VALID SESSION FROM THE PREVIOUS STEP
    DeleteAllActiveSessions

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN NEGATIVE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   ${oauthtoken}      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]   &{test_data}[testssolinking0000.input.errorCode.0]      &{test_data}[testssolinking0000.input.errorCode.0.Desc]     &{test_data}[testssolinking0000.input.secErrorDesc.0.Desc]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}

#TESTCASE5 - DELETE INVALID SESSION FROM TESTCASE2
#TESTCASE3 - EQUALTO SESSIONTIMEOUT OUT +VE - NOT A VALID TESTCASE
#TESTCASE6 - DELETE SESSION FROM TESTCASE3

###################TESTCASES PERTAINING TO maxsession value#########################
##################TESTCASE1 - WITHIN MAXSESSION +VE
header.runtime.oauth000007:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER
    #MODIFY COMMON SETTINGS ONLY ONCE FOR THE ENTIRE CATEGORY
    MODIFY COMMON SETTINGS  &{test_data}[common.settings.2.sessionlifetime]     &{test_data}[common.settings.2.idlesession]     &{test_data}[common.settings.2.maxsession]

    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM HEADER     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     ${waittime}
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   ${oauthtoken}      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}

    ${response}=        ACCESS TOKEN VALIDATION FLOW    &{test_data}[test100.tags]      &{test_data}[test103.doc]       &{test_data}[test103.logfile.name]      sample      &{Init}[oam.runtime.baseurl]     ssolinkid00       ${accesstoken}       &{test_data}[common.oauth.runtime.token.endpoint]/info
#    LOG TO CONSOLE  RESPONSE    ${response}${\n}

##################TESTCASE2 - AFTER MAXSESSION +VE
header.runtime.oauth000008:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER
    DeleteAllActiveSessions
	:FOR    ${INDEX}    IN RANGE    1    3
	\        ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM HEADER     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     ${waittime}
    SSO Resource Login    &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
   	SLEEP   20s
    Wait Until Page Contains    System error
    Page Should Contain    System error
    Close All Browsers
    SLEEP   260s
    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM HEADER     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     ${waittime}
#    MODIFY COMMON SETTINGS  &{test_data}[common.settings.2.sessionlifetime]     &{test_data}[common.settings.2.idlesession]     &{test_data}[common.settings.2.maxsession]
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

##################TESTCASE4 - DELETE VALID SESSION FROM TESTCASE1
header.runtime.oauth000009:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER:: FAILURE2
    DeleteAllActiveSessions
    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM HEADER     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     ${waittime}
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    #DELETE the CREATED VALID SESSION FROM THE PREVIOUS STEP
    DeleteAllActiveSessions

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN NEGATIVE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   ${oauthtoken}      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]   &{test_data}[testssolinking0000.input.errorCode.0]      &{test_data}[testssolinking0000.input.errorCode.0.Desc]     &{test_data}[testssolinking0000.input.secErrorDesc.0.Desc]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}
    MODIFY COMMON SETTINGS  &{test_data}[common.settings.00.sessionlifetime]     &{test_data}[common.settings.00.maxsession]     &{test_data}[common.settings.00.idlesession]

#TESTCASE3 - EQUALTO MAXSESSION +VE
#TESTCASE5 - DELETE SESSION FROM TESTCASE3
##################TESTCASES PERTAINING TO APPDOMAIN TIMEOUT#########################
##################SET1TESTCASE1 - AFTER SESSIONLIFETIME BEFORE APPDOMAINTIMEOUT
header.runtime.oauth000010:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER
    #MODIFY COMMON SETTINGS ONLY ONCE FOR THE ENTIRE CATEGORY
    MODIFY COMMON SETTINGS  &{test_data}[common.settings.3.sessionlifetime]     &{test_data}[common.settings.3.idlesession]     &{test_data}[common.settings.3.maxsession]

    SET APP DOMAIN TIMEOUT FOR WEBGATE_ID       &{test_data}[common.settings.3.appdomaintimeout]

    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM HEADER     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     180s
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   ${oauthtoken}      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}

    ${response}=        ACCESS TOKEN VALIDATION FLOW    &{test_data}[test100.tags]      &{test_data}[test103.doc]       &{test_data}[test103.logfile.name]      sample      &{Init}[oam.runtime.baseurl]     ssolinkid00       ${accesstoken}       &{test_data}[common.oauth.runtime.token.endpoint]/info
    LOG TO CONSOLE  RESPONSE    ${response}${\n}

#################SET1TESTCASE2 - AFTER SESSIONLIFETIME AFTER APPDOMAINTIMEOUT
header.runtime.oauth000011:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER:: Failure1
    #MODIFY COMMON SETTINGS ONLY ONCE FOR THE ENTIRE CATEGORY
    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM HEADER     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     300s
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN NEGATIVE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   ${oauthtoken}      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]   &{test_data}[testssolinking0000.input.errorCode.0]      &{test_data}[testssolinking0000.input.errorCode.0.Desc]     &{test_data}[testssolinking0000.input.secErrorDesc.0.Desc]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}

##################SET2TESTCASE1 - AFTER SESSIONLIFETIME AFTER APPDOMAINTIMEOUT VALIDCASE
header.runtime.oauth000012:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER
    #MODIFY COMMON SETTINGS ONLY ONCE FOR THE ENTIRE CATEGORY
    MODIFY COMMON SETTINGS  &{test_data}[common.settings.4.sessionlifetime]     &{test_data}[common.settings.4.idlesession]     &{test_data}[common.settings.4.maxsession]

    SET APP DOMAIN TIMEOUT FOR WEBGATE_ID       &{test_data}[common.settings.4.appdomaintimeout]

    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM HEADER     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     180s
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   ${oauthtoken}      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}

    ${response}=        ACCESS TOKEN VALIDATION FLOW    &{test_data}[test100.tags]      &{test_data}[test103.doc]       &{test_data}[test103.logfile.name]      sample      &{Init}[oam.runtime.baseurl]     ssolinkid00       ${accesstoken}       &{test_data}[common.oauth.runtime.token.endpoint]/info
#    LOG TO CONSOLE  RESPONSE    ${response}${\n}

##################SET2TESTCASE2 - AFTER SESSIONLIFETIME AFTER APPDOMAINTIMEOUT
header.runtime.oauth000013:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER:: Failure1
    #MODIFY COMMON SETTINGS ONLY ONCE FOR THE ENTIRE CATEGORY
    ${oauthtoken}=      OAUTH FETCH USERASSERTION TOKEN FROM HEADER     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      &{Init}[resource_url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]     300s
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN NEGATIVE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   ${oauthtoken}      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]   &{test_data}[testssolinking0000.input.errorCode.0]      &{test_data}[testssolinking0000.input.errorCode.0.Desc]     &{test_data}[testssolinking0000.input.secErrorDesc.0.Desc]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}


header.runtime.oauth000014:: OAM Runtime OAuth::INVALID ACCESSTOKEN granttype=JWT_BEARER:: Failure
    #MODIFY COMMON SETTINGS ONLY ONCE FOR THE ENTIRE CATEGORY
#    ${oauthtoken}=
#    LOG TO CONSOLE  OAUTH_TOKEN     ${oauthtoken}${\n}

    ${accesstoken}=     OAUTHRUNTIME JWT_BEARER GET ACCESSTOKEN NEGATIVE     &{test_data}[test8.tags]    &{test_data}[test8.doc]     &{test_data}[test.runtime.00004.logfile.name]   sample      ssolinkid00     &{Init}[oam.runtime.baseurl]    ${ssocl_id}     ${ssocl_sec}    &{test_data}[test109.input.1]   &{test_data}[test.runtime.0001.invalid.accesstoken]      http://google.com       ssolinkResServ0.robot1      &{test_data}[common.oauth.runtime.token.endpoint]   &{test_data}[testssolinking0000.input.errorCode.1]      &{test_data}[testssolinking0000.input.errorCode.1.Desc]     &{test_data}[testssolinking0000.input.secErrorDesc.1.Desc]
#    LOG TO CONSOLE  ACCESSTOKEN     ${accesstoken}${\n}

#########################SSOLINKING FOR HEADER ENDS FETCH FROM LEFT HERE######################################

oauth.admin0133:: OAM Admin OAuth::OAuthClient Deletion
    OAUTH ADMIN RESOURCESERVER CLIENTPROFILE DELETE OPERATION     &{test_data}[test0133.tags]       &{test_data}[test0133.doc]        &{test_data}[test0133.logfile.name]   sample      &{Init}[oam.admin.server]     &{Init}[oam.admin.username]     &{Init}[oam.admin.pass]       &{test_data}[test0133.input.1]     ssolinkid00     ssoclient00   &{test_data}[test0133.expected.1]    &{test_data}[common.oauth.admin.client.rest.endpoint]

oauth0008:: OAM Admin OAuth::ResourceServer Deletion
    OAUTH ADMIN RESOURCESERVER CLIENTPROFILE DELETE OPERATION     &{test_data}[test085.tags]       &{test_data}[test085.doc]        &{test_data}[test085.logfile.name]   sample      &{Init}[oam.admin.server]     &{Init}[oam.admin.username]     &{Init}[oam.admin.pass]       &{test_data}[test085.input.1]     ssolinkid00     ssolinkResServ0   &{test_data}[test085.expected.1]    &{test_data}[common.oauth.admin.resource.rest.endpoint]

oauth.admin0037:: OAM Admin OAuth::OAuthIdentityDomain Deletion
    OAUTH ADMIN IDENTITYDOMAIN DELETE OPERATION     &{test_data}[test037.tags]       &{test_data}[test037.doc]        &{test_data}[test037.logfile.name]   sample      &{Init}[oam.admin.server]     &{Init}[oam.admin.username]     &{Init}[oam.admin.pass]       &{test_data}[test037.input.1]     ssolinkid00   &{test_data}[test037.expected.1]    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]