*** Settings ***
Documentation  OAM OAuth TestSuite
Library     com.oracle.test.robot.common.PropertiesLoader
Library     Collections
Library     OperatingSystem
Library     com.oracle.test.robot.common.SystemLibrary

*** Variables ***
${protocol}=	http://
${secureprotocol}=	https://
${gold_log}=    goldlogs/idm/oam/oauth/
#${app1_url}=    /app1/pages/Sample.jsp
${app1_url}=    /index.html
${authz_redirect}=      /oauth2/rest/authorize
${invalid_authz_code}=      dnQzclplY2o1YWp1TXJNNGw2SjM5UT09fmU1OVBtNHF2V3RFcXRYZDhjQ0NVeEROVHhGQVhOMDE0UlJRRGRpUVdIU1BtZ3JOcHNLQlg4VUdnVld6R3hMN043d0svRzRDZWxlbVJ5UDVVQ1gxMGR5dnRxd1pxL3NSdlg3aHBWR1NOQUJ5TFNXa2pENlI3OEh4RGpGR3RsN1dKOUYrcWpNRFFJMUJHeWVwRnIySWYwa2VsR2h5VG5vK05RNDE5MFJBYk5uaEVaYlc1TFRrTmc1VUtzRThmYm1iNUdmK2MyWnlQWmpkS0gvcE1HTU00ZlR6KzRFeUhURTA2Y0JPNE9aeThoaHNIYlR2QmZRdXprZkFpbTN5ZHpVa2JYMDlna0F0TnZ6SnpkMys3Qk9aWDBSaUZRRHp0RExKMkNhdmQ2TThmazhzM0d6aE5uc3Z1dFN5VWp1ajQ2QUJV
${base_adminhost_adminport}=        ${protocol}${OAM_ADMSERVER_HOST}:${OAM_ADMSERVER_PORT}
#${base_adminhost_ohsport}=      ${protocol}${OAM_ADMSERVER_HOST}:${OHS_LISTEN_PORT}
${base_resourcewebgate_host_port}=       ${protocol}${OHS_HOST}:${OHS_LISTEN_PORT}

*** Keywords ***

Initialize Settings For ThreeLegged
	log     ${CURDIR}${/}..${/}..${/}..${/}settings${/}common${/}init.properties
#Process all the input values and [return]   the state of the environment
    ${workdir}=     Get Environment Variable     WORKDIR     ${EMPTY}
    log     ${workdir}
    log     ${workdir}${/}PREPARE${/}config.properties
    &{env_vars}     Get Environment Variables
    log dictionary  ${env_vars}

    &{Init}     create dictionary       goldlog.location=${gold_log}

	Set To Dictionary       ${Init}		oam.admin.server=${protocol}${OAM_ADMSERVER_HOST}:${OAM_ADMSERVER_PORT}
	Set To Dictionary       ${Init}		oam.admin.console.url=${protocol}${OAM_ADMSERVER_HOST}:${OAM_ADMSERVER_PORT}/oamconsole
	Set To Dictionary       ${Init}		oam.runtime.baseurl=${protocol}${OAM_ADMSERVER_HOST}:${OAM_MNGSERVER_PORT}
	Set To Dictionary       ${Init}		oam.domain.home=${OAM_DOMAIN_HOME}
	Set To Dictionary       ${Init}		oam.admin.username=${OAM_ADMIN_USER}
	Set To Dictionary       ${Init}		oam.admin.pass=${OAM_ADMIN_PWD}
	Set To Dictionary       ${Init}		resource_username=${OAM_ADMIN_USER}
	Set To Dictionary       ${Init}		resource_pwd=${OAM_ADMIN_PWD}
	Set To Dictionary       ${Init}		oam.admin.secure.server=${secureprotocol}${OAM_ADMSERVER_HOST}:${OAM_ADMSERVER_SSLPORT}
    Set To Dictionary       ${Init}		oam.admin.sslenabled='false'
	Set To Dictionary       ${Init}     oam.admin.secure.console.url=${secureprotocol}${OAM_ADMSERVER_HOST}:${OAM_ADMSERVER_SSLPORT}/oamconsole
	Set To Dictionary       ${Init}     oam.runtime.secure.baseurl=${secureprotocol}${OAM_ADMSERVER_HOST}:${OAM_MNGSERVER_SSL_PORT}
	Set To Dictionary       ${Init}     oam.domain.home=${OAM_DOMAIN_HOME}
    Set To Dictionary       ${Init}     resource_url=${protocol}${OHS_HOST}:${OHS_LISTEN_PORT}/index.html
    Set To Dictionary       ${Init}     oam.globallogouturl=${protocol}${OAM_ADMSERVER_HOST}:${OAM_MNGSERVER_PORT}/oam/server/logout
    Set To Dictionary       ${Init}     resource2_url=${protocol}${OHS_HOST}:${OHS_LISTEN_PORT}/index3.html
    Set To Dictionary       ${Init}     resource_appurl=${RESOURCE_APPURL}
    Set To Dictionary       ${Init}     resource_appdomain=${WEBGATE_ID}
    Set To Dictionary       ${Init}     oam.admin.secure.jksstorepath=${JKSSTORE_PATH}

