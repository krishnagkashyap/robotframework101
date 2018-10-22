*** Settings ***
Documentation  OAM OAuth TestSuite
Library		com.oracle.test.robot.rest.RestLibrary
Library		com.oracle.test.robot.rest.JSONLibrary
Library		com.oracle.test.robot.common.SystemLibrary
Library		com.oracle.test.robot.common.SSOLinking
Library		Selenium2Library
Library		String
Library     OperatingSystem
Library		com.oracle.test.robot.common.LogLibrary
Library		com.oracle.test.robot.common.LogCompareLibrary
Library     Collections
Resource    ../../../../../resources/keywords/idm/oam/common/ui_keywords.robot
Resource	../../../../../resources/keywords/common/init.robot
Resource    ../../../../../resources/keywords/idm/oam/oauth/oam_oauth_common.robot

Suite Setup	Setup Env
Test Setup  OPEN APPLICATION
Test Teardown  CLOSE APPLICATION


*** Variables ***
${waittime}=    20s

*** Keywords ***
OPEN APPLICATION
    LOG TO CONSOLE      Hello

CLOSE APPLICATION
    Close All Browsers

Setup Env
    Initialize Settings For ThreeLegged
    Initialize Test Data	 idm/oam/oauth/oam_oauth_policyadmin_testsuite.properties
	Initialize oamconsole xpaths    oamconsole.properties
    Set Common Test Variables
	Set Base URL	&{Init}[oam.runtime.baseurl]

Set Common Test Variables
    &{clientdetails}=       GET CLIENT DETAILS   &{test_data}[test3l0000.input.client.0]
    LOG TO CONSOLE      &{clientdetails}[id]${\n}
    LOG TO CONSOLE      &{clientdetails}[secret]${\n}

    &{iddomaindetails}=     GET IDDOMAIN DETAILS   &{test_data}[tests3l0000.input.id.0]
    LOG TO CONSOLE      &{iddomaindetails}[name]${\n}

    Set Suite Variable   ${std_authzurl}    &{Init}[oam.3l.adminhost.ohsport]/oauth2/rest/authorize
    Set Suite Variable   ${std_redirecturi}    &{Init}[oam.3l.adminhost.ohsport]&{test_data}[app1.url]

	Set Suite Variable	&{clientdetails}
    Set Suite Variable	&{iddomaindetails}

SET RESOURCESURI FOR EMPTY CASES
    SET TEST VARIABLE       ${empty_1}      ${std_authzurl}?response_type=&client_id=&domain=&scope=&state=&redirect_uri=
    SET TEST VARIABLE    ${empty_2}     ${std_authzurl}?response_type=token&client_id=&domain=&scope=&state=&redirect_uri=
    SET TEST VARIABLE       ${empty_3}      ${std_authzurl}?response_type=id_token token&client_id=&domain=&scope=&state=&redirect_uri=
    SET TEST VARIABLE       ${empty_4}      ${std_authzurl}?response_type=code&client_id=&domain=&scope=&state=&redirect_uri=
    SET TEST VARIABLE       ${empty_5}      ${std_authzurl}?response_type=code&client_id=3lOAUTHIDCLIENT0&domain=&scope=&state=&redirect_uri=
    SET TEST VARIABLE       ${empty_6}      ${std_authzurl}?response_type=code&client_id=3lOAUTHIDCLIENT0&domain=3lOAUTHIDMN0&scope=&state=&redirect_uri=
    SET TEST VARIABLE       ${empty_7}      ${std_authzurl}?response_type=code&client_id=3lOAUTHIDCLIENT0&domain=3lOAUTHIDMN0&scope=RServer0.playsong&state=&redirect_uri=
    SET TEST VARIABLE       ${empty_8}      ${std_authzurl}?response_type=code&client_id=3lOAUTHIDCLIENT0&domain=3lOAUTHIDMN0&scope=RServer0.playsong&state=validtestingthis&redirect_uri=

#    LOG TO CONSOLE      INVALID CASES
    LOG TO CONSOLE      ${empty_1}
    LOG TO CONSOLE      ${empty_2}
    LOG TO CONSOLE      ${empty_3}
    LOG TO CONSOLE      ${empty_4}
    LOG TO CONSOLE      ${empty_5}
    LOG TO CONSOLE      ${empty_6}
    LOG TO CONSOLE      ${empty_7}
    LOG TO CONSOLE      ${empty_8}
    LOG TO CONSOLE      EMPTY END


