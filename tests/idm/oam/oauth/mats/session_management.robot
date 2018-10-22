*** Settings ***
Documentation  OAM Session Management TestCases

Library     Selenium2Library
Library     String
Library     Process
Suite Setup	 Prerequisites
Test Teardown  Cleanup
Test Setup    DeleteAllActiveSessions  
Resource    ../../../../../resources/keywords/idm/oam/common/ui_keywords.robot
Resource	../../../../../resources/keywords/common/init.robot



*** keywords ***
Cleanup
	Run Keyword If Test Failed    Set Max no of sessions per user
	Close All Browsers

Prerequisites
	Initialize Settings for SME
	Initialize Test Data    idm/oam/sme/sme.properties
	init.Initialize oamconsole xpaths    oamconsole.properties
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	Click Delete All User Sessions    &{Init}[oam.admin.username]
	Sleep    5s
	Close All Browsers

DeleteAllActiveSessions
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	Click Delete All User Sessions    &{Init}[oam.admin.username]
	Close All Browsers

Set Max no of sessions per user
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass] 
	Goto Common Settings Page
	Set Number of sessions per user   &{test_data}[sme.maxnoofsessionsperuser]
	Wait Until Page Contains    &{test_data}[sme.profilechangemessage]
	OAMConsole Logout
	
Resource log in
	SSO Resource Login    &{Init}[resource_url]    &{Init}[resource_username]    &{Init}[resource_pwd]
	Wait Until Page Contains    &{test_data}[sme.resourceafterloginpagedata]
	Page Should Contain    &{test_data}[sme.resourceafterloginpagedata]

Set Max no of sessions per user(complete flow)
	[Arguments]    ${temp}
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	Goto Common Settings Page
	Set Number of sessions per user   ${temp}
	OAMConsole Logout

Get Max no of sessions per user(complete flow)
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	Goto Common Settings Page
	${temp}    Get Number of sessions per user   
	OAMConsole Logout
	[return]    ${temp}

Get List of all the active sessions
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	${ListofActiveSessions}    Get List of Active Sessions    &{Init}[oam.admin.username] 
	OAMConsole Logout
	[return]    ${ListofActiveSessions}

Set session lifetime(complete flow)
	[Arguments]    ${temp}
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	Goto Common Settings Page  
	Set Session Lifetime    ${temp}
	OAMConsole Logout

Get session lifetime(complete flow)
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	Goto Common Settings Page  
	${temp}    Get Session Lifetime    
	OAMConsole Logout
	[return]    ${temp}

Set app domain timeout(complete flow)
	[Arguments]    ${temp}
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	Goto Application Domain Page    &{Init}[resource_appdomain]
	Set App domain Timeout    ${temp}       &{Init}[resource_appdomain]
	sleep    15s
	OAMConsole Logout
Get app domain timeout(complete flow)
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	Goto Application Domain Page    &{Init}[resource_appdomain]
	${temp}    Get App domain Timeout    &{Init}[resource_appdomain]
	sleep    15s
	OAMConsole Logout
	[return]    ${temp}

Active Sessions Should be NULL
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	${ListofActiveSessions}    Get List of Active Sessions    &{Init}[oam.admin.username]
	Should Be Equal As Strings    ${ListofActiveSessions}    'NULL'



*** Test Cases ***

SME Test 1::session lifetime
	[Documentation]         Setting app domain time out =0 so that it does not over ride session lifetime attribute,  creating a session and sleep for the time duration
	...			Sleep of 60s inserted after setting session attributes because thats the time lag for policy sync to happen
	Resource log in
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
        Goto Common Settings Page  
        Set Session Lifetime   &{test_data}[sme.1.sessionlifetime]
	Set Idle Timeout     &{test_data}[sme.1.sessionidletimeout]
	OAMConsole Logout	
	Set app domain timeout(complete flow)    &{test_data}[sme.1.domaintimeout] 
	Sleep    60s  
	${temp}    Get session lifetime(complete flow)  
	Should Be Equal As Integers    ${temp}    &{test_data}[sme.1.sessionlifetime]
	Resource log in
        Page Should Contain    &{test_data}[sme.resourceafterloginpagedata]
        Sleep    &{test_data}[sme.1.sessionlifetime]m        
        Reload Page
        Page Should Contain    &{test_data}[sme.resourceloginpagedata]
	