#The following variables are required by Three-Legged flow only
    Set To Dictionary       ${Init}     oam.3l.vars.consentPageURL=${base_resourcewebgate_host_port}/oam/pages/consent.jsp
    Set To Dictionary       ${Init}     oam.3l.vars.errorPageURL=${base_resourcewebgate_host_port}/oam/pages/error.jsp
    Set To Dictionary       ${Init}     oam.3l.vars.redirectURI0=${base_resourcewebgate_host_port}${app1_url}
    Set To Dictionary       ${Init}     oam.3l.vars.redirectURI1=${base_adminhost_adminport}${app1_url}
    Set To Dictionary       ${Init}     oam.3l.adminhost.adminport=${base_adminhost_adminport}
    Set To Dictionary       ${Init}     oam.3l.adminhost.ohsport=${base_resourcewebgate_host_port}
    Set To Dictionary       ${Init}     oam.3l.ohshost.ohsport=${protocol}${OHS_HOST}:${OHS_LISTEN_PORT}
    Set To Dictionary       ${Init}     oam.3l.iss=${protocol}${OAM_ADMSERVER_HOST}:${OAM_MNGSERVER_PORT}/oauth2
    Set To Dictionary       ${Init}     oam.3l.identityProvider=${OAM_ID_STORE}

	Log Dictionary    ${Init}
	Set Suite Variable	&{Init}
	Set Suite Variable	${gold_Log_Dir}	&{Init}[goldlog.location]

    LOG TO CONSOLE      *****************************************************************${\n}
    LOG TO CONSOLE      DISPLAY INPUT PARAMETERS RECEIVED FROM ENVIRONMENT${\n}
    LOG TO CONSOLE      *****************************************************************${\n}
    ${items}=    Get Dictionary Items    ${Init}
    :FOR    ${key}    ${value}    IN    @{items}
    \    LOG TO CONSOLE     ${key} : ${value}

    LOG TO CONSOLE      *****************************************************************${\n}
    LOG TO CONSOLE      ${\n}
    LOG TO CONSOLE      TESTCASE EXECUTION STARTING NOW${\n}


Initialize Settings
	log     ${CURDIR}${/}..${/}..${/}..${/}settings${/}common${/}init.properties
