*** Settings ***
Documentation  OAM OAuth TestSuite
Library		com.oracle.test.robot.rest.RestLibrary
Library		com.oracle.test.robot.rest.JSONLibrary	WITH NAME	jl
Library		com.oracle.test.robot.common.SystemLibrary
#Library		Selenium2Library		WITH NAME		sl
Library		String
Library		OperatingSystem
Library		com.oracle.test.robot.common.LogLibrary
Library		com.oracle.test.robot.common.LogCompareLibrary
Library		com.oracle.test.robot.common.URLEncoder

Resource    ../../../../../resources/keywords/idm/oam/oauth/oam_oauth_common.robot

Suite Setup	Setup Env
Test Teardown	Remove Log locks

*** Keywords ***
Setup Env
	Initialize Settings
    Initialize Test Data	 idm/oam/oauth/oam_oauth_policyadmin_testsuite.properties
    Set Base URL	&{Init}[master.oam.admin.server]
    Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]


*** Test Cases ***
runtime.oauth0001:: OAM Admin OAuth::IdentityDomain Creation:: Success
	[Tags]  	&{test_data}[test6.tags]
	[Documentation]		&{test_data}[test6.doc]
	Set Test Variable	${testName}    &{test_data}[test6.logfile.name]
	Create Logger	${testName}
	Set Base URL	&{Init}[master.oam.admin.server]
	Set Content Type	&{test_data}[test6.input.1]
	Set Request Body	&{test_data}[test6.input.2]
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	${responseBody}	post	&{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test6.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

runtime.oauth0002:: OAM Admin OAuth::OAuthIdentityDomain Get:: Success
	[Tags]	    &{test_data}[test10.tags]
	[Documentation]		&{test_data}[test10.doc]
	Set Test Variable	${testName}    &{test_data}[test10.logfile.name]
	Create Logger	${testName}
	Set Base URL	&{Init}[master.oam.admin.server]
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Query Param    name    robot5
	${responseBody}	  get    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test10.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

runtime.oauth0002:: Clone OAM Admin OAuth::OAuthIdentityDomain Get:: Success
	[Tags]	    &{test_data}[test10.tags]
	[Documentation]		&{test_data}[test10.doc]
	sleep 60
	Set Test Variable	${testName}    &{test_data}[test10.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Base URL	&{Init}[clone1.oam.admin.server]
	Set Query Param    name    robot5
	${responseBody}	  get    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test10.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

runtime.oauth0003:: OAM Admin OAuth::ResourceServer Creation JSON:: Success
	[Tags]	    &{test_data}[test4.tags]
	[Documentation]		&{test_data}[test4.doc]
	Set Test Variable	${testName}    &{test_data}[test4.logfile.name]
	Create Logger	${testName}
    Set Base URL	&{Init}[master.oam.admin.server]
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
 	Set Content Type	&{test_data}[test4.input.1]
	Set Request Body	&{test_data}[test4.input.2]
	${responseBody}	post	&{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test4.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

runtime.oauth0004:: OAM Admin OAuth::OAuthResourceServer Get:: Success
	[Tags]	    &{test_data}[test16.tags]
	[Documentation]		&{test_data}[test16.doc]
	Set Test Variable	${testName}    &{test_data}[test16.logfile.name]
	Create Logger	${testName}
	Set Query Param    identityDomainName    robot5
	Set Query Param    name    RobotTestResSvr3
	${responseBody}	  get    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test16.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}


runtime.oauth0004:: Clone OAM Admin OAuth::OAuthResourceServer Get:: Success
	[Tags]	    &{test_data}[test16.tags]
	[Documentation]		&{test_data}[test16.doc]
	Set Test Variable	${testName}    &{test_data}[test16.logfile.name]
	Create Logger	${testName}
    Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
    Set Base URL	&{Init}[clone1.oam.admin.server]
	Set Query Param    identityDomainName    robot5
	Set Query Param    name    RobotTestResSvr3
	${responseBody}	  get    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test16.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}


runtime.oauth005:: OAM Admin OAuth::OAuthClient Creation JSON:: Success
	[Tags]	    &{test_data}[test8.tags]
	[Documentation]		&{test_data}[test8.doc]
	Set Test Variable	${testName}    &{test_data}[test8.logfile.name]
	Create Logger	${testName}
 	Set Content Type	&{test_data}[test8.input.1]
	Set Request Body	&{test_data}[test8.input.2]
	${responseBody}	post	&{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${cl_id} =    KW_GET_CLIENTID_FROM_RESP    ${responseBody}
    ${cl_sec} =    KW_GET_SECRET_FROM_RESP    ${responseBody}
    Set Suite Variable		${cl_id}
    Set Suite Variable		${cl_sec}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test8.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}


runtime.oauth006:: OAM Admin OAuth::OAuthClient Creation JSON GET:: Success
	[Tags]	    &{test_data}[test0109.tags]
	[Documentation]		&{test_data}[test0109.doc]
	Set Test Variable	${testName}    &{test_data}[test0109.logfile.name]
	Set Base URL	&{Init}[oam.admin.server]
    Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
    Set Content Type	&{test_data}[test8.input.1]
	Create Logger	${testName}
	Set Query Param    identityDomainName    robot5
	Set Query Param    name    testclient2
	${responseBody}	  get    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0109.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

runtime.oauth006:: Clone OAM Admin OAuth::OAuthClient Creation JSON GET:: Success
    [Tags]	    &{test_data}[test0109.tags]
    [Documentation]		&{test_data}[test0109.doc]
    Set Test Variable	${testName}    &{test_data}[test0109.logfile.name]
    Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
    Set Base URL	&{Init}[clone1.oam.admin.server]
    Set Content Type	&{test_data}[test8.input.1]
    Create Logger	${testName}
    Set Query Param    identityDomainName    robot5
    Set Query Param    name    testclient2
    ${responseBody}	  get    &{test_data}[common.oauth.admin.client.rest.endpoint]
    Write To Log	${responseBody}
    ${status}	Get Status
    ${actual}	Convert To String	${status}
    OAM Assert	${actual}	&{test_data}[test0109.expected.1]	${testName}
    ${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
    Attach Diff	${testName}	${result}

###### Runtime Testcases Starts #####################
#Runtime testcases are added as they depend on clientid and secret
#Later they should be moved to their different file

#Credential Collection Grant Flow
runtime.oauth00107:: OAM Runtime OAuth::Client Creds:: Success
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test107.doc]
	Set Test Variable	${testName}    &{test_data}[test.runtime.00001.logfile.name]
	Set Base URL	&{Init}[master.oam.runtime.baseurl]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test100.input.3]
	ReSet Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Create Logger	${testName}
 	Set Content Type	&{test_data}[test100.input.1]
 	log     ${cl_id}
 	log     ${cl_sec}
 	${payload} =    KW_CC_PAYLOAD   &{test_data}[test107.input.1]    http://google.com    RobotTestResSvr3.robot1
	Set Request Body	${payload}
	${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
	Response OK
	${cc_at}    Get String    ${responseBody}    access_token
	${tt}    Get String    ${responseBody}    token_type
	Should Not Be Empty    ${cc_at}
	Should Not Be Empty    ${tt}
	Should be equal as Strings    ${tt}    Bearer
	Set Suite Variable    ${cc_at}

runtime.oauth00108:: OAM Runtime OAuth::Access Token Validation FLOW: Client_Creds token:: Success
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test108.doc]
	Set Test Variable	${testName}    &{test_data}[test.runtime.00002.logfile.name]
	Set Base URL	&{Init}[master.oam.runtime.baseurl]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test100.input.3]
	Set Query Param    access_token    ${cc_at}
	Create Logger	${testName}
	${responseBody}	Get	&{test_data}[common.oauth.runtime.token.endpoint]/info
	Response OK


