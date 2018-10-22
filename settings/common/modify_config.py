#!/usr/bin/env python
#                NAME
#                       modify_config.py
#
#               DESCRIPTION
#                       Update oam config with custom attributes
#

import sys
import os
import base64
import requests
import time

HOSTNAME = ""
EXIT_STATUS = "FAILURE"
exit_value = 0
run_as_root_cmd = "/usr/local/packages/aime/ias/run_as_root"
createuserendpoint = "/management/weblogic/latest/serverConfig/securityConfiguration/realms/myrealm/authenticationProviders/DefaultAuthenticator/createUser"
modoamruntimeendpoint = "/iam/admin/config/api/v1/config"

if (len(sys.argv) < 4):
    print ("Usage: python xxxx.py import.txt export.txt runtime.txt\n");
    exit_value = -1
    sys.exit(exit_value)

importfile = str(sys.argv[1])
exportfile = str(sys.argv[2])
runtimefile = str(sys.argv[3])

print " build_run_robot.py: Python file is running....\n";

importProperties = {}
runtimeProperties = {}
exportProperties = {}
envProperties = {}


################################################
#  Read properties from import.txt file #
################################################
def parse_import_file(importfile):
    reader = open(importfile)
    for line in reader.readlines():
        line = line.strip("\n")
        (key, _, value) = line.partition("=")
        importProperties[key] = value
    reader.close()
    global HOSTNAME
    HOSTNAME = importProperties["HOSTNAME"]


################################################
#  Read properties from runtime.txt file #
################################################
def parse_runtime_file(importfile):
    reader = open(importfile)
    for line in reader.readlines():
        line = line.strip("\n")
        (key, _, value) = line.partition("=")
        runtimeProperties[key] = value
    reader.close()


################################################
#  Read properties from env.txt file #
################################################
def parse_env_file(importfile):
    reader = open(importfile)
    for line in reader.readlines():
        line = line.strip("\n")
        (key, _, value) = line.partition("=")
        envProperties[key] = value
    reader.close()


################################################
#  Writer properties to export.txt file #
################################################
def populate_export_file(exportfile):
    exportProperties["HOSTNAME"] = HOSTNAME
    exportProperties["EXIT_STATUS"] = EXIT_STATUS
    writer = open(exportfile, "w")
    for key in exportProperties.keys():
        writer.write(key + "=" + exportProperties[key] + "\n")
    writer.close()


def run_cmd(cmd):
    print "Executing: " + cmd
    f = os.popen(cmd)
    lines = f.readlines()
    for line in lines:
        print line
    f.close()
    return lines


def run_as_root(cmd):
    return run_cmd(run_as_root_cmd + " \"" + cmd + "\"")


################################################
#  Read properties from config.propertie and writer to EnvVariableFile.py #
################################################
def convert_properties():
    global envVariableFile
    print "Read properties file, and convert o EnvVariableFile.py"
    four_space = " " * 4
    reader = open(importProperties["PROPERTY_FILE"])
    envVariableFile = runtimeProperties["WORKDIR"] + "/EnvVariableFile.py"
    writer = open(envVariableFile, "w")
    # print EnvVariableFile.py's header
    writer.write("class EnvVariableFile(object):\n")
    writer.write(four_space + "T_WORK = '" + runtimeProperties["WORKDIR"] + "/../'\n")
    VIEW_ROOT = os.environ["ADE_VIEW_ROOT"] if "ADE_VIEW_ROOT" in os.environ else ""
    writer.write(four_space + "VIEW_ROOT = '" + VIEW_ROOT + "'\n")
    writer.write(four_space + "BROWSERTYPE = 'firefox'" + "\n")
    # print EnvVariableFile.py's properties
    for line in reader.readlines():
        line = line.strip("\n")
        if (len(line) == 0):
            continue
        writer.write(four_space)
        if (line.startswith("#")):
            writer.write(line + "\n")
        elif (line.find("=") > 0):
            (key, _, value) = line.partition("=")
            if (key.find(".") == -1):
                writer.write(key + " = '" + value + "'")
        else:
            print ("Unknow line: " + line)
        writer.write("\n")
    # print booter
    writer.write(four_space + "def __init__(self):\n")
    writer.write(four_space + four_space + "self.another_variable = 'another value'")
    reader.close()
    writer.close()


################################################
# Mofify Session attributes
################################################
def modifyOamSessionAttrs():
    ADMIN_USERNAME = importProperties["ADMIN_USERNAME"]
    ADMIN_PASSWORD = importProperties["ADMIN_PASSWORD"]
    ADMIN_HOSTNAME = importProperties["ADMIN_HOST"]
    ADMIN_PORT = importProperties["ADMIN_PORT"]
    bstr = ADMIN_USERNAME + ":" + ADMIN_PASSWORD
    AUTHB64 = base64.b64encode(bstr)
    print(AUTHB64)
    modsession_payload = """<Configuration xmlns="http://www.w3.org/2001/XMLSchema" schemaLocation="http://higgins.eclipse.org/sts/Configuration Configuration.xsd">
    <Setting Name="SessionConfigurations" Type="htf:map" Path="/DeployedComponent/Server/NGAMServer/Profile/Sme/SessionConfigurations">
        <Setting Name="Timeout" Type="htf:timeInterval">15 M</Setting>
        <Setting Name="MaxSessionsPerUser" Type="xsd:integer">400</Setting>
        <Setting Name="Expiry" Type="htf:timeInterval">480 M</Setting>
        <Setting Name="CredentialValidityInterval" Type="htf:timeInterval">480 M</Setting>
    </Setting>
</Configuration>"""
    headers = {
        'Content-Type': "application/xml",
        'Authorization': "Basic " + AUTHB64
    }
    
    url = "http://" + ADMIN_HOSTNAME + ":" + ADMIN_PORT + modoamruntimeendpoint
    
    response = requests.request("PUT", url, data=modsession_payload, headers=headers)
    
    print(modsession_payload)
    print(response.text)


parse_import_file(importfile)
parse_runtime_file(runtimefile)
tempenvfile = runtimefile.rsplit('/', 1)
envfile = tempenvfile[0] + '/env.txt'
print envfile
parse_env_file(envfile)

envVariableFile = ""
testBinaryDir = ""

modifyOamSessionAttrs()
time.sleep(30)
populate_export_file(exportfile)

os._exit(exit_value)
