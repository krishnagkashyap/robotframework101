*** Settings ***
Documentation  OAM SME TestSuite
Library		com.oracle.test.robot.common.SystemLibrary
Library		com.oracle.test.robot.rest.RestLibrary
Library		Selenium2Library
Library		com.oracle.test.robot.common.Asserter
Library          DateTime
Resource	../../../common/init.robot



*** Keywords ***
SSO Login
	[Documentation]    Performs SSO log in for oamconsole and return window id which hepls in switching b/w various oamconsole windows
	[Arguments]    ${url}    ${username}    ${password}

	Set Selenium Implicit Wait	20 seconds
	Set Selenium Timeout     20 seconds
	${id}=    Open Browser     ${url}
    Set Selenium Speed  2 seconds
#	Sleep    10s
	Wait Until Element Is Visible    &{oamconsole}[oamconsole.login.username]
	Wait Until Element Is Visible    &{oamconsole}[oamconsole.login.password]
#	Wait Until Element Is Enabled    &{oamconsole}[oamconsole.login.username]   timeout=5
#	Wait Until Element Is Enabled    &{oamconsole}[oamconsole.login.password]   timeout=5
	Input Text	&{oamconsole}[oamconsole.login.username]	${username}
	Input Text	&{oamconsole}[oamconsole.login.password]	${password}
	Click Button    Sign In
	Sleep    5s
	[return]    ${id}

SSO Resource Login
	[Documentation]    Performs SSO log in for a resource and return window id which hepls in switching b/w various oamconsole windows
	[Arguments]    ${url}    ${username}    ${password}


	Set Selenium Implicit Wait	20 seconds
	Set Selenium Timeout     20 seconds
	${id}=    Open Browser     ${url}
    Set Selenium Speed  2 seconds
#	Sleep    10s
	Wait Until Element Is Visible    &{oamconsole}[oamconsole.login.username]
	Input Text    &{oamconsole}[resource.login.username]    ${username}
	Input Text    &{oamconsole}[resource.login.password]     ${password}
	Click Button    Login
	[return]    ${id}

Relogin To Same Page
	[Documentation]    Performs re-login to same page usually used when a refresh is done on a resouce access page when it is logged out
	[Arguments]    ${username}    ${password}

	Wait Until Element Is Visible    &{oamconsole}[oamconsole.login.username]
	Input Text    &{oamconsole}[resource.login.username]    ${username}
	Input Text    &{oamconsole}[resource.login.password]     ${password}
	Click Button    Login

Goto Common Settings Page
	[Documentation]    Access common settings page by clicking on Configuration->View->common settings
    
	Set Selenium Implicit Wait	20 seconds
	Set Selenium Timeout     20 seconds
	Wait Until Element Is Visible    &{oamconsole}[configuration]    
	Click Element     &{oamconsole}[configuration]
	Wait Until Element Is Visible    &{oamconsole}[configuration.view]    
	Click Element     &{oamconsole}[configuration.view]
	Wait Until Element Is Visible    &{oamconsole}[configuration.view.commonsettings] 
	Sleep    5s   
	Click Element     &{oamconsole}[configuration.view.commonsettings] 	
	#Imp check 
	Wait Until Element Is Visible    &{oamconsole}[configuration.view.commonsettings.commonsettingslabel]    

Goto Application Domain Page
	[Documentation]    Go to specific app domain by clicking ApplicationDomian->Search->resource_appdomain
	[Arguments]    ${resource_appdomain}

	Set Selenium Implicit Wait	20 seconds
	Set Selenium Timeout     20 seconds
	Wait Until Element Is Visible    &{oamconsole}[applicationsecurity]
	Click Element     &{oamconsole}[applicationsecurity]
	Wait Until Element Is Visible    &{oamconsole}[applicatiosecurity.applicationdomain]
	Click Element     &{oamconsole}[applicatiosecurity.applicationdomain]
	Wait Until Element Is Visible    &{oamconsole}[applicatiosecurity.applicationdomain.search]
	Input Text    &{oamconsole}[applicationsecurity.agents.agentname]    ${resource_appdomain}
	Sleep    20s
	Click Element     &{oamconsole}[applicatiosecurity.applicationdomain.search]
	Wait Until Element Is Visible    &{oamconsole}[applicatiosecurity.applicationdomain.search.resultlink]${resource_appdomain}&{oamconsole}[closingbrackets]
	Click Element     &{oamconsole}[applicatiosecurity.applicationdomain.search.resultlink]${resource_appdomain}&{oamconsole}[closingbrackets]
	Wait Until Element Is Visible    &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.header]${resource_appdomain}&{oamconsole}[closingbrackets]