runtime.oauth00108:: Clone OAM Runtime OAuth::Access Token Validation FLOW: Client_Creds token:: Success
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test108.doc]
	Set Test Variable	${testName}    &{test_data}[test.runtime.00002.logfile.name]
	Set Base URL	&{Init}[clone1.oam.runtime.baseurl]
	Set Base URL	&{Init}[clone1.oam.admin.server]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test100.input.3]
	Set Query Param    access_token    ${cc_at}
	Create Logger	${testName}
	${responseBody}	Get	&{test_data}[common.oauth.runtime.token.endpoint]/info
	Response OK

###Resource Owner Creds Flow Testcases
runtime.oauth00109:: OAM Runtime OAuth::ROCF:: Success
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test100.doc]
	Set Test Variable	${testName}    &{test_data}[test.runtime.00003.logfile.name]
	Set Base URL	&{Init}[master.oam.runtime.baseurl]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test100.input.3]
	ReSet Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Create Logger	${testName}
 	Set Content Type	&{test_data}[test100.input.1]
 	${payload} =    KW_ROFC_PAYLOAD     &{test_data}[test100.input.2]    ${cl_id}    ${cl_sec}    http://google.com    RobotTestResSvr3.robot1    &{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Request Body	${payload}
	${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
	Write To Log	${responseBody}
	Response OK
	${at}    Get String    ${responseBody}    access_token
	${tt}    Get String    ${responseBody}    token_type
	${rt}    Get String    ${responseBody}    refresh_token
	Should Not Be Empty    ${at}
	Should Not Be Empty    ${tt}
	Should be equal as Strings    ${tt}    Bearer
	Set Suite Variable    ${at}
	Set Suite Variable    ${rt}


runtime.oauth001010:: OAM Runtime OAuth::CC as JWT and granttype=JWT_BEARER:: Success
	[Tags]	    &{test_data}[test8.tags]
	[Documentation]		&{test_data}[test8.doc]
	Set Test Variable	${testName}    &{test_data}[test.runtime.00004.logfile.name]
	Set Base URL	&{Init}[master.oam.runtime.baseurl]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test.runtime.0001.input.3]
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Create Logger	${testName}
 	Set Content Type	&{test_data}[test109.input.1]
 	#Remove client secret from the testcases once the code is fixed but for now it should be here
 	${payload} =    KW_JWTBEARER_CLIENTCREDS_PAYLOAD    &{test_data}[test.runtime.0001.input.4]     ${at}   http://google.com       RobotTestResSvr3.robot1
	Set Request Body	${payload}
	${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
	Write To Log	${responseBody}
	Response OK
	${cc1_at}    Get String    ${responseBody}    access_token
	Should Not Be Empty    ${cc1_at}


runtime.oauth001011:: OAM Runtime OAuth::RO with JWT Client Assertion:: Success
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test109.doc]
	Set Test Variable	${testName}    &{test_data}[test.runtime.00005.logfile.name]
	Set Base URL	&{Init}[master.oam.runtime.baseurl]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    robot5
	ReSet Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Create Logger	${testName}
 	Set Content Type	&{test_data}[test100.input.1]
 	#Remove client secret from the testcases once the code is fixed but for now it should be here
 	${payload} =    KW_ROFC_CC_JWT_PAYLOAD    &{test_data}[test.runtime.0001.input.5]    ${cc_at}     http://google.com    RobotTestResSvr3.robot1    &{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Request Body	${payload}
	${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
	Write To Log	${responseBody}
	Response OK
	${cc1_at}    Get String    ${responseBody}    access_token
	Should Not Be Empty    ${cc1_at}


runtime.oauth001012:: OAM Runtime OAuth::CC with JWT Client Assertion:: Success
    [Tags]	    &{test_data}[test100.tags]
    [Documentation]		&{test_data}[test109.doc]
    Set Test Variable	${testName}    &{test_data}[test.runtime.00006.logfile.name]
    Set Base URL	&{Init}[master.oam.runtime.baseurl]
    Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    robot5
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Create Logger	${testName}
    Set Content Type	&{test_data}[test100.input.1]
    #Remove client secret from the testcases once the code is fixed but for now it should be here
    ${payload} =    KW_JWTBEARER_CLIENTCREDS_PAYLOAD    &{test_data}[test.runtime.0001.input.6]    ${cc_at}     http://google.com    RobotTestResSvr3.robot1
    Set Request Body	${payload}
    ${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
    Write To Log	${responseBody}
    Response OK
    ${cc1_at}    Get String    ${responseBody}    access_token
    Should Not Be Empty    ${cc1_at}


runtime.oauth001013:: OAM Runtime OAuth::Refresh Token:: Success
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test110.doc]
	Set Test Variable	${testName}    &{test_data}[test.runtime.00007.logfile.name]
	Set Base URL	&{Init}[master.oam.runtime.baseurl]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test100.input.3]
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	${getencodedtoken} =    encode      ${rt}   UTF-8
	${payload} =    KW_REFERSH_TOKEN_PAYLOAD    &{test_data}[test.runtime.0001.input.7]     ${getencodedtoken}      RobotTestResSvr3.robot1
	Set Request Body	${payload}
	${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
    Write To Log	${responseBody}
	Response OK
	${myat}    Get String    ${responseBody}    access_token
	Should Not Be Empty    ${myat}
	Set Suite Variable    ${myat}
#
####################These are Negative Testcases for Resource Owner Grant Flow###################################
runtime.oauth001014:: ROCF:: fail_001
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test101.doc]
	Set Test Variable	${testName}    &{test_data}[test.runtime.00008.logfile.name]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test100.input.3]
	Create Logger	${testName}
 	Set Content Type	&{test_data}[test100.input.1]
 	${payload} =    KW_ROFC_PAYLOAD     &{test_data}[test100.input.2]    ${cl_id}    ${cl_sec}    ${EMPTY}    RobotTestResSvr3.robot1    &{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Request Body	${payload}
	${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
	Write To Log	${responseBody}
	Response Bad Request
	${e}    Get String    ${responseBody}    error
	${ed}    Get String    ${responseBody}    error_description
	Should Not Be Empty    ${e}
	Should Not Be Empty    ${ed}
	Should be equal as Strings    ${e}    &{test_data}[test101.expected.1]
	Should be equal as Strings    ${ed}    &{test_data}[test101.expected.2]

#runtime.oauth001015::ROCF:: fail_002
#	[Tags]	    &{test_data}[test100.tags]
#	[Documentation]		&{test_data}[test101.doc]
#	Set Test Variable	${testName}    &{test_data}[test.runtime.00009.logfile.name]
#	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-N AME    &{test_data}[test100.input.3]
#	Create Logger	${testName}
# 	Set Content Type	&{test_data}[test100.input.1]
# 	${payload} =    KW_ROFC_PAYLOAD    &{test_data}[test100.input.2]    ${cl_id}    ${cl_sec}    ${EMPTY}    InvalidResSvr.robot1    &{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
#	Set Request Body	${payload}
#	${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
#	Write To Log	${responseBody}
#	Response Bad Request
#	${e}    Get String    ${responseBody}    error
#	${ed}    Get String    ${responseBody}    error_description
#	Should Not Be Empty    ${e}
#	Should Not Be Empty    ${ed}
#	Should be equal as Strings    ${e}    &{test_data}[test102.expected.1]
#	Should be equal as Strings    ${ed}    &{test_data}[test102.expected.2]


runtime.oauth001016:: ROCF:: fail_003
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test102.doc]
	Set Test Variable	${testName}    &{test_data}[test.runtime.000010.logfile.name]
	Set Base URL	&{Init}[master.oam.runtime.baseurl]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test100.input.3]
	Create Logger	${testName}
 	Set Content Type	&{test_data}[test100.input.1]
 	${payload} =    KW_ROFC_PAYLOAD    &{test_data}[test100.input.2]    ${cl_id}    ${cl_sec}    http://google.com    ${EMPTY}    &{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Request Body	${payload}
	${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
	Write To Log	${responseBody}
	Response Bad Request
	${e}    Get String    ${responseBody}    error
	${ed}    Get String    ${responseBody}    error_description
	Should Not Be Empty    ${e}
	Should Not Be Empty    ${ed}
	Should be equal as Strings    ${e}    &{test_data}[test102.expected.1]
	Should be equal as Strings    ${ed}    &{test_data}[test102.expected.2]

runtime.oauth001017:: ROCF:: fail_004
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test102.doc]
	Set Test Variable	${testName}    &{test_data}[test.runtime.000011.logfile.name]
	Set Base URL	&{Init}[master.oam.runtime.baseurl]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test100.input.3]
	Create Logger	${testName}
	ReSet Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
 	Set Content Type	&{test_data}[test100.input.1]
 	Set Test Variable   ${cl_id}    &{test_data}[test.runtime.0001.invalid.clientid]
 	${payload} =    KW_ROFC_PAYLOAD    &{test_data}[test100.input.2]    ${cl_id}    ${cl_sec}    http://google.com    RobotTestResSvr3.robot1    &{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Request Body	${payload}
	${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
	Write To Log	${responseBody}
	Response Bad Request
	${e}    Get String    ${responseBody}    error
	${ed}    Get String    ${responseBody}    error_description
	Should Not Be Empty    ${e}
	Should Not Be Empty    ${ed}
	Should be equal as Strings    ${e}    &{test_data}[test102.runtime.expected.1]
	Should be equal as Strings    ${ed}    &{test_data}[test102.runtime.expected.0001]

runtime.oauth001018:: ROCF:: fail_005
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test102.doc]
	Set Test Variable	${testName}    &{test_data}[test.runtime.000012.logfile.name]
	Set Base URL	&{Init}[master.oam.runtime.baseurl]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test100.input.3]
	ReSet Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Create Logger	${testName}
 	Set Content Type	&{test_data}[test100.input.1]
 	${payload} =    KW_ROFC_PAYLOAD    &{test_data}[test100.input.2]    ${cl_id}    &{test_data}[test.runtime.0001.invalid.clientsecret]    http://google.com    RobotTestResSvr3.robot1    &{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Request Body	${payload}
	${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
	Write To Log	${responseBody}
	Response Bad Request
	${e}    Get String    ${responseBody}    error
	${ed}    Get String    ${responseBody}    error_description
	Should Not Be Empty    ${e}
	Should Not Be Empty    ${ed}
	Should be equal as Strings    ${e}    &{test_data}[test102.runtime.expected.1]
	Should be equal as Strings    ${ed}    &{test_data}[test102.runtime.expected.001]

runtime.oauth001019:: ROCF:: fail_006
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test102.doc]
	Set Test Variable	${testName}    &{test_data}[test.runtime.000013.logfile.name]
	Set Base URL	&{Init}[master.oam.runtime.baseurl]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test100.input.3]
	ReSet Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Create Logger	${testName}
 	Set Content Type	&{test_data}[test100.input.1]
 	${payload} =    KW_ROFC_PAYLOAD    &{test_data}[test100.input.2]    ${cl_id}    ${cl_sec}    http://google.com    RobotTestResSvr3.robot1    &{test_data}[test.runtime.0001.invalid.username]	&{test_data}[common.oauth.rest.password]
	Set Request Body	${payload}
	${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
	Write To Log	${responseBody}
	Response Bad Request
	${e}    Get String    ${responseBody}    error
	${ed}    Get String    ${responseBody}    error_description
	Should Not Be Empty    ${e}
	Should Not Be Empty    ${ed}
	Should be equal as Strings    ${e}    &{test_data}[test102.runtime.expected.2]
	Should be equal as Strings    ${ed}    &{test_data}[test102.runtime.expected.02]

runtime.oauth001020:: ROCF:: fail_007
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test102.doc]
	Set Test Variable	${testName}    &{test_data}[test.runtime.000014.logfile.name]
	Set Base URL	&{Init}[master.oam.runtime.baseurl]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test100.input.3]
	ReSet Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Create Logger	${testName}
 	Set Content Type	&{test_data}[test100.input.1]
 	${payload} =    KW_ROFC_PAYLOAD    &{test_data}[test100.input.2]    ${cl_id}    ${cl_sec}    http://google.com    RobotTestResSvr3.robot1    &{Init}[oam.admin.username]    &{test_data}[test.runtime.0001.invalid.password]
	Set Request Body	${payload}
	${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
	Write To Log	${responseBody}
	Response Bad Request
	${e}    Get String    ${responseBody}    error
	${ed}    Get String    ${responseBody}    error_description
	Should Not Be Empty    ${e}
	Should Not Be Empty    ${ed}
	Should be equal as Strings    ${e}    &{test_data}[test102.runtime.expected.2]
	Should be equal as Strings    ${ed}    &{test_data}[test102.runtime.expected.02]
####################These are Negative Testcases for Resource Owner Grant Flow###################################

####################These are Negative Testcases for Client Credential Flow###################################

runtime.oauth001021:: OAM Runtime OAuth::CC:: fail_001
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test101.doc]
	Set Test Variable	${testName}    &{test_data}[test.runtime.000015.logfile.name]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test100.input.3]
    ReSet Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
    Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Create Logger	${testName}
 	Set Content Type	&{test_data}[test100.input.1]
 	${payload} =    KW_CC_PAYLOAD     &{test_data}[test107.input.1]       ${EMPTY}    RobotTestResSvr3.robot1
	Set Request Body	${payload}
	${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
	Write To Log	${responseBody}
	Response Bad Request
	${e}    Get String    ${responseBody}    error
	${ed}    Get String    ${responseBody}    error_description
	Should Not Be Empty    ${e}
	Should Not Be Empty    ${ed}
	Should be equal as Strings    ${e}    &{test_data}[test101.expected.1]
	Should be equal as Strings    ${ed}    &{test_data}[test101.expected.2]


runtime.oauth001022:: OAM Runtime OAuth::CC:: fail_002
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test101.doc]
	Set Test Variable	${testName}    &{test_data}[test101.logfile.name]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test100.input.3]
    ReSet Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
    Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Create Logger	${testName}
 	Set Content Type	&{test_data}[test100.input.1]
 	${payload} =    KW_CC_PAYLOAD     &{test_data}[test107.input.1]       ${EMPTY}    InvalidResSvr.robot1
	Set Request Body	${payload}
	${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
	Write To Log	${responseBody}
	Response Bad Request
	${e}    Get String    ${responseBody}    error
	${ed}    Get String    ${responseBody}    error_description
	Should Not Be Empty    ${e}
	Should Not Be Empty    ${ed}
	Should be equal as Strings    ${e}    &{test_data}[test102.expected.1]
	Should be equal as Strings    ${ed}    &{test_data}[test102.expected.2]

runtime.oauth001023:: OAM Runtime OAuth::CC:: fail_003
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test101.doc]
	Set Test Variable	${testName}    &{test_data}[test.runtime.000015.logfile.name]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test100.input.3]
    ReSet Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
    Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Create Logger	${testName}
 	Set Content Type	&{test_data}[test100.input.1]
 	${payload} =    KW_CC_PAYLOAD     &{test_data}[test107.input.1]       http://google.com    RobotTestResSvr3.robot1
	Set Request Body	${payload}
	${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
	Write To Log	${responseBody}
#	Response Bad Request
	${e}    Get String    ${responseBody}    error
	${ed}    Get String    ${responseBody}    error_description
	Should Not Be Empty    ${e}
	Should Not Be Empty    ${ed}
	Should be equal as Strings    ${e}    &{test_data}[test102.runtime.expected.1]
	Should be equal as Strings    ${ed}    &{test_data}[test102.runtime.expected.0001]


runtime.oauth001024:: OAM Runtime OAuth::CC:: fail_004
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test101.doc]
	Set Test Variable	${testName}    &{test_data}[test101.logfile.name]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test100.input.3]
    ReSet Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
    Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Create Logger	${testName}
 	Set Content Type	&{test_data}[test100.input.1]
 	${payload} =    KW_CC_PAYLOAD     &{test_data}[test107.input.1]       http://google.com    RobotTestResSvr3.robot1
	Set Request Body	${payload}
	${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
	Write To Log	${responseBody}
	Response Bad Request
	${e}    Get String    ${responseBody}    error
	${ed}    Get String    ${responseBody}    error_description
	Should Not Be Empty    ${e}
	Should Not Be Empty    ${ed}
	Should be equal as Strings    ${e}    &{test_data}[test102.runtime.expected.1]
	Should be equal as Strings    ${ed}    &{test_data}[test102.runtime.expected.001]

####################These are Negative Testcases for Client Credential Flow###################################

####################These are Negative Testcases for CC as JWT and granttype=JWT_BEARER Flow###################################

runtime.oauth0106:: CC as JWT and granttype=JWT_BEARER:: fail_001
	[Tags]	    &{test_data}[test8.tags]
	[Documentation]		&{test_data}[test8.doc]
	Set Base URL	&{Init}[master.oam.runtime.baseurl]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test.runtime.0001.input.3]
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
 	Set Content Type	&{test_data}[test109.input.1]
 	#Remove client secret from the testcases once the code is fixed but for now it should be here
 	${payload} =    KW_JWTBEARER_CLIENTCREDS_PAYLOAD    &{test_data}[test.runtime.0001.input.4]     ${at}   ${EMPTY}       RobotTestResSvr3.robot1
	Set Request Body	${payload}
	${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
	Write To Log	${responseBody}
	Response Bad Request
	${e}    Get String    ${responseBody}    error
	${ed}    Get String    ${responseBody}    error_description
	Should Not Be Empty    ${e}
	Should Not Be Empty    ${ed}
	Should be equal as Strings    ${e}    &{test_data}[test101.expected.1]
	Should be equal as Strings    ${ed}    &{test_data}[test101.expected.2]

runtime.oauth01007:: CC as JWT and granttype=JWT_BEARER:: fail_002
	[Tags]	    &{test_data}[test8.tags]
	[Documentation]		&{test_data}[test8.doc]
	Set Base URL	&{Init}[master.oam.runtime.baseurl]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test.runtime.0001.input.3]
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
 	Set Content Type	&{test_data}[test109.input.1]
 	#Remove client secret from the testcases once the code is fixed but for now it should be here
 	${payload} =    KW_JWTBEARER_CLIENTCREDS_PAYLOAD    &{test_data}[test.runtime.0001.input.4]     ${at}   ${EMPTY}    InvalidResSvr.robot1
	Set Request Body	${payload}
	${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
	Write To Log	${responseBody}
	Response Bad Request
	${e}    Get String    ${responseBody}    error
	${ed}    Get String    ${responseBody}    error_description
	Should Not Be Empty    ${e}
	Should Not Be Empty    ${ed}
	Should be equal as Strings    ${e}    &{test_data}[test101.expected.3]
	Should be equal as Strings    ${ed}    &{test_data}[test101.expected.4]

runtime.oauth01008:: CC as JWT and granttype=JWT_BEARER:: fail_003
	[Tags]	    &{test_data}[test8.tags]
	[Documentation]		&{test_data}[test8.doc]
	Set Base URL	&{Init}[master.oam.runtime.baseurl]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test.runtime.0001.input.3]
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
 	Set Content Type	&{test_data}[test109.input.1]
 	#Remove client secret from the testcases once the code is fixed but for now it should be here
 	${payload} =    KW_JWTBEARER_CLIENTCREDS_PAYLOAD    &{test_data}[test.runtime.0001.input.4]     ${at}   ${EMPTY}    InvalidResSvr.robot1
	Set Request Body	${payload}
	${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
	Write To Log	${responseBody}
#	Response Bad Request
	${e}    Get String    ${responseBody}    error
	${ed}    Get String    ${responseBody}    error_description
	Should Not Be Empty    ${e}
	Should Not Be Empty    ${ed}
	Should be equal as Strings    ${e}    &{test_data}[test102.runtime.expected.1]
	Should be equal as Strings    ${ed}    &{test_data}[test102.runtime.expected.0001]

runtime.oauth01009:: CC as JWT and granttype=JWT_BEARER:: fail_004
	[Tags]	    &{test_data}[test8.tags]
	[Documentation]		&{test_data}[test8.doc]
	Set Base URL	&{Init}[master.oam.runtime.baseurl]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test.runtime.0001.input.3]
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
 	Set Content Type	&{test_data}[test109.input.1]
 	#Remove client secret from the testcases once the code is fixed but for now it should be here
 	${payload} =    KW_JWTBEARER_CLIENTCREDS_PAYLOAD    &{test_data}[test.runtime.0001.input.4]     ${at}   ${EMPTY}    InvalidResSvr.robot1
	Set Request Body	${payload}
	${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
	Write To Log	${responseBody}
	Response Bad Request
	${e}    Get String    ${responseBody}    error
	${ed}    Get String    ${responseBody}    error_description
	Should Not Be Empty    ${e}
	Should Not Be Empty    ${ed}
	Should be equal as Strings    ${e}    &{test_data}[test102.runtime.expected.1]
	Should be equal as Strings    ${ed}    &{test_data}[test102.runtime.expected.001]
####################These are Negative Testcases for CC as JWT and granttype=JWT_BEARER Flow###################################


####################These are Negative Testcases for RO with JWT Client Assertion Flow###################################

runtime.oauth01008:: OAM Runtime OAuth::RO with JWT Client Assertion:: fail_001
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test109.doc]
	Set Base URL	&{Init}[master.oam.runtime.baseurl]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    robot5
	ReSet Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
 	Set Content Type	&{test_data}[test100.input.1]
 	#Remove client secret from the testcases once the code is fixed but for now it should be here
 	${payload} =    KW_ROFC_CC_JWT_PAYLOAD    &{test_data}[test.runtime.0001.input.5]    ${cc_at}     ${EMPTY}    RobotTestResSvr3.robot1    &{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Request Body	${payload}
	${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
	Write To Log	${responseBody}
	Response Bad Request
	${e}    Get String    ${responseBody}    error
	${ed}    Get String    ${responseBody}    error_description
	Should Not Be Empty    ${e}
	Should Not Be Empty    ${ed}
	Should be equal as Strings    ${e}    &{test_data}[test101.expected.1]
	Should be equal as Strings    ${ed}    &{test_data}[test101.expected.2]

runtime.oauth010009:: OAM Runtime OAuth::RO with JWT Client Assertion:: fail_002
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test109.doc]
	Set Base URL	&{Init}[master.oam.runtime.baseurl]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    robot5
	ReSet Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
 	Set Content Type	&{test_data}[test100.input.1]
 	#Remove client secret from the testcases once the code is fixed but for now it should be here
 	${payload} =    KW_ROFC_CC_JWT_PAYLOAD    &{test_data}[test.runtime.0001.input.5]    ${cc_at}     ${EMPTY}    InvalidResSvr.robot1    &{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Request Body	${payload}
	${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
	Write To Log	${responseBody}
	Response Bad Request
	${e}    Get String    ${responseBody}    error
	${ed}    Get String    ${responseBody}    error_description
	Should Not Be Empty    ${e}
	Should Not Be Empty    ${ed}
	Should be equal as Strings    ${e}    &{test_data}[test101.expected.3]
	Should be equal as Strings    ${ed}    &{test_data}[test101.expected.4]

runtime.oauth0010010:: OAM Runtime OAuth::RO with JWT Client Assertion:: fail_003
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test109.doc]
	Set Base URL	&{Init}[master.oam.runtime.baseurl]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    robot5
	ReSet Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
 	Set Content Type	&{test_data}[test100.input.1]
 	#Remove client secret from the testcases once the code is fixed but for now it should be here
 	${payload} =    KW_ROFC_CC_JWT_PAYLOAD    &{test_data}[test.runtime.0001.input.5]    ${cc_at}     http://google.com    RobotTestResSvr3.robot1    &{test_data}[test.runtime.0001.invalid.username]	&{test_data}[common.oauth.rest.password]
	Set Request Body	${payload}
	${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
	Write To Log	${responseBody}
	Response Bad Request
	${e}    Get String    ${responseBody}    error
	${ed}    Get String    ${responseBody}    error_description
	Should Not Be Empty    ${e}
	Should Not Be Empty    ${ed}
	Should be equal as Strings    ${e}    &{test_data}[test102.runtime.expected.2]
	Should be equal as Strings    ${ed}    &{test_data}[test102.runtime.expected.02]

runtime.oauth0010011:: OAM Runtime OAuth::RO with JWT Client Assertion:: fail_004
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test109.doc]
	Set Base URL	&{Init}[master.oam.runtime.baseurl]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    robot5
	ReSet Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
 	Set Content Type	&{test_data}[test100.input.1]
 	#Remove client secret from the testcases once the code is fixed but for now it should be here
 	${payload} =    KW_ROFC_CC_JWT_PAYLOAD    &{test_data}[test.runtime.0001.input.5]    ${cc_at}     http://google.com    RobotTestResSvr3.robot1    &{Init}[oam.admin.username]   &{test_data}[test.runtime.0001.invalid.password]
	Set Request Body	${payload}
	${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
	Write To Log	${responseBody}
	Response Bad Request
	${e}    Get String    ${responseBody}    error
	${ed}    Get String    ${responseBody}    error_description
	Should Not Be Empty    ${e}
	Should Not Be Empty    ${ed}
	Should be equal as Strings    ${e}    &{test_data}[test102.runtime.expected.2]
	Should be equal as Strings    ${ed}    &{test_data}[test102.runtime.expected.02]
####################These are Negative Testcases for RO with JWT Client Assertion Flow###################################

####################These are Negative Testcases for CC with JWT Client Assertion Flow###################################
runtime.oauth01010:: OAM Runtime OAuth::CC with JWT Client Assertion:: fail_001
    [Tags]	    &{test_data}[test100.tags]
    [Documentation]		&{test_data}[test109.doc]
    Set Base URL	&{Init}[master.oam.runtime.baseurl]
    Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    robot5
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
    Set Content Type	&{test_data}[test100.input.1]
    #Remove client secret from the testcases once the code is fixed but for now it should be here
    ${payload} =    KW_JWTBEARER_CLIENTCREDS_PAYLOAD    &{test_data}[test.runtime.0001.input.6]    ${cc_at}     ${EMPTY}    RobotTestResSvr3.robot1
    Set Request Body	${payload}
    ${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
	Write To Log	${responseBody}
	Response Bad Request
	${e}    Get String    ${responseBody}    error
	${ed}    Get String    ${responseBody}    error_description
	Should Not Be Empty    ${e}
	Should Not Be Empty    ${ed}
	Should be equal as Strings    ${e}    &{test_data}[test101.expected.1]
	Should be equal as Strings    ${ed}    &{test_data}[test101.expected.2]

runtime.oauth01011:: OAM Runtime OAuth::CC with JWT Client Assertion:: fail_002
    [Tags]	    &{test_data}[test100.tags]
    [Documentation]		&{test_data}[test109.doc]
    Set Base URL	&{Init}[master.oam.runtime.baseurl]
    Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    robot5
    Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
    Set Content Type	&{test_data}[test100.input.1]
    #Remove client secret from the testcases once the code is fixed but for now it should be here
    ${payload} =    KW_JWTBEARER_CLIENTCREDS_PAYLOAD    &{test_data}[test.runtime.0001.input.6]    ${cc_at}     ${EMPTY}    InvalidResSvr.robot1
    Set Request Body	${payload}
    ${responseBody}	post	&{test_data}[common.oauth.runtime.token.endpoint]
	Write To Log	${responseBody}
	Response Bad Request
	${e}    Get String    ${responseBody}    error
	${ed}    Get String    ${responseBody}    error_description
	Should Not Be Empty    ${e}
	Should Not Be Empty    ${ed}
	Should be equal as Strings    ${e}    &{test_data}[test101.expected.3]
	Should be equal as Strings    ${ed}    &{test_data}[test101.expected.4]
####################These are Negative Testcases for CC with JWT Client Assertion Flow###################################


runtime.oauth0104:: OAM Runtime OAuth::Access Token Validation FLOW:: Success
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test103.doc]
	Set Test Variable	${testName}    &{test_data}[test103.logfile.name]
	#Set Base URL	&{Init}[master.oam.runtime.baseurl]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test100.input.3]
	Create Logger	${testName}
	Set Query Param    access_token    ${at}
	${responseBody}	Get	&{test_data}[common.oauth.runtime.token.endpoint]/info
	Write To Log	${responseBody}
	Response OK
	${r_cl}    Get String    ${responseBody}    client
	${r_user}    Get String    ${responseBody}    sub
	Should Not Be Empty    ${r_cl}
	Should Not Be Empty    ${r_user}

####################These are Negative Testcases for Access Token Validation Flow###################################
runtime.oauth0105:: OAM Runtime OAuth::Access Token Validation FLOW:: Fail001
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test104.doc]
	Set Test Variable	${testName}    &{test_data}[test104.logfile.name]
	#Set Base URL	&{Init}[master.oam.runtime.baseurl]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test100.input.3]
	Create Logger	${testName}
	${responseBody}	Get	&{test_data}[common.oauth.runtime.token.endpoint]/info
	Write To Log	${responseBody}
	Response Bad Request
	${err}    Get String    ${responseBody}    error
	Should Not Be Empty    ${err}
	Should Be Equal As Strings    &{test_data}[test104.expected.1]    ${err}

runtime.oauth0106:: OAM Runtime OAuth::Access Token Validation FLOW:: Fail002
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test105.doc]
	Set Test Variable	${testName}    &{test_data}[test105.logfile.name]
	#Set Base URL	&{Init}[master.oam.runtime.baseurl]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test100.input.3]
	Create Logger	${testName}
	Set Query Param    access_token    invalid_token
	${responseBody}	Get	&{test_data}[common.oauth.runtime.token.endpoint]/info
	Write To Log	${responseBody}
	Response Bad Request
	${err}    Get String    ${responseBody}    error
	Should Not Be Empty    ${err}
	Should Be Equal As Strings    &{test_data}[test105.expected.1]    ${err}

runtime.oauth0107:: OAM Runtime OAuth::Invalid Access Token Validation FLOW:: Fail003
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test105.doc]
	Set Test Variable	${testName}    &{test_data}[test105.logfile.name]
	Set Base URL	&{Init}[master.oam.runtime.baseurl]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test100.input.3]
	Create Logger	${testName}
	Set Query Param    access_token    &{test_data}[test.runtime.0001.invalid.accesstoken]
	${responseBody}	Get	&{test_data}[common.oauth.runtime.token.endpoint]/info
	Write To Log	${responseBody}
