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
	Initialize MDC Settings
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
oauth.admin00001:: OAM Admin OAuth::IdentityDomain Creation
    OAUTH ADMIN IDENTITYDOMAIN CREATION     &{test_data}[test01.tags]       &{test_data}[test01.doc]        &{test_data}[test01.logfile.name]   sample      &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[test01.input.1]    &{test_data}[test01.input.2]    &{test_data}[test01.expected.1]     &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
    LOG TO CONSOLE  SAMPLLLLELEEE

oauth.admin00002:: OAM Admin OAuth::IdentityDomain Creation
    OAUTH ADMIN IDENTITYDOMAIN CREATION     &{test_data}[test02.tags]       &{test_data}[test02.doc]        &{test_data}[test02.logfile.name]   sample      &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[test02.input.1]    &{test_data}[test02.input.2]    &{test_data}[test01.expected.1]     &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

oauth.admin00003:: OAM Admin OAuth::IdentityDomain Creation
    OAUTH ADMIN IDENTITYDOMAIN CREATION     &{test_data}[test03.tags]       &{test_data}[test03.doc]        &{test_data}[test03.logfile.name]   sample      &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[test03.input.1]    &{test_data}[test03.input.2]    &{test_data}[test01.expected.1]     &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

oauth.admin00004:: OAM Admin OAuth::IdentityDomain Creation
    OAUTH ADMIN IDENTITYDOMAIN CREATION     &{test_data}[test04.tags]       &{test_data}[test04.doc]        &{test_data}[test04.logfile.name]   sample      &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[test04.input.1]    &{test_data}[test04.input.2]    &{test_data}[test01.expected.1]     &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]


oauth.admin00005:: OAM Admin OAuth::IdentityDomain Creation:: Negative#1
    OAUTH ADMIN IDENTITYDOMAIN CREATION     &{test_data}[test05.tags]       &{test_data}[test05.doc]        &{test_data}[test05.logfile.name]   sample      &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[test05.input.1]    &{test_data}[test05.input.2]    &{test_data}[test05.expected.1]     &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

oauth.admin00006:: OAM Admin OAuth::IdentityDomain Creation:: Negative#2
    OAUTH ADMIN IDENTITYDOMAIN CREATION     &{test_data}[test06.tags]       &{test_data}[test06.doc]        &{test_data}[test06.logfile.name]   sample      &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[test06.input.1]    &{test_data}[test06.input.2]    &{test_data}[test06.expected.1]     &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

