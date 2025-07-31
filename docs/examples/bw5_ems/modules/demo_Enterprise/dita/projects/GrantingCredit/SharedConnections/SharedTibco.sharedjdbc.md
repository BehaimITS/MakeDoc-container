# SharedTibco {#Sharedjdbc .concept}

Section contains description of Shared JDBC " SharedTibco.sharedjdbc "

Source Library: " CalculateBonita "

Resource type: ae.shared.JDBCSharedResource

**Parent topic:**[Shared JDBC Connections](../../../../../../modules/demo_Enterprise/dita/projects/GrantingCredit/common/sharedjdbc.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
|GrantingCredit|The application Granting credit provides resolution whether a credit \(or mortgage\) can be granded to a user. Information about user is the input of the application.|
|\\SharedConnections|Connections shared by processes|

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