#	Response Bad Request
	${err}    Get String    ${responseBody}    error
	Should Not Be Empty    ${err}
	Should Be Equal As Strings    &{test_data}[test105.expected.1]    ${err}

#(acquired through refresh token flow test oauth0110)
runtime.oauth0108:: OAM Runtime OAuth::Access token validation :: Success
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]    Access token acquired in previous testcase is validated so this testcase completes one usecase
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test100.input.3]
	Set Query Param    access_token    ${myat}
	${responseBody}	Get	&{test_data}[common.oauth.runtime.token.endpoint]/info
	Response OK




#Verify all Access token validation flows on Clone server

####################These are Negative Testcases for CC with JWT Client Assertion Flow###################################
sleep   60

runtime.oauth0104:: Clone OAM Runtime OAuth::Access Token Validation FLOW:: Success
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test103.doc]
	Set Test Variable	${testName}    &{test_data}[test103.logfile.name]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test100.input.3]
	Create Logger	${testName}
    Set Base URL	&{Init}[clone1.oam.runtime.baseurl]
	Set Query Param    access_token    ${at}
	${responseBody}	Get	&{test_data}[common.oauth.runtime.token.endpoint]/info
	Write To Log	${responseBody}
	Response OK
	${r_cl}    Get String    ${responseBody}    client
	${r_user}    Get String    ${responseBody}    sub
	Should Not Be Empty    ${r_cl}
	Should Not Be Empty    ${r_user}

