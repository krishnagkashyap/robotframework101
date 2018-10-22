#!/usr/bin/env python
#                NAME
#                       build_run_robot.py
#
#               DESCRIPTION
#                       Compile and run robot test
#
#               Changelog
#
#               MODIFIED   (MM/DD/YY)
#               Norman Wang      07/20/16        v0.1    Creation
#               Norman Wang      09/21/16        v1.0    Add the function of download test binray from http url
#               Norman Wang      10/11/16        v1.1    Update for more generic, let it can run IDC code
import requests
import base64


HOSTNAME=""
EXIT_STATUS="FAILURE"
exit_value=0
run_as_root_cmd = "/usr/local/packages/aime/ias/run_as_root"

print " build_run_robot.py: Python file is running....\n"
str = 'weblogic:weblogic1'

authb64 = base64.b64encode(str)

print(base64.b64encode(str))

createuserendpoint = "/management/weblogic/latest/serverConfig/securityConfiguration/realms/myrealm/authenticationProviders/DefaultAuthenticator/createUser"
modoamruntimeendpoint="/iam/admin/config/api/v1/config"

def modifyCustomAuthnPluginIDCS():
    idcsauth_payload="""<Configuration xmlns="http://www.w3.org/2001/XMLSchema" schemaLocation="http://higgins.eclipse.org/sts/Configuration Configuration.xsd">
<Setting Name="idcsprovider" Type="htf:map"  Path="/DeployedComponent/Server/NGAMServer/Profile/AuthenticationModules/CompositeModules/idcsprovider0">
	<Setting Name="Steps" Type="htf:list">
		<Setting Name="0" Type="htf:map">
			<Setting Name="PluginName" Type="xsd:string">OpenIDConnectPlugin</Setting>
			<Setting Name="Description" Type="xsd:string"></Setting>
			<Setting Name="Parameters" Type="htf:map">
				<Setting Name="id_domain" Type="xsd:string"></Setting>
				<Setting Name="ouath_client_secret" Type="xsd:string">09c0eb82-683e-4ea3-a815-dd479e2c02d4</Setting>
				<Setting Name="token_end_point" Type="xsd:string"></Setting>
				<Setting Name="authz_end_point" Type="xsd:string"></Setting>
				<Setting Name="require_proxy" Type="xsd:string"></Setting>
				<Setting Name="provider" Type="xsd:string">idcs</Setting>
				<Setting Name="scope" Type="xsd:string"></Setting>
				<Setting Name="additional_parameters" Type="xsd:string"></Setting>
				<Setting Name="userinfo_end_point" Type="xsd:string"></Setting>
				<Setting Name="discovery_url" Type="xsd:string">https://idcs-7b8fa955e5b74490b65e1a967f9b1848.identity.c9dev1.oc9qadev.com</Setting>
				<Setting Name="username_attr" Type="xsd:string">sub</Setting>
				<Setting Name="oauth_client_id" Type="xsd:string">ff157b3f6acb4da290dfa4587cf97fac</Setting>
			</Setting>
			<Setting Name="StepName" Type="xsd:string">idcsp</Setting>
		</Setting>
		<Setting Name="1" Type="htf:map">
			<Setting Name="PluginName" Type="xsd:string">UserIdentificationPlugIn</Setting>
			<Setting Name="Description" Type="xsd:string"></Setting>
			<Setting Name="Parameters" Type="htf:map">
				<Setting Name="KEY_IDENTITY_STORE_REF" Type="xsd:string"></Setting>
				<Setting Name="KEY_LDAP_FILTER" Type="xsd:string"></Setting>
				<Setting Name="KEY_SEARCH_BASE_URL" Type="xsd:string"></Setting>
			</Setting>
			<Setting Name="StepName" Type="xsd:string">ui</Setting>
		</Setting>
	</Setting>
	<Setting Name="Description" Type="xsd:string"></Setting>
	<Setting Name="Strategy" Type="htf:map">
		<Setting Name="Orchestration" Type="htf:list">
			<Setting Name="0" Type="htf:map">
				<Setting Name="Description" Type="xsd:string"></Setting>
				<Setting Name="OnSuccess" Type="xsd:string">ui</Setting>
				<Setting Name="StepName" Type="xsd:string">idcsp</Setting>
				<Setting Name="OnError" Type="xsd:string">failure</Setting>
				<Setting Name="OnFailure" Type="xsd:string">failure</Setting>
			</Setting>
			<Setting Name="1" Type="htf:map">
				<Setting Name="Description" Type="xsd:string"></Setting>
				<Setting Name="OnSuccess" Type="xsd:string">success</Setting>
				<Setting Name="StepName" Type="xsd:string">ui</Setting>
				<Setting Name="OnError" Type="xsd:string">failure</Setting>
				<Setting Name="OnFailure" Type="xsd:string">failure</Setting>
			</Setting>
		</Setting>
		<Setting Name="StrategyName" Type="xsd:string">SequentialPlugInExecutionStrategy</Setting>
		<Setting Name="StartingStep" Type="xsd:string">idcsp</Setting>
	</Setting>
</Setting>
</Configuration>"""
    headers = {
        'Content-Type': "application/xml",
        'Authorization': "Basic "+ authb64
    }
    
    url="http://den02mpu.us.oracle.com:22456" + modoamruntimeendpoint
    
    response = requests.request("PUT", url, data=idcsauth_payload, headers=headers)
    
    print(idcsauth_payload)
    print(response.text)

def modifyOamSessionAttrs():
    modsession_payload="""<Configuration xmlns="http://www.w3.org/2001/XMLSchema" schemaLocation="http://higgins.eclipse.org/sts/Configuration Configuration.xsd">
    <Setting Name="SessionConfigurations" Type="htf:map" Path="/DeployedComponent/Server/NGAMServer/Profile/Sme/SessionConfigurations">
        <Setting Name="Timeout" Type="htf:timeInterval">15 M</Setting>
        <Setting Name="MaxSessionsPerUser" Type="xsd:integer">400</Setting>
        <Setting Name="Expiry" Type="htf:timeInterval">480 M</Setting>
        <Setting Name="CredentialValidityInterval" Type="htf:timeInterval">480 M</Setting>
    </Setting>
</Configuration>"""
    headers = {
        'Content-Type': "application/xml",
        'Authorization': "Basic "+ authb64
    }
    
    url="http://den02mpu.us.oracle.com:22456" + modoamruntimeendpoint

    response = requests.request("PUT", url, data=modsession_payload, headers=headers)

    print(modsession_payload)
    print(response.text)

modifyOamSessionAttrs()
# modifyCustomAuthnPluginIDCS()