# 	log     "Hello this is my first Robot log statement!!"
#Process all the input values and [return]   the state of the environment
    ${workdir}=     Get Environment Variable     WORKDIR     ${EMPTY}
    log     ${workdir}
    #log     %{WORKDIR}
    log     ${workdir}${/}PREPARE${/}config.properties
    &{env_vars}     Get Environment Variables
    log dictionary  ${env_vars}
    &{Init}     create dictionary   goldlog.location=${gold_log}

	Set To Dictionary	${Init}		oam.admin.server=${protocol}${OAM_ADMSERVER_HOST}:${OAM_ADMSERVER_PORT}
	Set To Dictionary	${Init}		oam.admin.console.url=${protocol}${OAM_ADMSERVER_HOST}:${OAM_ADMSERVER_PORT}/oamconsole
	Set To Dictionary	${Init}		oam.runtime.baseurl=${protocol}${OAM_ADMSERVER_HOST}:${OAM_MNGSERVER_PORT}
	Set To Dictionary	${Init}		oam.domain.home=${OAM_DOMAIN_HOME}
	Set To Dictionary   ${Init}		oam.admin.username=${OAM_ADMIN_PWD}
	Set To Dictionary	${Init}		oam.admin.pass=${OAM_ADMIN_PWD}
	Set To Dictionary	${Init}		resource_username=${OAM_ADMIN_PWD}
	Set To Dictionary   ${Init}		resource_pwd=${OAM_ADMIN_PWD}

	Set To Dictionary	${Init}		oam.admin.secure.server=${secureprotocol}${OAM_ADMSERVER_HOST}:${OAM_ADMSERVER_SSLPORT}
    Set To Dictionary	${Init}		oam.admin.sslenabled='false'
	Set To Dictionary   ${Init}    oam.admin.secure.console.url=${secureprotocol}${OAM_ADMSERVER_HOST}:${OAM_ADMSERVER_SSLPORT}/oamconsole
	Set To Dictionary	${Init}		oam.runtime.secure.baseurl=${secureprotocol}${OAM_ADMSERVER_HOST}:${OAM_MNGSERVER_SSL_PORT}
	Set To Dictionary   ${Init}    oam.domain.home=${OAM_DOMAIN_HOME}
    Set To Dictionary       ${Init}         resource_url=${protocol}${OHS_HOST}:${OHS_LISTEN_PORT}/index.html
    Set To Dictionary       ${Init}         oam.globallogouturl=${protocol}${OAM_ADMSERVER_HOST}:${OAM_MNGSERVER_PORT}/oam/server/logout
    Set To Dictionary       ${Init}         resource2_url=${protocol}${OHS_HOST}:${OHS_LISTEN_PORT}/index3.html
    Set To Dictionary       ${Init}         resource_appurl=${RESOURCE_APPURL}
    Set To Dictionary       ${Init}         resource_appdomain=${WEBGATE_ID}
    Set To Dictionary       ${Init}         oam.admin.secure.jksstorepath=${JKSSTORE_PATH}
#    file should exist  C:/Users/kgurupra.ORADEV/Desktop/DemoTrust.jks
#    copy file  C:/Users/kgurupra.ORADEV/Desktop/DemoTrust.jks  settings/common


#    file should exist  /net/${OAM_ADMSERVER_HOST}/${OAM_WLS_HOME}/server/lib/DemoTrust.jks
#    copy file  /net/${OAM_ADMSERVER_HOST}/${OAM_WLS_HOME}/server/lib/DemoTrust.jks  settings/common

	Log     After Init_prod is changed
	Log Dictionary    ${Init}
	Set Suite Variable	&{Init}
	Set Suite Variable	${gold_Log_Dir}	&{Init}[goldlog.location]

    LOG TO CONSOLE      *****************************************************************${\n}
    LOG TO CONSOLE      DISPLAY INPUT PARAMETERS RECEIVED FROM ENVIRONMENT${\n}
    LOG TO CONSOLE      *****************************************************************${\n}
    ${items}=    Get Dictionary Items    ${Init}
    :FOR    ${key}    ${value}    IN    @{items}
    \    LOG TO CONSOLE     ${key} : ${value}

    LOG TO CONSOLE      *****************************************************************${\n}
    LOG TO CONSOLE      ${\n}
    LOG TO CONSOLE      TESTCASE EXECUTION STARTING NOW${\n}

Initialize MDC Settings
	log     ${CURDIR}${/}..${/}..${/}..${/}settings${/}common${/}init.properties
#Process all the input values and [return]   the state of the environment
    ${workdir}=     Get Environment Variable     WORKDIR     ${EMPTY}
    log     ${workdir}
    log     ${workdir}${/}PREPARE${/}config.properties
    &{env_vars}     Get Environment Variables
    log dictionary  ${env_vars}

    &{Init}     create dictionary       goldlog.location=${gold_log}

#GET ALL LBR DETAILS FROM ENV

	Set To Dictionary       ${Init}		lbr.install.loc=${DC1_HAPROXY_INSTALL_LOC}
	Set To Dictionary       ${Init}		lbr.config.loc=${DC1_HAPROXY_CONFIG_FILE}
	Set To Dictionary       ${Init}		lbr.host=${DC1_HAPROXY_LBR_HOST}
	Set To Dictionary       ${Init}		lbr.port=${DC1_LBR_PORT}