####################These are Negative Testcases for Access Token Validation Flow###################################
runtime.oauth0105:: Clone OAM Runtime OAuth::Access Token Validation FLOW:: Fail001
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test104.doc]
	Set Test Variable	${testName}    &{test_data}[test104.logfile.name]
    Set Base URL	&{Init}[clone1.oam.runtime.baseurl]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test100.input.3]
	Create Logger	${testName}
	${responseBody}	Get	&{test_data}[common.oauth.runtime.token.endpoint]/info
	Write To Log	${responseBody}
	Response Bad Request
	${err}    Get String    ${responseBody}    error
	Should Not Be Empty    ${err}
	Should Be Equal As Strings    &{test_data}[test104.expected.1]    ${err}

runtime.oauth0106:: Clone OAM Runtime OAuth::Access Token Validation FLOW:: Fail002
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test105.doc]
	Set Test Variable	${testName}    &{test_data}[test105.logfile.name]
	Set Base URL	&{Init}[clone1.oam.runtime.baseurl]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test100.input.3]
	Create Logger	${testName}
	Set Query Param    access_token    invalid_token
	${responseBody}	Get	&{test_data}[common.oauth.runtime.token.endpoint]/info
	Write To Log	${responseBody}
	Response Bad Request
	${err}    Get String    ${responseBody}    error
	Should Not Be Empty    ${err}
	Should Be Equal As Strings    &{test_data}[test105.expected.1]    ${err}

