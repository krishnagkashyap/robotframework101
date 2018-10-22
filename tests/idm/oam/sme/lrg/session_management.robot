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



*** Keywords ***
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

Enable Direct Authn
	[Documentation]		This keyword enables direct authn flag using EnableDirectAuthenticationDesc.py script.The first step is to replace connect() string in the script with machine name etc
	...			and then the script to enable DirectAuthn flag
	Create File	${CURDIR}${/}..${/}..${/}..${/}..${/}..${/}resources/scripts/temp.py
	${handle1} =    Run Process    python    ${CURDIR}${/}..${/}..${/}..${/}..${/}..${/}resources/scripts/replaceStringInFile.py    ${CURDIR}${/}..${/}..${/}..${/}..${/}..${/}resources/scripts/EnableDirectAuthenticationDesc.py   ${CURDIR}${/}..${/}..${/}..${/}..${/}..${/}resources/scripts/temp.py   &{Init}[connect.url]    connect()
	${handle} =    Start Process    &{Init}[wlst.location]   ${CURDIR}${/}..${/}..${/}..${/}..${/}..${/}resources/scripts/temp.py   stdout=log.txt
	${res}=    Wait For Process    ${handle}
	${TextFileContent}=    Get File    log.txt
	Log to console   ${TextFileContent}
	Should Contain	 ${TextFileContent}    Updating Current Setting: ServiceStatus:false



*** Test Cases  ***


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
	

SME Test 4::Get list of all the active sessions
	[Documentation]		This test case is making sure we have list of session that we have just created

	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	Goto Common Settings Page
	Set Number of sessions per user    &{test_data}[sme.4.numberofsessionsperuser]
	sleep    15s
	OAMConsole Logout
	:FOR    ${INDEX}    IN RANGE    1    &{test_data}[sme.4.numberofsessionsperuser]
	\    Resource log in
	${ListofActiveSessions}    Get List of all the active sessions


SME Test 5::count of active sessions
	[Documentation]		This test case makes sure the no of sessions created by a user is same as that it appears in SME UI

	:FOR    ${INDEX}    IN RANGE    0    &{test_data}[sme.5.numberofsessionsperuser]
	\    Resource log in
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	${ListofActiveSessions}    Get List of Active Sessions    &{Init}[oam.admin.username]
	Log List    ${ListofActiveSessions}
	${count}=    Get Length    ${ListofActiveSessions}
	Should Be Equal As Numbers    ${count}    &{test_data}[sme.5.numberofsessionsperuser]
	Close All Browsers

SME Test 6::Delete All Sessions
	[Documentation]		It clicks on delete all user session from SME UI and gets the list of active sessions which should be NULL

	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	DeleteAllActiveSessions
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	${ListofActiveSessions}    Get List of Active Sessions    &{Init}[oam.admin.username]
	Should Be Equal As Strings    ${ListofActiveSessions}    'NULL'
	Close All Browsers


SME Test 7::Log out from a resource
	[Documentation]	This tests performs log out from a resource and check if session got deleted in SME UI or not.The log out URL here is global log out URL(load balancer port no)

	Resource log in
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	${oldestsession}    Get Session Id    &{Init}[oam.admin.username]    1
	Close Browser
	Go To    &{Init}[oam.globallogouturl]
	Wait Until Page Contains     &{test_data}[sme.logoutpage]
	Page Should Contain    &{test_data}[sme.logoutpage]
	Sleep    60s

SME Test 8::Session information
	[Documentation]		This test verifies if session information for a particular session is visible in SME UI  or not

        Resource log in
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	${sessioninformation}    Get All Session Information    1    &{Init}[oam.admin.username]
	Log    ${sessioninformation}
	${sessionAttributes}=    Create List    User ID    Session ID    Impersonating    Creation Instant    Last Access Time    Last Update Time    Client IP Address
        : FOR    ${flag}    IN RANGE    0    7
        	\    ${value}    Get From List    ${sessioninformation}    ${flag}
		\    ${session}    Get From List    ${sessionAttributes}    ${flag}
		\    Log    ${session}
		\    Log    ${value}
		\    Should Not Be Empty    ${value.strip()}
	Close All Browsers


SME Test 9::Delete a user session
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

SME Test 10::Userid field case insensitive
	[Documentation]		To check whether user id field in SME UI is test case insesitive or not. We have taken there scenarios like for weblogic user we are checking various combination
	...			WEBLOGIC, WebLogic etc

	Resource log in
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	${list1}=    Get List of Active Sessions    &{Init}[oam.admin.username]
	${username}=    Convert To Uppercase    &{Init}[oam.admin.username]
	Click Launchpad
	${list2}=    Get List of Active Sessions    ${username}
	${second} =	Get Substring	&{Init}[oam.admin.username]	1	
	${first}=    Get Substring   &{Init}[oam.admin.username]     0    1
	${first}=    Convert To Uppercase    ${first}
	${uname}    Catenate    SEPARATOR=    ${first}    ${second}
	Click Launchpad
	${list3}=    Get List of Active Sessions    ${uname}
	Lists Should Be Equal    ${list1}    ${list2}
	Lists Should Be Equal    ${list1}    ${list3}