Set App domain Timeout
	[Documentation]    Set resouce idle time out after using 'Goto Application Domian Page' keyword
	[Arguments]    ${sessionidletimeout}    ${resource_appdomain}

	Set Selenium Implicit Wait	20 seconds
	Set Selenium Timeout     20 seconds
	Wait Until Element Is Visible    &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.header]${resource_appdomain}&{oamconsole}[closingbrackets]
	${temp}    Get Text    &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.sessionidletimeout.input]
	Set Global Variable    ${default_session_idle_timeout_val}    ${temp}
	Clear Element Text     &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.sessionidletimeout.input]
	Sleep    5s
	Input Text     &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.sessionidletimeout.input]    ${sessionidletimeout}
	Sleep    5s
	Click Element    &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.apply]
	Page Should Contain    modified successfully

Get App domain Timeout
	[Documentation]    Get resouce idle time out,this keyword is after using 'Goto Application Domian Page' keyword
	[Arguments]    ${resource_appdomain}

	Set Selenium Implicit Wait	20 seconds
	Set Selenium Timeout     20 seconds
	Wait Until Element Is Visible    &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.header]${resource_appdomain}&{oamconsole}[closingbrackets]
	Sleep    5s
	${temp}    Get Element Attribute    &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.sessionidletimeout.input]@value
	[return]    ${temp}

Set Number of sessions per user
	[Documentation]    Set max no of session per user,this keyword is used after using keyword 'Goto common settings page'
	[Arguments]    ${numberofsessionsperuser}

	Set Selenium Implicit Wait	20 seconds
	Set Selenium Timeout     20 seconds
	Wait Until Element Is Visible    &{oamconsole}[configuration.view.commonsettings.maxnoofsession.label]
	${temp}    Get Text    &{oamconsole}[configuration.view.commonsettings.maxnoofsession.input]     
	Set Global Variable    ${default_number_of_sessions_per_user}    ${temp}
	Clear Element Text     &{oamconsole}[configuration.view.commonsettings.maxnoofsession.input]
	Input Text     &{oamconsole}[configuration.view.commonsettings.maxnoofsession.input]    ${numberofsessionsperuser}
	Click Element    &{oamconsole}[configuration.view.commonsettings.apply]
Get Number of sessions per user
	[Documentation]    Get max no of session per user,this keyword is used after using keyword 'Goto common settings page'

	Set Selenium Implicit Wait	20 seconds
	Set Selenium Timeout     20 seconds
	Wait Until Element Is Visible    &{oamconsole}[configuration.view.commonsettings.maxnoofsession.label]
	Sleep    5s
	${temp}    Get Element Attribute    &{oamconsole}[configuration.view.commonsettings.maxnoofsession.input]@value   
	[return]    ${temp}

Set Session Lifetime 
	[Documentation]    Set session lifetime,this keyword is used after using keyword 'Goto common settings page'
	[Arguments]    ${sessiontimeout} 
	 
	Set Selenium Implicit Wait	20 seconds
	Set Selenium Timeout     20 seconds
	Wait Until Element Is Visible    &{oamconsole}[configuration.view.commonsettings.sessionlifetime.label]   
	${temp}    Get Text    &{oamconsole}[configuration.view.commonsettings.sessionlifetime.input]     
	Set Global Variable    ${default_session_timeout_val}    ${temp}
	Clear Element Text     &{oamconsole}[configuration.view.commonsettings.sessionlifetime.input]
	Input Text     &{oamconsole}[configuration.view.commonsettings.sessionlifetime.input]    ${sessiontimeout}
	Click Element    &{oamconsole}[configuration.view.commonsettings.apply] 
	Page Should Contain    OAM Server Profile modified successfully.