runtime.oauth0107:: Clone OAM Runtime OAuth::Invalid Access Token Validation FLOW:: Fail003
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]		&{test_data}[test105.doc]
	Set Test Variable	${testName}    &{test_data}[test105.logfile.name]
	Set Base URL	&{Init}[clone1.oam.runtime.baseurl]
	Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test100.input.3]
	Create Logger	${testName}
	Set Query Param    access_token    &{test_data}[test.runtime.0001.invalid.accesstoken]
	${responseBody}	Get	&{test_data}[common.oauth.runtime.token.endpoint]/info
	Write To Log	${responseBody}
#	Response Bad Request
	${err}    Get String    ${responseBody}    error
	Should Not Be Empty    ${err}
	Should Be Equal As Strings    &{test_data}[test105.expected.1]    ${err}

#(acquired through refresh token flow test oauth0110)
runtime.oauth0108:: Clone OAM Runtime OAuth::Access token validation :: Success
	[Tags]	    &{test_data}[test100.tags]
	[Documentation]    Access token acquired in previous testcase is validated so this testcase completes one usecase
	Set Base URL	&{Init}[clone1.oam.runtime.baseurl]
    Set Request Header    X-OAUTH-IDENTITY-DOMAIN-NAME    &{test_data}[test100.input.3]
	Set Query Param    access_token    ${myat}
	${responseBody}	Get	&{test_data}[common.oauth.runtime.token.endpoint]/info
	Response OK


