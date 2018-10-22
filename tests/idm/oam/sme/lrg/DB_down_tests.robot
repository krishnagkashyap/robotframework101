*** Settings ***
Documentation  OAM Session Management TestCases

Library     Selenium2Library
Library     String
Library     Process
Suite Setup	 Prerequisites
Test Teardown  Cleanup
#Test Setup    DeleteAllActiveSessions  
Resource    ../../../../../resources/keywords/idm/oam/common/ui_keywords.robot
Resource	../../../../../resources/keywords/common/init.robot



*** Keywords ***
Cleanup
    Run Keyword If Test Failed    Start DB   
    Close All Browsers 

Prerequisites
    Initialize Settings for SME
	Initialize Test Data    idm/oam/sme/sme.properties
	init.Initialize oamconsole xpaths    oamconsole.properties
    Close All Browsers

	
	
DeleteAllActiveSessions
    SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
    Click Delete All User Sessions    &{Init}[oam.admin.username]
    Close Browser
	
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
Setting Max no of sessions per user
        [Arguments]    ${temp}
        SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
        Goto Common Settings Page
        Set Number of sessions per user   ${temp}
        OAMConsole Logout
Get List of all the active sessions
        SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
        ${ListofActiveSessions}    Get List of Active Sessions    &{Init}[oam.admin.username] 
        OAMConsole Logout
        [return]    ${ListofActiveSessions}
Setting session lifetime
        [Arguments]    ${temp}
        SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
        Goto Common Settings Page  
        Set Session Lifetime    ${temp}
        OAMConsole Logout
Start DB
        ${DBHandle} =    Start Process    &{Init}[database.home]/startup.csh    stdout=&{Init}[database.home]/startUplog.txt    
         ${res}=    Wait For Process    ${DBHandle}
         ${TextFileContent}=    Get File    &{Init}[database.home]/startUplog.txt 
         Should Contain    ${TextFileContent}    ORACLE instance started.
Stop DB
       ${DBHandle} =    Start Process    &{Init}[database.home]/shutdown.csh    stdout=&{Init}[database.home]/stopDBlog.txt    
         ${res}=    Wait For Process    ${DBHandle}
         ${TextFileContent}=    Get File    &{Init}[database.home]/stopDBlog.txt 
         Should Contain    ${TextFileContent}    ORACLE instance shut down.
Set Domain timeout
	[Arguments]    ${temp}
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
        Goto Application Domain Page    &{Init}[resource_appdomain]
        Set App domain Timeout    ${temp}       &{Init}[resource_appdomain]
        sleep    15s
        OAMConsole Logout
 	
*** Test Cases ***

DB_Down_Test_1::Resource log out

	[Documentation]    Log out resource is a supported scenrio when DB is down
        Stop DB
	Resource log in
	Go To    &{Init}[oam.globallogouturl]
    	Wait Until Page Contains     &{test_data}[sme.logoutpage]
    	Page Should Contain    &{test_data}[sme.logoutpage]
	Start DB
	Sleep    10m

DB_Down_Test_2::App domain timeout

	[Documentation]		App domain time out shoud not be honoured if DB is is down, only session time out would be honoured, here we are testing 3 scenrios related to that,this being first where session is   	...			created when DB was up and during session lifetime itself, DB goes down.A sleep of 2 mins after bringing down DB is to normalize resource access as during testing it was observed that
	...			product behaves unexpectedly in such unforseen situations
        
        SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
        Goto Common Settings Page  
        Set Session Lifetime   &{test_data}[dbdown.2.sessionlifetime]
	Set Idle Timeout     &{test_data}[dbdown.2.sessionidletimeout]
	OAMConsole Logout
	Set Domain timeout    &{test_data}[dbdown.2.domaintimeout]
	Sleep    1m
	Resource log in
        Stop DB
	Sleep    &{test_data}[dbdown.2.domaintimeout]m
	Reload Page
	Page Should Contain    &{test_data}[sme.resourceafterloginpagedata]
        Start DB
	Sleep    2m


DB_Down_Test_3::App domain timeout

	[Documentation]		Second scenario where session is created when DB was down and during session lifetime DB remains down.Here also app domain timeout wont be honoured
         
	Stop DB
	Sleep    2m
	Resource log in
	Sleep    &{test_data}[dbdown.2.domaintimeout]m
	Reload Page
	Page Should Contain    &{test_data}[sme.resourceafterloginpagedata]
        Start DB
	Sleep    2m

DB_Down_Test_4::App domain timeout

	[Documentation]		Third scenario where session is created when DB was down and during session lifetime itself, DB comes up.Here also app domain timeout wont be honoured
      
	Stop DB
	Sleep    2m
	Resource log in
	Start DB
	Sleep    &{test_data}[dbdown.2.domaintimeout]m
	Reload Page
	Page Should Contain    &{test_data}[sme.resourceafterloginpagedata]
        Sleep    2m

DB_Down_Test_5::idle time out

	[Documentation]		idle time out would be honoured for all the three scenarios, this is where session is created when DB was up and during session lifetime DB goes down

        SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
        Goto Common Settings Page  
        Set Session Lifetime   &{test_data}[dbdown.5.sessionlifetime]
	Set Idle Timeout     &{test_data}[dbdown.5.sessionidletimeout]
	OAMConsole Logout
	Set Domain timeout    &{test_data}[dbdown.5.domaintimeout]
	Sleep    60s
        Resource log in
        Stop DB
        Sleep    60s
        Reload Page
        Page Should Contain    &{test_data}[sme.resourceafterloginpagedata]
        Sleep    60s
        Page Should Contain    &{test_data}[sme.resourceafterloginpagedata]
        Sleep    &{test_data}[dbdown.5.sessionidletimeout]m
	Reload Page
        Page Should Contain    &{test_data}[sme.resourceloginpagedata] 
        Start DB
	Sleep    2m

