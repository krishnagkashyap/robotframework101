#*** Settings ***
#Documentation  OAM OAuth TestSuite
#Library		String
#Library		OperatingSystem
#Library     Json
#Resource    ../../../../resources/keywords/idm/oam/oauth/oam_oauth_common.robot
#
#Suite Setup	Setup Env
#Test Teardown	Remove Log locks
#
#
#*** Keywords ***
#Setup Env
#	Initialize Settings
#    Initialize Test Data	 idm/idcs/srv/oam_oauth_policyadmin_testsuite.properties
#    Set Base URL	&{Init}[master.oam.admin.server]
#    Set Basic Auth	&{Init}[master.oam.admin.username]    &{Init}[master.oam.admin.pass]
#
#WRITE JSON TO FILE
#	[Arguments]	${fileName}     ${content}
#    Create File	${fileName}     ${content}
#    File Should Exist   ${fileName}
#
#SET IDCS TENENT VALUES
#        &{idcsparameters}     create dictionary
#        Set To Dictionary       ${idparameters}     oauthClientId=&{Init}[oam.idcs.oauthclientid]
#        Set To Dictionary       ${idparameters}     errorPageURL=&{3ldict}[oam.3l.vars.errorPageURL]
#        Set To Dictionary       ${idparameters}     name=&{test_data}[3l.idDomain.name]
#    #    Set To Dictionary       ${idparameters}     identityProvider=&{test_data}[3l.identityProvider]
#        Set To Dictionary       ${idparameters}     identityProvider=&{Init}[oam.idstore]
#
############################################################################################
#### Admin Testcases added for ACCESS_2016-12-16 Sprint
####IdentityDomain Creation POST
####http://aseng-wiki.us.oracle.com/asengwiki/display/ASQA/Single+Node+Server+with+Admin%2C+Runtime%2C+Issue+and+Validate
####Covers Single Node Server with Admin, Runtime, Issue and Validate FROM 13-18 on http for POST on OAuthIdentityDomain
####https not covered yet i.e from 19-24
############################################################################################
#*** Test Cases ***
#idcs.wg1
#	[Tags]      &{test_data}[test01.tags]
#	[Documentation]		&{test_data}[test01.doc]
#    LOG TO CONSOLE      &{test_data}[idcs.wg.cloud.config]
#    WRITE JSON TO FILE     $webgate_path/cloud.config      &{test_data}[idcs.wg.cloud.config]
#
#
#