######## Runtime Testcases End ################################################
###############################################################################

runtime.oauth0013:: OAM Admin OAuth::OAuthClient Deletion:: Success
	[Tags]	    &{test_data}[test13.tags]
	[Documentation]		&{test_data}[test13.doc]
	Set Test Variable	${testName}    &{test_data}[test13.logfile.name]
	Create Logger	${testName}
    Set Base URL    &{Init}[oam.admin.server]
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test13.input.1]
	#Set Request Body	&{test_data}[test13.input.2]
	Set Query Param    identityDomainName    robot5
	Set Query Param    name    testclient2
	${responseBody}	delete    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test13.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

runtime.oauth0017:: OAM Admin OAuth::OAuthClient Creation JSON GET:: Success
	[Tags]	    &{test_data}[test0109.tags]
	[Documentation]		&{test_data}[test0109.doc]
	Set Test Variable	${testName}    &{test_data}[test0109.logfile.name]
	Set Base URL	&{Init}[oam.admin.server]
    Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
    Set Content Type	&{test_data}[test8.input.1]
	Create Logger	${testName}
	Set Query Param    identityDomainName    robot5
	Set Query Param    name    testclient2
	${responseBody}	  get    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test.runtime.0001.expected.error]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

runtime.oauth0008:: OAM Admin OAuth::ResourceServer Deletion:: Success
	[Tags]	&{test_data}[test5.tags]
	[Documentation]		&{test_data}[test5.doc]
	Set Test Variable	${testName}    &{test_data}[test5.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test5.input.1]
	#Set Request Body	&{test_data}[test5.input.2]
	Set Query Param    identityDomainName    robot5
	Set Query Param    name    RobotTestResSvr3
	${responseBody}	delete    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test5.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

