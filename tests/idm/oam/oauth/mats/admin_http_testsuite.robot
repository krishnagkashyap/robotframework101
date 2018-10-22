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
    Set Base URL	&{Init}[oam.admin.server]
    Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]

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
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Content Type	&{test_data}[test01.input.1]
	Set Request Body	&{test_data}[test01.input.2]
	${responseBody}	post	&{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[http.status.200]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin00002:: OAM Admin OAuth::IdentityDomain Creation:: Success
	[Tags]  	&{test_data}[test02.tags]
	[Documentation]		&{test_data}[test02.doc]
	Set Test Variable	${testName}    &{test_data}[test02.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Content Type	&{test_data}[test02.input.1]
	Set Request Body	&{test_data}[test02.input.2]
	${responseBody}	post	&{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[http.status.200]	${testName}
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
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Query Param    name    robot01
	${responseBody}	  get    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[http.status.200]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin00014:: OAM Admin OAuth::OAuthIdentityDomain Get:: Success
	[Tags]	    &{test_data}[test014.tags]
	[Documentation]		&{test_data}[test014.doc]
	Set Test Variable	${testName}    &{test_data}[test014.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Query Param    name    robot02
	${responseBody}	  get    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[http.status.200]	${testName}
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
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Content Type	&{test_data}[common.json.contenttype]
	Set Query Param    name    robot01
	Set Request Body	&{test_data}[test025.input.1]
	${responseBody}	    put    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[http.status.200]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0026:: OAM Admin OAuth::OAuthIdentityDomain Modify:: Success
	[Tags]	    &{test_data}[test026.tags]
	[Documentation]		&{test_data}[test026.doc]
	Set Test Variable	${testName}    &{test_data}[test026.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Content Type	&{test_data}[common.json.contenttype]
	Set Query Param    name    robot02
	Set Request Body	&{test_data}[test026.input.1]
	${responseBody}	    put    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[http.status.200]	${testName}
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
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Content Type	&{test_data}[test049.input.1]
	Set Request Body	&{test_data}[test049.input.2]
	${responseBody}	post	&{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[http.status.200]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth0005:: OAM Admin OAuth::ResourceServer Creation JSON:: Success
	[Tags]	    &{test_data}[test00050.tags]
	[Documentation]		&{test_data}[test00050.doc]
	Set Test Variable	${testName}    &{test_data}[test00050.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
 	Set Content Type	&{test_data}[test00050.input.1]
	Set Request Body	&{test_data}[test00050.input.2]
	${responseBody} post	&{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[http.status.200]	${testName}
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
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Query Param    identityDomainName    robot01
	Set Query Param    name    RobotTestResSvr2
	${responseBody}	  get    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[http.status.200]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0062:: OAM Admin OAuth::OAuthResourceServer Get:: Success
	[Tags]	    &{test_data}[test16.tags]
	[Documentation]		&{test_data}[test16.doc]
	Set Test Variable	${testName}    &{test_data}[test16.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Query Param    identityDomainName    robot01
	Set Query Param    name    RobotTestResSvr2
	${responseBody}	  get    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[http.status.200]	${testName}
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
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Content Type	&{test_data}[test073.input.1]
	Set Request Body	&{test_data}[test073.input.2]
	Set Query Param    name    RobotTestResSvr2
	${responseBody}	    put    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[http.status.200]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth0074:: OAM Admin OAuth::ResourceServer Modify:: Success
	[Tags]	    &{test_data}[test074.tags]
	[Documentation]		&{test_data}[test074.doc]
	Set Test Variable	${testName}    &{test_data}[test074.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Content Type	&{test_data}[test074.input.1]
	Set Request Body	&{test_data}[test074.input.2]
	Set Query Param    name    RobotTestResSvr2
	${responseBody}	    put    &{test_data}[common.oauth.admin.resource.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[http.status.200]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

##########################################################################################
## Admin Testcases added for ACCESS_2016-12-16 Sprint
##IdentityDomain Creation POST
##http://aseng-wiki.us.oracle.com/asengwiki/display/ASQA/Single+Node+Server+with+Admin%2C+Runtime%2C+Issue+and+Validate
##Covers Single Node Server with Admin, Runtime, Issue and Validate FROM 97-102 on http for POST on OAuthClient
##https not covered yet i.e from 103-108
##########################################################################################

#### Commenting the simple create test case
#oauth.admin0097:: OAM Admin OAuth::OAuthClient Creation:: Success
#	[Tags]	    &{test_data}[test097.tags]
#	[Documentation]		&{test_data}[test097.doc]
#	Set Test Variable	${testName}    &{test_data}[test097.logfile.name]
#	Create Logger	${testName}
#	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
# 	Set Content Type	&{test_data}[test097.input.1]
#	Set Request Body	&{test_data}[test097.input.2]
#	${responseBody}	post	&{test_data}[common.oauth.admin.client.rest.endpoint]
#	Write To Log	${responseBody}
#	${status}	Get Status
#	${actual}	Convert To String	${status}
#	OAM Assert	${actual}	&{test_data}[http.status.200]	${testName}
#	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
#	Attach Diff	${testName}	${result}

oauth.admin0098:: OAM Admin OAuth::OAuthClient Creation JSON:: Success
	[Tags]	    &{test_data}[test098.tags]
	[Documentation]		&{test_data}[test098.doc]
	Set Test Variable	${testName}    &{test_data}[test098.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
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
	OAM Assert	${actual}	&{test_data}[http.status.200]	${testName}
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
    Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
    Set Content Type	&{test_data}[test8.input.1]
	Create Logger	${testName}
	Set Query Param    identityDomainName    robot01
	Set Query Param    name    client0-1
	${responseBody}	  get    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[http.status.200]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

##Commenting due to simple create
#oauth.admin0110:: OAM Admin OAuth::OAuthClient Get:: Success
#	[Tags]	    &{test_data}[test0110.tags]
#	[Documentation]		&{test_data}[test0110.doc]
#	Set Test Variable	${testName}    &{test_data}[test0110.logfile.name]
#	Set Base URL	&{Init}[oam.admin.server]
 #   Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
#    Set Content Type	&{test_data}[test0110.input.1]
#	Create Logger	${testName}
#	Set Query Param    identityDomainName    robot01
#	Set Query Param    name    testclient1
#	${responseBody}	  get    &{test_data}[common.oauth.admin.client.rest.endpoint]
#	Write To Log	${responseBody}
#	${status}	Get Status
#	${actual}	Convert To String	${status}
#	OAM Assert	${actual}	&{test_data}[http.status.200]	${testName}
#	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
#	Attach Diff	${testName}	${result}

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
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Content Type	&{test_data}[test0121.input.1]
	Set Request Body	&{test_data}[test0121.input.2]
	Set Query Param    name    RobotTestResSvr2
	${responseBody}	    put    &{test_data}[common.oauth.admin.client.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[http.status.200]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}


#########################################################################################
# Admin Testcases added for ACCESS_2016-12-16 Sprint
#IdentityDomain Creation POST
#http://aseng-wiki.us.oracle.com/asengwiki/display/ASQA/Single+Node+Server+with+Admin%2C+Runtime%2C+Issue+and+Validate
#Covers Single Node Server with Admin, Runtime, Issue and Validate FROM 133-138 on http for DELETE on OAuthClient
#https not covered yet i.e from 139-144
#########################################################################################

###Commenting due to simple create
#oauth.admin0133:: OAM Admin OAuth::OAuthClient Deletion:: Success
#	[Tags]	    &{test_data}[test0133.tags]
#	[Documentation]		&{test_data}[test0133.doc]
#	Set Test Variable	${testName}    &{test_data}[test0133.logfile.name]
#	Create Logger	${testName}
#	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
#	Set Content Type	&{test_data}[test0133.input.1]
#	#Set Request Body	&{test_data}[test0133.input.2]
#	Set Query Param    identityDomainName    robot01
#	Set Query Param    name    testclient1
#	${responseBody}	delete    &{test_data}[common.oauth.admin.client.rest.endpoint]
#	Write To Log	${responseBody}
#	${status}	Get Status
#	${actual}	Convert To String	${status}
#	OAM Assert	${actual}	&{test_data}[http.status.200]	${testName}
#	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
#	Attach Diff	${testName}	${result}

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
	OAM Assert	${actual}	&{test_data}[http.status.200]	${testName}
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
	OAM Assert	${actual}	&{test_data}[http.status.200]	${testName}
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
	OAM Assert	${actual}	&{test_data}[http.status.200]	${testName}
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
	Set Basic Auth  &{Init}[oam.admin.username]     &{Init}[oam.admin.pass]
	log     &{Init}[oam.admin.username]
	log     &{Init}[oam.admin.pass]
	Set Content Type	&{test_data}[test037.input.1]
	#Set Request Body	&{test_data}[test037.input.2]
	Set Query Param    name    robot01
	${responseBody}	delete    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[http.status.200]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth.admin0038:: OAM Admin OAuth::OAuthIdentityDomain Deletion:: Success
	[Tags]	    &{test_data}[test038.tags]
	[Documentation]		&{test_data}[test038.doc]
	Set Test Variable	${testName}    &{test_data}[test038.logfile.name]
	Create Logger	${testName}
	Set Basic Auth	&{Init}[oam.admin.username]   &{Init}[oam.admin.pass]
	Set Content Type	&{test_data}[test038.input.1]
	#Set Request Body	&{test_data}[test038.input.2]
	Set Query Param    name    robot02
	${responseBody}	delete    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
	Write To Log	${responseBody}
	${status}	Get Status
	${actual}	Convert To String	${status}
	OAM Assert	${actual}	&{test_data}[http.status.200]	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}

oauth0015:: OAM Admin OAuth::Audit log generation:: Success
	[Tags]	    &{test_data}[test17.tags]
	[Documentation]		&{test_data}[test17.doc]
	Set Test Variable	${testName}    &{test_data}[test17.logfile.name]
	Create Logger	${testName}
	${str}	Grep File	&{init}[oam.domain.home]/servers/AdminServer/logs/auditlogs/OAM/audit.log	OAuthIDDomainCreation	encoding_errors=ignore
	${count}	Get Line Count	${str}
	${str_count}	Convert To String	${count}
	Write To Log	${str_count}
	${var}=	Set Variable If	${count} > 0	AUDIT_LOGS_CREATED	NO_AUDIT_LOGS
	OAM Assert	${var}	AUDIT_LOGS_CREATED	${testName}
	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
	Attach Diff	${testName}	${result}
