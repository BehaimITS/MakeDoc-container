# FileAdapterConfiguration {#Adapter .concept}

License for TIBCO Software Use Only!

Section contains description of Adapter " FileAdapterConfiguration.adfiles "

Full adapter path: FileAdapter

Instance ID: FileAdapterConfiguration

**Parent topic:**[Adapters](../../../projects/AccountState/common/adapter.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
|AccountState|This application simulate get bank account state process which using rating of client bonita.|
|/SharedResources|Resorces shared by processes|

## Adapter description: {#Description}

|No description|

## Startup: {#Startup}

|Name|Value|
|----|-----|
|Default startup|active|
|Banner|true|
|Standard micro agent|true|
|Standard micro agent name|COM.TIBCO.ADAPTER.adfiles.%%Deployment%%.%%InstanceId%%|
|Standard micro agent timeout|10000|
|Micro agent class|%%HawkEnabled%%|
|Micro agent class name|COM.TIBCO.adfiles.%%Deployment%%.%%InstanceId%%|
|Micro agent class timeout|10000|
|Default micro agent session|FAHawkDefaultSession|

Start components:

|State|Name|
|-----|----|
|active|DefaultRVSession|
|active|ExitSubscriber|
|active|DefaultRVRPCSession|
|active|UserExitClient|
|active|FAHawkDefaultSession|
|active|DefaultRVCMSession|
|active|SubscriptionServiceEndPoint|

## Deployment: {#Deployment}

Advisories:

|Name|Subject|
|----|-------|
|advisory.rv.error|\_RV.ERROR.\>|
|advisory.rv.warn|\_RV.WARN.\>|
|advisory.sdk.error|\_SDK.ERROR.\>|
|advisory.sdk.warn|\_SDK.WARN.\>|
|advisory.sdk.info|\_SDK.INFO.\>|

Sessions:

|Name|Value|
|----|-----|
|rvSession|\#rvSession.DefaultRVSession|
|rvSession|\#rvSession.DefaultRVRPCSession|
|rvSession|\#rvSession.FAHawkDefaultSession|
|rvCmSession|\#rvCmSession.DefaultRVCMSession|

Producers: no producers

Clients:

|Name|Value|
|----|-----|
|rvRpcClient|\#client.UserExitClient|

Consumers:

|Name|Value|
|----|-----|
|rvSubscriber|\#consumer.ExitSubscriber|
|rvCmSubscriber|\#consumer.SubscriptionServiceEndPoint|

Servers: no servers

## Log sinks: {#LogSinks}

File sinks:

|Name|File name|File count|File limit|Append mode|Sink roles|
|----|---------|----------|----------|-----------|----------|
|fileSink|%%DirTrace%%/%%Deployment%%.%%InstanceId%%.log|3|30000|true|infoRole , errorRole , warnRole|

Standard IO sinks:

|Name|IO Name|Sink roles|
|----|-------|----------|
|stdioSink|stdout|infoRole , errorRole , warnRole|

## Metadata: {#Metadata}

|Name|Value|
|----|-----|
|loadUrl|/AESchemas/ae/baseDocument.aeschema|

## Adapter services: {#AdapterServices}

Adapter version: 5.1

## File Schemas: {#FileSchemas}

## Hawk microagents: {#hawk}

### fa\_custom\_hawk {#fa_custom_hawk}

-   Help: fa custom hawk
-   Session: \#rvSession.FAHawkDefaultSession

Methods:

***SetPollingInterval***

-   Help: Set polling interval for the specified Publication Service.

Input parameters:

|Name|Type|Help|Legal Value Choices|
|----|----|----|-------------------|
|Publication Service|string|Name of the Publication Service. Mandatory|
|Polling Interval|integer|New value for polling interval \(in seconds\). Mandatory|

***GetPollingInterval***

-   Help: Get the polling interval for the specified Publication Service. Default returns for all.
-   Index: Publication Service

Input parameters:

|Name|Type|Help|Legal Value Choices|
|----|----|----|-------------------|
|Publication Service|string|Name of the Publication Service|

Output parameters:

|Name|Type|Help|
|----|----|----|
|Line|integer|Row Number|
|Publication Service|string|Name of the Publication Service|
|Polling Interval|integer|Polling interval \(in seconds\) for the Publication Service|

***SetDocumentDelay***

-   Help: Set document delay for the specified Publication Service.

Input parameters:

|Name|Type|Help|Legal Value Choices|
|----|----|----|-------------------|
|Publication Service|string|Name of the Publication Service. Mandatory|
|Document Delay|integer|New value for document delay \(in milliseconds\) for the Publication Service. Mandatory|

***GetDocumentDelay***

-   Help: Get document delay values for the specified Publication Service. Default returns all.
-   Index: Publication Service

Input parameters:

|Name|Type|Help|Legal Value Choices|
|----|----|----|-------------------|
|Publication Service|string|Name of the Publication Service|

Output parameters:

|Name|Type|Help|
|----|----|----|
|Line|integer|Row Number|
|Publication Service|string|Name of the Publication Service|
|Document Delay|integer|Document delay \(in milliseconds\) for the Publication Service|

***GetActivityStatisticsByServiceName***

-   Help: Retuns the total number of objects processed for each of the schemas associated with the specified service. Also, returns the number of success and error objects
-   Index: Schema Name

Input parameters:

|Name|Type|Help|Legal Value Choices|
|----|----|----|-------------------|
|Service Name|string|Name of publication or subscription service|

Output parameters:

|Name|Type|Help|
|----|----|----|
|Operation|string|The type of operation this service performs \(Read or Write\)|
|Schema Name|string|Name of the schema that is associated with this service|
|Total|string|Publisher: Total number of objects processed for this schema. Subscriber: Total number of objects received for this schema|
|Success|string|The number of objects that were successfully identified for this schema which will be published \(publication service\), or written to a file \(subscription service|
|Error|string|The number of objects that were identified for this schema but were will not be published because the header of the schema failed validation\(publication service\), or writen to a file because the schema was not associated with the subscriber\(subscription service\)|

***GetActivityStatisticsBySchema***

-   Help: Retuns the total number of objects processed for the given schema by each service that uses the schema. Also, returns the number of success and error objects
-   Index: Service Name

Input parameters:

|Name|Type|Help|Legal Value Choices|
|----|----|----|-------------------|
|Schema Name|string|Name of the schema|

Output parameters:

|Name|Type|Help|
|----|----|----|
|Service Name|string|Service name that is associated with this schema|
|Total|string|Publisher: Total number of objects processed for this schema. Subscriber: Total number of objects received for this schema|
|Success|string|The number of objects that were successfully identified for this schema which will be published \(publication service\), or written to a file \(subscription service|
|Error|string|The number of objects that were identified for this schema but were will not be published because the header of the schema failed validation\(publication service\), or writen to a file because the schema was not associated with the subscriber\(subscription service\)|

***GetActivityStatisticsByOperation***

-   Help: Returns the total number of objects processed for all the schemas by each service associated with the specified operation. Also, returns the number of success and error objects
-   Index: Service Name

Input parameters:

|Name|Type|Help|Legal Value Choices|
|----|----|----|-------------------|
|Operation|string|Valid values for Operation are 'Read', 'Write'|

Output parameters:

|Name|Type|Help|
|----|----|----|
|Service Name|string|Name of the service that is associated with the specified operation|
|Total|string|Publisher: Total number of objects processed for this schema.\\n Subscriber: Total number of objects received for this schema|
|Success|string|The number of objects that were successfully identified for this schema which will be published \(publication service\), or written to a file \(subscription service|
|Error|string|The number of objects that were identified for this schema but were will not be published because the header of the schema failed validation\(publication service\), or writen to a file because the schema was not associated with the subscriber\(subscription service\)|

***GetActivityStatistics***

-   Help: Based on the request type returns the total number of objects processed for all the schemas. Also, returns the number of success and error objects
-   Index: Line

Input parameters:

|Name|Type|Help|Legal Value Choices|
|----|----|----|-------------------|
|Type|integer|Type = 0, returns statistics categorized by service, Type = 1 returns statistics categorized by Operation \(Read or Write\)|

Output parameters:

|Name|Type|Help|
|----|----|----|
|Line|integer|Row Number|
|Name|string|Name of the service or Operation type|
|Total|string|Publisher: Total number of objects processed for this schema. Subscriber: Total number of objects received for this schema|
|Success|string|The number of objects that were successfully identified for this schema which will be published \(publication service\), or written to a file \(subscription service|
|Error|string|The number of objects that were identified for this schema but were will not be published because the header of the schema failed validation\(publication service\), or writen to a file because the schema was not associated with the subscriber\(subscription service\)|

***ResetActivityStatistics***

-   Help: Reset the counters

## Other objects: {#OtherObjects}

### DefaultRVSession {#DefaultRVSession}

Object type: session.RV

Properties:

|Name|Value|
|----|-----|
|daemon|%%RvDaemon%%|
|service|%%RvService%%|
|network|%%RvNetwork%%|

### DefaultRVRPCSession {#DefaultRVRPCSession}

Object type: session.RV

Properties:

|Name|Value|
|----|-----|
|daemon|%%RvDaemon%%|
|service|%%RvService%%|
|network|%%RvNetwork%%|

### FAHawkDefaultSession {#FAHawkDefaultSession}

Object type: session.RV

Properties:

|Name|Value|
|----|-----|
|daemon|%%TIBHawkDaemon%%|
|service|%%TIBHawkService%%|
|network|%%TIBHawkNetwork%%|

### DefaultRVCMSession {#DefaultRVCMSession}

Object type: session.RVCM

Properties:

|Name|Value|
|----|-----|
|daemon|%%RvDaemon%%|
|service|%%RvService%%|
|network|%%RvNetwork%%|
|cmName|%%Domain%%.%%Deployment%%.%%AppName%%.%%InstanceId%%.CM|
|relayAgent| |
|ledgerFile|%%DirLedger%%/%%Domain%%.%%Deployment%%.%%AppName%%.%%InstanceId%%.ldg|
|syncLedger|true|
|defaultTimeLimit|0|
|requireOldMessages|true|

### ExitSubscriber {#ExitSubscriber}

Object type: endpoint.RVSubscriber

Properties:

|Name|Value|
|----|-----|
|subject|%%Domain%%.%%Deployment%%.adfiles.%%InstanceId%%.exit|
|wireFormat|rvMsg|
|session|\#rvSession.DefaultRVSession|

### UserExitClient {#UserExitClient}

Object type: endpoint.RVRPCClient

Properties:

|Name|Value|
|----|-----|
|subject|%%Domain%%.%%Deployment%%.adfiles.%%InstanceId%%.userExit|
|wireFormat|rvMsg|
|invocationTimeout|60|
|session|\#rvSession.DefaultRVRPCSession|
|class|[/AESchemas/ae/FileAdapter/operation.aeschema\#rpcClass.Operation](../AESchemas/ae/FileAdapter/operation.aeschema.md#)|

### SubscriptionServiceEndPoint {#SubscriptionServiceEndPoint}

Object type: endpoint.RVCMSubscriber

Properties:

|Name|Value|
|----|-----|
|wireFormat|aeRvMsg|
|session|\#rvCmSession.DefaultRVCMSession|
|subject|%%Domain%%.%%Deployment%%.FileAdapter.FileAdapterConfiguration.SubscriptionService|

