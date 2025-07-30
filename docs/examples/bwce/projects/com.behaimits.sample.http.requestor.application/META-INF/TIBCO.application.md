# Application {#ApplicationMain .concept}

License for TIBCO Software Use Only!

Section contains description of Application " TIBCO.xml " .

**Parent topic:**[Application settings](../../../projects/com.behaimits.sample.http.requestor.application/common/application.md)

## Overview {#Overview}

-   ID: com.behaimits.sample.http.requestor.application
-   Version: 1.0.0.qualifier
-   Name: Tibco Bw Sample Palette Http RequestResponse Application
-   Vendor: TIBCO Software Inc.
-   Description:

## Module Profiles {#ModuleProfile}

|Module Property Name|default|UnixProfile|WindowsProfile|
|--------------------|-------|-----------|--------------|
|**//com.behaimits.sample.http.requestor//BW.DEPLOYMENTUNIT.TYPE**| | | |
|**//com.behaimits.sample.http.requestor//BW.APPNODE.NAME**| | | |
|**//com.behaimits.sample.http.requestor//BW.DEPLOYMENTUNIT.NAME**| | | |
|**//com.behaimits.sample.http.requestor//BW.HOST.NAME**|localhost|localhost|localhost|
|**//com.behaimits.sample.http.requestor//BW.DOMAIN.NAME**| | | |
|**//com.behaimits.sample.http.requestor//BW.DEPLOYMENTUNIT.VERSION**| | | |
|**//com.behaimits.sample.http.requestor//BW.APPSPACE.NAME**| | | |
|**//com.behaimits.sample.http.requestor//BW.MODULE.VERSION**| | | |
|**//com.behaimits.sample.http.requestor//BW.MODULE.NAME**| | | |
|**//com.behaimits.sample.http.requestor//LISTENING\_PORT**|13008|13008|13008|
|**//com.behaimits.sample.http.requestor//LISTENING\_HTTP\_CONNECTION**|com.behaimits.sample.http.requestor.ListeningHTTPConnection|com.behaimits.sample.http.requestor.ListeningHTTPConnection|com.behaimits.sample.http.requestor.ListeningHTTPConnection|
|**//com.behaimits.sample.http.requestor//REQUESTING\_HTTP\_CONNECTION**|com.behaimits.sample.http.requestor.RequestingHTTPConnection|com.behaimits.sample.http.requestor.RequestingHTTPConnection|com.behaimits.sample.http.requestor.RequestingHTTPConnection|
|**//com.behaimits.sample.http.requestor//HOST\_NAME**|localhost|localhost|localhost|
|**//com.behaimits.sample.http.requestor//LOGGING\_QUEUE**|com.behaimits.sample.http.requestor.logging|com.behaimits.sample.http.requestor.logging|com.behaimits.sample.http.requestor.logging|
|**//com.behaimits.sample.http.requestor//EMS\_CONNECTOR**|com.behaimits.sample.http.requestor.JMSConnectionResource|com.behaimits.sample.http.requestor.JMSConnectionResource|com.behaimits.sample.http.requestor.JMSConnectionResource|
|**//com.behaimits.sample.http.requestor//JDBC\_CONNECTOR**|com.behaimits.sample.http.requestor.JDBCConnectionResource|com.behaimits.sample.http.requestor.JDBCConnectionResource|com.behaimits.sample.http.requestor.JDBCConnectionResource|
|**//com.behaimits.sample.http.requestor//JDBC\_TIMEOUT**|30000|30000|30000|
|**//com.behaimits.sample.http.requestor//EMS\_TIMEOUT**|30000|30000|30000|

## Module Properties {#Module}

|Name|Type|Public Access|Scalable|Override|
|----|----|-------------|--------|--------|
|//com.behaimits.sample.http.requestor//BW.DEPLOYMENTUNIT.TYPE|xsd:string|private|true|false|
|//com.behaimits.sample.http.requestor//BW.APPNODE.NAME|xsd:string|private|true|false|
|//com.behaimits.sample.http.requestor//BW.DEPLOYMENTUNIT.NAME|xsd:string|private|true|false|
|//com.behaimits.sample.http.requestor//BW.HOST.NAME|xsd:string|private|true|false|
|//com.behaimits.sample.http.requestor//BW.DOMAIN.NAME|xsd:string|private|true|false|
|//com.behaimits.sample.http.requestor//BW.DEPLOYMENTUNIT.VERSION|xsd:string|private|true|false|
|//com.behaimits.sample.http.requestor//BW.APPSPACE.NAME|xsd:string|private|true|false|
|//com.behaimits.sample.http.requestor//BW.MODULE.VERSION|xsd:string|private|true|false|
|//com.behaimits.sample.http.requestor//BW.MODULE.NAME|xsd:string|private|true|false|
|//com.behaimits.sample.http.requestor//LISTENING\_PORT|xsd:int|public|true|false|
|//com.behaimits.sample.http.requestor//LISTENING\_HTTP\_CONNECTION|httpconnector:HttpConnectorConfiguration|public|true|false|
|//com.behaimits.sample.http.requestor//REQUESTING\_HTTP\_CONNECTION|http:HttpClientConfiguration|public|true|false|
|//com.behaimits.sample.http.requestor//HOST\_NAME|xsd:string|public|true|false|
|//com.behaimits.sample.http.requestor//LOGGING\_QUEUE|xsd:string|public|true|false|
|//com.behaimits.sample.http.requestor//EMS\_CONNECTOR|jms:JMSConnectionFactory|public|true|false|
|//com.behaimits.sample.http.requestor//JDBC\_CONNECTOR|jdbc:JdbcDataSource|public|true|false|
|//com.behaimits.sample.http.requestor//JDBC\_TIMEOUT|xsd:int|public|true|false|
|//com.behaimits.sample.http.requestor//EMS\_TIMEOUT|xsd:int|public|true|false|

## Module Includes {#ModuleIncludes}

|Name|Type|Version|
|----|----|-------|
|com.behaimits.sample.http.requestor|osgi-bundle,bw-appmodule|1.0.0.qualifier|