#GET ALL DETAILS OF MASTER DC FROM ENV
	Set To Dictionary       ${Init}		oam.admin.username=${DC1_WLS_USER}
	Set To Dictionary       ${Init}		oam.admin.pass=${DC1_WLS_PWD}
	Set To Dictionary       ${Init}		dc1.mw.home=${DC1_MW_HOME}
	Set To Dictionary       ${Init}		dc1.wl.home=${DC1_WL_HOME}
	Set To Dictionary       ${Init}		dc1.oracle.home=${DC1_ORACLE_HOME}
	Set To Dictionary       ${Init}		dc1.wls.domain.home=${DC1_WLS_DOMAIN_HOME}
	Set To Dictionary       ${Init}		dc1.common.oracle.home=${DC1_COMMON_ORACLE_HOME}
	Set To Dictionary       ${Init}		dc1.hostname=${DC1_HOSTNAME}
	Set To Dictionary       ${Init}		dc1.wls.console.port=${DC1_WLS_CONSOLE_PORT}
	Set To Dictionary       ${Init}		dc1.wls.console.sslport=${DC1_WLS_CONSOLE_SSLPORT}
	Set To Dictionary       ${Init}		dc1.oam.mngserver.port=${DC1_OAM_MNGSERVER_PORT}
	Set To Dictionary       ${Init}		dc1.oam.mngserver.ssl_port=${DC1_OAM_MNGSERVER_SSL_PORT}
	Set To Dictionary       ${Init}		dc1.oam.mngserver2.port=${DC1_OAM_MNGSERVER_PORT}
	Set To Dictionary       ${Init}		dc1.oam.mngserver2.ssl.port=${DC1_OAM_MNGSERVER_SSL_PORT}

#GET ALL DETAILS OF Clone1 DC FROM ENV
	Set To Dictionary       ${Init}     dc2.wls.user=${DC2_WLS_USER}
	Set To Dictionary       ${Init}     dc2.wls.pwd=${DC2_WLS_PWD}
	Set To Dictionary       ${Init}     dc2.mw.home=${DC2_MW_HOME}
	Set To Dictionary       ${Init}     dc2.wl.home=${DC2_WL_HOME}
	Set To Dictionary       ${Init}     dc2.oracle.home=${DC2_ORACLE_HOME}
	Set To Dictionary       ${Init}     dc2.wls.domain.home=${DC2_WLS_DOMAIN_HOME}
	Set To Dictionary       ${Init}     dc2.common.oracle.home=${DC2_COMMON_ORACLE_HOME}
	Set To Dictionary       ${Init}     dc2.hostname=${DC2_HOSTNAME}
	Set To Dictionary       ${Init}     dc2.wls.console.port=${DC2_WLS_CONSOLE_PORT}
	Set To Dictionary       ${Init}     dc2.wls.console.sslport=${DC2_WLS_CONSOLE_SSLPORT}
	Set To Dictionary       ${Init}     dc2.oam.mngserver.port=${DC2_OAM_MNGSERVER_PORT}
	Set To Dictionary       ${Init}     dc2.oam.mngserver.ssl_port=${DC2_OAM_MNGSERVER_SSL_PORT}
	Set To Dictionary       ${Init}     dc2.oam.mngserver2.port=${DC2_OAM_MNGSERVER2_PORT}
	Set To Dictionary       ${Init}     dc2.oam.mngserver2.ssl.port=${DC2_OAM_MNGSERVER2_SSL_PORT}
        #############BUILD HTTP AND HTTPS LINKS FOR RUNNING OAUTH ADMIN REST API AND RUNTIME REST API##############


#ORGANISE THE INPUT COMING FROM ENVIRONMENT FILE FOR NON-MDC AND MDC CASES, TO INCLUDE BOTH HTTP AND HTTPS