SET RESOURCESURI FOR INVALID CASES
    SET TEST VARIABLE       ${invalid_1}     ${std_authzurl}?response_type=incode&client_id=inClientId0-1&domain=inrobot01&scope=inRobotTestResSvr3.robot1&state=intestingthis&redirect_uri=in${base_resourcewebgate_host_port}${app1_url}
    SET TEST VARIABLE       ${invalid_2}     ${std_authzurl}?response_type=code&client_id=inClientId0-1&domain=inrobot01&scope=inRobotTestResSvr3.robot1&state=intestingthis&redirect_uri=in${base_resourcewebgate_host_port}${app1_url}
    SET TEST VARIABLE       ${invalid_3}     ${std_authzurl}?response_type=code&client_id=ClientId0-1&domain=inrobot01&scope=inRobotTestResSvr3.robot1&state=intestingthis&redirect_uri=in${base_resourcewebgate_host_port}${app1_url}
    SET TEST VARIABLE       ${invalid_4}     ${std_authzurl}?response_type=code&client_id=ClientId0-1&domain=robot01&scope=inRobotTestResSvr3.robot1&state=intestingthis&redirect_uri=inhttp://den02mpu.us.oracle.com:2222${app1_url}
    SET TEST VARIABLE       ${invalid_5}     ${std_authzurl}?response_type=code&client_id=ClientId0-1&domain=robot01&scope=RobotTestResSvr3.robot1&state=intestingthis&redirect_uri=in${base_resourcewebgate_host_port}${app1_url}
    SET TEST VARIABLE       ${invalid_6}     ${std_authzurl}?response_type=code&client_id=ClientId0-1&domain=robot01&scope=RobotTestResSvr3.robot1&state=testingthis&redirect_uri=in${base_resourcewebgate_host_port}${app1_url}
#    LOG TO CONSOLE      ${base_admin_host_port}
#    LOG TO CONSOLE      ${base_resourcewebgate_host_port}
    LOG TO CONSOLE      INVALID CASES
    LOG TO CONSOLE      ${invalid_1}
    LOG TO CONSOLE      ${invalid_2}
    LOG TO CONSOLE      ${invalid_3}
    LOG TO CONSOLE      ${invalid_4}
    LOG TO CONSOLE      ${invalid_5}
    LOG TO CONSOLE      ${invalid_6}

#DefaultScope checking
SET RESOURCESURI FOR DEFAULT SCOPE CASES
#response_type=code
    SET TEST VARIABLE       ${DS_1}     ${std_authzurl}?response_type=code&client_id=ClientId0-1&domain=robot01&state=testingthis&redirect_uri=${std_redirecturi}
    SET TEST VARIABLE       ${DS_2}     ${std_authzurl}?response_type=code&client_id=ClientId0-1&domain=robot01&state=testingthis&redirect_uri=${std_redirecturi}
    SET TEST VARIABLE       ${DS_3}     ${std_authzurl}?response_type=code&client_id=ClientId0-1&domain=robot01&state=testingthis&redirect_uri=${std_redirecturi}

    SET TEST VARIABLE       ${DS_4}     ${std_authzurl}?response_type=code&client_id=ClientId0-1&domain=robot01&scope=&state=testingthis&redirect_uri=${std_redirecturi}
    SET TEST VARIABLE       ${DS_5}     ${std_authzurl}?response_type=code&client_id=ClientId0-1&domain=robot01&scope=&state=testingthis&redirect_uri=${std_redirecturi}
    SET TEST VARIABLE       ${DS_6}     ${std_authzurl}?response_type=code&client_id=ClientId0-1&domain=robot01&scope=&state=testingthis&redirect_uri=${std_redirecturi}