############################################################################################
#### Admin Testcases added for ACCESS_2016-12-16 Sprint
####IdentityDomain Creation POST
####http://aseng-wiki.us.oracle.com/asengwiki/display/ASQA/Single+Node+Server+with+Admin%2C+Runtime%2C+Issue+and+Validate
####Covers Single Node Server with Admin, Runtime, Issue and Validate FROM 13-18 on http for GET on OAuthIdentityDomain
####https not covered yet i.e from 19-24
############################################################################################
#
oauth.admin00013:: OAM Admin OAuth::OAuthIdentityDomain Get
    OAUTH ADMIN IDENTITYDOMAIN READ     &{test_data}[test013.tags]       &{test_data}[test013.doc]        &{test_data}[test013.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot01      &{test_data}[test013.expected.1]     &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

oauth.admin00014:: OAM Admin OAuth::OAuthIdentityDomain Get
    OAUTH ADMIN IDENTITYDOMAIN READ     &{test_data}[test014.tags]       &{test_data}[test014.doc]        &{test_data}[test014.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot02      &{test_data}[test014.expected.1]      &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

oauth.admin00015:: OAM Admin OAuth::OAuthIdentityDomain Get
    OAUTH ADMIN IDENTITYDOMAIN READ     &{test_data}[test015.tags]       &{test_data}[test015.doc]        &{test_data}[test015.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot03      &{test_data}[test013.expected.1]      &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

oauth.admin00016:: OAM Admin OAuth::OAuthIdentityDomain Get
    OAUTH ADMIN IDENTITYDOMAIN READ     &{test_data}[test016.tags]       &{test_data}[test016.doc]        &{test_data}[test016.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot04      &{test_data}[test016.expected.1]    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

oauth.admin00017:: OAM Admin OAuth::OAuthIdentityDomain Get:: Negative#1
    OAUTH ADMIN IDENTITYDOMAIN READ     &{test_data}[test017.tags]       &{test_data}[test017.doc]        &{test_data}[test017.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot01      &{test_data}[test017.expected.1]      &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

oauth.admin00018:: OAM Admin OAuth::OAuthIdentityDomain Get:: Negative#2
    OAUTH ADMIN IDENTITYDOMAIN READ     &{test_data}[test018.tags]       &{test_data}[test018.doc]        &{test_data}[test018.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       ""      &{test_data}[test018.expected.1]      &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

#WAIT FOR POLLINTERVEL TIME BEFORE HITTING CLONE
	sleep  60

oauth.admin00013:: Clone OAM Admin OAuth::OAuthIdentityDomain Get
    OAUTH ADMIN IDENTITYDOMAIN READ     &{test_data}[test013.tags]       &{test_data}[test013.doc]        &{test_data}[test013.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot01      &{test_data}[test013.expected.1]     &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

oauth.admin00014:: Clone OAM Admin OAuth::OAuthIdentityDomain Get
    OAUTH ADMIN IDENTITYDOMAIN READ     &{test_data}[test014.tags]       &{test_data}[test014.doc]        &{test_data}[test014.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot02      &{test_data}[test014.expected.1]      &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

oauth.admin00015:: Clone OAM Admin OAuth::OAuthIdentityDomain Get
    OAUTH ADMIN IDENTITYDOMAIN READ     &{test_data}[test015.tags]       &{test_data}[test015.doc]        &{test_data}[test015.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot03      &{test_data}[test013.expected.1]      &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

oauth.admin00016:: Clone OAM Admin OAuth::OAuthIdentityDomain Get
    OAUTH ADMIN IDENTITYDOMAIN READ     &{test_data}[test016.tags]       &{test_data}[test016.doc]        &{test_data}[test016.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot04      &{test_data}[test016.expected.1]    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

oauth.admin00017:: Clone OAM Admin OAuth::OAuthIdentityDomain Get:: Negative#1
    OAUTH ADMIN IDENTITYDOMAIN READ     &{test_data}[test017.tags]       &{test_data}[test017.doc]        &{test_data}[test017.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot01      &{test_data}[test017.expected.1]      &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

oauth.admin00018:: Clone OAM Admin OAuth::OAuthIdentityDomain Get:: Negative#2
    OAUTH ADMIN IDENTITYDOMAIN READ     &{test_data}[test018.tags]       &{test_data}[test018.doc]        &{test_data}[test018.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       ""      &{test_data}[test018.expected.1]      &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

############################################################################################
#### Admin Testcases added for ACCESS_2016-12-16 Sprint
####IdentityDomain Creation POST
####http://aseng-wiki.us.oracle.com/asengwiki/display/ASQA/Single+Node+Server+with+Admin%2C+Runtime%2C+Issue+and+Validate
####Covers Single Node Server with Admin, Runtime, Issue and Validate FROM 25-30 on http  for PUT on OAuthIdentityDomain
####https not covered yet i.e from 31-36
############################################################################################


oauth.admin0025:: OAM Admin OAuth::OAuthIdentityDomain Modify
    OAUTH ADMIN IDENTITYDOMAIN MODIFY     &{test_data}[test025.tags]       &{test_data}[test025.doc]        &{test_data}[test025.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     robot01     &{test_data}[test025.input.1]   &{test_data}[test025.expected.1]    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

oauth.admin0026:: OAM Admin OAuth::OAuthIdentityDomain Modify
    OAUTH ADMIN IDENTITYDOMAIN MODIFY     &{test_data}[test026.tags]       &{test_data}[test026.doc]        &{test_data}[test026.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     robot02     &{test_data}[test026.input.1]   &{test_data}[test026.expected.1]    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

oauth.admin0027:: OAM Admin OAuth::OAuthIdentityDomain Modify
    OAUTH ADMIN IDENTITYDOMAIN MODIFY     &{test_data}[test027.tags]       &{test_data}[test027.doc]        &{test_data}[test027.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     robot03     &{test_data}[test027.input.1]   &{test_data}[test027.expected.1]    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

oauth.admin0028:: OAM Admin OAuth::OAuthIdentityDomain Modify
    OAUTH ADMIN IDENTITYDOMAIN MODIFY     &{test_data}[test028.tags]       &{test_data}[test028.doc]        &{test_data}[test028.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     robot04     &{test_data}[test028.input.1]   &{test_data}[test028.expected.1]    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

oauth.admin0029:: OAM Admin OAuth::OAuthIdentityDomain Modify:: Negative#1
    OAUTH ADMIN IDENTITYDOMAIN MODIFY     &{test_data}[test029.tags]       &{test_data}[test029.doc]        &{test_data}[test029.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     robot04     &{test_data}[test029.input.1]   &{test_data}[test029.expected.1]    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

oauth.admin0030:: OAM Admin OAuth::OAuthIdentityDomain Modify:: Negative#2
    OAUTH ADMIN IDENTITYDOMAIN MODIFY     &{test_data}[test030.tags]       &{test_data}[test030.doc]        &{test_data}[test030.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     ""      &{test_data}[test030.input.1]   &{test_data}[test030.expected.1]    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

#WAIT FOR POLLINTERVEL TIME BEFORE HITTING CLONE
#WE ARE HITTING AGAIN AGAINST CLONE, TO GET THE MODIFIED ARTIFACT DETAILS
	sleep  60

oauth.admin00013:: Clone OAM Admin OAuth::OAuthIdentityDomain Get
    OAUTH ADMIN IDENTITYDOMAIN READ     &{test_data}[test013.tags]       &{test_data}[test013.doc]        &{test_data}[test013.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot01      &{test_data}[test013.expected.1]     &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

oauth.admin00014:: Clone OAM Admin OAuth::OAuthIdentityDomain Get
    OAUTH ADMIN IDENTITYDOMAIN READ     &{test_data}[test014.tags]       &{test_data}[test014.doc]        &{test_data}[test014.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot02      &{test_data}[test014.expected.1]      &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

oauth.admin00015:: Clone OAM Admin OAuth::OAuthIdentityDomain Get
    OAUTH ADMIN IDENTITYDOMAIN READ     &{test_data}[test015.tags]       &{test_data}[test015.doc]        &{test_data}[test015.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot03      &{test_data}[test013.expected.1]      &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

oauth.admin00016:: Clone OAM Admin OAuth::OAuthIdentityDomain Get
    OAUTH ADMIN IDENTITYDOMAIN READ     &{test_data}[test016.tags]       &{test_data}[test016.doc]        &{test_data}[test016.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot04      &{test_data}[test016.expected.1]    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

###########################################################################################
### Admin Testcases added for ACCESS_2016-12-16 Sprint
###IdentityDomain Creation POST
###http://aseng-wiki.us.oracle.com/asengwiki/display/ASQA/Single+Node+Server+with+Admin%2C+Runtime%2C+Issue+and+Validate
###Covers Single Node Server with Admin, Runtime, Issue and Validate FROM 49-54 on http for POST on ResourceServer
###https not covered yet i.e from 55-60
###########################################################################################

oauth.admin0049:: OAM Admin OAuth::ResourceServer Creation
    OAUTH ADMIN RESOURCESERVER CREATION     &{test_data}[test049.tags]       &{test_data}[test049.doc]        &{test_data}[test049.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[test049.input.1]    &{test_data}[test049.input.2]    &{test_data}[test049.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]


oauth0005:: OAM Admin OAuth::ResourceServer Creation JSON
    OAUTH ADMIN RESOURCESERVER CREATION     &{test_data}[test00050.tags]       &{test_data}[test00050.doc]        &{test_data}[test00050.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[test00050.input.1]    &{test_data}[test00050.input.2]    &{test_data}[test00050.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]

oauth.admin0050:: OAM Admin OAuth::ResourceServer Creation JSON
    OAUTH ADMIN RESOURCESERVER CREATION     &{test_data}[test050.tags]       &{test_data}[test050.doc]        &{test_data}[test050.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[test050.input.1]    &{test_data}[test050.input.2]    &{test_data}[test050.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]

oauth.admin0051:: OAM Admin OAuth::ResourceServer Creation JSON
    OAUTH ADMIN RESOURCESERVER CREATION     &{test_data}[test051.tags]       &{test_data}[test051.doc]        &{test_data}[test051.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[test051.input.1]    &{test_data}[test051.input.2]    &{test_data}[test051.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]


oauth.admin0052:: OAM Admin OAuth::ResourceServer Creation JSON
    OAUTH ADMIN RESOURCESERVER CREATION     &{test_data}[test052.tags]       &{test_data}[test052.doc]        &{test_data}[test052.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[test052.input.1]    &{test_data}[test052.input.2]    &{test_data}[test052.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]

oauth.admin0053:: OAM Admin OAuth::ResourceServer Creation JSON
    OAUTH ADMIN RESOURCESERVER CREATION     &{test_data}[test053.tags]       &{test_data}[test053.doc]        &{test_data}[test053.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[test053.input.1]    &{test_data}[test053.input.2]    &{test_data}[test053.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]

oauth.admin0054:: OAM Admin OAuth::ResourceServer Creation JSON:: Negative#1
    OAUTH ADMIN RESOURCESERVER CREATION     &{test_data}[test054.tags]       &{test_data}[test054.doc]        &{test_data}[test054.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[test054.input.1]    &{test_data}[test054.input.2]    &{test_data}[test054.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]


###########################################################################################
### Admin Testcases added for ACCESS_2016-12-16 Sprint
###IdentityDomain Creation POST
###http://aseng-wiki.us.oracle.com/asengwiki/display/ASQA/Single+Node+Server+with+Admin%2C+Runtime%2C+Issue+and+Validate
###Covers Single Node Server with Admin, Runtime, Issue and Validate FROM 61-66 on http for GET on ResourceServer
###https not covered yet i.e from 67-72
###########################################################################################

oauth0007:: OAM Admin OAuth::OAuthResourceServer Get
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test061.tags]       &{test_data}[test061.doc]        &{test_data}[test061.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot01    RobotTestResSvr2    &{test_data}[test061.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]

oauth.admin0062:: OAM Admin OAuth::OAuthResourceServer Get
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test16.tags]       &{test_data}[test16.doc]        &{test_data}[test16.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot01    RobotTestResSvr2    &{test_data}[test16.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]

oauth.admin0063:: OAM Admin OAuth::OAuthResourceServer Get
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test16.tags]       &{test_data}[test16.doc]        &{test_data}[test16.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot01    ResourceSrv50    &{test_data}[test16.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]

oauth.admin0064:: OAM Admin OAuth::OAuthResourceServer Get
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test16.tags]       &{test_data}[test16.doc]        &{test_data}[test16.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot02    ResourceServer51    &{test_data}[test16.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]

oauth.admin0065:: OAM Admin OAuth::OAuthResourceServer Get
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test16.tags]       &{test_data}[test16.doc]        &{test_data}[test16.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot03    ResourceServer52    &{test_data}[test16.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]

oauth.admin0066:: OAM Admin OAuth::OAuthResourceServer Get:: Negative#1
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test16.tags]       &{test_data}[test16.doc]        &{test_data}[test16.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot01    ""    &{test_data}[test16.expected.2]     &{test_data}[common.oauth.admin.resource.rest.endpoint]

oauth0007:: Clone OAM Admin OAuth::OAuthResourceServer Get
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test061.tags]       &{test_data}[test061.doc]        &{test_data}[test061.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot01    RobotTestResSvr2    &{test_data}[test061.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]

oauth.admin0062:: Clone OAM Admin OAuth::OAuthResourceServer Get
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test16.tags]       &{test_data}[test16.doc]        &{test_data}[test16.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot01    RobotTestResSvr2    &{test_data}[test16.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]

oauth.admin0063:: Clone OAM Admin OAuth::OAuthResourceServer Get
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test16.tags]       &{test_data}[test16.doc]        &{test_data}[test16.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot01    ResourceSrv50    &{test_data}[test16.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]

oauth.admin0064:: Clone OAM Admin OAuth::OAuthResourceServer Get
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test16.tags]       &{test_data}[test16.doc]        &{test_data}[test16.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot02    ResourceServer51    &{test_data}[test16.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]


oauth.admin0065:: Clone OAM Admin OAuth::OAuthResourceServer Get
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test16.tags]       &{test_data}[test16.doc]        &{test_data}[test16.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot03    ResourceServer52    &{test_data}[test16.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]


oauth.admin0066:: Clone OAM Admin OAuth::OAuthResourceServer Get:: Negative#1
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test16.tags]       &{test_data}[test16.doc]        &{test_data}[test16.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot01    ""    &{test_data}[test16.expected.2]     &{test_data}[common.oauth.admin.resource.rest.endpoint]


###########################################################################################
### Admin Testcases added for ACCESS_2016-12-16 Sprint
###IdentityDomain Creation POST
###http://aseng-wiki.us.oracle.com/asengwiki/display/ASQA/Single+Node+Server+with+Admin%2C+Runtime%2C+Issue+and+Validate
###Covers Single Node Server with Admin, Runtime, Issue and Validate FROM 73-78 on http for PUT on ResourceServer
###https not covered yet i.e from 79-84
###########################################################################################
#
oauth0006:: OAM Admin OAuth::ResourceServer Modify
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE MODIFY     &{test_data}[test073.tags]       &{test_data}[test073.doc]        &{test_data}[test073.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     RobotTestResSvr2     &{test_data}[test073.input.2]   &{test_data}[test073.expected.1]    &{test_data}[common.oauth.admin.resource.rest.endpoint]

#
oauth0074:: OAM Admin OAuth::ResourceServer Modify
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE MODIFY     &{test_data}[test074.tags]       &{test_data}[test074.doc]        &{test_data}[test074.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     RobotTestResSvr2     &{test_data}[test074.input.2]   &{test_data}[test074.expected.1]    &{test_data}[common.oauth.admin.resource.rest.endpoint]

#
oauth0075:: OAM Admin OAuth::ResourceServer Modify
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE MODIFY     &{test_data}[test075.tags]       &{test_data}[test075.doc]        &{test_data}[test075.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     ResourceSrv50     &{test_data}[test075.input.2]   &{test_data}[test075.expected.1]    &{test_data}[common.oauth.admin.resource.rest.endpoint]

#
oauth0076:: OAM Admin OAuth::ResourceServer Modify
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE MODIFY     &{test_data}[test076.tags]       &{test_data}[test076.doc]        &{test_data}[test076.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     ResourceServer51     &{test_data}[test076.input.2]   &{test_data}[test076.expected.1]    &{test_data}[common.oauth.admin.resource.rest.endpoint]

#
oauth0077:: OAM Admin OAuth::ResourceServer Modify
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE MODIFY     &{test_data}[test077.tags]       &{test_data}[test077.doc]        &{test_data}[test077.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     RobotTestResSvr3     &{test_data}[test077.input.2]   &{test_data}[test077.expected.1]    &{test_data}[common.oauth.admin.resource.rest.endpoint]

#
oauth0078:: OAM Admin OAuth::ResourceServer Modify:: Negative#1
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE MODIFY     &{test_data}[test078.tags]       &{test_data}[test078.doc]        &{test_data}[test078.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     DNE     &{test_data}[test078.input.2]   &{test_data}[test078.expected.1]    &{test_data}[common.oauth.admin.resource.rest.endpoint]


oauth.admin0065:: Clone OAM Admin OAuth::OAuthResourceServer Get
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test16.tags]       &{test_data}[test16.doc]        &{test_data}[test16.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot01    RobotTestResSvr2    &{test_data}[test16.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]


oauth.admin0065:: Clone OAM Admin OAuth::OAuthResourceServer Get
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test16.tags]       &{test_data}[test16.doc]        &{test_data}[test16.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot01    RobotTestResSvr3    &{test_data}[test16.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]

oauth.admin0065:: Clone OAM Admin OAuth::OAuthResourceServer Get
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test16.tags]       &{test_data}[test16.doc]        &{test_data}[test16.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot01    ResourceSrv50    &{test_data}[test16.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]

oauth.admin0065:: Clone OAM Admin OAuth::OAuthResourceServer Get
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test16.tags]       &{test_data}[test16.doc]        &{test_data}[test16.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot02    ResourceServer51    &{test_data}[test16.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]

oauth.admin0065:: Clone OAM Admin OAuth::OAuthResourceServer Get
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test16.tags]       &{test_data}[test16.doc]        &{test_data}[test16.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot01    RobotTestResSvr3    &{test_data}[test16.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]

###########################################################################################
### Admin Testcases added for ACCESS_2016-12-16 Sprint
###IdentityDomain Creation POST
###http://aseng-wiki.us.oracle.com/asengwiki/display/ASQA/Single+Node+Server+with+Admin%2C+Runtime%2C+Issue+and+Validate
###Covers Single Node Server with Admin, Runtime, Issue and Validate FROM 97-102 on http for POST on OAuthClient
###https not covered yet i.e from 103-108
###########################################################################################
#
oauth.admin0097:: OAM Admin OAuth::OAuthClient Creation
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
#
oauth.admin0098:: OAM Admin OAuth::OAuthClient Creation JSON
    OAUTH ADMIN CLIENT CREATION     &{test_data}[test098.tags]       &{test_data}[test098.doc]        &{test_data}[test098.logfile.name]   sample      &{Init}[master.oam.admin.server]    &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[test098.input.1]    &{test_data}[test098.input.2]    &{test_data}[test098.expected.1]     &{test_data}[common.oauth.admin.client.rest.endpoint]
#
oauth.admin0099:: OAM Admin OAuth::OAuthClient Creation JSON
    OAUTH ADMIN CLIENT CREATION     &{test_data}[test099.tags]       &{test_data}[test099.doc]        &{test_data}[test099.logfile.name]   sample      &{Init}[master.oam.admin.server]    &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[test099.input.1]    &{test_data}[test099.input.2]    &{test_data}[test099.expected.1]     &{test_data}[common.oauth.admin.client.rest.endpoint]
#
oauth.admin0100:: OAM Admin OAuth::OAuthClient Creation JSON
    OAUTH ADMIN CLIENT CREATION     &{test_data}[test0100.tags]       &{test_data}[test0100.doc]        &{test_data}[test0100.logfile.name]   sample      &{Init}[master.oam.admin.server]    &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[test0100.input.1]    &{test_data}[test0100.input.2]    &{test_data}[test0100.expected.1]     &{test_data}[common.oauth.admin.client.rest.endpoint]
#
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

###########################################################################################
### Admin Testcases added for ACCESS_2016-12-16 Sprint
###IdentityDomain Creation POST
###http://aseng-wiki.us.oracle.com/asengwiki/display/ASQA/Single+Node+Server+with+Admin%2C+Runtime%2C+Issue+and+Validate
###Covers Single Node Server with Admin, Runtime, Issue and Validate FROM 109-114 on http for GET on OAuthClient
###https not covered yet i.e from 115-120
###########################################################################################
#
oauth0011:: OAM Admin OAuth::OAuthClient Get
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test0109.tags]       &{test_data}[test0109.doc]        &{test_data}[test0109.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot01    client0-1    &{test_data}[test0109.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]
#
oauth.admin0110:: OAM Admin OAuth::OAuthClient Get
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test0110.tags]       &{test_data}[test0110.doc]        &{test_data}[test0110.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot01    testclient1    &{test_data}[test0110.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]
#
oauth.admin0111:: OAM Admin OAuth::OAuthClient Get    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test0111.tags]       &{test_data}[test0111.doc]        &{test_data}[test0111.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot02    client0-2    &{test_data}[test0111.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]
#
oauth.admin0112:: OAM Admin OAuth::OAuthClient Get
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test0112.tags]       &{test_data}[test0112.doc]        &{test_data}[test16.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot03    testclient4    &{test_data}[test0112.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]
#
oauth.admin0113:: OAM Admin OAuth::OAuthClient Get
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test0113.tags]       &{test_data}[test0113.doc]        &{test_data}[test0113.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot01    testclient1    &{test_data}[test0113.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]
#
oauth.admin0114:: OAM Admin OAuth::OAuthClient Get
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test0114.tags]       &{test_data}[test0114.doc]        &{test_data}[test0114.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       ""    testclient02    &{test_data}[test0114.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]
#
oauth0011:: Clone OAM Admin OAuth::OAuthClient Get
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test0109.tags]       &{test_data}[test0109.doc]        &{test_data}[test0109.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot01    client0-1    &{test_data}[test0109.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]
#
oauth.admin0110:: Clone OAM Admin OAuth::OAuthClient Get
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test0110.tags]       &{test_data}[test0110.doc]        &{test_data}[test16.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot01    testclient1    &{test_data}[test0110.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]
#
oauth.admin0111:: Clone OAM Admin OAuth::OAuthClient Get
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test0111.tags]       &{test_data}[test0111.doc]        &{test_data}[test0111.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot02    client0-2    &{test_data}[test0111.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]
#
oauth.admin0112:: Clone OAM Admin OAuth::OAuthClient Get
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test0112.tags]       &{test_data}[test0112.doc]        &{test_data}[test0112.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot03    testclient4    &{test_data}[test0112.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]
#
oauth.admin0113:: Clone OAM Admin OAuth::OAuthClient Get
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test0113.tags]       &{test_data}[test0113.doc]        &{test_data}[test0113.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       robot01    testclient1    &{test_data}[test0113.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]
#
oauth.admin0114:: Clone OAM Admin OAuth::OAuthClient Get
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ     &{test_data}[test0114.tags]       &{test_data}[test0114.doc]        &{test_data}[test0114.logfile.name]   sample      &{Init}[clone1.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       ""    testclient02    &{test_data}[test0114.expected.1]     &{test_data}[common.oauth.admin.resource.rest.endpoint]
#
###########################################################################################
### Admin Testcases added for ACCESS_2016-12-16 Sprint
###IdentityDomain Creation POST
###http://aseng-wiki.us.oracle.com/asengwiki/display/ASQA/Single+Node+Server+with+Admin%2C+Runtime%2C+Issue+and+Validate
###Covers Single Node Server with Admin, Runtime, Issue and Validate FROM 121-127 on http for MODIFY on OAuthClient
###https not covered yet i.e from 128-132
###########################################################################################

oauth.admin0121:: OAM Admin OAuth::OAuthClient Modify
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE MODIFY     &{test_data}[test0121.tags]       &{test_data}[test0121.doc]        &{test_data}[test0121.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     RobotTestResSvr2     &{test_data}[test0121.input.2]   &{test_data}[test0121.expected.1]    &{test_data}[common.oauth.admin.client.rest.endpoint]
#
oauth.admin0122:: OAM Admin OAuth::OAuthClient Modify
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE MODIFY     &{test_data}[test0122.tags]       &{test_data}[test0122.doc]        &{test_data}[test0122.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     RobotTestResSvr2     &{test_data}[test0122.input.2]   &{test_data}[test0122.expected.1]    &{test_data}[common.oauth.admin.client.rest.endpoint] &{test_data}[common.oauth.admin.resource.rest.endpoint]
#
oauth.admin0123:: OAM Admin OAuth::OAuthClient Modify
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE MODIFY     &{test_data}[test0123.tags]       &{test_data}[test0123.doc]        &{test_data}[test0123.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     RobotTestResSvr2     &{test_data}[test0123.input.2]   &{test_data}[test0123.expected.1]    &{test_data}[common.oauth.admin.client.rest.endpoint]
#
oauth.admin0124:: OAM Admin OAuth::OAuthClient Modify
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE MODIFY     &{test_data}[test0124.tags]       &{test_data}[test0124.doc]        &{test_data}[test0124.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     RobotTestResSvr2     &{test_data}[test0124.input.2]   &{test_data}[test0124.expected.1]    &{test_data}[common.oauth.admin.client.rest.endpoint]
#
oauth.admin0125:: OAM Admin OAuth::OAuthClient Modify
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE MODIFY     &{test_data}[test0125.tags]       &{test_data}[test0125.doc]        &{test_data}[test0125.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     RobotTestResSvr2     &{test_data}[test0125.input.2]   &{test_data}[test0125.expected.1]    &{test_data}[common.oauth.admin.client.rest.endpoint]
#
oauth.admin0126:: OAM Admin OAuth::OAuthClient Modify:: Negative#1
    OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE MODIFY     &{test_data}[test0126.tags]       &{test_data}[test0126.doc]        &{test_data}[test0126.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     ""     &{test_data}[test0126.input.2]   &{test_data}[test0126.expected.1]    &{test_data}[common.oauth.admin.client.rest.endpoint]
#
##########################################################################################
## Admin Testcases added for ACCESS_2016-12-16 Sprint
##IdentityDomain Creation POST
##http://aseng-wiki.us.oracle.com/asengwiki/display/ASQA/Single+Node+Server+with+Admin%2C+Runtime%2C+Issue+and+Validate
##Covers Single Node Server with Admin, Runtime, Issue and Validate FROM 133-138 on http for DELETE on OAuthClient
##https not covered yet i.e from 139-144
##########################################################################################
#
oauth.admin0133:: OAM Admin OAuth::OAuthClient Deletion
    OAUTH ADMIN RESOURCESERVER CLIENTPROFILE DELETE OPERATION     &{test_data}[test0133.tags]       &{test_data}[test0133.doc]        &{test_data}[test0133.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     robot01     testclient1   &{test_data}[test0133.expected.1]    &{test_data}[common.oauth.admin.client.rest.endpoint]
#
oauth.admin0134:: OAM Admin OAuth::OAuthClient Deletion
    OAUTH ADMIN RESOURCESERVER CLIENTPROFILE DELETE OPERATION     &{test_data}[test0133.tags]       &{test_data}[test0133.doc]        &{test_data}[test0133.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     robot01     testclient1   &{test_data}[test0133.expected.1]    &{test_data}[common.oauth.admin.client.rest.endpoint]
#
oauth.admin0135:: OAM Admin OAuth::OAuthClient Deletion
    OAUTH ADMIN RESOURCESERVER CLIENTPROFILE DELETE OPERATION     &{test_data}[test0135.tags]       &{test_data}[test0135.doc]        &{test_data}[test0135.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     robot02     client0-2   &{test_data}[test0135.expected.1]    &{test_data}[common.oauth.admin.client.rest.endpoint]
#
oauth.admin0136:: OAM Admin OAuth::OAuthClient Deletion
    OAUTH ADMIN RESOURCESERVER CLIENTPROFILE DELETE OPERATION     &{test_data}[test0136.tags]       &{test_data}[test0136.doc]        &{test_data}[test0136.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     robot03     testclient4   &{test_data}[test0136.expected.1]    &{test_data}[common.oauth.admin.client.rest.endpoint]
#
oauth.admin0137:: OAM Admin OAuth::OAuthClient Deletion:: Negative#1
    OAUTH ADMIN RESOURCESERVER CLIENTPROFILE DELETE OPERATION     &{test_data}[test0137.tags]       &{test_data}[test0137.doc]        &{test_data}[test0137.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     robot01     testclient02   &{test_data}[test0137.expected.1]    &{test_data}[common.oauth.admin.client.rest.endpoint]
#
oauth.admin0138:: OAM Admin OAuth::OAuthClient Deletion:: Negative#2
    OAUTH ADMIN RESOURCESERVER CLIENTPROFILE DELETE OPERATION     &{test_data}[test0138.tags]       &{test_data}[test0138.doc]        &{test_data}[test0138.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     ""     testclient02   &{test_data}[test0138.expected.1]    &{test_data}[common.oauth.admin.client.rest.endpoint]
#
###########################################################################################
### Admin Testcases added for ACCESS_2016-12-16 Sprint
###IdentityDomain Creation POST
###http://aseng-wiki.us.oracle.com/asengwiki/display/ASQA/Single+Node+Server+with+Admin%2C+Runtime%2C+Issue+and+Validate
###Covers Single Node Server with Admin, Runtime, Issue and Validate FROM 85-90 on http for DELETE on ResourceServer
###https not covered yet i.e from 91-96
###########################################################################################
#
oauth0008:: OAM Admin OAuth::ResourceServer Deletion
    OAUTH ADMIN RESOURCESERVER CLIENTPROFILE DELETE OPERATION     &{test_data}[test085.tags]       &{test_data}[test085.doc]        &{test_data}[test085.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     robot01     RobotTestResSvr2   &{test_data}[test085.expected.1]    &{test_data}[common.oauth.admin.resource.rest.endpoint]

oauth.admin0086:: OAM Admin OAuth::ResourceServer Deletion
    OAUTH ADMIN RESOURCESERVER CLIENTPROFILE DELETE OPERATION     &{test_data}[test086.tags]       &{test_data}[test086.doc]        &{test_data}[test086.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     robot01     RobotTestResSvr3   &{test_data}[test086.expected.1]    &{test_data}[common.oauth.admin.resource.rest.endpoint]

oauth.admin0087:: OAM Admin OAuth::ResourceServer Deletion
    OAUTH ADMIN RESOURCESERVER CLIENTPROFILE DELETE OPERATION     &{test_data}[test087.tags]       &{test_data}[test087.doc]        &{test_data}[test087.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     robot01     ResourceSrv50   &{test_data}[test087.expected.1]    &{test_data}[common.oauth.admin.resource.rest.endpoint]

oauth.admin0088:: OAM Admin OAuth::ResourceServer Deletion
    OAUTH ADMIN RESOURCESERVER CLIENTPROFILE DELETE OPERATION     &{test_data}[test088.tags]       &{test_data}[test088.doc]        &{test_data}[test088.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     robot02     ResourceServer51   &{test_data}[test088.expected.1]    &{test_data}[common.oauth.admin.resource.rest.endpoint]

oauth.admin0089:: OAM Admin OAuth::ResourceServer Deletion:: Negative#1
    OAUTH ADMIN RESOURCESERVER CLIENTPROFILE DELETE OPERATION     &{test_data}[test089.tags]       &{test_data}[test089.doc]        &{test_data}[test089.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     robot01     RobotTestResSvr2   &{test_data}[test089.expected.1]    &{test_data}[common.oauth.admin.resource.rest.endpoint]

oauth.admin0090:: OAM Admin OAuth::ResourceServer Deletion:: Negative#2
    OAUTH ADMIN RESOURCESERVER CLIENTPROFILE DELETE OPERATION     &{test_data}[test090.tags]       &{test_data}[test090.doc]        &{test_data}[test090.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     ""     RobotTestResSvr3   &{test_data}[test090.expected.1]    &{test_data}[common.oauth.admin.resource.rest.endpoint]
#
###########################################################################################
### Admin Testcases added for ACCESS_2016-12-16 Sprint
###IdentityDomain Creation POST
###http://aseng-wiki.us.oracle.com/asengwiki/display/ASQA/Single+Node+Server+with+Admin%2C+Runtime%2C+Issue+and+Validate
###Covers Single Node Server with Admin, Runtime, Issue and Validate FROM 37-42 on http for DELETE on OAuthIdentityDomain
###https not covered yet i.e from 43-48
###########################################################################################
oauth.admin0037:: OAM Admin OAuth::OAuthIdentityDomain Deletion
    OAUTH ADMIN IDENTITYDOMAIN DELETE OPERATION     &{test_data}[test037.tags]       &{test_data}[test037.doc]        &{test_data}[test090.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     robot01   &{test_data}[test090.expected.1]    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
#
oauth.admin0038:: OAM Admin OAuth::OAuthIdentityDomain Deletion
    OAUTH ADMIN IDENTITYDOMAIN DELETE OPERATION     &{test_data}[test038.tags]       &{test_data}[test038.doc]        &{test_data}[test038.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     robot02   &{test_data}[test038.expected.1]    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

oauth.admin0039:: OAM Admin OAuth::OAuthIdentityDomain Deletion
    OAUTH ADMIN IDENTITYDOMAIN DELETE OPERATION     &{test_data}[test039.tags]       &{test_data}[test039.doc]        &{test_data}[test039.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     robot03   &{test_data}[test039.expected.1]    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

oauth.admin0040:: OAM Admin OAuth::OAuthIdentityDomain Deletion
    OAUTH ADMIN IDENTITYDOMAIN DELETE OPERATION     &{test_data}[test040.tags]       &{test_data}[test040.doc]        &{test_data}[test040.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     robot04   &{test_data}[test040.expected.1]    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]
#
oauth.admin0041:: OAM Admin OAuth::OAuthIdentityDomain Deletion:: Negative#1
    OAUTH ADMIN IDENTITYDOMAIN DELETE OPERATION     &{test_data}[test041.tags]       &{test_data}[test041.doc]        &{test_data}[test090.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     robot01   &{test_data}[test041.expected.1]    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

oauth.admin0042:: OAM Admin OAuth::OAuthIdentityDomain Deletion:: Negative#2
    OAUTH ADMIN IDENTITYDOMAIN DELETE OPERATION     &{test_data}[test042.tags]       &{test_data}[test042.doc]        &{test_data}[test042.logfile.name]   sample      &{Init}[master.oam.admin.server]     &{Init}[master.oam.admin.username]     &{Init}[master.oam.admin.pass]       &{test_data}[common.json.contenttype]     "NOTFINE"   &{test_data}[test042.expected.1]    &{test_data}[common.oauth.admin.identitydomain.rest.endpoint]

oauth0015:: OAM Admin OAuth::Audit log generation
    OAUTHADMIN AUDIT LOG GENERATION     &{test_data}[test17.tags]       &{test_data}[test17.doc]        &{test_data}[test17.logfile.name]   sample      OAuthIDDomainCreation   &{init}[oam.domain.home]/servers/AdminServer/logs/auditlogs/OAM/audit.log

oauth0016:: OAM Admin OAuth::Audit log generation
    OAUTHADMIN AUDIT LOG GENERATION     &{test_data}[test17.tags]       &{test_data}[test17.doc]        &{test_data}[test17.logfile.name]   sample      OAuthIDDomainModification   &{init}[oam.domain.home]/servers/AdminServer/logs/auditlogs/OAM/audit.log

oauth0017:: OAM Admin OAuth::Audit log generation
    OAUTHADMIN AUDIT LOG GENERATION     &{test_data}[test17.tags]       &{test_data}[test17.doc]        &{test_data}[test17.logfile.name]   sample      OAuthIDDOmainDeletion   &{init}[oam.domain.home]/servers/AdminServer/logs/auditlogs/OAM/audit.log

oauth0018:: OAM Admin OAuth::Audit log generation
    OAUTHADMIN AUDIT LOG GENERATION     &{test_data}[test17.tags]       &{test_data}[test17.doc]        &{test_data}[test17.logfile.name]   sample      OAuthResourceServerCreation   &{init}[oam.domain.home]/servers/AdminServer/logs/auditlogs/OAM/audit.log

oauth0019:: OAM Admin OAuth::Audit log generation
    OAUTHADMIN AUDIT LOG GENERATION     &{test_data}[test17.tags]       &{test_data}[test17.doc]        &{test_data}[test17.logfile.name]   sample      OAuthResourceServerModification   &{init}[oam.domain.home]/servers/AdminServer/logs/auditlogs/OAM/audit.log

oauth0020:: OAM Admin OAuth::Audit log generation
    OAUTHADMIN AUDIT LOG GENERATION     &{test_data}[test17.tags]       &{test_data}[test17.doc]        &{test_data}[test17.logfile.name]   sample      OAuthResourceServerDeletion   &{init}[oam.domain.home]/servers/AdminServer/logs/auditlogs/OAM/audit.log

oauth0021:: OAM Admin OAuth::Audit log generation
    OAUTHADMIN AUDIT LOG GENERATION     &{test_data}[test17.tags]       &{test_data}[test17.doc]        &{test_data}[test17.logfile.name]   sample      OAuthClientProfileCreation   &{init}[oam.domain.home]/servers/AdminServer/logs/auditlogs/OAM/audit.log

oauth0022:: OAM Admin OAuth::Audit log generation
    OAUTHADMIN AUDIT LOG GENERATION     &{test_data}[test17.tags]       &{test_data}[test17.doc]        &{test_data}[test17.logfile.name]   sample      OAuthClientProfileModification   &{init}[oam.domain.home]/servers/AdminServer/logs/auditlogs/OAM/audit.log

oauth0022:: OAM Admin OAuth::Audit log generation
    OAUTHADMIN AUDIT LOG GENERATION     &{test_data}[test17.tags]       &{test_data}[test17.doc]        &{test_data}[test17.logfile.name]   sample      OAuthClientProfileDeletion   &{init}[oam.domain.home]/servers/AdminServer/logs/auditlogs/OAM/audit.log