runtime.oauth0016:: OAM Admin OAuth::OAuthResourceServer Get:: Success
	[Tags]	    &{test_data}[test16.tags]
	[Documentation]		&{test_data}[test16.doc]
	Set Test Variable	${testName}    &{test_data}[test16.logfile.name]
	Create Logger	${testName}
	Set Query Param    identityDomainName    robot5
	Set Query Param    name    RobotTestResSvr3
	${responseBody}	  get    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test.runtime.0001.expected.error]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}


runtime.oauth0014:: OAM Admin OAuth::OAuthIdentityDomain Deletion:: Success
	[Tags]	    &{test_data}[test14.tags]
	[Documentation]		&{test_data}[test14.doc]
	Set Test Variable	${testName}    &{test_data}[test14.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test14.input.1]
	#Set Request Body	&{test_data}[test14.input.2]
	Set Query Param    name    robot5
	${responseBody}	delete    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test14.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}


runtime.oauth0015:: OAM Admin OAuth::OAuthIdentityDomain Get:: Success
	[Tags]	    &{test_data}[test10.tags]
	[Documentation]		&{test_data}[test10.doc]
	Set Test Variable	${testName}    &{test_data}[test10.logfile.name]
	Create Logger	${testName}
	Set Query Param    name    robot5
	${responseBody}	  get    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test.runtime.0001.expected.error]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

runtime.oauth0018:: OAM Admin OAuth::Audit log generation:: Success
	[Tags]	    &{test_data}[test17.tags]
	[Documentation]		&{test_data}[test17.doc]
	Set Test Variable	${testName}    &{test_data}[test17.logfile.name]
	Create Logger	${testName}
	${str}	Grep File	&{init}[oam.domain.home]/servers/AdminServer/logs/auditlogs/OAM/audit.log	OAuthAdminOperation	encoding_errors=ignore
	${count}	Get Line Count	${str}
	${str_count}	Convert To String	${count}
	Write To Log	${str_count}
	${var}=	Set Variable If	${count} > 0	AUDIT_LOGS_CREATED	NO_AUDIT_LOGS
	OAM Assert	${var}	AUDIT_LOGS_CREATED	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}