#response_type=token
    SET TEST VARIABLE       ${DS_7}     ${std_authzurl}?response_type=token&client_id=ClientId0-1&domain=robot01&state=testingthis&redirect_uri=${std_redirecturi}
    SET TEST VARIABLE       ${DS_8}     ${std_authzurl}?response_type=token&client_id=ClientId0-1&domain=robot01&state=testingthis&redirect_uri=${std_redirecturi}
    SET TEST VARIABLE       ${DS_9}     ${std_authzurl}?response_type=token&client_id=ClientId0-1&domain=robot01&state=testingthis&redirect_uri=${std_redirecturi}

    SET TEST VARIABLE       ${DS_10}     ${std_authzurl}?response_type=token&client_id=ClientId0-1&domain=robot01&scope=&state=testingthis&redirect_uri=${std_redirecturi}
    SET TEST VARIABLE       ${DS_11}     ${std_authzurl}?response_type=token&client_id=ClientId0-1&domain=robot01&scope=&state=testingthis&redirect_uri=${std_redirecturi}
    SET TEST VARIABLE       ${DS_12}     ${std_authzurl}?response_type=token&client_id=ClientId0-1&domain=robot01&scope=&state=testingthis&redirect_uri=${std_redirecturi}

#response_type=token id_token
    SET TEST VARIABLE       ${DS_13}     ${std_authzurl}?response_type=token id_token&client_id=ClientId0-1&domain=robot01&state=testingthis&redirect_uri=${std_redirecturi}
    SET TEST VARIABLE       ${DS_14}     ${std_authzurl}?response_type=token id_token&client_id=ClientId0-1&domain=robot01&state=testingthis&redirect_uri=${std_redirecturi}
    SET TEST VARIABLE       ${DS_15}     ${std_authzurl}?response_type=token id_token&client_id=ClientId0-1&domain=robot01&state=testingthis&redirect_uri=${std_redirecturi}

    SET TEST VARIABLE       ${DS_16}     ${std_authzurl}?response_type=token id_token&client_id=ClientId0-1&domain=robot01&scope=&state=testingthis&redirect_uri=${std_redirecturi}
    SET TEST VARIABLE       ${DS_17}     ${std_authzurl}?response_type=token id_token&client_id=ClientId0-1&domain=robot01&scope=&state=testingthis&redirect_uri=${std_redirecturi}
    SET TEST VARIABLE       ${DS_18}     ${std_authzurl}?response_type=token id_token&client_id=ClientId0-1&domain=robot01&scope=&state=testingthis&redirect_uri=${std_redirecturi}

    LOG TO CONSOLE      DEFAULT SCOPE CASES
    LOG TO CONSOLE      ${DS_1}
    LOG TO CONSOLE      ${DS_2}
    LOG TO CONSOLE      ${DS_3}
    LOG TO CONSOLE      ${DS_4}
    LOG TO CONSOLE      ${DS_5}
    LOG TO CONSOLE      ${DS_6}
    LOG TO CONSOLE      ${DS_7}
    LOG TO CONSOLE      ${DS_8}
    LOG TO CONSOLE      ${DS_9}
    LOG TO CONSOLE      ${DS_10}
    LOG TO CONSOLE      ${DS_11}
    LOG TO CONSOLE      ${DS_12}
    LOG TO CONSOLE      ${DS_13}
    LOG TO CONSOLE      ${DS_14}
    LOG TO CONSOLE      ${DS_15}
    LOG TO CONSOLE      ${DS_16}
    LOG TO CONSOLE      ${DS_17}
    LOG TO CONSOLE      ${DS_18}