#CONSTURCT ALL LINKS PERTAINING TO MASTER
	Set To Dictionary   ${Init}     master.oam.admin.server=${protocol}${DC1_HOSTNAME}:${DC1_WLS_CONSOLE_PORT}
	Set To Dictionary   ${Init}     master.oam.admin.console.url=${protocol}${DC1_HOSTNAME}:${DC1_WLS_CONSOLE_PORT}/oamconsole
	Set To Dictionary   ${Init}     master.oam.runtime.baseurl=${protocol}${DC1_HOSTNAME}:${DC1_OAM_MNGSERVER_PORT}
	Set To Dictionary   ${Init}     master.oam.domain.home=${DC1_WLS_DOMAIN_HOME}
	Set To Dictionary   ${Init}     master.oam.admin.username=${DC1_WLS_USER}
	Set To Dictionary   ${Init}     master.oam.admin.pass=${DC1_WLS_PWD}
	Set To Dictionary   ${Init}     dc1.oam.3l.adminhost.ohsport=${protocol}${DC1_OHS12C_HOSTNAME}:${DC1_OHS12C_LISTEN_PORT}
	Set To Dictionary   ${Init}     dc1.oam.3l.adminhost.adminport=${protocol}${DC1_HOSTNAME}:${DC1_WLS_CONSOLE_PORT}
	Set To Dictionary   ${Init}     dc1.oam.3l.ohshost.ohsport=${protocol}${DC1_OHS12C_HOSTNAME}:${DC1_OHS12C_LISTEN_PORT}
	Set To Dictionary   ${Init}     dc1.oam.runtime.baseurl=${protocol}${DC1_HOSTNAME}:${DC1_OAM_MNGSERVER_PORT}
	Set To Dictionary   ${Init}     dc2.oam.3l.adminhost.ohsport=${protocol}${DC2_OHS12C_HOSTNAME}:${DC2_OHS12C_LISTEN_PORT}
	Set To Dictionary   ${Init}     dc2.oam.3l.adminhost.adminport=${protocol}${DC2_HOSTNAME}:${DC2_WLS_CONSOLE_PORT}
	Set To Dictionary   ${Init}     dc2.oam.3l.ohshost.ohsport=${protocol}${DC2_OHS12C_HOSTNAME}:${DC2_OHS12C_LISTEN_PORT}
	Set To Dictionary   ${Init}     dc2.oam.runtime.baseurl=${protocol}${DC2_HOSTNAME}:${DC2_OAM_MNGSERVER_PORT}
#    Set To Dictionary   ${Init}     dc1.oam.3l.identityProvider=${OAM_ID_STORE}
    Set To Dictionary   ${Init}     dc1.oam.3l.identityProvider=UserIdentityStore1
    Set To Dictionary   ${Init}     oam.3l.iss=${protocol}${DC1_HOSTNAME}:${DC1_OAM_MNGSERVER_PORT}/oauth2
    Set To Dictionary   ${Init}     oam.3l.vars.redirectURI0=${protocol}${DC1_OHS12C_HOSTNAME}:${DC1_OHS12C_LISTEN_PORT}${app1_url}
    Set To Dictionary   ${Init}     oam.3l.vars.redirectURI1=${protocol}${DC1_OHS12C_HOSTNAME}:${DC1_OHS12C_LISTEN_PORT}${app1_url}

#CONSTURCT ALL LINKS PERTAINING TO Clone1
	Set To Dictionary   ${Init}		clone1.oam.admin.server=${protocol}${DC2_HOSTNAME}:${DC2_WLS_CONSOLE_PORT}
	Set To Dictionary   ${Init}		clone1.oam.admin.console.url=${protocol}${DC2_HOSTNAME}:${DC2_WLS_CONSOLE_PORT}/oamconsole
	Set To Dictionary   ${Init}		clone1.oam.runtime.baseurl=${protocol}${DC2_HOSTNAME}:${DC2_OAM_MNGSERVER_PORT}
	Set To Dictionary   ${Init}		clone1.oam.domain.home=${DC2_WLS_DOMAIN_HOME}
	Set To Dictionary   ${Init}		clone1.oam.admin.username=${DC2_WLS_USER}
	Set To Dictionary   ${Init}		clone1.oam.admin.pass=${DC2_WLS_PWD}
#Build http links for robotframework to make use, containing both DC1 and DC2 details

	Log     After Init_prod is changed
	Log Dictionary    ${Init}

	Set Suite Variable	&{Init}
	Set Suite Variable	${gold_Log_Dir}	&{Init}[goldlog.location]
	LOG TO CONSOLE      *****************************************************************${\n}
	LOG TO CONSOLE      DISPLAY INPUT PARAMETERS RECEIVED FROM ENVIRONMENT${\n}
	LOG TO CONSOLE      *****************************************************************${\n}
    ${items}=    Get Dictionary Items    ${Init}
    :FOR    ${key}    ${value}    IN    @{items}
    \    LOG TO CONSOLE     ${key} : ${value}

	LOG TO CONSOLE      *****************************************************************${\n}
    LOG TO CONSOLE      ${\n}
    LOG TO CONSOLE      TESTCASE EXECUTION STARTING NOW${\n}

Initialize Settings for SME
		log     ${CURDIR}${/}..${/}..${/}..${/}settings${/}common${/}init.properties