SME Test 2::session idle timeout	
	[Documentation]         Setting app domain time out =0 so that it does not over ride session lifetime attribute,  creating a session and reloading session after 1 min to(to make session not idle before idle 		...			time out and start clock again for idle timeout) and later waiting for idle time out		
	...			Sleep of 60s inserted after setting session attributes because thats the time lag for policy sync to happen

	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
        Goto Common Settings Page  
        Set Session Lifetime   &{test_data}[sme.2.sessionlifetime]
	Set Idle Timeout     &{test_data}[sme.2.sessionidletimeout]
	OAMConsole Logout
	Set app domain timeout(complete flow)    &{test_data}[sme.2.domaintimeout]
	Sleep    60s
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
        Goto Common Settings Page  
	${temp}    Get Idle Timeout     
	OAMConsole Logout
	Should Be Equal As Integers    ${temp}    &{test_data}[sme.2.sessionidletimeout]
        Resource log in
        Page Should Contain    &{test_data}[sme.resourceafterloginpagedata]
        Sleep    60s
	Reload Page
        Page Should Contain    &{test_data}[sme.resourceafterloginpagedata]
        Sleep    &{test_data}[sme.2.sessionidletimeout]m
	Reload Page
        Page Should Contain    &{test_data}[sme.resourceloginpagedata] 


SME Test 3::app dmain time out
	[Documentation]		App domain time if not set=0, should override session lifetime, to verify the same we have set app domain timeout>session lifetime and session should expire after sleep of
	...			app domain time out being set.Sleep of 60s inserted after setting session attributes because thats the time lag for policy sync to happen
	
        SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
        Goto Common Settings Page  
        Set Session Lifetime   &{test_data}[sme.3.sessionlifetime]
	Set Idle Timeout     &{test_data}[sme.3.sessionidletimeout]
	OAMConsole Logout
	Set app domain timeout(complete flow)    &{test_data}[sme.3.domaintimeout]
	${setValueOfAppDomianTimeout}    Get app domain timeout(complete flow)
	Sleep    60s
	Should Be Equal As Integers    ${setValueOfAppDomianTimeout}    &{test_data}[sme.3.domaintimeout]
	Resource log in
	Sleep    &{test_data}[sme.3.domaintimeout]m   
	Reload Page
	Page Should Contain    &{test_data}[sme.resourceloginpagedata]
	Set app domain timeout(complete flow)    0


SME Test 4::Delete All Sessions
	[Documentation]		It clicks on delete all user session from SME UI and gets the list of active sessions which should be NULL

	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	DeleteAllActiveSessions
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	${ListofActiveSessions}    Get List of Active Sessions    &{Init}[oam.admin.username]
	Should Be Equal As Strings    ${ListofActiveSessions}    'NULL'
	Close All Browsers
	Active Sessions Should be NULL

SME Test 5::Log out from a resource
	[Documentation]	This tests performs log out from a resource and check if session got deleted in SME UI or not.The log out URL here is global log out URL(load balancer port no)

	Resource log in
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	${oldestsession}    Get Session Id    &{Init}[oam.admin.username]    1
	Close Browser
	Go To    &{Init}[oam.globallogouturl]
	Wait Until Page Contains     &{test_data}[sme.logoutpage]
	Page Should Contain    &{test_data}[sme.logoutpage]
	Sleep    60s
	


SME Test 6::Delete a user session
	[Documentation]		This test verifies whether deletion of a single sessions from SME UI throws log in page for a create session

        Resource log in
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	${SessionId}    Get Session Id    &{Init}[oam.admin.username]    1
	Click Launchpad
	DeleteSpecificUserSession    &{Init}[oam.admin.username]    ${SessionId}
	Sleep    10s
	Close Browser
	Reload Page
	Page Should Contain    &{test_data}[sme.resourceloginpagedata]
	Active Sessions Should be NULL


SME Test 7::Max number of sessions per user
	[Documentation]		This test verifies if we create one more session thanmax no of session per user limit then we should get an error page and we get to log in to resource only if one of the sessions 		...			times out

	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	Goto Common Settings Page
	Set Number of sessions per user    &{test_data}[sme.12.value]
	Set Session Lifetime   &{test_data}[sme.12.sessionlifetime]
	Wait Until Page Contains    &{test_data}[sme.profilechangemessage]
	OAMConsole Logout
	DeleteAllActiveSessions
	:FOR    ${INDEX}    IN RANGE    1    4
	\    Resource log in
	SSO Resource Login    &{Init}[resource_url]    &{Init}[resource_username]    &{Init}[resource_pwd]
	Wait Until Page Contains    Error
	Page Should Contain    Error
	Sleep    2m
        Sleep    &{test_data}[sme.12.sessionlifetime]m
	Resource log in
	Close Browser
	Set Max no of sessions per user



