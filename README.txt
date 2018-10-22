/
/ $Header: ngam/test/functional/robot-exec/README.txt /main/3 2017/06/20 20:57:13 kgurupra Exp $
/
/ README.txt
/
/ Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
/
/   NAME
/     README.txt - <one-line expansion of the name>
/
/   DESCRIPTION
/     <short description of component this file declares/defines>
/
/   NOTES
/     <other useful comments, qualifications, etc.>
/
/   MODIFIED   (MM/DD/YY)
/   kgurupra    02/26/17 - Creation
/


Modify EnvVariableFile.py file, to contain the working environment  details under OAM server info section only as of this check-in.

STEPS TO EXECUTE THE TESTCASES
1. COMMENT ALL THE ROBOT FILES WHICH YOU DO NOT INTEND TO EXECUTE.
2. UNCOMMENT THE ONLY ROBOT TESTCASES WHICH YOU INTEND TO EXECUTE
3. Modify <testCasesDirectory>tests/idm/oam/oauth</testCasesDirectory> pom.xml file under robot-exec project to point
 to respective testcases, you would like to execute
4. Go to command line and execute first mvn clean install on robot-libraries project
5. Go to command line and execute mvn clean install on robot-exec project, to execute the testcases which you have
uncommented in STEP 2


STEPS TO GENERATE ZIP FILE
1. EXECUTE mvn clean install on robot-libraries project first
2. EXECUTE mvn clean install on parent project(provided you have already received a clean result on robot-exec project)
3. zip file will be generated, it contains robot-exec dir and lib dir