# 	log     "Hello this is my first Robot log statement!!"
#Process all the input values and [return]   the state of the environment
	log	${OAM_ADMSERVER_HOST}
	log	${OAM_ADMSERVER_PORT}
	log	${OAM_WLS_USER}
	log	${OAM_WLS_PWD}
	log	${OAM_MW_HOME}
	log	${OAM_ORACLE_HOME}
	log	${OAM_DOMAIN_HOME}
	log	${OAM_MNGSERVER_PORT}
	log	${OAM_MNGSERVER_NAME}
	log	${OAM_ADMIN_USER}
	log	${OAM_ADMIN_PWD}


   	${workdir}=     Get Environment Variable     WORKDIR     ${EMPTY}
	log     ${workdir}
	#log     %{WORKDIR}
	log     ${workdir}${/}PREPARE${/}config.properties
	#log     %{WORKDIR}${/}PREPARE${/}config.properties
	Get Environment Variables
	#Copy File 	${workdir}${/}PREPARE${/}config.properties

	&{Init}=	Get Properties	${CURDIR}${/}..${/}..${/}..${/}settings${/}common${/}init.properties	settings
	#&{Init_prod}=	Get Properties	%{WORKDIR}${/}PREPARE${/}config.properties	settings
	log     Before Starting with Init values
	Log Dictionary    ${Init}

	Set To Dictionary	${Init}		oam.admin.server=${protocol}${OAM_ADMSERVER_HOST}:${OAM_ADMSERVER_PORT}
	Set To Dictionary	${Init}		oam.admin.console.url=${protocol}${OAM_ADMSERVER_HOST}:${OAM_ADMSERVER_PORT}/oamconsole
	Set To Dictionary	${Init}		oam.runtime.baseurl=${protocol}${OAM_ADMSERVER_HOST}:${OAM_MNGSERVER_PORT}
	Set To Dictionary       ${Init}		oam.admin.username=${OAM_ADMIN_USER}
	Set To Dictionary	${Init}		oam.admin.pass=${OAM_ADMIN_PWD}
	Set To Dictionary	${Init}		resource_username=${OAM_ADMIN_USER}
	Set To Dictionary       ${Init}		resource_pwd=${OAM_ADMIN_PWD}
    Set To Dictionary       ${Init}         resource_appdomain=${WEBGATE_ID}
    Set To Dictionary       ${Init}         resource_url=${protocol}${OHS_HOST}:${OHS_LISTEN_PORT}/index.html
    Set To Dictionary       ${Init}         oam.globallogouturl=${protocol}${OAM_ADMSERVER_HOST}:${OAM_MNGSERVER_PORT}/oam/server/logout
    Set To Dictionary       ${Init}         resource2_url=${protocol}${OHS_HOST}:${OHS_LISTEN_PORT}/index_de.html
	Set To Dictionary       ${Init}		database.home=${DATABASE_HOME}
	Set To Dictionary   ${Init}    oamconfig.path=${OAM_DOMAIN_HOME}/config/fmwconfig/
	Set To Dictionary   ${Init}    oamconfig.path.temp=${OAM_MW_HOME}/
	Set To Dictionary       ${Init}         direct_authn_url=${protocol}${OAM_ADMSERVER_HOST}:${OAM_MNGSERVER_PORT}/oam/server/authentication?username=${OAM_ADMIN_USER}&password=${OAM_ADMIN_PWD}&successurl=${protocol}${OHS_HOST}:${OHS_LISTEN_PORT}/index.html
	Set To Dictionary	${Init}		connect.url=connect('${OAM_ADMIN_USER}','${OAM_ADMIN_PWD}','t3://${OAM_ADMSERVER_HOST}:${OAM_ADMSERVER_PORT}')
	Set To Dictionary	${Init}		wlst.location=${OAM_MW_HOME}/oracle_common/common/bin/wlst.sh

	Log     After Init_prod is changed
	Log Dictionary    ${Init}

	Set Suite Variable	&{Init}
	Set Suite Variable	${gold_Log_Dir}	&{Init}[goldlog.location]

	
Initialize Test Data
	[Arguments]	${test_file}
	&{test_data}=	Get Properties	${CURDIR}${/}..${/}..${/}..${/}testdata${/}${test_file}	testdata
	Set Suite Variable		&{test_data}

Initialize oamconsole xpaths
	[Arguments]	${test_file}
	&{oamconsole}=	Get Properties	${CURDIR}${/}..${/}..${/}..${/}settings${/}idm${/}oam${/}${test_file}	settings
	Set Suite Variable		&{oamconsole}

