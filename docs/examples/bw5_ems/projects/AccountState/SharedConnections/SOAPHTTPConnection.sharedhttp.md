# SOAPHTTPConnection {#Sharedhttp .concept}

License for TIBCO Software Use Only!

Section contains description of Shared HTTP Resource " SOAPHTTPConnection.sharedhttp "

**Parent topic:**[Shared HTTP Connections](../../../projects/AccountState/common/sharedhttp.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
|AccountState|This application simulate get bank account state process which using rating of client bonita.|
|/SharedConnections|Connections shared by processes|

## HTTP description: {#HTTPDescription}

|Connection for HTTP SOAP communication with GetAcoountState process|

## HTTP configuration: {#Config}

|Name|Value|
|----|-----|
|serverType|Tomcat|
|HttpConnectionProperties|maxPostSize \(bytes\) 2097152 maxSavePostSize \(bytes\) 4096 uriEncoding acceptCount compressableMimeType text/html,text/xml,text/plain compression off connectionTimeOut \(ms\) 60000|
|Host|localhost|
|Port|%%HTTPSOAPPort%%|
|description|Connection for HTTP SOAP communication with GetAcoountState process|

Connection properties:

|Name|Value|Default value|
|----|-----|-------------|
|maxPostSize \(bytes\)| |2097152|
|maxSavePostSize \(bytes\)| |4096|
|uriEncoding| | |
|acceptCount| | |
|compressableMimeType| |text/html,text/xml,text/plain|
|compression| |off|
|connectionTimeOut \(ms\)| |60000|