Get Session Lifetime 
	[Documentation]    Set session lifetime,this keyword is used after using keyword 'Goto common settings page'
	 
	Set Selenium Implicit Wait	20 seconds
	Set Selenium Timeout     20 seconds
	Wait Until Element Is Visible    &{oamconsole}[configuration.view.commonsettings.sessionlifetime.label]   
	Sleep    5s
	${temp}    Get Element Attribute    &{oamconsole}[configuration.view.commonsettings.sessionlifetime.input]@value   
	[return]    ${temp}

Set Idle Timeout 
	[Documentation]    Set idle timeout ,this keyword is used after using keyword 'Goto common settings page'
	[Arguments]    ${idletimeout}

	Set Selenium Implicit Wait	20 seconds
	Set Selenium Timeout     20 seconds
	Wait Until Element Is Visible    &{oamconsole}[configuration.view.commonsettings.idletimeout.label]
	${temp}    Get Text    &{oamconsole}[configuration.view.commonsettings.idletimeout.input]     
	Set Global Variable     ${default_idle_timeout_val}    ${temp}    
	Clear Element Text     &{oamconsole}[configuration.view.commonsettings.idletimeout.input]
	Input Text     &{oamconsole}[configuration.view.commonsettings.idletimeout.input]    ${idletimeout}
	Sleep    5s
	Click Element    &{oamconsole}[configuration.view.commonsettings.apply] 
	Page Should Contain    OAM Server Profile modified successfully.
	Sleep    1m
Get Idle Timeout 
	[Documentation]    Return idle timeout,This keyword is used after using keyword 'Goto common settings page'

	Set Selenium Implicit Wait	20 seconds
	Set Selenium Timeout     20 seconds
	Wait Until Element Is Visible    &{oamconsole}[configuration.view.commonsettings.idletimeout.label]
	${temp}    Get Element Attribute    &{oamconsole}[configuration.view.commonsettings.idletimeout.input]@value    
	[return]    ${temp}

Get Session Id
	[Documentation]    Get session id after click 'Search user sessions', it accepts arguments as username and the row no of sessing info list we see on SME UI
	[Arguments]    ${username}    ${temp}

	${temp}=    Evaluate    ${temp} * 2 - 1    
	Search avalible user sessions    ${username}
	${SessionId}    Get Text    &{oamconsole}[applicatiosecurity.sessionmanagement.search.sessionid1]${temp}&{oamconsole}[applicatiosecurity.sessionmanagement.search.sessionid2]
	Log    ${SessionId}
	[return]    ${SessionId}

Get List of Active Sessions
	[Documentation]    Returns list of active session for a particular user,'flag' variable is set to false when a particular session's xpath is not visible,it return NULL is none is visible ,the range for
	...		   no of session has been taken from0 to a very high limit of 10000 
	[Arguments]    ${username}

	Search avalible user sessions    ${username}
	${numberofsessions}=    Convert To Integer    1	
	${temp}=    Convert To Integer    1
	${flag}=    Run Keyword And Return Status    Element Should Be Visible   &{oamconsole}[applicatiosecurity.sessionmanagement.search.sessionid1]${temp}&{oamconsole}[applicatiosecurity.sessionmanagement.search.sessionid2]
	Return From Keyword If    '${flag}' == 'False'    'NULL'
	${SId}    Get Text    &{oamconsole}[applicatiosecurity.sessionmanagement.search.sessionid1]${temp}&{oamconsole}[applicatiosecurity.sessionmanagement.search.sessionid2]
	${ListOfSessions}=    Create List    ${SId}
	Log    ${flag}
	: FOR    ${flag}    IN RANGE    10000
	\    Log    ${flag}
	\    ${temp}=    Evaluate    ${temp}+2
	\    ${flag}=    Run Keyword And Return Status    Element Should Be Visible   &{oamconsole}[applicatiosecurity.sessionmanagement.search.sessionid1]${temp}&{oamconsole}[applicatiosecurity.sessionmanagement.search.sessionid2]
	\    Run Keyword If    '${flag}' == 'False'    Exit For Loop
	\    ${SId}    Get Text    &{oamconsole}[applicatiosecurity.sessionmanagement.search.sessionid1]${temp}&{oamconsole}[applicatiosecurity.sessionmanagement.search.sessionid2]
	\    Append To List    ${ListOfSessions}    ${SId}
	Log List    ${ListOfSessions}

	[return]    ${ListOfSessions}

