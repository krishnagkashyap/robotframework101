#
# $Id: EnableDirectAuthenticationDesc.py /main/1 2017/10/05 09:25:50 arusarda Exp $
# This script enables Direct Authentication flag to true.The script has to be passed as parameter to wlst.sh  
#
import os,sys

oamConfigObjectName = "oracle.oam:type=Config"

from java.lang import String 
from java.util import HashMap
from java.lang import System 
from oracle.security.am.admin.config.mgmt.model import IntegerSettings
from oracle.security.am.admin.config.mgmt.model import BooleanSettings
from oracle.security.am.admin.config.mgmt.model import StringSettings
from oracle.security.am.admin.config.mgmt.model import MapSettings
from oracle.security.am.admin.config.mgmt.model import AbstractSettings 
from oracle.security.am.common.utilities.crypto import OAMKeyStore
from javax.management.openmbean import CompositeData

def getStringProperty(path):
    on = ObjectName(oamConfigObjectName)
    if mbs == None:
        connect()
        domainRuntime()

    paramsAdd = [path]
    signatureAdd = ["java.lang.String"]

    propObjectName =  mbs.invoke(on, "retrieveStringProperty", paramsAdd, signatureAdd)

    if propObjectName != None:
        oldSetting = StringSettings.from(propObjectName)
        return oldSetting.toString()
    else:
        return "(null)"

def setStringProperty(parentPath, key, value):
    on = ObjectName(oamConfigObjectName)
                       
    if mbs == None:
        connect()
        domainRuntime()           

    path = parentPath + '/' + key
    stringSetting = StringSettings(key, value)
    cData = stringSetting.toCompositeData(StringSettings.toCompositeType())

    paramsAdd = [path, cData]
    signatureAdd = ["java.lang.String","javax.management.openmbean.CompositeData"]
    try:
        mbs.invoke(on, "applyStringProperty", paramsAdd, signatureAdd)
    except Exception,e:
        print "setStringProperty for " + path + " failed."
        print e.getLocalizedMessage()

def getBooleanProperty(path):
    on = ObjectName(oamConfigObjectName)
    if mbs == None:
        connect()
        domainRuntime()

    paramsAdd = [path]
    signatureAdd = ["java.lang.String"]

    propObjectName =  mbs.invoke(on, "retrieveBooleanProperty", paramsAdd, signatureAdd)

    if propObjectName != None:
        oldSetting = BooleanSettings.from(propObjectName)
        return oldSetting.toString()
    else:
        return "(null)"

def setBooleanProperty(parentPath, key, value):
    on = ObjectName(oamConfigObjectName)
                       
    if mbs == None:
        connect()
        domainRuntime()           

    path = parentPath + '/' + key
    booleanSetting = BooleanSettings(key, value)
    cData = booleanSetting.toCompositeData(BooleanSettings.toCompositeType())

    paramsAdd = [path, cData]
    signatureAdd = ["java.lang.String","javax.management.openmbean.CompositeData"]
    try:
        mbs.invoke(on, "applyBooleanProperty", paramsAdd, signatureAdd)
    except Exception,e:
        print "setBooleanProperty for " + path + " failed."
        print e.getLocalizedMessage()

def updateBooleanProperty(parentPath, key, value):
    oldValue = getBooleanProperty(parentPath + '/' + key)
    print 'Updating Current Setting: ' + oldValue + ' at Path: ' + parentPath
    print ''
    setBooleanProperty(parentPath, key, value)

def updateStringProperty(parentPath, key, value):
    oldValue = getStringProperty(parentPath + '/' + key)
    print 'Updating Current Setting: ' + oldValue + ' at Path: ' + parentPath
    print ''
    setStringProperty(parentPath, key, value)

# start
connect()
domainRuntime()

#set impersonation config
impProfile='/DeployedComponent/Descriptors/OAMSEntityDescriptor/OAMServicesDescriptor/DirectAuthenticationServiceDescriptor'
specificSetting1='ServiceStatus'
newStatus1 = Boolean(true)
updateBooleanProperty(impProfile, specificSetting1, newStatus1)


