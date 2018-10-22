*** Settings ***
Documentation  OAM OAuth TestSuite
Library		com.oracle.test.robot.common.SystemLibrary
Library		Selenium2Library
Library		com.oracle.test.robot.common.Asserter
Resource	../../../common/init.robot
Library     OperatingSystem
Library     String


*** Keywords ***
Initialize UI Properties 
	&{ocui}=	Get Properties	${CURDIR}${/}..${/}..${/}..${/}..${/}..${/}settings${/}idm/oam/oamconsole.properties	settings
	Set Suite Variable	&{ocui}

Attach Diff
	[Arguments]	${fileName}	${diff_flag}
	Run keyword if	'${diff_flag}'=='False'	OAM Attach Diff File	${fileName}

OAM Attach Diff File
	[Arguments]	${fileName}
	Log	<a href="${gold_Log_Dir}/${fileName}.diff">Diff</a>	html=yes	
	FAIL	'Assertion against Gold log has been Failed '
	
#OAM Login
#	Set System Property	webdriver.chrome.driver	&{Init}[chromedriver]
#    Set System Property     webdriver.firefox.driver    C:/bin/geckodriver-v0.13.0-win32/geckodriver.exe
#    Set Test Variable    ${FF_PROFILE}   D:/ff
#	Open Browser    http://slc04oqo.us.oracle.com:7001/oamconsole   googlechrome
#	Maximize Browser Window
#	Input text	id=username	weblogic
#	Input Password	id=password	Welcome1
#	Submit Form	id=loginData

OAM Assert
	[Arguments]	${actual}	${expected}	${testCase_Name}
	${boolean}	compare	${actual}	${expected}
	Run keyword if	${boolean}==False	OAM Fail Test	${actual}	${expected}	${testCase_Name}
	
OAM Assert True
	[Arguments]	${boolean}	${testCase_Name}
	Run keyword if	${boolean}==False	OAM Fail Test	${boolean}	True	${testCase_Name}

OAM Fail Test
	[Arguments]	${actual}	${expected}	${testCase_Name}
	${message}	Replace Variables	'Actual is: ${actual} But Expected is: ${expected}'
	Write To Log	${message}
	Generate Assertion Diff		${message}	${testCase_Name}
	FAIL	msg=${message}

Goto OAuth Config Page
	Set Selenium Implicit Wait	10 seconds
	Click Element	&{ocui}[oc.xpath.mobsec.tab]
	Click Element	&{ocui}[oc.xpath.mobsec.oauth.grid.link]
	
Goto OAuth Client Config Page
	Set Selenium Implicit Wait	10 seconds
	#Wait Until Page Contains Element	&{ocui}[oc.xpath.mobsec.oauth.domain]	timeout=10
	#Wait Until Element Is Visible	&{ocui}[oc.xpath.mobsec.oauth.domain]	timeout=10
	Click Element	&{ocui}[oc.xpath.mobsec.oauth.domain]
	Click Element	&{ocui}[oc.xpath.mobsec.oauth.domain]
	Click Element	&{ocui}[oc.xpath.mobsec.oauth.domain]
	Click Element	&{ocui}[oc.xpath.mobsec.oauth.domain]
	Click Element	&{ocui}[oc.xpath.mobsec.oauth.clients.tab]
	
Create OAuth Client
	[Arguments]	${OAuth_Client_Name}
	Set Selenium Implicit Wait	10 seconds
	Click Element	&{ocui}[oc.xpath.mobsec.oauth.client.create.btn]
	Input text	&{ocui}[oc.xpath.mobsec.oauth.client.create.name.input]	${OAuth_Client_Name}
	Click Element	&{ocui}[oc.xpath.mobsec.oauth.client.create.id.gen.btn]
	Click Element	&{ocui}[oc.xpath.mobsec.oauth.client.create.pass.gen.btn]
	Click Element	&{ocui}[oc.xpath.mobsec.oauth.client.create.priv]
	Select Checkbox	&{ocui}[oc.xpath.mobsec.oauth.client.create.consentbypass.check]
	Select Checkbox	&{ocui}[oc.xpath.mobsec.oauth.client.create.allscopecheck.check]
	Select Checkbox	&{ocui}[oc.xpath.mobsec.oauth.client.create.resownercred.check]
	Select Checkbox	&{ocui}[oc.xpath.mobsec.oauth.client.create.clientcred.check]
	Click Element	&{ocui}[oc.xpath.mobsec.oauth.client.create.submit.btn]
	
