#!/bin/sh
# resolve links - $0 may be a softlink
PRG="$0"

while [ -h "$PRG" ]; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done

# Get standard environment variables
PRGDIR=`dirname "$PRG"`

if [ "$#" -ne "3" ]; then
  echo "usage: $0 <shutdownPort> <httpPort> <ajpPort>"  
  exit 1  
fi

SHUTDOWN_PORT="$1"
HTTP_PORT="$2"
APJ_PORT="$3"

# Get CATALINA_HOME
TOMCAT_HOME=`cd "$PRGDIR/.." >/dev/null; pwd`

if [ -r "$TOMCAT_HOME/conf/server.xml" ]; then
  SERVERFILE="$TOMCAT_HOME/conf/server.xml"
  sed  -i "s/@@SHUTDOWN_PORT@@/$SHUTDOWN_PORT/g"  $SERVERFILE \
  && sed  -i "s/@@HTTP_PORT@@/$HTTP_PORT/g"  $SERVERFILE \
  && sed  -i "s/@@AJP_PORT@@/$APJ_PORT/g"  $SERVERFILE
  if [ "$?" -eq "0" ]; then
    echo "set tomcat port successfully!"
  fi 
fi

