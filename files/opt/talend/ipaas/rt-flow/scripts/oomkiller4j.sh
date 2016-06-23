#!/bin/bash

# this script is invoked when the karaf jvm detects out of memeroy condition
# it then sends container unregister event to the dispatcher

/usr/bin/pkill -9 -f karaf-org.osgi.core.jar
/opt/talend/ipaas/rt-flow/scripts/unregister unexpected_shutdown

