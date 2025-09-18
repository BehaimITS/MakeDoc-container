# databaseURL: jdbc:tibcosoftwareinc:oracle://10.246.4.34:1521;SID=ACCOUNTS {#projUpdateCustomerDB .concept}

License for TIBCO Software Use Only!

**[databaseURL: jdbc:tibcosoftwareinc:oracle://10.246.4.34:1521;SID=ACCOUNTS](../msgs/dest_Id96.md)**

|**Action:**|JDBCUpdate|
|**Activity:**|UpdateCustomerDB \(JDBCCall\)|
|**Source:**|[/ProcessDefinitions/GetAccountState/GetAccountState](../../../projects/AccountState/ProcessDefinitions/GetAccountState/GetAccountState.process.md) \(BW Process\)|
|**Query timeout:**|10|
|**Override transaction behaviour:**|true|
|**Database URL:**|jdbc:tibcosoftwareinc:oracle://%%jdbc/url\_port%%;SID=%%jdbc/sid%%|
|**SQL Statement:**|UPDATE CUSTOMER SET DATE = ? WHERE ID = ?|
|**User name:**|%%jdbc/user%%|
|**Use Shared JNDI Configuration:**|true|
|**JDBC Driver:**|tibcosoftwareinc.jdbc.oracle.OracleDriver|
|**JDBC Connection:**|/SharedConnections/SharedTibco.sharedjdbc|
|**Password:**|%%jdbc/password%%|
|**JDBC Connection type:**|JDBC|
|**Login timeout:**|0|
|**Maximum connections:**|120|
|**Prepared SQL parameters:**| |
|** **|date\_now : VARCHAR|
|** **|id : INTEGER|

**Parent topic:**[AccountState](../../../crossref/dest/projs/AccountState.md)

