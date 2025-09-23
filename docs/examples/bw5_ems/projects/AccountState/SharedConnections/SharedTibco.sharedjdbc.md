# SharedTibco {#Sharedjdbc .concept}

License for TIBCO Software Use Only!

Section contains description of Shared JDBC " SharedTibco.sharedjdbc "

Source Library: " CalculateBonita "

Resource type: ae.shared.JDBCSharedResource

**Parent topic:**[Shared JDBC Connections](../../../projects/AccountState/common/sharedjdbc.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
|AccountState|This application simulate get bank account state process which using rating of client bonita.|
|/SharedConnections|Connections shared by processes|

## JDBC description: {#JDBCDescription}

|No description|

## JDBC configuration: {#Config}

|Name|Value|
|----|-----|
|driver|tibcosoftwareinc.jdbc.oracle.OracleDriver|
|maxConnections|120|
|loginTimeout|0|
|connectionType|JDBC|
|UseSharedJndiConfig|false|
|location|jdbc:tibcosoftwareinc:oracle://%%jdbc/url\_port%%;SID=%%jdbc/sid%%|
|user|%%jdbc/user%%|
|password|%%jdbc/password%%|

