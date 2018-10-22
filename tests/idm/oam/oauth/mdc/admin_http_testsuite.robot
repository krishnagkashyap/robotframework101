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

Resource    ../../../../../resources/keywords/idm/oam/oauth/oam_oauth_common.robot

Suite Setup	Setup Env
Test Teardown	Remove Log locks

*** Keywords ***
Setup Env
	Initialize Settings
    Initialize Test Data	 idm/oam/oauth/oam_oauth_policyadmin_testsuite.properties
    Set Base URL	&{Init}[master.oam.admin.server]
    Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]

###########################################################################################
### Admin Testcases added for ACCESS_2016-12-16 Sprint
###IdentityDomain Creation POST
###http://aseng-wiki.us.oracle.com/asengwiki/display/ASQA/Single+Node+Server+with+Admin%2C+Runtime%2C+Issue+and+Validate
###Covers Single Node Server with Admin, Runtime, Issue and Validate FROM 13-18 on http for POST on OAuthIdentityDomain
###https not covered yet i.e from 19-24
###########################################################################################
*** Test Cases ***
oauth.admin00001:: OAM Admin OAuth::IdentityDomain Creation:: Success
	[Tags]      &{test_data}[test01.tags]
	[Documentation]		&{test_data}[test01.doc]
	Set Test Variable	${testName}    &{test_data}[test01.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test01.input.1]
	Set Request Body	&{test_data}[test01.input.2]
	${responseBody}	post	&{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test01.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin00002:: OAM Admin OAuth::IdentityDomain Creation:: Success
	[Tags]  	&{test_data}[test02.tags]
	[Documentation]		&{test_data}[test02.doc]
	Set Test Variable	${testName}    &{test_data}[test02.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test02.input.1]
	Set Request Body	&{test_data}[test02.input.2]
	${responseBody}	post	&{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test02.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin00003:: OAM Admin OAuth::IdentityDomain Creation:: Success
	[Tags]  	&{test_data}[test03.tags]
	[Documentation]		&{test_data}[test03.doc]
	Set Test Variable	${testName}    &{test_data}[test03.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test03.input.1]
	Set Request Body	&{test_data}[test03.input.2]
	${responseBody}	post	&{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test03.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin00004:: OAM Admin OAuth::IdentityDomain Creation:: Success
	[Tags]  	&{test_data}[test04.tags]
	[Documentation]		&{test_data}[test04.doc]
	Set Test Variable	${testName}    &{test_data}[test04.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test04.input.1]
	Set Request Body	&{test_data}[test04.input.2]
	${responseBody}	post	&{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test04.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin00005:: OAM Admin OAuth::IdentityDomain Creation:: Negative#1
	[Tags]  	&{test_data}[test05.tags]
	[Documentation]		&{test_data}[test05.doc]
	Set Test Variable	${testName}    &{test_data}[test05.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test05.input.1]
	Set Request Body	&{test_data}[test05.input.2]
	${responseBody}	post	&{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test05.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin00006:: OAM Admin OAuth::IdentityDomain Creation:: Negative#2
	[Tags]  	&{test_data}[test06.tags]
	[Documentation]		&{test_data}[test06.doc]
	Set Test Variable	${testName}    &{test_data}[test06.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test06.input.1]
	Set Request Body	&{test_data}[test06.input.2]
	${responseBody}	post	&{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test06.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

###########################################################################################
### Admin Testcases added for ACCESS_2016-12-16 Sprint
###IdentityDomain Creation POST
###http://aseng-wiki.us.oracle.com/asengwiki/display/ASQA/Single+Node+Server+with+Admin%2C+Runtime%2C+Issue+and+Validate
###Covers Single Node Server with Admin, Runtime, Issue and Validate FROM 13-18 on http for GET on OAuthIdentityDomain
###https not covered yet i.e from 19-24
###########################################################################################

oauth.admin00013:: OAM Admin OAuth::OAuthIdentityDomain Get:: Success
	[Tags]	    &{test_data}[test013.tags]
	[Documentation]		&{test_data}[test013.doc]
	Set Test Variable	${testName}    &{test_data}[test013.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Query Param    name    robot01
	${responseBody}	  get    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test013.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin00014:: OAM Admin OAuth::OAuthIdentityDomain Get:: Success
	[Tags]	    &{test_data}[test014.tags]
	[Documentation]		&{test_data}[test014.doc]
	Set Test Variable	${testName}    &{test_data}[test014.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Query Param    name    robot02
	${responseBody}	  get    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test014.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin00015:: OAM Admin OAuth::OAuthIdentityDomain Get:: Success
	[Tags]	    &{test_data}[test015.tags]
	[Documentation]		&{test_data}[test015.doc]
	Set Test Variable	${testName}    &{test_data}[test015.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Query Param    name    robot03
	${responseBody}	  get    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test015.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin00016:: OAM Admin OAuth::OAuthIdentityDomain Get:: Success
	[Tags]	    &{test_data}[test016.tags]
	[Documentation]		&{test_data}[test016.doc]
	Set Test Variable	${testName}    &{test_data}[test016.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Query Param    name    robot04
	${responseBody}	  get    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test016.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin00017:: OAM Admin OAuth::OAuthIdentityDomain Get:: Negative#1
	[Tags]	    &{test_data}[test017.tags]
	[Documentation]		&{test_data}[test017.doc]
	Set Test Variable	${testName}    &{test_data}[test017.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Query Param    name    robot01
	${responseBody}	  get    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test017.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin00018:: OAM Admin OAuth::OAuthIdentityDomain Get:: Negative#2
	[Tags]	    &{test_data}[test018.tags]
	[Documentation]		&{test_data}[test018.doc]
	Set Test Variable	${testName}    &{test_data}[test018.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Query Param    name     ""
	${responseBody}	  get    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test018.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin00013:: Clone OAM Admin OAuth::OAuthIdentityDomain Get:: Success
	[Tags]	    &{test_data}[test013.tags]
	[Documentation]		&{test_data}[test013.doc]
	sleep  60
	Set Test Variable	${testName}    &{test_data}[test013.logfile.name]
	Create Logger	${testName}
	Set Base URL	&{Init}[clone1.oam.admin.server]
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Query Param    name    robot01
	${responseBody}	  get    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test013.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin00014:: Clone OAM Admin OAuth::OAuthIdentityDomain Get:: Success
	[Tags]	    &{test_data}[test014.tags]
	[Documentation]		&{test_data}[test014.doc]
	Set Test Variable	${testName}    &{test_data}[test014.logfile.name]
	Create Logger	${testName}
	Set Base URL	&{Init}[clone1.oam.admin.server]
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Query Param    name    robot02
	${responseBody}	  get    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test014.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin00015:: Clone OAM Admin OAuth::OAuthIdentityDomain Get:: Success
	[Tags]	    &{test_data}[test015.tags]
	[Documentation]		&{test_data}[test015.doc]
	Set Test Variable	${testName}    &{test_data}[test015.logfile.name]
	Create Logger	${testName}
	Set Base URL	&{Init}[clone1.oam.admin.server]
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Query Param    name    robot03
	${responseBody}	  get    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test015.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin00016:: Clone OAM Admin OAuth::OAuthIdentityDomain Get:: Success
	[Tags]	    &{test_data}[test016.tags]
	[Documentation]		&{test_data}[test016.doc]
	Set Test Variable	${testName}    &{test_data}[test016.logfile.name]
	Create Logger	${testName}
	Set Base URL	&{Init}[clone1.oam.admin.server]
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Query Param    name    robot04
	${responseBody}	  get    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test016.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin00017:: Clone OAM Admin OAuth::OAuthIdentityDomain Get:: Negative#1
	[Tags]	    &{test_data}[test017.tags]
	[Documentation]		&{test_data}[test017.doc]
	Set Test Variable	${testName}    &{test_data}[test017.logfile.name]
	Create Logger	${testName}
	Set Base URL	&{Init}[clone1.oam.admin.server]
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Query Param    name    robot01
	${responseBody}	  get    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test017.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin00018:: Clone OAM Admin OAuth::OAuthIdentityDomain Get:: Negative#2
	[Tags]	    &{test_data}[test018.tags]
	[Documentation]		&{test_data}[test018.doc]
	Set Test Variable	${testName}    &{test_data}[test018.logfile.name]
	Create Logger	${testName}
	Set Base URL	&{Init}[clone1.oam.admin.server]
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Query Param    name     ""
	${responseBody}	  get    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test018.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

###########################################################################################
### Admin Testcases added for ACCESS_2016-12-16 Sprint
###IdentityDomain Creation POST
###http://aseng-wiki.us.oracle.com/asengwiki/display/ASQA/Single+Node+Server+with+Admin%2C+Runtime%2C+Issue+and+Validate
###Covers Single Node Server with Admin, Runtime, Issue and Validate FROM 25-30 on http  for PUT on OAuthIdentityDomain
###https not covered yet i.e from 31-36
###########################################################################################

oauth.admin0025:: OAM Admin OAuth::OAuthIdentityDomain Modify:: Success
	[Tags]	    &{test_data}[test025.tags]
	[Documentation]		&{test_data}[test025.doc]
	Set Test Variable	${testName}    &{test_data}[test025.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[common.json.contenttype]
	Set Query Param    name    robot01
	Set Request Body	&{test_data}[test025.input.1]
	${responseBody}	    put    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test025.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0026:: OAM Admin OAuth::OAuthIdentityDomain Modify:: Success
	[Tags]	    &{test_data}[test026.tags]
	[Documentation]		&{test_data}[test026.doc]
	Set Test Variable	${testName}    &{test_data}[test026.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[common.json.contenttype]
	Set Query Param    name    robot02
	Set Request Body	&{test_data}[test026.input.1]
	${responseBody}	    put    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test026.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0027:: OAM Admin OAuth::OAuthIdentityDomain Modify:: Success
	[Tags]	    &{test_data}[test027.tags]
	[Documentation]		&{test_data}[test027.doc]
	Set Test Variable	${testName}    &{test_data}[test027.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[common.json.contenttype]
	Set Query Param    name    robot03
	Set Request Body	&{test_data}[test027.input.1]
	${responseBody}	    put    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test027.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0028:: OAM Admin OAuth::OAuthIdentityDomain Modify:: Success
	[Tags]	    &{test_data}[test028.tags]
	[Documentation]		&{test_data}[test028.doc]
	Set Test Variable	${testName}    &{test_data}[test028.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[common.json.contenttype]
	Set Query Param    name    robot04
	Set Request Body	&{test_data}[test028.input.1]
	${responseBody}	    put    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test028.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0029:: OAM Admin OAuth::OAuthIdentityDomain Modify:: Negative#1
	[Tags]	    &{test_data}[test029.tags]
	[Documentation]		&{test_data}[test029.doc]
	Set Test Variable	${testName}    &{test_data}[test029.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[common.json.contenttype]
	Set Query Param    name     robot04
	Set Request Body	&{test_data}[test029.input.1]
	${responseBody}	    put    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test029.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0030:: OAM Admin OAuth::OAuthIdentityDomain Modify:: Negative#2
	[Tags]	    &{test_data}[test030.tags]
	[Documentation]		&{test_data}[test030.doc]
	Set Test Variable	${testName}    &{test_data}[test030.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[common.json.contenttype]
	Set Query Param    name    ""
	Set Request Body	&{test_data}[test030.input.1]
	${responseBody}	    put    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test030.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

##########################################################################################
## Admin Testcases added for ACCESS_2016-12-16 Sprint
##IdentityDomain Creation POST
##http://aseng-wiki.us.oracle.com/asengwiki/display/ASQA/Single+Node+Server+with+Admin%2C+Runtime%2C+Issue+and+Validate
##Covers Single Node Server with Admin, Runtime, Issue and Validate FROM 49-54 on http for POST on ResourceServer
##https not covered yet i.e from 55-60
##########################################################################################

oauth.admin0049:: OAM Admin OAuth::ResourceServer Creation:: Success
	[Tags]	    &{test_data}[test049.tags]
	[Documentation]		&{test_data}[test049.doc]
	Set Test Variable	${testName}    &{test_data}[test049.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test049.input.1]
	Set Request Body	&{test_data}[test049.input.2]
	${responseBody}	post	&{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test049.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth0005:: OAM Admin OAuth::ResourceServer Creation JSON:: Success
	[Tags]	    &{test_data}[test00050.tags]
	[Documentation]		&{test_data}[test00050.doc]
	Set Test Variable	${testName}    &{test_data}[test00050.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
 	Set Content Type	&{test_data}[test00050.input.1]
	Set Request Body	&{test_data}[test00050.input.2]
	${responseBody}	post	&{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test00050.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}


oauth.admin0050:: OAM Admin OAuth::ResourceServer Creation JSON:: Success
	[Tags]	    &{test_data}[test050.tags]
	[Documentation]		&{test_data}[test050.doc]
	Set Test Variable	${testName}    &{test_data}[test050.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
 	Set Content Type	&{test_data}[test050.input.1]
	Set Request Body	&{test_data}[test050.input.2]
	${responseBody}	post	&{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test050.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0051:: OAM Admin OAuth::ResourceServer Creation JSON:: Success
	[Tags]	    &{test_data}[test051.tags]
	[Documentation]		&{test_data}[test051.doc]
	Set Test Variable	${testName}    &{test_data}[test051.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
 	Set Content Type	&{test_data}[test051.input.1]
	Set Request Body	&{test_data}[test051.input.2]
	${responseBody}	post	&{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test051.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0052:: OAM Admin OAuth::ResourceServer Creation JSON:: Success
	[Tags]	    &{test_data}[test052.tags]
	[Documentation]		&{test_data}[test052.doc]
	Set Test Variable	${testName}    &{test_data}[test052.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
 	Set Content Type	&{test_data}[test052.input.1]
	Set Request Body	&{test_data}[test052.input.2]
	${responseBody}	post	&{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test052.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0053:: OAM Admin OAuth::ResourceServer Creation JSON:: Success
	[Tags]	    &{test_data}[test053.tags]
	[Documentation]		&{test_data}[test053.doc]
	Set Test Variable	${testName}    &{test_data}[test053.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
 	Set Content Type	&{test_data}[test053.input.1]
	Set Request Body	&{test_data}[test053.input.2]
	${responseBody}	post	&{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test053.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0054:: OAM Admin OAuth::ResourceServer Creation JSON:: Negative#1
	[Tags]	    &{test_data}[test054.tags]
	[Documentation]		&{test_data}[test054.doc]
	Set Test Variable	${testName}    &{test_data}[test054.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
 	Set Content Type	&{test_data}[test054.input.1]
	Set Request Body	&{test_data}[test054.input.2]
	${responseBody}	post	&{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test054.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

##########################################################################################
## Admin Testcases added for ACCESS_2016-12-16 Sprint
##IdentityDomain Creation POST
##http://aseng-wiki.us.oracle.com/asengwiki/display/ASQA/Single+Node+Server+with+Admin%2C+Runtime%2C+Issue+and+Validate
##Covers Single Node Server with Admin, Runtime, Issue and Validate FROM 61-66 on http for GET on ResourceServer
##https not covered yet i.e from 67-72
##########################################################################################

oauth0007:: OAM Admin OAuth::OAuthResourceServer Get:: Success
	[Tags]	    &{test_data}[test061.tags]
	[Documentation]		&{test_data}[test061.doc]
	Set Test Variable	${testName}    &{test_data}[test061.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Query Param    identityDomainName    robot01
	Set Query Param    name    RobotTestResSvr2
	${responseBody}	  get    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test061.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0062:: OAM Admin OAuth::OAuthResourceServer Get:: Success
	[Tags]	    &{test_data}[test16.tags]
	[Documentation]		&{test_data}[test16.doc]
	Set Test Variable	${testName}    &{test_data}[test16.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Query Param    identityDomainName    robot01
	Set Query Param    name    RobotTestResSvr2
	${responseBody}	  get    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test16.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0063:: OAM Admin OAuth::OAuthResourceServer Get:: Success
	[Tags]	    &{test_data}[test16.tags]
	[Documentation]		&{test_data}[test16.doc]
	Set Test Variable	${testName}    &{test_data}[test16.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Query Param    identityDomainName    robot01
	Set Query Param    name    ResourceSrv50
	${responseBody}	  get    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test16.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0064:: OAM Admin OAuth::OAuthResourceServer Get:: Success
	[Tags]	    &{test_data}[test16.tags]
	[Documentation]		&{test_data}[test16.doc]
	Set Test Variable	${testName}    &{test_data}[test16.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Query Param    identityDomainName    robot02
	Set Query Param    name    ResourceServer51
	${responseBody}	  get    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test16.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0065:: OAM Admin OAuth::OAuthResourceServer Get:: Success
	[Tags]	    &{test_data}[test16.tags]
	[Documentation]		&{test_data}[test16.doc]
	Set Test Variable	${testName}    &{test_data}[test16.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Query Param    identityDomainName    robot03
	Set Query Param    name    ResourceServer52
	${responseBody}	  get    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test16.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0066:: OAM Admin OAuth::OAuthResourceServer Get:: Negative#1
	[Tags]	    &{test_data}[test16.tags]
	[Documentation]		&{test_data}[test16.doc]
	Set Test Variable	${testName}    &{test_data}[test16.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Query Param    identityDomainName    robot01
	Set Query Param    name     ""
	${responseBody}	  get    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test16.expected.2]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth0007:: Clone OAM Admin OAuth::OAuthResourceServer Get:: Success
	[Tags]	    &{test_data}[test061.tags]
	[Documentation]		&{test_data}[test061.doc]
	Set Test Variable	${testName}    &{test_data}[test061.logfile.name]
	Create Logger	${testName}
	Set Base URL	&{Init}[clone1.oam.admin.server]
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Query Param    identityDomainName    robot01
	Set Query Param    name    RobotTestResSvr2
	${responseBody}	  get    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test061.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0062:: Clone OAM Admin OAuth::OAuthResourceServer Get:: Success
	[Tags]	    &{test_data}[test16.tags]
	[Documentation]		&{test_data}[test16.doc]
	sleep   60
	Set Test Variable	${testName}    &{test_data}[test16.logfile.name]
	Create Logger	${testName}
	Set Base URL	&{Init}[clone1.oam.admin.server]
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Query Param    identityDomainName    robot01
	Set Query Param    name    RobotTestResSvr2
	${responseBody}	  get    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test16.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0063:: Clone OAM Admin OAuth::OAuthResourceServer Get:: Success
	[Tags]	    &{test_data}[test16.tags]
	[Documentation]		&{test_data}[test16.doc]
	Set Test Variable	${testName}    &{test_data}[test16.logfile.name]
	Create Logger	${testName}
	Set Base URL	&{Init}[clone1.oam.admin.server]
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Query Param    identityDomainName    robot01
	Set Query Param    name    ResourceSrv50
	${responseBody}	  get    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test16.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0064:: Clone OAM Admin OAuth::OAuthResourceServer Get:: Success
	[Tags]	    &{test_data}[test16.tags]
	[Documentation]		&{test_data}[test16.doc]
	Set Test Variable	${testName}    &{test_data}[test16.logfile.name]
	Create Logger	${testName}
	Set Base URL	&{Init}[clone1.oam.admin.server]
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Query Param    identityDomainName    robot02
	Set Query Param    name    ResourceServer51
	${responseBody}	  get    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test16.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0065:: Clone OAM Admin OAuth::OAuthResourceServer Get:: Success
	[Tags]	    &{test_data}[test16.tags]
	[Documentation]		&{test_data}[test16.doc]
	Set Test Variable	${testName}    &{test_data}[test16.logfile.name]
	Create Logger	${testName}
	Set Base URL	&{Init}[clone1.oam.admin.server]
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Query Param    identityDomainName    robot03
	Set Query Param    name    ResourceServer52
	${responseBody}	  get    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test16.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0066:: Clone OAM Admin OAuth::OAuthResourceServer Get:: Negative#1
	[Tags]	    &{test_data}[test16.tags]
	[Documentation]		&{test_data}[test16.doc]
	Set Test Variable	${testName}    &{test_data}[test16.logfile.name]
	Create Logger	${testName}
	Set Base URL	&{Init}[clone1.oam.admin.server]
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Query Param    identityDomainName    robot01
	Set Query Param    name     ""
	${responseBody}	  get    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test16.expected.2]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

##########################################################################################
## Admin Testcases added for ACCESS_2016-12-16 Sprint
##IdentityDomain Creation POST
##http://aseng-wiki.us.oracle.com/asengwiki/display/ASQA/Single+Node+Server+with+Admin%2C+Runtime%2C+Issue+and+Validate
##Covers Single Node Server with Admin, Runtime, Issue and Validate FROM 73-78 on http for PUT on ResourceServer
##https not covered yet i.e from 79-84
##########################################################################################

oauth0006:: OAM Admin OAuth::ResourceServer Modify:: Success
	[Tags]	    &{test_data}[test073.tags]
	[Documentation]		&{test_data}[test073.doc]
	Set Test Variable	${testName}    &{test_data}[test073.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test073.input.1]
	Set Request Body	&{test_data}[test073.input.2]
	Set Query Param    name    RobotTestResSvr2
	${responseBody}	    put    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test073.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth0074:: OAM Admin OAuth::ResourceServer Modify:: Success
	[Tags]	    &{test_data}[test074.tags]
	[Documentation]		&{test_data}[test074.doc]
	Set Test Variable	${testName}    &{test_data}[test074.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test074.input.1]
	Set Request Body	&{test_data}[test074.input.2]
	Set Query Param    name    RobotTestResSvr2
	${responseBody}	    put    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test074.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth0075:: OAM Admin OAuth::ResourceServer Modify:: Success
	[Tags]	    &{test_data}[test075.tags]
	[Documentation]		&{test_data}[test075.doc]
	Set Test Variable	${testName}    &{test_data}[test075.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test075.input.1]
	Set Request Body	&{test_data}[test075.input.2]
	Set Query Param    name    ResourceSrv50
	${responseBody}	    put    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test075.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth0076:: OAM Admin OAuth::ResourceServer Modify:: Success
	[Tags]	    &{test_data}[test076.tags]
	[Documentation]		&{test_data}[test076.doc]
	Set Test Variable	${testName}    &{test_data}[test076.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test076.input.1]
	Set Request Body	&{test_data}[test076.input.2]
	Set Query Param    name    ResourceServer51
	${responseBody}	    put    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test076.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth0077:: OAM Admin OAuth::ResourceServer Modify:: Success
	[Tags]	    &{test_data}[test077.tags]
	[Documentation]		&{test_data}[test077.doc]
	Set Test Variable	${testName}    &{test_data}[test077.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test077.input.1]
	Set Request Body	&{test_data}[test077.input.2]
	Set Query Param    name    RobotTestResSvr3
	${responseBody}	    put    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test077.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth0078:: OAM Admin OAuth::ResourceServer Modify:: Negative#1
	[Tags]	    &{test_data}[test078.tags]
	[Documentation]		&{test_data}[test078.doc]
	Set Test Variable	${testName}    &{test_data}[test078.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test078.input.1]
	Set Request Body	&{test_data}[test078.input.2]
	Set Query Param    name     DNE
	${responseBody}	    put    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test078.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

##########################################################################################
## Admin Testcases added for ACCESS_2016-12-16 Sprint
##IdentityDomain Creation POST
##http://aseng-wiki.us.oracle.com/asengwiki/display/ASQA/Single+Node+Server+with+Admin%2C+Runtime%2C+Issue+and+Validate
##Covers Single Node Server with Admin, Runtime, Issue and Validate FROM 97-102 on http for POST on OAuthClient
##https not covered yet i.e from 103-108
##########################################################################################

oauth.admin0097:: OAM Admin OAuth::OAuthClient Creation:: Success
	[Tags]	    &{test_data}[test097.tags]
	[Documentation]		&{test_data}[test097.doc]
	Set Test Variable	${testName}    &{test_data}[test097.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
 	Set Content Type	&{test_data}[test097.input.1]
	Set Request Body	&{test_data}[test097.input.2]
	${responseBody}	post	&{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test097.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0098:: OAM Admin OAuth::OAuthClient Creation JSON:: Success
	[Tags]	    &{test_data}[test098.tags]
	[Documentation]		&{test_data}[test098.doc]
	Set Test Variable	${testName}    &{test_data}[test098.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
 	Set Content Type	&{test_data}[test098.input.1]
	Set Request Body	&{test_data}[test098.input.2]
	${responseBody}	post	&{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${cl_id} =    KW_GET_CLIENTID_FROM_RESP    ${responseBody}
    ${cl_sec} =    KW_GET_SECRET_FROM_RESP    ${responseBody}
    Set Suite Variable		${cl_id}
    Set Suite Variable		${cl_sec}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test098.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}


oauth.admin0099:: OAM Admin OAuth::OAuthClient Creation JSON:: Success
	[Tags]	    &{test_data}[test099.tags]
	[Documentation]		&{test_data}[test099.doc]
	Set Test Variable	${testName}    &{test_data}[test099.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
 	Set Content Type	&{test_data}[test099.input.1]
	Set Request Body	&{test_data}[test099.input.2]
	${responseBody}	post	&{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${cl_id} =    KW_GET_CLIENTID_FROM_RESP    ${responseBody}
    ${cl_sec} =    KW_GET_SECRET_FROM_RESP    ${responseBody}
    Set Suite Variable		${cl_id}
    Set Suite Variable		${cl_sec}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test099.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}


oauth.admin0100:: OAM Admin OAuth::OAuthClient Creation JSON:: Success
	[Tags]	    &{test_data}[test0100.tags]
	[Documentation]		&{test_data}[test0100.doc]
	Set Test Variable	${testName}    &{test_data}[test0100.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
 	Set Content Type	&{test_data}[test0100.input.1]
	Set Request Body	&{test_data}[test0100.input.2]
	${responseBody}	post	&{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${cl_id} =    KW_GET_CLIENTID_FROM_RESP    ${responseBody}
    ${cl_sec} =    KW_GET_SECRET_FROM_RESP    ${responseBody}
    Set Suite Variable		${cl_id}
    Set Suite Variable		${cl_sec}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0100.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}


oauth.admin0101:: OAM Admin OAuth::OAuthClient Creation JSON:: Negative Case 1
	[Tags]	    &{test_data}[test0101.tags]
	[Documentation]		&{test_data}[test0101.doc]
	Set Test Variable	${testName}    &{test_data}[test0101.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
 	Set Content Type	&{test_data}[test0101.input.1]
	Set Request Body	&{test_data}[test0101.input.2]
	${responseBody}	post	&{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	Response Bad Request
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0101.expected.1]		${testName}
	Should Start With	${responseBody}		&{test_data}[test0101.expected.2]
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}


oauth.admin0102:: OAM Admin OAuth::OAuthClient Creation JSON:: Negative Case 2
	[Tags]	    &{test_data}[test0102.tags]
	[Documentation]		&{test_data}[test0102.doc]
	Set Test Variable	${testName}    &{test_data}[test0102.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
 	Set Content Type	&{test_data}[test0102.input.1]
	Set Request Body	&{test_data}[test0102.input.2]
	${responseBody}	post	&{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
#	Response Bad Request
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0102.expected.1]		${testName}
	Should Start With	${responseBody}		&{test_data}[test0102.expected.2]
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

##########################################################################################
## Admin Testcases added for ACCESS_2016-12-16 Sprint
##IdentityDomain Creation POST
##http://aseng-wiki.us.oracle.com/asengwiki/display/ASQA/Single+Node+Server+with+Admin%2C+Runtime%2C+Issue+and+Validate
##Covers Single Node Server with Admin, Runtime, Issue and Validate FROM 109-114 on http for GET on OAuthClient
##https not covered yet i.e from 115-120
##########################################################################################

oauth0011:: OAM Admin OAuth::OAuthClient Get:: Success
	[Tags]	    &{test_data}[test0109.tags]
	[Documentation]		&{test_data}[test0109.doc]
	Set Test Variable	${testName}    &{test_data}[test0109.logfile.name]
	Set Base URL	&{Init}[oam.admin.server]
    Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
    Set Content Type	&{test_data}[test8.input.1]
	Create Logger	${testName}
	Set Query Param    identityDomainName    robot01
	Set Query Param    name    client0-1
	${responseBody}	  get    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0109.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0110:: OAM Admin OAuth::OAuthClient Get:: Success
	[Tags]	    &{test_data}[test0110.tags]
	[Documentation]		&{test_data}[test0110.doc]
	Set Test Variable	${testName}    &{test_data}[test0110.logfile.name]
	Set Base URL	&{Init}[oam.admin.server]
    Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
#    Set Content Type	&{test_data}[test0110.input.1]
	Create Logger	${testName}
	Set Query Param    identityDomainName    robot01
	Set Query Param    name    testclient1
	${responseBody}	  get    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0110.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0111:: OAM Admin OAuth::OAuthClient Get:: Success
	[Tags]	    &{test_data}[test0111.tags]
	[Documentation]		&{test_data}[test0111.doc]
	Set Test Variable	${testName}    &{test_data}[test0111.logfile.name]
	Set Base URL	&{Init}[oam.admin.server]
    Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
#    Set Content Type	&{test_data}[test0111.input.1]
	Create Logger	${testName}
	Set Query Param    identityDomainName    robot02
	Set Query Param    name    client0-2
	${responseBody}	  get    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0111.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0112:: OAM Admin OAuth::OAuthClient Get:: Success
	[Tags]	    &{test_data}[test0112.tags]
	[Documentation]		&{test_data}[test0112.doc]
	Set Test Variable	${testName}    &{test_data}[test0112.logfile.name]
	Set Base URL	&{Init}[oam.admin.server]
    Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
#    Set Content Type	&{test_data}[test0112.input.1]
	Create Logger	${testName}
	Set Query Param    identityDomainName    robot03
	Set Query Param    name    testclient4
	${responseBody}	  get    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0112.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0113:: OAM Admin OAuth::OAuthClient Get:: Success
	[Tags]	    &{test_data}[test0113.tags]
	[Documentation]		&{test_data}[test0113.doc]
	Set Test Variable	${testName}    &{test_data}[test0113.logfile.name]
	Set Base URL	&{Init}[oam.admin.server]
    Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
#    Set Content Type	&{test_data}[test0113.input.1]
	Create Logger	${testName}
	Set Query Param    identityDomainName    robot01
	Set Query Param    name    testclient1
	${responseBody}	  get    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0113.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0114:: OAM Admin OAuth::OAuthClient Get:: Success
	[Tags]	    &{test_data}[test0114.tags]
	[Documentation]		&{test_data}[test0114.doc]
	Set Test Variable	${testName}    &{test_data}[test0114.logfile.name]
	Set Base URL	&{Init}[oam.admin.server]
    Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
#    Set Content Type	&{test_data}[test0114.input.1]
	Create Logger	${testName}
	Set Query Param    identityDomainName       ""
	Set Query Param    name    testclient02
	${responseBody}	  get    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0114.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth0011:: Clone OAM Admin OAuth::OAuthClient Get:: Success
	[Tags]	    &{test_data}[test0109.tags]
	[Documentation]		&{test_data}[test0109.doc]
	sleep   60
	Set Test Variable	${testName}    &{test_data}[test0109.logfile.name]
	Set Base URL	&{Init}[clone1.oam.admin.server]
    Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
    Set Content Type	&{test_data}[test8.input.1]
	Create Logger	${testName}
	Set Query Param    identityDomainName    robot01
	Set Query Param    name    client0-1
	${responseBody}	  get    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0109.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0110:: Clone OAM Admin OAuth::OAuthClient Get:: Success
	[Tags]	    &{test_data}[test0110.tags]
	[Documentation]		&{test_data}[test0110.doc]
	Set Test Variable	${testName}    &{test_data}[test0110.logfile.name]
	Set Base URL	&{Init}[clone1.oam.admin.server]
    Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
#    Set Content Type	&{test_data}[test0110.input.1]
	Create Logger	${testName}
	Set Query Param    identityDomainName    robot01
	Set Query Param    name    testclient1
	${responseBody}	  get    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0110.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0111:: Clone OAM Admin OAuth::OAuthClient Get:: Success
	[Tags]	    &{test_data}[test0111.tags]
	[Documentation]		&{test_data}[test0111.doc]
	Set Test Variable	${testName}    &{test_data}[test0111.logfile.name]
	Set Base URL	&{Init}[clone1.oam.admin.server]
    Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
#    Set Content Type	&{test_data}[test0111.input.1]
	Create Logger	${testName}
	Set Query Param    identityDomainName    robot02
	Set Query Param    name    client0-2
	${responseBody}	  get    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0111.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0112:: Clone OAM Admin OAuth::OAuthClient Get:: Success
	[Tags]	    &{test_data}[test0112.tags]
	[Documentation]		&{test_data}[test0112.doc]
	Set Test Variable	${testName}    &{test_data}[test0112.logfile.name]
	Set Base URL	&{Init}[clone1.oam.admin.server]
    Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
#    Set Content Type	&{test_data}[test0112.input.1]
	Create Logger	${testName}
	Set Query Param    identityDomainName    robot03
	Set Query Param    name    testclient4
	${responseBody}	  get    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0112.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0113:: Clone OAM Admin OAuth::OAuthClient Get:: Success
	[Tags]	    &{test_data}[test0113.tags]
	[Documentation]		&{test_data}[test0113.doc]
	Set Test Variable	${testName}    &{test_data}[test0113.logfile.name]
	Set Base URL	&{Init}[clone1.oam.admin.server]
    Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
#    Set Content Type	&{test_data}[test0113.input.1]
	Create Logger	${testName}
	Set Query Param    identityDomainName    robot01
	Set Query Param    name    testclient1
	${responseBody}	  get    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0113.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0114:: Clone OAM Admin OAuth::OAuthClient Get:: Success
	[Tags]	    &{test_data}[test0114.tags]
	[Documentation]		&{test_data}[test0114.doc]
	Set Test Variable	${testName}    &{test_data}[test0114.logfile.name]
	Set Base URL	&{Init}[clone1.oam.admin.server]
    Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
#    Set Content Type	&{test_data}[test0114.input.1]
	Create Logger	${testName}
	Set Query Param    identityDomainName       ""
	Set Query Param    name    testclient02
	${responseBody}	  get    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0114.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

##########################################################################################
## Admin Testcases added for ACCESS_2016-12-16 Sprint
##IdentityDomain Creation POST
##http://aseng-wiki.us.oracle.com/asengwiki/display/ASQA/Single+Node+Server+with+Admin%2C+Runtime%2C+Issue+and+Validate
##Covers Single Node Server with Admin, Runtime, Issue and Validate FROM 121-127 on http for MODIFY on OAuthClient
##https not covered yet i.e from 128-132
##########################################################################################

oauth.admin0121:: OAM Admin OAuth::OAuthClient Modify:: Success
	[Tags]	&{test_data}[test0121.tags]
	[Documentation]		&{test_data}[test0121.doc]
	Set Test Variable	${testName}    &{test_data}[test0121.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test0121.input.1]
	Set Request Body	&{test_data}[test0121.input.2]
	Set Query Param    name    RobotTestResSvr2
	${responseBody}	    put    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0121.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0122:: OAM Admin OAuth::OAuthClient Modify:: Success
	[Tags]	&{test_data}[test0122.tags]
	[Documentation]		&{test_data}[test0122.doc]
	Set Test Variable	${testName}    &{test_data}[test0122.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test0122.input.1]
	Set Request Body	&{test_data}[test0122.input.2]
	Set Query Param    name    RobotTestResSvr2
	${responseBody}	    put    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0122.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0123:: OAM Admin OAuth::OAuthClient Modify:: Success
	[Tags]	&{test_data}[test0123.tags]
	[Documentation]		&{test_data}[test0123.doc]
	Set Test Variable	${testName}    &{test_data}[test0123.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test0123.input.1]
	Set Request Body	&{test_data}[test0123.input.2]
	Set Query Param    name    RobotTestResSvr2
	${responseBody}	    put    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0123.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0124:: OAM Admin OAuth::OAuthClient Modify:: Success
	[Tags]	&{test_data}[test0124.tags]
	[Documentation]		&{test_data}[test0124.doc]
	Set Test Variable	${testName}    &{test_data}[test0124.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test0124.input.1]
	Set Request Body	&{test_data}[test0124.input.2]
	Set Query Param    name    RobotTestResSvr2
	${responseBody}	    put    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0124.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0125:: OAM Admin OAuth::OAuthClient Modify:: Success
	[Tags]	&{test_data}[test0125.tags]
	[Documentation]		&{test_data}[test0125.doc]
	Set Test Variable	${testName}    &{test_data}[test0125.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test0125.input.1]
	Set Request Body	&{test_data}[test0125.input.2]
	Set Query Param    name    RobotTestResSvr2
	${responseBody}	    put    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0125.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0126:: OAM Admin OAuth::OAuthClient Modify:: Negative#1
	[Tags]	&{test_data}[test0126.tags]
	[Documentation]		&{test_data}[test0126.doc]
	Set Test Variable	${testName}    &{test_data}[test0126.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test0126.input.1]
	Set Request Body	&{test_data}[test0126.input.2]
	Set Query Param    name     ""
	${responseBody}	    put    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0126.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

#########################################################################################
# Admin Testcases added for ACCESS_2016-12-16 Sprint
#IdentityDomain Creation POST
#http://aseng-wiki.us.oracle.com/asengwiki/display/ASQA/Single+Node+Server+with+Admin%2C+Runtime%2C+Issue+and+Validate
#Covers Single Node Server with Admin, Runtime, Issue and Validate FROM 133-138 on http for DELETE on OAuthClient
#https not covered yet i.e from 139-144
#########################################################################################

oauth.admin0133:: OAM Admin OAuth::OAuthClient Deletion:: Success
	[Tags]	    &{test_data}[test0133.tags]
	[Documentation]		&{test_data}[test0133.doc]
	Set Test Variable	${testName}    &{test_data}[test0133.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test0133.input.1]
	#Set Request Body	&{test_data}[test0133.input.2]
	Set Query Param    identityDomainName    robot01
	Set Query Param    name    testclient1
	${responseBody}	delete    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0133.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0134:: OAM Admin OAuth::OAuthClient Deletion:: Success
	[Tags]	    &{test_data}[test0134.tags]
	[Documentation]		&{test_data}[test0134.doc]
	Set Test Variable	${testName}    &{test_data}[test0134.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Content Type	&{test_data}[test0134.input.1]
	#Set Request Body	&{test_data}[test0134.input.2]
	Set Query Param    identityDomainName    robot01
	Set Query Param    name    client0-1
	${responseBody}	delete    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0134.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0135:: OAM Admin OAuth::OAuthClient Deletion:: Success
	[Tags]	    &{test_data}[test0135.tags]
	[Documentation]		&{test_data}[test0135.doc]
	Set Test Variable	${testName}    &{test_data}[test0135.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Content Type	&{test_data}[test0135.input.1]
	#Set Request Body	&{test_data}[test0135.input.2]
	Set Query Param    identityDomainName    robot02
	Set Query Param    name    client0-2
	${responseBody}	delete    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0135.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0136:: OAM Admin OAuth::OAuthClient Deletion:: Success
	[Tags]	    &{test_data}[test0136.tags]
	[Documentation]		&{test_data}[test0136.doc]
	Set Test Variable	${testName}    &{test_data}[test0136.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Content Type	&{test_data}[test0136.input.1]
	#Set Request Body	&{test_data}[test0136.input.2]
	Set Query Param    identityDomainName    robot03
	Set Query Param    name    testclient4
	${responseBody}	delete    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0136.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0137:: OAM Admin OAuth::OAuthClient Deletion:: Negative#1
	[Tags]	    &{test_data}[test0137.tags]
	[Documentation]		&{test_data}[test0137.doc]
	Set Test Variable	${testName}    &{test_data}[test0137.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Content Type	&{test_data}[test0137.input.1]
	#Set Request Body	&{test_data}[test0137.input.2]
	Set Query Param    identityDomainName    robot01
	Set Query Param    name    testclient02
	${responseBody}	delete    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0137.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0138:: OAM Admin OAuth::OAuthClient Deletion:: Negative#2
	[Tags]	    &{test_data}[test0138.tags]
	[Documentation]		&{test_data}[test0138.doc]
	Set Test Variable	${testName}    &{test_data}[test0138.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Content Type	&{test_data}[test0138.input.1]
	#Set Request Body	&{test_data}[test0138.input.2]
	Set Query Param    identityDomainName       ""
	Set Query Param    name    testclient02
	${responseBody}	delete    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test0138.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}


##########################################################################################
## Admin Testcases added for ACCESS_2016-12-16 Sprint
##IdentityDomain Creation POST
##http://aseng-wiki.us.oracle.com/asengwiki/display/ASQA/Single+Node+Server+with+Admin%2C+Runtime%2C+Issue+and+Validate
##Covers Single Node Server with Admin, Runtime, Issue and Validate FROM 85-90 on http for DELETE on ResourceServer
##https not covered yet i.e from 91-96
##########################################################################################

oauth0008:: OAM Admin OAuth::ResourceServer Deletion:: Success
	[Tags]	&{test_data}[test085.tags]
	[Documentation]		&{test_data}[test085.doc]
	Set Test Variable	${testName}    &{test_data}[test085.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Content Type	&{test_data}[test085.input.1]
	#Set Request Body	&{test_data}[test085.input.2]
	Set Query Param    identityDomainName    robot01
	Set Query Param    name    RobotTestResSvr2
	${responseBody}	delete    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test085.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0086:: OAM Admin OAuth::ResourceServer Deletion:: Success
	[Tags]	&{test_data}[test086.tags]
	[Documentation]		&{test_data}[test086.doc]
	Set Test Variable	${testName}    &{test_data}[test086.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Content Type	&{test_data}[test086.input.1]
	#Set Request Body	&{test_data}[test086.input.2]
	Set Query Param    identityDomainName    robot01
	Set Query Param    name    RobotTestResSvr3
	${responseBody}	delete    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test086.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0087:: OAM Admin OAuth::ResourceServer Deletion:: Success
	[Tags]	&{test_data}[test087.tags]
	[Documentation]		&{test_data}[test087.doc]
	Set Test Variable	${testName}    &{test_data}[test087.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Content Type	&{test_data}[test087.input.1]
	#Set Request Body	&{test_data}[test087.input.2]
	Set Query Param    identityDomainName    robot01
	Set Query Param    name    ResourceSrv50
	${responseBody}	delete    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test087.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0088:: OAM Admin OAuth::ResourceServer Deletion:: Success
	[Tags]	&{test_data}[test088.tags]
	[Documentation]		&{test_data}[test088.doc]
	Set Test Variable	${testName}    &{test_data}[test088.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Content Type	&{test_data}[test088.input.1]
	#Set Request Body	&{test_data}[test088.input.2]
	Set Query Param    identityDomainName    robot02
	Set Query Param    name    ResourceServer51
	${responseBody}	delete    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test088.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0089:: OAM Admin OAuth::ResourceServer Deletion:: Negative#1
	[Tags]	&{test_data}[test089.tags]
	[Documentation]		&{test_data}[test089.doc]
	Set Test Variable	${testName}    &{test_data}[test089.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Content Type	&{test_data}[test089.input.1]
	#Set Request Body	&{test_data}[test089.input.2]
	Set Query Param    identityDomainName    robot01
	Set Query Param    name    RobotTestResSvr2
	${responseBody}	delete    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test089.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0090:: OAM Admin OAuth::ResourceServer Deletion:: Negative#2
	[Tags]	&{test_data}[test090.tags]
	[Documentation]		&{test_data}[test090.doc]
	Set Test Variable	${testName}    &{test_data}[test090.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Content Type	&{test_data}[test090.input.1]
	#Set Request Body	&{test_data}[test090.input.2]
	Set Query Param    identityDomainName       ""
	Set Query Param    name    RobotTestResSvr3
	${responseBody}	delete    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test090.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

##########################################################################################
## Admin Testcases added for ACCESS_2016-12-16 Sprint
##IdentityDomain Creation POST
##http://aseng-wiki.us.oracle.com/asengwiki/display/ASQA/Single+Node+Server+with+Admin%2C+Runtime%2C+Issue+and+Validate
##Covers Single Node Server with Admin, Runtime, Issue and Validate FROM 37-42 on http for DELETE on OAuthIdentityDomain
##https not covered yet i.e from 43-48
##########################################################################################

oauth.admin0037:: OAM Admin OAuth::OAuthIdentityDomain Deletion:: Success
	[Tags]	    &{test_data}[test037.tags]
	[Documentation]		&{test_data}[test037.doc]
	Set Test Variable	${testName}    &{test_data}[test037.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	log     &{Init}[oam.admin.username]
	log     &{Init}[oam.admin.pass]
	Set Content Type	&{test_data}[test037.input.1]
	#Set Request Body	&{test_data}[test037.input.2]
	Set Query Param    name    robot01
	${responseBody}	delete    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test037.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0038:: OAM Admin OAuth::OAuthIdentityDomain Deletion:: Success
	[Tags]	    &{test_data}[test038.tags]
	[Documentation]		&{test_data}[test038.doc]
	Set Test Variable	${testName}    &{test_data}[test038.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test038.input.1]
	#Set Request Body	&{test_data}[test038.input.2]
	Set Query Param    name    robot02
	${responseBody}	delete    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test038.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0039:: OAM Admin OAuth::OAuthIdentityDomain Deletion:: Success
	[Tags]	    &{test_data}[test039.tags]
	[Documentation]		&{test_data}[test039.doc]
	Set Test Variable	${testName}    &{test_data}[test039.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test039.input.1]
	#Set Request Body	&{test_data}[test039.input.2]
	Set Query Param    name    robot03
	${responseBody}	delete    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test039.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0040:: OAM Admin OAuth::OAuthIdentityDomain Deletion:: Success
	[Tags]	    &{test_data}[test040.tags]
	[Documentation]		&{test_data}[test040.doc]
	Set Test Variable	${testName}    &{test_data}[test040.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test040.input.1]
	#Set Request Body	&{test_data}[test040.input.2]
	Set Query Param    name    robot04
	${responseBody}	delete    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test040.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0041:: OAM Admin OAuth::OAuthIdentityDomain Deletion:: Negative#1
	[Tags]	    &{test_data}[test041.tags]
	[Documentation]		&{test_data}[test041.doc]
	Set Test Variable	${testName}    &{test_data}[test041.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test041.input.1]
	#Set Request Body	&{test_data}[test041.input.2]
	Set Query Param    name    robot01
	${responseBody}	delete    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test041.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0042:: OAM Admin OAuth::OAuthIdentityDomain Deletion:: Negative#2
	[Tags]	    &{test_data}[test042.tags]
	[Documentation]		&{test_data}[test042.doc]
	Set Test Variable	${testName}    &{test_data}[test042.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
	Set Content Type	&{test_data}[test042.input.1]
	#Set Request Body	&{test_data}[test042.input.2]
	Set Query Param    name     "NOTFINE"
	${responseBody}	delete    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[test042.expected.1]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth0015:: OAM Admin OAuth::Audit log generation:: Success
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

