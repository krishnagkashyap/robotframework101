#!/usr/dev_infra/platform/bin/python2.7
import os;
import sys;
import shutil, errno;
import zipfile;
import sys;
import subprocess;


def createZip(output_filename, format, dir_name):
	# print("OUTPUTFILENAME>>>>>" + output_filename);
	# print("FORMAT>>>>" + format);
	# print("DIR_NAME>>>>>" + dir_name);
	shutil.make_archive(output_filename, format, dir_name);
	shutil.copy2(output_filename + ".zip", dir_name);
	print("Created zipfile successfully!");


def copyJars(fromDir, robot_libraries_sh, copyrobot_libraries, toDir):
	##copy jars from slc06xgk machine
	IGNORE_PATTERNS = ('*.pyc', 'CVS', '^.git', 'tmp', '.svn', '.ade_path', 'lib')
	# if (not os.path.isfile(copyrobot_libraries)):
	# 	print("Running robot-library for execution!");
	# 	retcode = subprocess.call([robot_libraries_sh]);
	# 	# retcode.wait();
	# 	print ("Return Code for mvn >>>>>>", retcode);
	try:
		shutil.copytree(fromDir, toDir, ignore=shutil.ignore_patterns(IGNORE_PATTERNS));
		shutil.copy2(copyrobot_libraries, toDir);
		print("Created lib dir and copied jars successfully!");
	except OSError as exc:
		if exc.errno == errno.ENOTDIR:
			shutil.copy(fromDir, toDir);
		else:
			raise;


def copyRobotSrc(fromSrc, toSrc):
	##Copy robot-exec source from ngam dir
	IGNORE_PATTERNS = ('*.pyc', 'CVS', '^.git', 'tmp', '.svn')
	print("fromSrc>>>>", fromSrc);
	print("toSrc>>>>", toSrc);
	try:
		shutil.copytree(fromSrc, toSrc);
		print("Copied robot-exec successfully!");
	except OSError as exc:
		if exc.errno == errno.ENOTDIR:
			shutil.copy(fromSrc, toSrc);
		else:
			raise;


def deleteZip(ziploc0, ziploc1):
	print("IF ANY - Trying to delete already created zip folder and files!!");
	try:
		if (os.path.exists(ziploc0)):
			print("Removing dir >>>>>>" + ziploc0);
			shutil.rmtree(ziploc0);
			print("Successfully Removed dir >>>>>>" + ziploc0);
		else:
			print("Did not remove dir >>>>>>" + ziploc0);
	except:
		print("Did not remove dir >>>>>>" + ziploc0);
	try:
		if (os.path.isfile(ziploc1)):
			print("Removing file >>>>>>" + ziploc1);
			os.remove(ziploc1);
			print("Successfully Removed file >>>>>>" + ziploc1);
		else:
			print("Did not removefile >>>>>>" + ziploc1);
	except:
		print("Did not remove file >>>>>>" + ziploc1);


def main():
	print("Begin creation of robot-zip file");
	# create dir
	ade_view_root = os.environ['ADE_VIEW_ROOT'];
	scriptfilezip_path = ade_view_root + "/ngam/test/functional/robot-exec/py/oauthrobot.zip";
	zipfilefile_path = ade_view_root + "/ngam/test/functional/robot-zip";
	file_path = ade_view_root + "/ngam/test/functional/robot-zip/oauthrobot";
	fromDir = "/net/slc06xgk/scratch/kgurupra/oauthrobot/lib";
	toDir = ade_view_root + "/ngam/test/functional/robot-zip/oauthrobot/lib";
	fromSrc = ade_view_root + "/ngam/test/functional/robot-exec";
	toSrc = ade_view_root + "/ngam/test/functional/robot-zip/oauthrobot/robot-exec";
	robot_libraries_sh = ade_view_root + "/ngam/test/functional/robot-exec/py/mvnrobot-lib.sh";
	copyrobot_libraries = ade_view_root + "/ngam/test/functional/robot-libraries/target/robot-libraries-0.0.1-SNAPSHOT.jar";
	
	# print ("ADE_VIEW_ROOT>>>>>>>>>" + ade_view_root + "\n");
	# print ("file_path>>>>>>>>>" + file_path + "\n");
	# print ("fromDir>>>>>>>>>" + fromDir + "\n");
	# print ("toDir>>>>>>>>>" + toDir + "\n");
	# print ("fromSrc>>>>>>>>>" + fromSrc + "\n");
	# print ("toSrc>>>>>>>>>" + toSrc + "\n");
	
	try:
		# check if dir exists
		os.path.isdir(file_path);
	except:
		print("robot-zip dir does not exist");
		os.mkdir(file_path);
	# COPY LIB dir from slc06xgk.us.oracle.com machine on to existing view
	os.environ["JAVA_HOME"] = "/ade_autofs/gd29_3rdparty/JDK8_MAIN_LINUX.X64.rdd/161004.1.8.0.111.0B014/jdk8";
	print("JAVA_HOME>>>>>>>>>>", os.environ["JAVA_HOME"]);
	deleteZip(file_path, scriptfilezip_path);
	copyJars(fromDir, robot_libraries_sh, copyrobot_libraries, toDir);
	copyRobotSrc(fromSrc, toSrc);
	createZip("oauthrobot", "zip", zipfilefile_path);
	print("End creation of robot-zip file");


main();