Verify Create OAuth Client
	[Arguments]	${OAuth_Client_Name}
	Wait until Page Contains Element	xpath=//a[contains(text(),'${OAuth_Client_Name}')]

KW_GET_CLIENTID_FROM_RESP
    [Arguments]    ${args}
    @{str1} =    Split String    ${args}     separator=,
    @{id} =    Split String    @{str1}[3]    separator==
    ${id_f} =  Strip String    @{id}[1]
    [Return]    ${id_f}


KW_GET_SECRET_FROM_RESP
    [Arguments]    ${args}
    @{str1} =    Split String    ${args}     separator=,
    @{sec} =    Split String    @{str1}[6]    separator==
    ${sec_f} =  Strip String    @{sec}[1]
#    log     @{str1}
    [Return]    ${sec_f}

KW_GET_AUTHZCODE_VALUE_FROM_TEXT
    [Arguments]    ${args}
    Log to Console      HELLO
    ${code}=        Get Lines Matching Pattern		${args}     ^?code=.*&state
    Log to Console      ${code}
    [Return]    ${code}

KW_AUTHZCODE_PAYLOAD
     [Arguments]    ${main_str}    ${code}    ${redirect_URI}
     ${str1} =    Replace String    ${main_str}    _jwtuat_       ${code}
     ${str1} =    Replace String    ${str1}    _ru_       ${redirect_URI}
     [Return]    ${str1}


KW_ROFC_PAYLOAD
     [Arguments]    ${main_str}    ${cl_id}    ${cl_sec}    ${redirect_URI}    ${scope}    ${user}    ${pwd}
     ${str1} =    Replace String    ${main_str}    _cli_       ${cl_id}
     ${str1} =    Replace String    ${str1}    _cls_       ${cl_sec}
     ${str1} =    Replace String    ${str1}    _ru_       ${redirect_URI}
     ${str1} =    Replace String    ${str1}    _s_       ${scope}
     ${str1} =    Replace String    ${str1}    _user_       ${user}
     ${str1} =    Replace String    ${str1}    _pwd_       ${pwd}
     [Return]    ${str1}

KW_ROCC_PAYLOAD
     [Arguments]    ${main_str}    ${cl_id}    ${cl_sec}    ${redirect_URI}    ${scope}
     ${str1} =    Replace String    ${main_str}    _cli_       ${cl_id}
     ${str1} =    Replace String    ${str1}    _cls_       ${cl_sec}
     ${str1} =    Replace String    ${str1}    _ru_       ${redirect_URI}
     ${str1} =    Replace String    ${str1}    _s_       ${scope}
     [Return]    ${str1}
     
KW_CC_PAYLOAD
     [Arguments]    ${main_str}    ${redirect_URI}    ${scope}
     ${str1} =    Replace String    ${main_str}    _ru_       ${redirect_URI}
     ${str1} =    Replace String    ${str1}    _s_       ${scope}
     [Return]    ${str1}
     
KW_ROFC_CC_JWT_PAYLOAD
     [Arguments]    ${main_str}    ${cl_assertion}    ${redirect_URI}    ${scope}    ${user}    ${pwd}
     ${str1} =    Replace String    ${main_str}    _cli_       ${cl_assertion}
     ${str1} =    Replace String    ${str1}    _ru_       ${redirect_URI}
     ${str1} =    Replace String    ${str1}    _s_       ${scope}
     ${str1} =    Replace String    ${str1}    _user_       ${user}
     ${str1} =    Replace String    ${str1}    _pwd_       ${pwd}
     [Return]    ${str1}
     
KW_JWTBEARER_CLIENTCREDS_PAYLOAD
     [Arguments]    ${main_str}    ${jwt_user_assertion}    ${redirect_URI}    ${scope}
     ${str1} =    Replace String    ${main_str}    _jwtuat_       ${jwt_user_assertion}
     ${str1} =    Replace String    ${str1}    _ru_       ${redirect_URI}
     ${str1} =    Replace String    ${str1}    _s_       ${scope}
     [Return]    ${str1}

