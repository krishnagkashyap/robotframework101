#*** Settings ***
#Documentation  OAM OAuth TestSuite
#Library		com.oracle.test.robot.rest.RestLibrary
#Library		com.oracle.test.robot.rest.JSONLibrary	WITH NAME	jl
#Library		com.oracle.test.robot.common.SystemLibrary
#Library		Selenium2Library
#Library		String
#Library		com.oracle.test.robot.common.LogLibrary
#Library		com.oracle.test.robot.common.LogCompareLibrary
#
#Resource    ../../../../resources/keywords/idm/oam/oauth/oam_oauth_common.robot
#
#Suite Setup	Setup Env
#Test Teardown	Remove Log locks
#
#*** Keywords ***
#Setup Env
#	Initialize Settings
#	Initialize UI Properties
#	Initialize Test Data	 idm/oam/oauth/suite.properties
#	Set Base URL	&{Init}[oam.runtime.baseurl]
#	Set Basic Auth	&{test_data}[common.clientid]	&{test_data}[common.clientsec]
#
#*** Test Cases ***
#OAuth Client Creds Flow:: Get Access Token :: Fail_400
#	[tags]	&{test_data}[test1.tags]
#	[Documentation]		&{test_data}[test1.doc]
#	Set Test Variable	${testName}    &{test_data}[test0.logfile.name]
#	Create Logger	${testName}
#	Set Content Type	&{test_data}[test0.input.1]
#	Set Request Body	&{test_data}[test0.input.2]
#	${responseBody}	post	&{test_data}[common.oauth.endpoint]
#	Write To Log	${responseBody}
#	${status}	Get Status
#	${actual}	Convert To String	${status}
#	OAM Assert	${actual}	&{test_data}[test0.expected.1]	${testName}
#	${err}	jl.Get String	${responseBody}	error
#	OAM Assert	${err}	&{test_data}[test0.expected.2]	${testName}
#	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
#	Attach Diff	${testName}	${result}
#
#OAuth Client Creds Flow:: Get Access Token :: Success
#	[tags]	&{test_data}[test1.tags]
#	[Documentation]		&{test_data}[test1.doc]
#	Set Test Variable	${testName}    &{test_data}[test1.logfile.name]
#	Create Logger	${testName}
#	Set Content Type	&{test_data}[test1.input.1]
#	Set Request Body	&{test_data}[test1.input.2]
#	${responseBody}	post	&{test_data}[common.oauth.endpoint]
#	${status}	Get Status
#	${actual}	Convert To String	${status}
#	Should Be Equal As Integers	${status}	&{test_data}[test1.expected.1]
#	OAM Assert	${actual}	&{test_data}[test1.expected.1]	${testName}
#	${token}	jl.Get String	${responseBody}	access_token
#	Log	${token}
#	Log	 Get Response Headers
#	Set Suite Variable	${token_pass}	${token}
#	${MYDICT}=  Create Dictionary   expires_in=TIME  access_token=TOKEN
#	${up_json}	Update Json	${responseBody}	${MYDICT}
#	Write To Log	${up_json}
#	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
#	Attach Diff	${testName}	${result}
#
#OAuth Client Creds Flow:: Validate Access Token :: Success
#	[tags]	&{test_data}[test2.tags]
#	[Documentation]		&{test_data}[test2.doc]
#	Set Test Variable	${testName}    &{test_data}[test2.logfile.name]
#	Create Logger	${testName}
#	Log	${token_pass}
#	Set Request Body	&{test_data}[test2.input.1]${token_pass}
#	${responseBody}	post	&{test_data}[common.oauth.endpoint]
#	write To Log	${responseBody}
#	${status}	Get Status
#	${actual}	Convert To String	${status}
#	Should Be Equal As Integers	${status}	200
#	OAM Assert	${actual}	200	${testName}
#	${successful}	jl.Get Boolean	${responseBody}	successful
#	OAM Assert True	${successful}	${testName}
#	${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
#	Attach Diff	${testName}	${result}
#
#OAM Admin OAuth::Client Creation:: Success
#	${RANDOM} =    Generate Random String    4   [NUMBERS]
#	${OAuth_Client_Name}=	Catenate	SEPARATOR=_	OCL	${RANDOM}
#	OAM Login
#	Set System Property	webdriver.chrome.driver	&{Init}[chromedriver]
#	Set System Property     webdriver.firefox.driver    C:/bin/geckodriver-v0.13.0-win32/geckodriver.exe
#	Set Test Variable    ${FF_PROFILE}   D:/ff
#	Open Browser    http://slc04oqo.us.oracle.com:7001/oamconsole   googlechrome
#	Maximize Browser Window
#	Input text	id=username	weblogic
#	Input Password	id=password	Welcome1
#	Submit Form	id=loginData
#	Set Browser Implicit Wait   10
#	Wait Until Page Contains     Application Security
#	Set Browser Implicit Wait   10
#	sleep   10
#   	Close Browser
#	Goto OAuth Config Page
#	Goto OAuth Client Config Page
#	Create OAuth Client	${OAuth_Client_Name}
#	Verify Create OAuth Client	${OAuth_Client_Name}
#