#Multivalue
SET RESOURCESURI FOR MULTIVALUE CASES
    SET TEST VARIABLE       ${MV_1}     ${std_authzurl}?response_type=code id_token token&client_id=ClientId0-1&domain=robot01&scope=RobotTestResSvr3.robot1&state=testingthis&redirect_uri=${std_redirecturi}
    SET TEST VARIABLE       ${MV_2}     ${std_authzurl}?response_type=code token&client_id=ClientId0-1&domain=robot01&scope=RobotTestResSvr3.robot1&state=testingthis&redirect_uri=${std_redirecturi}
    SET TEST VARIABLE       ${MV_3}     ${std_authzurl}?response_type=code id_token&client_id=ClientId0-1&domain=robot01&scope=RobotTestResSvr3.robot1&state=testingthis&redirect_uri=${std_redirecturi}
    SET TEST VARIABLE       ${MV_4}     ${std_authzurl}?response_type=id_token token invalidcode&client_id=ClientId0-1&domain=robot01&scope=RobotTestResSvr3.robot1&state=testingthis&redirect_uri=${std_redirecturi}
    SET TEST VARIABLE       ${MV_5}     ${std_authzurl}?response_type=code,code1&client_id=ClientId0-1&domain=robot01&scope=RobotTestResSvr3.robot1&state=testingthis&redirect_uri=${std_redirecturi}
    SET TEST VARIABLE       ${MV_6}     ${std_authzurl}?response_type=code,code1&client_id=ClientId0-1,ClientId0-1&domain=robot01&scope=RobotTestResSvr3.robot1&state=testingthis&redirect_uri=${std_redirecturi}
    SET TEST VARIABLE       ${MV_7}     ${std_authzurl}?response_type=code,code1&client_id=ClientId0-1,ClientId0-1&domain=robot01,robot02&scope=RobotTestResSvr3.robot1&state=testingthis&redirect_uri=${std_redirecturi}
    SET TEST VARIABLE       ${MV_8}     ${std_authzurl}?response_type=code,code1&client_id=ClientId0-1,ClientId0-1&domain=robot01,robot02&scope=RobotTestResSvr3.robot1,RobotTestResSvr3.robot1&state=testingthis&redirect_uri=${std_redirecturi}
    SET TEST VARIABLE       ${MV_9}     ${std_authzurl}?response_type=code,code1&client_id=ClientId0-1,ClientId0-1&domain=robot01,robot02&scope=RobotTestResSvr3.robot1,RobotTestResSvr3.robot1&state=testingthis,testingthis&redirect_uri=${std_redirecturi}
    SET TEST VARIABLE       ${MV_10}     ${std_authzurl}?response_type=code,code1&client_id=ClientId0-1,ClientId0-1&domain=robot01,robot02&scope=RobotTestResSvr3.robot1,RobotTestResSvr3.robot1&state=testingthis,testingthis&redirect_uri=${std_redirecturi},${base_resourcewebgate_host_port}${app1_url}
    LOG TO CONSOLE      MULTI VALUE CASES
    LOG TO CONSOLE      ${MV_1}
    LOG TO CONSOLE      ${MV_2}
    LOG TO CONSOLE      ${MV_3}
    LOG TO CONSOLE      ${MV_4}
    LOG TO CONSOLE      ${MV_5}
    LOG TO CONSOLE      ${MV_6}
    LOG TO CONSOLE      ${MV_7}
    LOG TO CONSOLE      ${MV_8}
    LOG TO CONSOLE      ${MV_9}
    LOG TO CONSOLE      ${MV_10}

SET RESOURCESURI FOR INVALID SCOPE CASES
#Invalid Scope
    SET TEST VARIABLE       ${INVALIDSCOPE_1}       ${std_authzurl}?response_type=code&client_id=ClientId0-1&domain=robot01&scope=RServer0.playsong&RServer0.invalidscope&state=testingthis&redirect_uri=${std_redirecturi}
    SET TEST VARIABLE       ${INVALIDSCOPE_2}       ${std_authzurl}?response_type=token&client_id=ClientId0-1&domain=robot01&scope=RServer0.playsong&RServer0.invalidscope&state=testingthis&redirect_uri=${std_redirecturi}
    SET TEST VARIABLE       ${INVALIDSCOPE_3}       ${std_authzurl}?response_type=token id_token&client_id=ClientId0-1&domain=robot01&scope=RServer0.playsong&RServer0.invalidscope&state=testingthis&redirect_uri=${std_redirecturi}
    @{invalidscope}=    Create List    ${INVALIDSCOPE_1}    invalid_grant   ${INVALIDSCOPE_2}  invalid_grant    ${INVALIDSCOPE_3}   invalid_request
    SET TEST VARIABLE   ${invalidscope}
    LOG TO CONSOLE      INVALID SCOPE CASES
    LOG TO CONSOLE      ${invalidscope_1}
    LOG TO CONSOLE      ${invalidscope_2}
    LOG TO CONSOLE      ${invalidscope_3}

OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE
    [Arguments]  ${resource_url}    ${waittime}     ${error_expected}
    [Tags]      KW_NEGATIVE_AUTHZCODE_FLOW
    [Documentation]		${testdoc}
    @{MyList}=    Create List    ${resource_url}    ${waittime}     ${error_expected}
    LOG TO CONSOLE  ${\n}INPUT
    LOG TO CONSOLE  ${MyList}
    REMOVE VALUES FROM LIST     ${MyList}   ${resource_url}     ${waittime}     ${error_expected}
    Open Browser        ${resource_url}
    ${code_content}=    Selenium2Library.Get Location
    LOG TO CONSOLE      BEFORE
    LOG TO CONSOLE      ${code_content}
    LOG TO CONSOLE      ${error_expected}
