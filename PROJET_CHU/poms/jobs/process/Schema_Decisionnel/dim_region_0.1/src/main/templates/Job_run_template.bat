%~d0
cd %~dp0
java -Dtalend.component.manager.m2.repository="%cd%/../lib" -Xms256M -Xmx1024M -Dfile.encoding=UTF-8 -cp .;../lib/routines.jar;../lib/log4j-slf4j-impl-2.12.1.jar;../lib/log4j-api-2.12.1.jar;../lib/log4j-core-2.12.1.jar;../lib/log4j-1.2-api-2.12.1.jar;../lib/commons-collections-3.2.2.jar;../lib/commons-lang-2.6.jar;../lib/geronimo-stax-api_1.0_spec-1.0.1.jar;../lib/poi-ooxml-4.1.0-20190523141255_modified_talend.jar;../lib/httpcore-4.4.4.jar;../lib/commons-codec-1.9.jar;../lib/poi-scratchpad-4.1.0-20190523141255_modified_talend.jar;../lib/hadoop-auth-2.6.0-cdh5.12.1.jar;../lib/jersey-core-1.9.jar;../lib/hadoop-hdfs-2.6.0-cdh5.12.1.jar;../lib/poi-ooxml-schemas-4.1.0-20190523141255_modified_talend.jar;../lib/jackson-mapper-asl-1.9.14-TALEND.jar;../lib/commons-logging-1.2.jar;../lib/slf4j-api-1.7.25.jar;../lib/httpclient-4.5.2.jar;../lib/commons-math3-3.6.1.jar;../lib/xmlbeans-3.1.0.jar;../lib/avro-1.7.6-cdh5.12.1.jar;../lib/commons-configuration-1.6.jar;../lib/commons-collections4-4.1.jar;../lib/servlet-api-2.5.jar;../lib/commons-cli-1.2.jar;../lib/hadoop-common-2.6.0-cdh5.12.1.jar;../lib/dom4j-2.1.1.jar;../lib/poi-4.1.0-20190523141255_modified_talend.jar;../lib/external_sort.jar;../lib/htrace-core4-4.0.1-incubating.jar;../lib/jackson-core-asl-1.9.14-TALEND.jar;../lib/talendcsv.jar;../lib/crypto-utils.jar;../lib/talend_file_enhanced_20070724.jar;../lib/guava-12.0.1.jar;../lib/commons-compress-1.19.jar;../lib/protobuf-java-2.5.0.jar;dim_region_0_1.jar; chu.dim_region_0_1.Dim_Region  %*