SME Test 11::Chagnging Session Idle time 
	[Documentation]		This test verifies if we change session idle time out then it should be applied to active sessions also

	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	Goto Common Settings Page
	Set Session Lifetime   &{test_data}[sme.sessiontime]
	Wait Until Page Contains    &{test_data}[sme.profilechangemessage]
	OAMConsole Logout
	${resWin1}=    SSO Resource Login    &{Init}[resource_url]    &{Init}[resource_username]    &{Init}[resource_pwd]
	Wait Until Page Contains    &{test_data}[sme.resourceafterloginpagedata]
	Page Should Contain    &{test_data}[sme.resourceafterloginpagedata]
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	Goto Common Settings Page
	Set Session Lifetime   &{test_data}[sme.11.time]
	Wait Until Page Contains    &{test_data}[sme.profilechangemessage]
	OAMConsole Logout
	${resWin2}=    SSO Resource Login    &{Init}[resource_url]    &{Init}[resource_username]    &{Init}[resource_pwd]
	Wait Until Page Contains    &{test_data}[sme.resourceafterloginpagedata]
	Page Should Contain    &{test_data}[sme.resourceafterloginpagedata]
	Sleep    60s
        Sleep    &{test_data}[sme.11.time]m
	Reload Page
	Page Should Contain    &{test_data}[sme.resourceloginpagedata]
	Switch Browser    ${resWin1}
	Reload Page
	Page Should Contain    &{test_data}[sme.resourceloginpagedata]


SME Test 12::Max number of sessions per user
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

SME Test 13::Check if session gets created for anonymous scheme
	[Documentation]		This test verifies that no session should be created for Anonymous authentication scheme

	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	Goto Application Domain Page    &{Init}[resource_appdomain]
	Sleep    5s
	Create Authentication Policy    &{test_data}[sme.13.authnpol]    &{test_data}[sme.13.authnscheme]
	Click App domain tab    &{Init}[resource_appdomain]
	Create protected resource    &{test_data}[sme.13.authnpol]    &{test_data}[sme.13.resname]    &{Init}[resource_appdomain]
	Open Browser   &{Init}[resource2_url]
	Page Should Contain    Oracle HTTP Server 12c
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	${ListofActiveSessions}    Get List of Active Sessions    &{Init}[oam.admin.username]
	Should Be Equal As Strings    ${ListofActiveSessions}    'NULL'

SME Test 14::Check if session gets created for an unauthenticated user
        [Documentation]		This test verifies if a session gets created for an unauthenticated user or not
	   
        SSO Resource Login    &{Init}[resource_url]    &{Init}[resource_username]    &{test_data}[sme.14.password]
	Wait Until Page Contains    &{test_data}[sme.errormessage]
	Page Should Contain    &{test_data}[sme.errormessage]
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
        ${ListofActiveSessions}    Get List of Active Sessions    &{Init}[oam.admin.username]
        Should Be Equal As Strings    ${ListofActiveSessions}    'NULL'	

SME Test 15::set max no of session as zero
	[Documentation]		Setting max no of session per user a 0 should let user create large no of session , here we are creating around 400 sessions

	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	Goto Common Settings Page
	Set Number of sessions per user    &{test_data}[sme.15.maxnoofsessionsperuser]
	Sleep    1m
	:FOR    ${INDEX}    IN RANGE    0    &{test_data}[sme.15.noofsessions]
	\    Sleep    5s
	\    Resource log in
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	${ListofActiveSessions}    Get List of Active Sessions    &{Init}[oam.admin.username]
	Log List    ${ListofActiveSessions}
	${count}=    Get Length    ${ListofActiveSessions}
	Should Be Equal As Numbers    ${count}    &{test_data}[sme.15.noofsessions]
        Set Max no of sessions per user


SME Test 16::Set max no of session per user as 1
	[Documentation]		Setting max no of session per user as 1 would let only one sesin to be created but if we try to create another session then the previous session woud be kicked off
	...			In the test case I have applied the logic where we create a session and get the session id and then create another session and get thet session id too and
	...			compare if both are same or different. same means previous session was not kicked off

	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	Goto Common Settings Page
	Set Number of sessions per user   &{test_data}[sme.16.numberofsessionsperuser]
	OAMConsole Logout
        Sleep    60s
	${setmaxnoofsessionperuser}    Get Max no of sessions per user(complete flow)
	Should Be Equal As Integers    ${setmaxnoofsessionperuser}    &{test_data}[sme.16.numberofsessionsperuser]
	Resource log in
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	${Session_id_1}=     Get Session Id    &{Init}[oam.admin.username]    1
	Log    ${Session_id_1}
	OAMConsole Logout
	Resource log in
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	${Session_id_2}=    Get Session Id    &{Init}[oam.admin.username]    1
	Click Launchpad
	${ListofActiveSessions}    Get List of Active Sessions    &{Init}[oam.admin.username]
	${count}=    Get Length    ${ListofActiveSessions}
	Should Be Equal As Numbers    ${count}    1
	Log    ${Session_id_2}
	Should Not Be Equal As Strings    ${Session_id_1}    ${Session_id_2}
	OAMConsole Logout
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	Goto Common Settings Page
	Set Number of sessions per user   &{test_data}[sme.maxnoofsessionsperuser]
	OAMConsole Logout
	Close All Browsers


SME Test 17::Access resource through direct authentication
	[Documentation]		Enable direct authentication flag in oam-config.xml and bump up the version for the same which is hanldled by the script enableDirectAuthn.py and the access the resource
	
	Enable Direct Authn
	Open Browser     &{Init}[direct_authn_url]
	Wait Until Page Contains    &{test_data}[sme.resourceafterloginpagedata]
	Page Should Contain    &{test_data}[sme.resourceafterloginpagedata]
	
