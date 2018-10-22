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

import sys
import os
import pprint
import subprocess
import urllib2
import re


HOSTNAME=""
EXIT_STATUS="FAILURE"
exit_value=0
run_as_root_cmd = "/usr/local/packages/aime/ias/run_as_root"

if ( len(sys.argv) < 4): 
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
        importProperties[key]=value
    reader.close()
    global HOSTNAME
    HOSTNAME=importProperties["HOSTNAME"]
    
################################################
#  Read properties from runtime.txt file #
################################################
def parse_runtime_file(importfile):
    reader = open(importfile)
    for line in reader.readlines():
        line = line.strip("\n")
        (key, _, value) = line.partition("=")
        runtimeProperties[key]=value
    reader.close()

################################################
#  Read properties from env.txt file #
################################################
def parse_env_file(importfile):
    reader = open(importfile)
    for line in reader.readlines():
        line = line.strip("\n")
        (key, _, value) = line.partition("=")
        envProperties[key]=value
    reader.close()

################################################
#  Writer properties to export.txt file #
################################################
def populate_export_file(exportfile):
    exportProperties["HOSTNAME"]=HOSTNAME
    exportProperties["EXIT_STATUS"]=EXIT_STATUS
    writer = open (exportfile,"w")
    for key in exportProperties.keys():
        writer.write(key+ "=" +exportProperties[key] + "\n")
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
        return run_cmd(run_as_root_cmd + " \""+ cmd +"\"")

################################################
#  Read properties from config.propertie and writer to EnvVariableFile.py #
################################################
def convert_properties():
    global envVariableFile
    print "Read properties file, and convert o EnvVariableFile.py"
    four_space = " " *4
    reader = open(importProperties["PROPERTY_FILE"])
    envVariableFile = runtimeProperties["WORKDIR"]+"/EnvVariableFile.py"
    writer = open(envVariableFile,"w")
    #print EnvVariableFile.py's header
    writer.write("class EnvVariableFile(object):\n")
    writer.write(four_space + "T_WORK = '" +  runtimeProperties["WORKDIR"] + "/../'\n")
    VIEW_ROOT = os.environ["ADE_VIEW_ROOT"] if "ADE_VIEW_ROOT" in os.environ else ""
    writer.write(four_space + "VIEW_ROOT = '" +  VIEW_ROOT  + "'\n")
    writer.write(four_space + "BROWSERTYPE = 'firefox'"+ "\n")
    #print EnvVariableFile.py's properties
    for line in reader.readlines():
        line = line.strip("\n")
        if (len(line)==0):
            continue
        writer.write(four_space)
        if (line.startswith("#")):
            writer.write(line + "\n")
        elif (line.find("=")>0):
            (key, _, value) = line.partition("=")
            if (key.find(".")==-1):
                writer.write(key + " = '" + value + "'")
        else:
            print ("Unknow line: " + line)
        writer.write("\n")
    #print booter
    writer.write(four_space + "def __init__(self):\n")
    writer.write(four_space + four_space + "self.another_variable = 'another value'")
    reader.close()
    writer.close()

 
################################################
# download and unzip binary
# TEST_BINARY suppport below 3 format
# 1. /net/slc00bpj/xxx/iQRF.zip, unzip it directory
# 2. http://xxx/xxx/xxx.zip, download then unzip it
# 3. others, get the latest version from artifactory 
################################################
def download_unzip_binary():
    global testBinaryDir,testBinaryURLFolder
    TEST_BINARY_URL=""
    TEST_BINARY = importProperties["TEST_BINARY"]
    
    if (TEST_BINARY.startswith("http")):
        TEST_BINARY_URL=TEST_BINARY
        print "Use the url provided by user to download test binary: " + TEST_BINARY_URL
    elif (TEST_BINARY.find("zip")>0):
        print "Use the local binary provided by user: " + TEST_BINARY
    else:
        releaseVersion= importProperties["REL"]
        testBinaryURLFolder=testBinaryURLFolder + "iQRF_" + releaseVersion + "/"
        response = urllib2.urlopen(testBinaryURLFolder)
        html = response.read()
        r = re.compile(r'\d{6}\.\d{4}')
        latestVersion = max(r.findall(html))
        print "Latest version: " + latestVersion
        TEST_BINARY_URL = testBinaryURLFolder +latestVersion + "/iQRF_" +releaseVersion +"_" + latestVersion+ ".zip"
        print "Find latest test binary url: " + TEST_BINARY_URL
    
    if (TEST_BINARY_URL.startswith("http")):
        print "Download test binary: " + TEST_BINARY_URL
        TEST_BINARY = TEST_BINARY_URL.split("/")[-1]
        run_cmd("rm -rf " + TEST_BINARY)    
        run_cmd("wget " + TEST_BINARY_URL)
   
    workdir=runtimeProperties["WORKDIR"]
    t_work = '/'.join(workdir.split('/')[:-1])
    testBinaryDir=t_work+"/TestBinary/"
    if(os.path.exists(testBinaryDir)):
        run_cmd("rm -rf "+testBinaryDir)
    run_cmd("mkdir "+testBinaryDir)
    run_cmd("unzip "+TEST_BINARY + " -d "+ testBinaryDir)
    print "Unzip test binary completed"


