#!/bin/bash

ORIGDIR=$(pwd)

export JAVA_HOME=/usr/lib/jvm/java-7-oracle
export JDK=$JAVA_HOME
export JAVACMD=$JAVA_HOME/bin/java 

# Download spark sources
if [ ! -d ~/Spark ]
then
   cd ~
   git clone https://github.com/igniterealtime/Spark.git
fi

cd ~/Spark

# apply patch
if [ -d /opt/sparkpatch ]
then
   git apply /opt/sparkpatch/*.binpatch
fi

# create directories that break the build when they don't exis
mkdir -p src/plugins/roar/build/lib
mkdir -p src/plugins/fastpath/build/lib/dist

cd build

for TARGET in clean release installer.debian installer.izpack installer.izpack.exe
do
	ant -f build.xml $TARGET
	RC=$?
	if [ $RC != 0 ]
	then
	   echo "Error while building target $TARGET"
 	   cd "$ORIGDIR"
           exit $RC
	fi
done

echo "Build completed!"
cd "$ORIGDIR"
exit 0