Click Launchpad
	[Documentation]    Clicks on launchpad

	Wait Until Element Is Visible    &{oamconsole}[launchpad]
	Click Element    &{oamconsole}[launchpad]


DeleteSpecificUserSession
	[Documentation]    Deletes a specific user session with a session id, flag varibale is set to check if xpath of a particular session is visible or not
	[Arguments]    ${username}    ${SessionId}

	Search avalible user sessions    ${username}
	${numberofsessions}=    Convert To Integer    1
	${temp}=    Convert To Integer    1
	${sessionfound}=    Convert To Integer    1
	${flag}=    Run Keyword And Return Status    Element Should Be Visible   &{oamconsole}[applicatiosecurity.sessionmanagement.search.sessionid1]${temp}&{oamconsole}[applicatiosecurity.sessionmanagement.search.sessionid2]
	${SId}    Get Text    &{oamconsole}[applicatiosecurity.sessionmanagement.search.sessionid1]${temp}&{oamconsole}[applicatiosecurity.sessionmanagement.search.sessionid2]
	${ListOfSessions}=    Create List    ${SId}
	Log    ${flag}
	: FOR    ${flag}    IN RANGE    10000
	\    Log    ${flag}
	\    ${flag}=    Run Keyword And Return Status    Element Should Be Visible   &{oamconsole}[applicatiosecurity.sessionmanagement.search.sessionid1]${temp}&{oamconsole}[applicatiosecurity.sessionmanagement.search.sessionid2]
	\    Log    ${flag}
	\    ${sessionfound}    Run Keyword If    "${SId}" == "${SessionId}"    Delete an element    ${temp}
	\    Log    ${sessionfound}
	\    Run Keyword If    ${sessionfound} == 0    Exit For Loop
	\    ${temp}=    Evaluate    ${temp}+2
	\    ${SId}    Get Text    &{oamconsole}[applicatiosecurity.sessionmanagement.search.sessionid1]${temp}&{oamconsole}[applicatiosecurity.sessionmanagement.search.sessionid2]
	\    Log    ${temp}
	\    Set Selenium Implicit Wait      20 seconds

Delete an element
	[Documentation]    Deletes a particular session. used only along with keyword DeletSpecificSession
	[Arguments]    ${temp}

	Click Element    &{oamconsole}[applicatiosecurity.sessionmanagement.search.sessionid1]${temp}&{oamconsole}[applicatiosecurity.sessionmanagement.search.sessionid2]
	Click Element   //span[text()='Delete']
	[return]    0


Click Delete All User Sessions
	[Documentation]    Clicks delete all user session option in SME UI
	[Arguments]    ${username}

	Search avalible user sessions    ${username}
	Click Element    &{oamconsole}[applicatiosecurity.sessionmanagement.deleteallusersession]
	Wait Until Element Is Visible    &{oamconsole}[applicatiosecurity.sessionmanagement.deleteallusersession.yes]
	Click Element    &{oamconsole}[applicatiosecurity.sessionmanagement.deleteallusersession.yes]

Get All Session Information
	[Documentation]    Returns session information for a particular session in a row, has to be used after Search avalible user sessions keyword
	[Arguments]    ${rownum}    ${username}

	Search avalible user sessions    ${username}
	${flag}=    Convert To Integer    1
	${sessioninfo}=    Create List
	${effectRowNo}=    Evaluate    ${rownum}+${rownum}-1
	: FOR    ${flag}    IN RANGE    1    10
	\    Log    ${flag}
	\     ${temp}    Get Text    &{oamconsole}[applicatiosecurity.sessionmanagement.search.sessionattributes1]${effectRowNo}&{oamconsole}[applicatiosecurity.sessionmanagement.search.sessionattributes2]${flag}]
	\    Append To List    ${sessioninfo}    ${temp}

	Log    ${sessioninfo}
	[return]    ${sessioninfo}