KW_REFERSH_TOKEN_PAYLOAD
     [Arguments]    ${main_str}    ${refresh_token}     ${scope}
     ${str1} =    Replace String    ${main_str}    _jwtuat_       ${refresh_token}
     ${str1} =    Replace String    ${str1}    _s_       ${scope}
     [Return]    ${str1}


KW_AUDITLOG_OAUTHEVENT_VERIFY
    [Arguments]    ${auditlog_loc}    ${verify_event}
    Log  ${auditlog_loc}
    Log  ${verify_event}
    ${contents}=    Get File    ${auditlog_loc}
    Log  ${contents}

PRINT LIST
    [Arguments]  ${MyList}
    :FOR    ${value}    IN    @{MyList}
    \    LOG TO CONSOLE     ${value}


OAUTHADMIN AUDIT LOG GENERATION
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${eventId}  ${auditLogDir}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${eventId}      ${auditLogDir}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${eventId}  ${auditLogDir}
    Set Test Variable	${testName}    ${logfile_name}
    Create Logger	${testName}
	${str}	Grep File	${auditLogDir}	${eventId}  encoding_errors=ignore
	${count}	Get Line Count	${str}
	${str_count}	Convert To String	${count}
	${var}=	Set Variable If	${count} > 0	AUDIT_LOGS_CREATED	NO_AUDIT_LOGS
    Write To Log	${str}
    Write To Log	${count}
    Write To Log	${str_count}
    LOG TO CONSOLE  OUTPUT
    LOG TO CONSOLE  ${str}
    LOG TO CONSOLE  ${count}
    LOG TO CONSOLE  ${str_count}
    OAM Assert	${actual}	${expected}     ${testName}
    ${result}       Compare Logs	${gold_Log_Dir}	${testName}		${null}
    Attach Diff     ${testName}     ${result}