DB_Down_Test_6::idle time out

	[Documentation]		In this scenario, session is created when DB was down and during session lifetime DB goes down.idle time out would be honoured here

	Stop DB
	Sleep    1m
        Resource log in
        Sleep    60s
        Reload Page
        Page Should Contain    &{test_data}[sme.resourceafterloginpagedata]
        Sleep    60s
        Page Should Contain    &{test_data}[sme.resourceafterloginpagedata]
        Sleep    &{test_data}[dbdown.5.sessionidletimeout]m
	Reload Page
        Page Should Contain    &{test_data}[sme.resourceloginpagedata]  
        Start DB
	Sleep    2m

DB_Down_Test_7::idle time out

	[Documentation]		In this scenario ,session is created when DB was down and DB comes up during session lifetime. idle time out would be honoured here
  
        Resource log in
        Stop DB
        Sleep    60s
        Reload Page
        Page Should Contain    &{test_data}[sme.resourceafterloginpagedata]
        Sleep    60s
        Page Should Contain    &{test_data}[sme.resourceafterloginpagedata]
	Start DB
        Sleep    &{test_data}[dbdown.5.sessionidletimeout]m
	Reload Page
        Page Should Contain    &{test_data}[sme.resourceloginpagedata] 
        Sleep    2m


DB_Down_Test_8::session lifetime

	[Documentation]	session lifetime would be honoured for all the three scenarios, this is where session is created when DB was up and during session lifetime DB goes down

        SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
        Goto Common Settings Page  
        Set Session Lifetime   &{test_data}[dbdown.8.sessionlifetime]
	Set Idle Timeout     &{test_data}[dbdown.8.sessionidletimeout]
	OAMConsole Logout
	Set Domain timeout    &{test_data}[dbdown.8.domaintimeout]     
	Resource log in
        Stop DB
        Reload Page
        Page Should Contain    &{test_data}[sme.resourceafterloginpagedata]
        Sleep    &{test_data}[dbdown.8.sessionlifetime]m
        Sleep    60s
        Reload Page
        Page Should Contain    &{test_data}[sme.resourceloginpagedata] 
        Start DB
	Sleep    2m

DB_Down_Test_9::session lifetime

	[Documentation]	session lifetime would be honoured for all the three scenarios, this is where session is created when DB was down and during session lifetime DBremains down
    
	Stop DB
	Sleep    2m
        Resource log in
        Page Should Contain    &{test_data}[sme.resourceafterloginpagedata]
        Sleep    &{test_data}[dbdown.8.sessionlifetime]m
        Sleep    60s
        Reload Page
        Page Should Contain    &{test_data}[sme.resourceloginpagedata]
        Start DB
	Sleep    2m
DB_Down_Test_10::session lifetime

	[Documentation]	session lifetime would be honoured for all the three scenarios, this is where session is created when DB was down and during session lifetime DB comes down
       
        Resource log in
        Stop DB
        Reload Page
        Page Should Contain    &{test_data}[sme.resourceafterloginpagedata]
	Start DB
        Sleep    &{test_data}[dbdown.8.sessionlifetime]m
        Sleep    60s
        Reload Page
        Page Should Contain    &{test_data}[sme.resourceloginpagedata] 
	Sleep    10m

DB_Down_Test_11::Max no of sessions per user

	[Documentation]    This attribute of a session is not supported when DB is down, instead we would be allowed to create as many session as we want.Here in the test cases, we are setting value as 4 and creating
	...		   4 sessions when DB is up and bring down the DB and creating more sessions(any no) and bringing up the DB and creating one more session to show that max no session is still supported when
	...	 	   DB comes up and then waitig for sessions to expire
	
	SSO Login    &{Init}[oam.admin.console.url]    &{Init}[oam.admin.username]    &{Init}[oam.admin.pass]
	Goto Common Settings Page
	Set Number of sessions per user    &{test_data}[dbdown.12.value]
	Set Session Lifetime   &{test_data}[dbdown.12.sessionlifetime]
	Set Idle Timeout     &{test_data}[dbdown.12.sessionidletimeout]
	Wait Until Page Contains    &{test_data}[sme.profilechangemessage]
	OAMConsole Logout
	Set Domain timeout    0
	DeleteAllActiveSessions
	:FOR    ${INDEX}    IN RANGE    0    &{test_data}[dbdown.12.value]
	\    Resource log in
	Stop DB
	Sleep    2m
	:FOR    ${INDEX}    IN RANGE    1    4
	\    Sleep    1m
	\    Resource log in
	Start DB
	Sleep    1m	
	SSO Resource Login    &{Init}[resource_url]    &{Init}[resource_username]    &{Init}[resource_pwd]
	Wait Until Page Contains    Error
	Page Should Contain    Error
	Sleep    2m
        Sleep    &{test_data}[dbdown.12.sessionlifetime]m
	Resource log in

	${ListofActiveSessions}    Get List of all the active sessions

	${count}=    Get Length    ${ListofActiveSessions}
	Should Be Equal As Numbers    ${count}    &{test_data}[dbdown.12.value]
	Close Browser
	Set Max no of sessions per user
	Sleep    10m