Search avalible user sessions
	[Documentation]    
	[Arguments]    ${username}

	Set Selenium Implicit Wait      20 seconds
	Wait Until Element Is Visible    &{oamconsole}[applicatiosecurity.sessionmanagement]
	Click Element    &{oamconsole}[applicatiosecurity.sessionmanagement]
	Sleep    10s
	Clear Element Text     &{oamconsole}[applicatiosecurity.sessionmanagement.search.userid.input]
	Sleep    10s
	Input Text     &{oamconsole}[applicatiosecurity.sessionmanagement.search.userid.input]    ${username}
	Sleep    10s
	${tmp}    Get Text    &{oamconsole}[applicatiosecurity.sessionmanagement.search.userid.input]
	Log    ${tmp}
	Click Element    &{oamconsole}[applicatiosecurity.sessionmanagement.search]
	Sleep    10s


Get the oldest session
	[Documentation]    Return the oldest session in the list of session in SME UI. The logic of this keyword is implementnted by converting fetching 'creation instant' attribute of every session
	...		   and converting it into epoch and comparing the same attibute with rest of the sessions in the row,setting sesssion id for that 'creation instant' whose's value is lowest in
	...		   epoch format
	[Arguments]    ${username}

	Search avalible user sessions    ${username}
	${rowno}=    Convert To Integer    1
	${effectiveRowNo}=    Convert To Integer   1
	Click Launchpad
	${sessioninfo}    Get All Session Information    ${rowno}    ${username}
	${temptimecreation}    Get From List    ${sessioninfo}    3
	${CurEpo}    Convert The date to epoch    ${temptimecreation}
	${firstSession}    Get From List    ${sessioninfo}    1
	Set Global Variable    ${oldestsession}    ${firstSession}
	${flag2}=    Convert To String    'True'
	Log    ${CurEpo}
	: FOR   ${row}    IN RANGE    1    10000
	\    Log    ${oldestsession}
	\    Log    ${row}
	\    Sleep    5s
	\    ${flag}=    Run Keyword And Return Status    Element Should Be Visible    &{oamconsole}[applicatiosecurity.sessionmanagement.search.sessionid1]${effectiveRowNo}&{oamconsole}[applicatiosecurity.sessionmanagement.search.sessionid2]
	\    Log    ${flag}
	\    Run Keyword If    ${flag} == False    Exit For Loop
	\    Click Launchpad
	\    ${sessioninfo}    Get All Session Information    ${rowno}    ${username}
	\    ${tempSessionID}    Get From List    ${sessioninfo}    1
	\    Log    ${tempSessionID}
	\    Log    ${flag2}
	\    Run Keyword If    ${flag2} == True    ${oldestsession}=${tempSessionID}
	\    Log    ${oldestsession}
	\    ${flag2}=    Convert To String    False
	\    ${temptimecreation}    Get From List    ${sessioninfo}    3
	\    Log    ${temptimecreation}
	\    ${TinEpo}    Convert The date to epoch    ${temptimecreation}
	\    Run Keyword If    ${TinEpo}<${CurEpo}    ${oldestsession}=${tempSessionID}
	\    Log    ${oldestsession}
	\    ${CurEpo}=    Set Variable If    ${TinEpo}<${CurEpo}    ${TinEpo}
	\    ${rowno}=    Evaluate    ${rowno}+1
	\    ${effectiveRowNo}=    Evaluate    ${rowno}+${rowno}-1
	\    Set Selenium Implicit Wait      20 seconds
	[return]    ${oldestsession}

Convert The date to epoch
	[Documentation]    Convet a date to epoch format
	[Arguments]    ${date}

	${epoch_date}=    Convert Date    ${date}    epoch
	[return]    ${epoch_date}	