OAUTH ADMIN IDENTITYDOMAIN CREATION
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}   ${reqbody}   ${expected}     ${endpoint}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}   ${reqbody}   ${expected}     ${endpoint}
#    PRINT LIST  ${MyList}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}   ${username}     ${password}     ${contenttype}   ${reqbody}   ${expected}     ${endpoint}
    Set Test Variable	${testName}    ${logfile_name}
    Create Logger	${testName}
    Set Base URL	${url}
    Set Basic Auth	${username}     ${password}
    Set Content Type	${contenttype}
    Set Request Body	${reqbody}
    ${responseBody}     POST    ${endpoint}
    Write To Log	${responseBody}
    LOG TO CONSOLE  OUTPUT
    LOG TO CONSOLE  ${responseBody}
    ${status}	Get Status
    ${actual}	Convert To String	${status}
    OAM Assert	${actual}	${expected}     ${testName}
    ${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
    Attach Diff	${testName}	${result}
#    LOG TO CONSOLE  DELETING CONTENT OF LIST
#    LOG TO CONSOLE  ${MyList}


OAUTH ADMIN IDENTITYDOMAIN READ
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${queryParam}   ${expected}     ${endpoint}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${queryParam}   ${endpoint}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testdoc}  ${logfile_name}     ${testname}  ${url}       ${username}     ${password}     ${queryParam}    ${endpoint}
    Set Test Variable	${testName}    ${logfile_name}
    Create Logger	${testName}
    Set Base URL	${url}
    Set Basic Auth	${username}     ${password}
    Set Query Param    name    ${queryParam}
    ${responseBody}     GET     ${endpoint}
    Write To Log	${responseBody}
    LOG TO CONSOLE  OUTPUT
    LOG TO CONSOLE  ${responseBody}
    ${status}	Get Status
    ${actual}	Convert To String	${status}
    OAM Assert	${actual}	${expected}     ${testName}
    ${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
    Attach Diff	${testName}	${result}


OAUTH ADMIN IDENTITYDOMAIN MODIFY
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}   ${queryParam}   ${reqbody}      ${expected}     ${endpoint}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}   ${queryParam}   ${reqbody}      ${expected}     ${endpoint}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}   ${queryParam}   ${reqbody}       ${expected}     ${endpoint}
    Set Test Variable	${testName}    ${logfile_name}
    Create Logger	${testName}
    Set Basic Auth	${username}     ${password}
    Set Content Type	${contenttype}
    Set Query Param    name    ${queryParam}
    Set Base URL	${url}
    Set Request Body	${reqbody}
    ${responseBody}     PUT     ${endpoint}
    Write To Log	${responseBody}
    LOG TO CONSOLE  OUTPUT
    LOG TO CONSOLE  ${responseBody}
    ${status}	Get Status
    ${actual}	Convert To String	${status}
    OAM Assert	${actual}	${expected}     ${testName}
    ${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
    Attach Diff	${testName}	${result}

OAUTH ADMIN RESOURCESERVER CREATION
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}  ${reqbody}      ${expected}     ${endpoint}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${username}     ${password}     ${contenttype}   ${reqbody}   ${expected}     ${endpoint}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${username}     ${password}     ${contenttype}   ${reqbody}   ${expected}     ${endpoint}
    Set Test Variable	${testName}    ${logfile_name}
    Create Logger	${testName}
    Set Basic Auth	${username}     ${password}
    Set Content Type	${contenttype}
    Set Request Body	${reqbody}
    ${responseBody}     POST    ${endpoint}
    Write To Log	${responseBody}
    LOG TO CONSOLE  OUTPUT
    LOG TO CONSOLE  ${responseBody}
    ${status}	Get Status
    ${actual}	Convert To String	${status}
    OAM Assert	${actual}	${expected}     ${testName}
    ${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
    Attach Diff	${testName}	${result}

OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE READ
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${queryParam1}  ${queryParam2}      ${expected}     ${endpoint}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${queryParam1}  ${queryParam2}      ${expected}     ${endpoint}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${queryParam1}  ${queryParam2}      ${expected}     ${endpoint}
    Set Test Variable	${testName}    ${logfile_name}
    Create Logger	${testName}
    Set Base URL	${url}
    Set Basic Auth	${username}     ${password}
    Set Query Param    identityDomainName    ${queryParam1}
    Set Query Param    name    ${queryParam2}
    ${responseBody}     GET     ${endpoint}
    Write To Log	${responseBody}
    LOG TO CONSOLE  OUTPUT
    LOG TO CONSOLE  ${responseBody}
    ${status}	Get Status
    ${actual}	Convert To String	${status}
    OAM Assert	${actual}	${expected}     ${testName}
    ${result}	Compare Logs	${gold__Log_Dir}	${testName}		${null}
    Attach Diff	${testName}	${result}

OAUTH ADMIN RESOURCESERVER AND CLIENTPROFILE MODIFY
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}   ${queryParam}   ${reqbody}      ${expected}     ${endpoint}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}   ${queryParam}   ${reqbody}      ${expected}     ${endpoint}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}   ${queryParam}   ${reqbody}       ${expected}     ${endpoint}
    Set Test Variable	${testName}    ${logfile_name}
    Create Logger	${testName}
    Set Basic Auth	${username}     ${password}
    Set Content Type	${contenttype}
    Set Query Param    name    ${queryParam}
    Set Base URL	${url}
    Set Request Body	${reqbody}
    ${responseBody}     PUT     ${endpoint}
    Write To Log	${responseBody}
    LOG TO CONSOLE  OUTPUT
    LOG TO CONSOLE  ${responseBody}
    ${status}	Get Status
    ${actual}	Convert To String	${status}
    OAM Assert	${actual}	${expected}     ${testName}
    ${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
    Attach Diff	${testName}	${result}

OAUTH ADMIN CLIENT CREATION
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}     ${username}     ${password}     ${contenttype}   ${reqbody}   ${expected}     ${endpoint}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${username}     ${password}     ${contenttype}   ${reqbody}   ${expected}     ${endpoint}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${username}     ${password}     ${contenttype}   ${reqbody}   ${expected}     ${endpoint}
    Set Test Variable	${testName}    ${logfile_name}
    Create Logger	${testName}
    Set Basic Auth	${username}     ${password}
    Set Content Type	${contenttype}
    Set Base URL	${url}
    Set Request Body	${reqbody}
    ${responseBody}     POST    ${endpoint}
    Write To Log	${responseBody}
	${cl_id} =    KW_GET_CLIENTID_FROM_RESP    ${responseBody}
    ${cl_sec} =    KW_GET_SECRET_FROM_RESP    ${responseBody}
    LOG TO CONSOLE  OUTPUT
    LOG TO CONSOLE  ${responseBody}
    ${status}	Get Status
    ${actual}	Convert To String	${status}
    OAM Assert	${actual}	${expected}     ${testName}
    ${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
    Attach Diff	${testName}	${result}
    [Return]    ${cl_id}    ${cl_sec}


OAUTH ADMIN RESOURCESERVER CLIENTPROFILE DELETE OPERATION
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}  ${queryParam1}  ${queryParam2}  ${expected}     ${endpoint}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}  ${queryParam1}  ${queryParam2}  ${expected}     ${endpoint}     ${endpoint}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}  ${queryParam1}  ${queryParam2}  ${expected}     ${endpoint}
    Create Logger	${testName}
    Set Content Type	${contenttype}
    Set Base URL	${url}
    Set Basic Auth	${username}     ${password}
    Set Query Param    identityDomainName    ${queryParam1}
    Set Query Param    name    ${queryParam2}
    ${responseBody}     DELETE      ${endpoint}
    Write To Log	${responseBody}
    LOG TO CONSOLE  OUTPUT
    LOG TO CONSOLE  ${responseBody}
    ${status}	Get Status
    ${actual}	Convert To String	${status}
    OAM Assert	${actual}	${expected}     ${testName}
    ${result}	Compare Logs	${gold__Log_Dir}	${testName}		${null}
    Attach Diff	${testName}	${result}

