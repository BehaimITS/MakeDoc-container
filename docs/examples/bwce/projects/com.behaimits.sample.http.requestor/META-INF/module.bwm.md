# Module {#ModuleMain .concept}

License for TIBCO Software Use Only!

Section contains Module properties " C:/tmp/demo\_project/com.behaimits.sample.http.requestor/META-INF/module.bwm " .

Name: com.behaimits.sample.http.requestor

**Parent topic:**[Module Descriptor](../../../projects/com.behaimits.sample.http.requestor/common/moduleDescriptor.md)

## Overview {#Overview}

-   ID: com.behaimits.sample.http.requestor
-   Version: 1.0.0.qualifier
-   Name: Behaim ITS BW Sample
-   Vendor: Behaim ITS a.s.
-   Description:

## Module Properties {#Module}

|Name|Type|Public Access|Scalable|Description|
|----|----|-------------|--------|-----------|
|BW.DEPLOYMENTUNIT.TYPE|XMLSchema:string|false|true| |
|BW.APPNODE.NAME|XMLSchema:string|false|true| |
|BW.DEPLOYMENTUNIT.NAME|XMLSchema:string|false|true| |
|BW.HOST.NAME|XMLSchema:string|false|true| |
|BW.DOMAIN.NAME|XMLSchema:string|false|true| |
|BW.DEPLOYMENTUNIT.VERSION|XMLSchema:string|false|true| |
|BW.APPSPACE.NAME|XMLSchema:string|false|true| |
|BW.MODULE.VERSION|XMLSchema:string|false|true| |
|BW.MODULE.NAME|XMLSchema:string|false|true| |
|LISTENING\_PORT|XMLSchema:int|true|true| |
|LISTENING\_HTTP\_CONNECTION|httpconnector:HttpConnectorConfiguration|true|true| |
|REQUESTING\_HTTP\_CONNECTION|http:HttpClientConfiguration|true|true| |
|HOST\_NAME|XMLSchema:string|true|true| |
|LOGGING\_QUEUE|XMLSchema:string|true|true| |
|JDBC\_CONNECTOR|jdbc:JdbcDataSource|true|true| |
|EMS\_CONNECTOR|jms:JMSConnectionFactory|true|true| |
|JDBC\_TIMEOUT|XMLSchema:int|true|true| |
|EMS\_TIMEOUT|XMLSchema:int|true|true| |

## Module Components {#ModuleComponents}

|Name|Process Name|Version|
|----|------------|-------|
|ComponentProcess|com.behaimits.sample.jms.receiver.ReceiveLog|1.0.0.qualifier|
|Component1Process|com.behaimits.sample.http.requestor.HTTPReceiver|1.0.0.qualifier|

## Module Shared Variables {#ModuleMSV}

## Module Job Shared Variables {#ModuleJSV}

## Module Dependencies {#ModuleMF}

|Namespace|Module Filter|
|---------|-------------|
|com.tibco.bw.sharedresource.model|filter:="\(name=bw.jmsconnection\)"|
|com.tibco.bw.palette|filter:="\(name=bw.xml\)"|
|com.tibco.bw.sharedresource.model|filter:="\(name=bw.httpclient\)"|
|com.tibco.bw.model|filter:="\(name=bwext\)"|
|com.tibco.bw.palette|filter:="\(name=bw.jms\)"|
|com.tibco.bw.sharedresource.model|filter:="\(name=bw.httpconnector\)"|
|com.tibco.bw.palette|filter:="\(name=bw.http\)"|
|com.tibco.bw.palette|filter:="\(name=bw.restjson\)"|
|com.tibco.bw.sharedresource.model|filter:="\(name=bw.jdbc\)"|
|com.tibco.bw.palette|filter:="\(name=bw.generalactivities\)"|