OAMConsole Logout
	Click Element     &{oamconsole}[oamconsole.user]
	Wait Until Element Is Visible      &{oamconsole}[oamconsole.signout]    3000
	Click Element    &{oamconsole}[oamconsole.signout]
	Close Browser

Resource Logout
	[Arguments]     ${base_url}     ${resource_logouturi}
	sleep    5s
	stSet Base URL	${base_url}
	get     ${resource_logouturi}
	Close Browser

Create Authentication Policy
	[Documentation]    Creates an authentication pol for a particular app domain and accepts arguments like name of policy and name of authn scheme
	[Arguments]     ${Authpol}     ${AuthnScheme}

	Wait Until Element Is Visible    &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.Authenticationpolicies]
	Click Link    &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.Authenticationpolicies]
	Sleep    5s
	Wait Until Element Is Visible    &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.Authenticationpolicies.create]
	Click Element    &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.Authenticationpolicies.create]
	Wait Until Element Is Visible    &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.Authenticationpolicies.create.name.input]
	Input Text    &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.Authenticationpolicies.create.name.input]    ${Authpol}
	Click Element    &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.Authenticationpolicies.create.name.authschemeoption]
	Sleep    10s
	Click Element   &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.Authenticationpolicies.create.name.authschemename]${AuthnScheme}&{oamconsole}[closingbrackets]
	Sleep    10s
	Click Element    &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.Authenticationpolicies.create.apply]
	Wait Until Page Contains    Authentication Policy, ${Authpol}, created successfully

Click App domain tab
	[Arguments]    ${appdomain}
	Click Element    &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.tab]${appdomain}']

Create protected resource
	[Documentation]    Creates a protected resource for a particular app domain recieving arguments like authticationpol, host identifier and resoucr url
	[Arguments]     ${Authpol}     ${resourcename}    ${hostIdentifier}

	Sleep    5s
	Click Element    &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.resource]
	Sleep    5s
	Wait Until Element Is Visible    &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.resource.create]
	Click Element    &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.resource.create]
	#Click Element    //span[text()='Create']
	Sleep    5s
	Click Element     &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.resource.create.type]
	Sleep    10s
	Click Element   &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.resource.create.type.HTTP]
	Sleep    5s
	Input Text    &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.resource.create.hostidentifier]    ${hostIdentifier}
	Input Text    &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.resource.create.resourceurl]    ${resourcename}
	Sleep    5s
	Click Element    &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.resource.create.protectionlevel]
	Sleep    5s
	Click Element   &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.resource.create.protectionlevel.unprotected]
	Sleep    5s
	Click Element   &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.resource.create.authpolselect]
	Sleep    5s
	Click Element   xpath=&{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.resource.create.authnpolname]${Authpol}&{oamconsole}[closingbrackets]
	Sleep    5s
	Click Element   &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.resource.create.apply]
	Wait Until Page Contains    created successfully

Change Agent Mode to Simple
	[Arguments]     ${agent} 
	Set Selenium Implicit Wait	20 seconds
	Set Selenium Timeout     20 seconds
	Wait Until Element Is Visible    &{oamconsole}[applicationsecurity]
	Click Element     &{oamconsole}[applicationsecurity]
	Wait Until Element Is Visible    &{oamconsole}[applicationsecurity.agents]
	Click Element     &{oamconsole}[applicationsecurity.agents]
	Sleep    10s
	Input Text    &{oamconsole}[applicationsecurity.agents.agentname]    ${agent}
	Sleep    10s
	Click Element    &{oamconsole}[searchbutton]
	Sleep    10s
	Wait Until Element Is Visible    &{oamconsole}[applicatiosecurity.applicationdomain.search.resultlink]${agent}&{oamconsole}[closingbrackets]
	Click Element     &{oamconsole}[applicatiosecurity.applicationdomain.search.resultlink]${agent}&{oamconsole}[closingbrackets]
	Wait Until Element Is Visible    &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.header]${agent}&{oamconsole}[closingbrackets]
	Click Element	&{oamconsole}[applicationsecurity.agents.agentname.agentmodesimple]
	Click Element    &{oamconsole}[applybutton]
	Wait Until Page Contains    OAM Webgate ${agent} modified successfully.

