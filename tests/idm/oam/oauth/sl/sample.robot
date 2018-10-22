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
Library     Collections

*** Variables ***

${xmlprp}=      "<Configuration xmlns="http://www.w3.org/2001/XMLSchema" schemaLocation="http://higgins.eclipse.org/sts/Configuration Configuration.xsd">  <Setting Name="SessionConfigurations" Type="htf:map" Path="/DeployedComponent/Server/NGAMServer/Profile/Sme/SessionConfigurations"> <Setting Name="Timeout" Type="htf:timeInterval">15 M</Setting> <Setting Name="MaxSessionsPerUser" Type="xsd:integer">400</Setting> <Setting Name="Expiry" Type="htf:timeInterval">480 M</Setting> <Setting Name="CredentialValidityInterval" Type="htf:timeInterval">480 M</Setting> </Setting> </Configuration>"

*** Test Cases ***
#SAMPLE LOGS
#    [Tags]      s1
#    [Documentation]     sample
#    LOG TO CONSOLE      ${xmlprp}
#    Set Base URL	http://adc01bfo.us.oracle.com:23245
#	Set Basic Auth      weblogic   weblogic1
#	Set Content Type	application/xml
#	Set Request Body	${xmlprp}
#	${responseBody}     PUT     /iam/admin/config/api/v1/config
#	${status}	Get Status
#	${actual}	Convert To String	${status}
#
#

CONFIGURE NODEMANAGER
	[Tags]      CONFNM
	[Documentation]		This Keyword verifies something
	Set Basic Auth	weblogic   weblogic1
    Set Base URL	http://slc12ldo.us.oracle.com:22703
	Set Request Header      X-Requested-By      MyClient
	Set Content Type	application/json
	Set Request Body	{ "name":"Machine0" }
	${responseBody}	POST	/management/weblogic/latest/edit/machines
	${status}	Get Status
	${actual}	Convert To String	${status}
    LOG TO CONSOLE      ${actual}
