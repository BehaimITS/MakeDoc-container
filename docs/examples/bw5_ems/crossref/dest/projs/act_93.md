# databaseURL: jdbc:tibcosoftwareinc:oracle://10.246.4.34:1521;SID=TIBCO {#projGetAccount .concept}

License for TIBCO Software Use Only!

**[databaseURL: jdbc:tibcosoftwareinc:oracle://10.246.4.34:1521;SID=TIBCO](../msgs/dest_Id94.md)**

|**Action:**|JDBCQuery|
|**Activity:**|GetAccount \(JDBCCall\)|
|**Source:** |[/ProcessDefinitions/GetAccountState/GetAccountState](../../../projects/AccountState/ProcessDefinitions/GetAccountState/GetAccountState.process.md) \(BW Process\)|
|**Maximum rows:**|100|
|**Query timeout:**|10|
|**Override transaction behaviour:**|true|
|**Database URL:**|jdbc:tibcosoftwareinc:oracle://%%jdbcTIBCO/database/url\_port%%;SID=%%jdbcTIBCO/database/sid%%|
|**SQL Statement:**|SELECT ID, NAME, VALUE, MONTH\_INCREMENT FROM ACCOUNTS WHERE ID = ?|
|**User name:**|%%jdbcTIBCO/database/user%%|
|**Use Shared JNDI Configuration:**|true|
|**JDBC Driver:**|tibcosoftwareinc.jdbc.oracle.OracleDriver|
|**JDBC Connection:**|/SharedConnections/Tibco.sharedjdbc|
|**Password:**|%%jdbcTIBCO/database/password%%|
|**JDBC Connection type:**|JDBC|
|**Login timeout:**|0|
|**Maximum connections:**|120|
|**Prepared SQL parameters:**| |
|** **|id : INTEGER|

**Parent topic:**[AccountState](../../../crossref/dest/projs/AccountState.md)