OAUTH ADMIN IDENTITYDOMAIN DELETE OPERATION
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}  ${queryParam1}  ${expected}     ${endpoint}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}  ${queryParam1}  ${expected}     ${endpoint}    ${endpoint}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}  ${queryParam1}  ${expected}     ${endpoint}    ${endpoint}
    Create Logger	${testName}
    Set Content Type	${contenttype}
    Set Base URL	${url}
    Set Basic Auth	${username}     ${password}
    Set Query Param    name    ${queryParam1}
    ${responseBody}     DELETE      ${endpoint}
    Write To Log	${responseBody}
    LOG TO CONSOLE  OUTPUT
    LOG TO CONSOLE  ${responseBody}
    ${status}	Get Status
    ${actual}	Convert To String	${status}
    OAM Assert	${actual}	${expected}     ${testName}
    ${result}	Compare Logs	${gold__Log_Dir}	${testName}		${null}
    Attach Diff	${testName}	${result}


OAUTH ADMIN HTTPS IDENTITYDOMAIN CREATION
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}		${username}     ${password}     ${contenttype}   ${reqbody}   ${expected}     ${endpoint}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}	${username}     ${password}     ${contenttype}   ${reqbody}   ${expected}     ${endpoint}
#    PRINT LIST  ${MyList}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testdoc}  ${logfile_name}     ${testname}		${url}     ${username}     ${password}     ${contenttype}   ${reqbody}   ${expected}     ${endpoint}
    Set Test Variable	${testName}    ${logfile_name}
    Create Logger	${testName}
    Set Basic Auth	${username}     ${password}
    Set Content Type	${contenttype}
    Set Base URL	${url}
    Set Request Body	${reqbody}
    ${responseBody}		POSTHTTPS	${endpoint}
    Write To Log	${responseBody}
    LOG TO CONSOLE  OUTPUT
    LOG TO CONSOLE  ${responseBody}
    ${status}	GETHTTPSStatus
    ${actual}	Convert To String	${status}
    OAM Assert	${actual}	${expected}     ${testName}
    ${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
    Attach Diff	${testName}	${result}
#    LOG TO CONSOLE  DELETING CONTENT OF LIST
#    LOG TO CONSOLE  ${MyList}

OAUTH ADMIN HTTPS IDENTITYDOMAIN READ
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${queryParam}   ${expected}     ${endpoint}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${queryParam}   ${endpoint}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testdoc}  ${logfile_name}     ${testname}  ${url}       ${username}     ${password}     ${queryParam}    ${endpoint}
    Set Test Variable	${testName}    ${logfile_name}
    Create Logger	${testName}
    Set Base URL	${url}
    Set Basic Auth	${username}     ${password}
    Set Query Param    name    ${queryParam}
    ${responseBody}		GETHTTPS	${endpoint}
    Write To Log	${responseBody}
    LOG TO CONSOLE  OUTPUT
    LOG TO CONSOLE  ${responseBody}
    ${status}	GETHTTPSStatus
    ${actual}	Convert To String	${status}
    OAM Assert	${actual}	${expected}     ${testName}
    ${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
    Attach Diff	${testName}	${result}

OAUTH ADMIN HTTPS IDENTITYDOMAIN MODIFY
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}   ${queryParam}   ${reqbody}      ${expected}     ${endpoint}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}   ${queryParam}   ${reqbody}      ${expected}     ${endpoint}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}   ${queryParam}   ${reqbody}       ${expected}     ${endpoint}
    Set Test Variable	${testName}    ${logfile_name}
    Create Logger	${testName}
    Set Basic Auth	${username}     ${password}
    Set Content Type	${contenttype}
    Set Query Param    name    ${queryParam}
    Set Base URL	${url}
    Set Request Body	${reqbody}
    ${responseBody}		PUTHTTPS	${endpoint}
    Write To Log	${responseBody}
    LOG TO CONSOLE  OUTPUT
    LOG TO CONSOLE  ${responseBody}
    ${status}	GETHTTPSStatus
    ${actual}	Convert To String	${status}
    OAM Assert	${actual}	${expected}     ${testName}
    ${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
    Attach Diff	${testName}	${result}


OAUTH ADMIN HTTPS RESOURCESERVER CREATION
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}  ${reqbody}      ${expected}     ${endpoint}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${username}     ${password}     ${contenttype}   ${reqbody}   ${expected}     ${endpoint}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${username}     ${password}     ${contenttype}   ${reqbody}   ${expected}     ${endpoint}
    Set Test Variable	${testName}    ${logfile_name}
    Create Logger	${testName}
    Set Basic Auth	${username}     ${password}
    Set Content Type	${contenttype}
    Set Request Body	${reqbody}
    ${responseBody}		POSTHTTPS	${endpoint}
    Write To Log	${responseBody}
    LOG TO CONSOLE  OUTPUT
    LOG TO CONSOLE  ${responseBody}
    ${status}	GETHTTPSStatus
    ${actual}	Convert To String	${status}
    OAM Assert	${actual}	${expected}     ${testName}
    ${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
    Attach Diff	${testName}	${result}


OAUTH ADMIN HTTPS RESOURCESERVER AND CLIENTPROFILE READ
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${queryParam1}  ${queryParam2}      ${expected}     ${endpoint}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${queryParam1}  ${queryParam2}      ${expected}     ${endpoint}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${queryParam1}  ${queryParam2}      ${expected}     ${endpoint}
    Set Test Variable	${testName}    ${logfile_name}
    Create Logger	${testName}
    Set Base URL	${url}
    Set Basic Auth	${username}     ${password}
    Set Query Param    identityDomainName    ${queryParam1}
    Set Query Param    name    ${queryParam2}
    ${responseBody}		GETHTTPS	${endpoint}
    Write To Log	${responseBody}
    LOG TO CONSOLE  OUTPUT
    LOG TO CONSOLE  ${responseBody}
    ${status}	GETHTTPSStatus
    ${actual}	Convert To String	${status}
    OAM Assert	${actual}	${expected}     ${testName}
    ${result}	Compare Logs	${gold__Log_Dir}	${testName}		${null}
    Attach Diff	${testName}	${result}

OAUTH ADMIN HTTPS RESOURCESERVER AND CLIENTPROFILE MODIFY
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}   ${queryParam}   ${reqbody}      ${expected}     ${endpoint}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}   ${queryParam}   ${reqbody}      ${expected}     ${endpoint}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}   ${queryParam}   ${reqbody}       ${expected}     ${endpoint}
    Set Test Variable	${testName}    ${logfile_name}
    Create Logger	${testName}
    Set Basic Auth	${username}     ${password}
    Set Content Type	${contenttype}
    Set Query Param    name    ${queryParam}
    Set Base URL	${url}
    Set Request Body	${reqbody}
    ${responseBody}		PUTHTTPS	${endpoint}
    Write To Log	${responseBody}
    LOG TO CONSOLE  OUTPUT
    LOG TO CONSOLE  ${responseBody}
    ${status}	GETHTTPSStatus
    ${actual}	Convert To String	${status}
    OAM Assert	${actual}	${expected}     ${testName}
    ${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
    Attach Diff	${testName}	${result}

OAUTH ADMIN HTTPS CLIENT CREATION
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}     ${username}     ${password}     ${contenttype}   ${reqbody}   ${expected}     ${endpoint}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${username}     ${password}     ${contenttype}   ${reqbody}   ${expected}     ${endpoint}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${username}     ${password}     ${contenttype}   ${reqbody}   ${expected}     ${endpoint}
    Set Test Variable	${testName}    ${logfile_name}
    Create Logger	${testName}
    Set Basic Auth	${username}     ${password}
    Set Content Type	${contenttype}
    Set Request Body	${reqbody}
    ${responseBody}		POSTHTTPS	${endpoint}
    Write To Log	${responseBody}
	${cl_id} =    KW_GET_CLIENTID_FROM_RESP    ${responseBody}
    ${cl_sec} =    KW_GET_SECRET_FROM_RESP    ${responseBody}
    Set Suite Variable		${cl_id}
    Set Suite Variable		${cl_sec}
    LOG TO CONSOLE  OUTPUT
    LOG TO CONSOLE  ${responseBody}
    ${status}	GETHTTPSStatus
    ${actual}	Convert To String	${status}
    OAM Assert	${actual}	${expected}     ${testName}
    ${result}	Compare Logs	${gold_Log_Dir}	${testName}		${null}
    Attach Diff	${testName}	${result}