#    Page Should Contain     ${error_expected}
	${str}=  Get Lines Containing String	${code_content}     error=${error_expected}     case_insensitive=True
	LOG TO CONSOLE      AFTER RETURN
	LOG TO CONSOLE  ${str}
	Should Not Be Empty     ${str}
#    Close All Browsers


*** Test Cases ***
NEGATIVE TESTCASES ON QPEMPTY VALUES
    [Tags]      neg3l
    [Documentation]		Negative testcases for Three Legged Flow Cases
    SET RESOURCESURI FOR EMPTY CASES
    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${empty_1}    ${waittime}        invalid_request

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${empty_2}     ${waittime}        invalid_request

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${empty_3}     ${waittime}        invalid_request

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${empty_4}     ${waittime}        invalid_request

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${empty_5}     ${waittime}        invalid_request

NEGATIVE TESTCASES ON QPINVALID VALUES
    [Tags]      neg3l
    [Documentation]		Negative testcases for Three Legged Flow Cases
    SET RESOURCESURI FOR INVALID CASES
    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${invalid_1}     ${waittime}      unsupported_response_type

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${invalid_2}     ${waittime}      invalid_grant

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${invalid_3}     ${waittime}      invalid_grant

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${invalid_4}     ${waittime}      invalid_grant

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${invalid_5}     ${waittime}      invalid_grant

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${invalid_6}     ${waittime}      invalid_grant

NEGATIVE TESTCASES ON QPDEFAULTSCOPE VALUES
    [Tags]      neg3l
    [Documentation]		Negative testcases for Three Legged Flow Cases
    SET RESOURCESURI FOR DEFAULT SCOPE CASES
    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${DS_1}     ${waittime}   invalid_grant

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${DS_2}     ${waittime}   invalid_grant

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${DS_3}     ${waittime}   invalid_grant

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${DS_4}     ${waittime}   invalid_grant

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${DS_5}     ${waittime}   invalid_grant

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${DS_6}     ${waittime}   invalid_grant

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${DS_7}     ${waittime}   invalid_grant

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${DS_8}     ${waittime}   invalid_grant

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${DS_9}     ${waittime}   invalid_grant

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${DS_10}     ${waittime}   invalid_grant

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${DS_11}     ${waittime}   invalid_grant

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${DS_12}     ${waittime}   invalid_grant

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${DS_13}     ${waittime}   invalid_request

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${DS_14}     ${waittime}   invalid_request

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${DS_15}     ${waittime}   invalid_request

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${DS_16}     ${waittime}   invalid_request

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${DS_17}     ${waittime}   invalid_request

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${DS_18}     ${waittime}   invalid_request

NEGATIVE TESTCASES ON QPMULTI VALUES
    [Tags]      neg3l
    [Documentation]		Negative testcases for Three Legged Flow Cases
    SET RESOURCESURI FOR MULTIVALUE CASES
    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${MV_1}     ${waittime}   unsupported_response_type

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${MV_2}     ${waittime}   unsupported_response_type

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${MV_3}     ${waittime}   unsupported_response_type

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${MV_4}     ${waittime}   unsupported_response_type

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${MV_5}     ${waittime}   unsupported_response_type

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${MV_6}     ${waittime}   unsupported_response_type

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${MV_7}     ${waittime}   unsupported_response_type

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${MV_8}     ${waittime}   unsupported_response_type

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${MV_9}     ${waittime}   unsupported_response_type

    OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${MV_10}     ${waittime}   unsupported_response_type

NEGATIVE TESTCASES ON QPINVALIDSCOPE VALUES
    [Tags]      neg3l
    [Documentation]		Negative testcases for Three Legged Flow Cases
    SET RESOURCESURI FOR INVALID SCOPE CASES
	:FOR    ${INDEX}    ${ERRORLIST}    IN      @{invalidscope}
	\   Run Keyword And Continue On Failure     OAUTHRUNTIME FETCH AUTHORIZATION CODE NEGATIVE      ${INDEX}     ${waittime}   ${ERRORLIST}
	\   LOG TO CONSOLE  ${INDEX}
	\   LOG TO CONSOLE  ${ERRORLIST}