Change Agent Mode to Open
	[Arguments]     ${agent} 
	Set Selenium Implicit Wait	20 seconds
	Set Selenium Timeout     20 seconds
	Wait Until Element Is Visible    &{oamconsole}[applicationsecurity]
	Click Element     &{oamconsole}[applicationsecurity]
	Wait Until Element Is Visible    &{oamconsole}[applicationsecurity.agents]
	Click Element     &{oamconsole}[applicationsecurity.agents]
	Sleep    10s
	Input Text    &{oamconsole}[applicationsecurity.agents.agentname]    ${agent}
	Sleep    10s
	Click Element    &{oamconsole}[searchbutton]
	Sleep    10s
	Wait Until Element Is Visible    &{oamconsole}[applicatiosecurity.applicationdomain.search.resultlink]${agent}&{oamconsole}[closingbrackets]
	Click Element     &{oamconsole}[applicatiosecurity.applicationdomain.search.resultlink]${agent}&{oamconsole}[closingbrackets]
	Wait Until Element Is Visible    &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.header]${agent}&{oamconsole}[closingbrackets]
	Click Element	&{oamconsole}[applicationsecurity.agents.agentname.agentmodeopen]
	Click Element    &{oamconsole}[applybutton]
	Wait Until Page Contains    OAM Webgate ${agent} modified successfully.

Change Agent Mode to Cert
	[Arguments]     ${agent}    ${AgentKeyPassword}
	Set Selenium Implicit Wait	20 seconds
	Set Selenium Timeout     20 seconds
	Wait Until Element Is Visible    &{oamconsole}[applicationsecurity]
	Click Element     &{oamconsole}[applicationsecurity]
	Wait Until Element Is Visible    &{oamconsole}[applicationsecurity.agents]
	Click Element     &{oamconsole}[applicationsecurity.agents]
	Sleep    10s
	Input Text    &{oamconsole}[applicationsecurity.agents.agentname]    ${agent}
	Sleep    10s
	Click Element    &{oamconsole}[searchbutton]
	Sleep    10s
	Wait Until Element Is Visible    &{oamconsole}[applicatiosecurity.applicationdomain.search.resultlink]${agent}&{oamconsole}[closingbrackets]
	Click Element     &{oamconsole}[applicatiosecurity.applicationdomain.search.resultlink]${agent}&{oamconsole}[closingbrackets]
	Wait Until Element Is Visible    &{oamconsole}[applicatiosecurity.applicationdomain.specificappdomain.header]${agent}&{oamconsole}[closingbrackets]
	Click Element	&{oamconsole}[applicationsecurity.agents.agentname.agentmodecert]
	Input Text	&{oamconsole}[applicationsecurity.agents.agentname.agentmodecert.agentkeypassword]	${AgentKeyPassword}
	Click Element    &{oamconsole}[applybutton]
	Wait Until Page Contains    OAM Webgate ${agent} modified successfully.

Set Cert mode config
	[Arguments]    ${PEMKeyStoreAlias}    ${PAMKeystroeALiasPassword}
	Wait Until Element Is Visible    &{oamconsole}[configuration]    
	Click Element     &{oamconsole}[configuration]
	Wait Until Element Is Visible    &{oamconsole}[configuration.view]    
	Click Element     &{oamconsole}[configuration.view]
	Wait Until Element Is Visible    &{oamconsole}[configuration.view.accessmanager]
	Click Element    &{oamconsole}[configuration.view.accessmanager]
	Wait Until Element Is Visible    &{oamconsole}[configuration.view.accessmanager.PEMKeystorealias]
	Wait Until Element Is Visible    &{oamconsole}[configuration.view.accessmanager.PEMKeystorealiaspassword]
	Input Text    &{oamconsole}[configuration.view.accessmanager.PEMKeystorealias]    ${PEMKeyStoreAlias}
	Input Text    &{oamconsole}[configuration.view.accessmanager.PEMKeystorealiaspassword]	${PAMKeystroeALiasPassword}
	Click Element    &{oamconsole}[applybutton]
	Wait Until Page Contains    OAM Server Profile modified successfully.