################################################
#  launch robot test #
################################################   
def launch_robot():
    global EXIT_STATUS,exit_value,testBinaryDir
    print "launch_robot"
    testOutputDir=runtimeProperties["WORKDIR"]+ "/TestResult"
    if(os.path.exists(testOutputDir)):
        run_cmd("rm -rf "+testOutputDir)
    run_cmd("mkdir "+testOutputDir)
    
    projectName = os.listdir(testBinaryDir)[0]
    print "projectName: " + projectName
    testBinaryDir = testBinaryDir + "/" + projectName
    lib_dirs=[]
    for root, dirs, files in os.walk(testBinaryDir):
        if (dirs.count("lib")>0):
            lib_dirs.append(root+"/lib/*") 
    launchRobotCmd="jybot --loglevel TRACE  --outputdir "+ testOutputDir + " --variablefile "+ envVariableFile + " "  + testBinaryDir +  importProperties["TEST_SUITE"]
    print "Prepare the Env variables ...\n"
    os.environ["DISPLAY"]= HOSTNAME+":"+ importProperties["displayNum"]
    PYTHON_HOME = importProperties["PYTHON_HOME"]
    JYTHON_HOME = importProperties["JYTHON_HOME"]
    JAVA_HOME = importProperties["JAVA_HOME"]
    T_WORKDIR = envProperties["T_WORK"]
    FIREFOX14_DIR = T_WORKDIR + "/firefox:"
    print "T_WORKDIR"+ T_WORKDIR
    print "FIREFOX14_DIR"+ FIREFOX14_DIR
    os.environ["PYTHON_HOME"]= PYTHON_HOME
    os.environ["JYTHON_HOME"]= JYTHON_HOME
    os.environ["JAVA_HOME"]= JAVA_HOME
    os.environ["PYTHONPATH"]= PYTHON_HOME + "/lib"
    os.environ["PATH"] = PYTHON_HOME + "/bin:" + PYTHON_HOME + "/lib:" + JYTHON_HOME + "/bin:" + "/lib:" + JAVA_HOME + ":" + JAVA_HOME+"/bin:" + FIREFOX14_DIR + os.environ["PATH"]
    #ADE_VIEW_ROOT=os.environ["ADE_VIEW_ROOT"] if "ADE_VIEW_ROOT" in os.environ else ""
    print "PATH SET BEFORE EXECUTING ROBOT TESTCASES" + os.environ["PATH"]
    CLASSPATH=""
    for lib_dir in lib_dirs:
        CLASSPATH=CLASSPATH+lib_dir + ":"
    os.environ["CLASSPATH"] =  CLASSPATH + "."
    print "CLASSPATH:" +   os.environ["CLASSPATH"]
    print "PATH:" +   os.environ["PATH"]  
    run_cmd (launchRobotCmd)
    if (os.path.exists(testOutputDir + "/log.html")):
         EXIT_STATUS="SUCCESS"
         exit_value=1
    exportProperties['TEST_RESULT_DIR']=testOutputDir


parse_import_file(importfile)
parse_runtime_file(runtimefile)
tempenvfile = runtimefile.rsplit('/', 1)
envfile = tempenvfile[0] + '/env.txt'
print envfile
parse_env_file(envfile)

envVariableFile = ""
testBinaryDir=""
testBinaryURLFolder="http://artifactory-slc.oraclecorp.com/artifactory/fmwtest-sandbox-local/com/oracle/fmwtest/qa/"


convert_properties()
download_unzip_binary()
launch_robot()
populate_export_file(exportfile)

os._exit(exit_value)
