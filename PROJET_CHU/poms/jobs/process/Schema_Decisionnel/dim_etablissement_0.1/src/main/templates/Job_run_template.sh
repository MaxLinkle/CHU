#!/bin/sh
cd `dirname $0`
ROOT_PATH=`pwd`
java -Dtalend.component.manager.m2.repository=$ROOT_PATH/../lib -Xms256M -Xmx1024M -Dfile.encoding=UTF-8 -cp .:$ROOT_PATH:$ROOT_PATH/../lib/routines.jar:$ROOT_PATH/../lib/log4j-slf4j-impl-2.12.1.jar:$ROOT_PATH/../lib/log4j-api-2.12.1.jar:$ROOT_PATH/../lib/log4j-core-2.12.1.jar:$ROOT_PATH/../lib/log4j-1.2-api-2.12.1.jar:$ROOT_PATH/../lib/commons-collections-3.2.2.jar:$ROOT_PATH/../lib/commons-lang-2.6.jar:$ROOT_PATH/../lib/geronimo-stax-api_1.0_spec-1.0.1.jar:$ROOT_PATH/../lib/poi-ooxml-4.1.0-20190523141255_modified_talend.jar:$ROOT_PATH/../lib/httpcore-4.4.4.jar:$ROOT_PATH/../lib/commons-codec-1.9.jar:$ROOT_PATH/../lib/poi-scratchpad-4.1.0-20190523141255_modified_talend.jar:$ROOT_PATH/../lib/hadoop-auth-2.6.0-cdh5.12.1.jar:$ROOT_PATH/../lib/jersey-core-1.9.jar:$ROOT_PATH/../lib/hadoop-hdfs-2.6.0-cdh5.12.1.jar:$ROOT_PATH/../lib/poi-ooxml-schemas-4.1.0-20190523141255_modified_talend.jar:$ROOT_PATH/../lib/jackson-mapper-asl-1.9.14-TALEND.jar:$ROOT_PATH/../lib/commons-logging-1.2.jar:$ROOT_PATH/../lib/slf4j-api-1.7.25.jar:$ROOT_PATH/../lib/httpclient-4.5.2.jar:$ROOT_PATH/../lib/commons-math3-3.6.1.jar:$ROOT_PATH/../lib/xmlbeans-3.1.0.jar:$ROOT_PATH/../lib/avro-1.7.6-cdh5.12.1.jar:$ROOT_PATH/../lib/commons-configuration-1.6.jar:$ROOT_PATH/../lib/commons-collections4-4.1.jar:$ROOT_PATH/../lib/servlet-api-2.5.jar:$ROOT_PATH/../lib/jboss-serialization.jar:$ROOT_PATH/../lib/commons-cli-1.2.jar:$ROOT_PATH/../lib/advancedPersistentLookupLib-1.2.jar:$ROOT_PATH/../lib/hadoop-common-2.6.0-cdh5.12.1.jar:$ROOT_PATH/../lib/dom4j-2.1.1.jar:$ROOT_PATH/../lib/poi-4.1.0-20190523141255_modified_talend.jar:$ROOT_PATH/../lib/htrace-core4-4.0.1-incubating.jar:$ROOT_PATH/../lib/jackson-core-asl-1.9.14-TALEND.jar:$ROOT_PATH/../lib/trove.jar:$ROOT_PATH/../lib/talendcsv.jar:$ROOT_PATH/../lib/crypto-utils.jar:$ROOT_PATH/../lib/talend_file_enhanced_20070724.jar:$ROOT_PATH/../lib/guava-12.0.1.jar:$ROOT_PATH/../lib/commons-compress-1.19.jar:$ROOT_PATH/../lib/protobuf-java-2.5.0.jar:$ROOT_PATH/dim_etablissement_0_1.jar: chu.dim_etablissement_0_1.Dim_Etablissement  "$@"