OAUTH ADMIN HTTPS RESOURCESERVER CLIENTPROFILE DELETE OPERATION
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}  ${queryParam1}  ${queryParam2}  ${expected}     ${endpoint}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}  ${queryParam1}  ${queryParam2}  ${expected}     ${endpoint}     ${endpoint}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}  ${queryParam1}  ${queryParam2}  ${expected}     ${endpoint}
    Create Logger	${testName}
    Set Content Type	${contenttype}
    Set Base URL	${url}
    Set Basic Auth	${username}     ${password}
    Set Query Param    identityDomainName    ${queryParam1}
    Set Query Param    name    ${queryParam2}
    ${responseBody}		DELETEHTTPS	${endpoint}
    Write To Log	${responseBody}
    LOG TO CONSOLE  OUTPUT
    LOG TO CONSOLE  ${responseBody}
    ${status}	GETHTTPSStatus
    ${actual}	Convert To String	${status}
    OAM Assert	${actual}	${expected}     ${testName}
    ${result}	Compare Logs	${gold__Log_Dir}	${testName}		${null}
    Attach Diff	${testName}	${result}

OAUTH ADMIN HTTPS IDENTITYDOMAIN DELETE OPERATION
    [Arguments]  ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}  ${queryParam1}  ${expected}     ${endpoint}
    [Tags]      ${testtags}
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}  ${queryParam1}  ${expected}     ${endpoint}    ${endpoint}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${testtags}    ${testdoc}  ${logfile_name}     ${testname}     ${url}  ${username}     ${password}     ${contenttype}  ${queryParam1}  ${expected}     ${endpoint}    ${endpoint}
    Create Logger	${testName}
    Set Content Type	${contenttype}
    Set Base URL	${url}
    Set Basic Auth	${username}     ${password}
    Set Query Param    name    ${queryParam1}
    ${responseBody}		DELETEHTTPS	${endpoint}
    Write To Log	${responseBody}
    LOG TO CONSOLE  OUTPUT
    LOG TO CONSOLE  ${responseBody}
    ${status}	GETHTTPSStatus
    ${actual}	Convert To String	${status}
    OAM Assert	${actual}	${expected}     ${testName}
    ${result}	Compare Logs	${gold__Log_Dir}	${testName}		${null}
    Attach Diff	${testName}	${result}
