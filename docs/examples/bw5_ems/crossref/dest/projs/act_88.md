# Queue: DEV.BANK.CALCULATEBONITA.REQUEST {#projBonita_JMSQueueRequestor .concept}

License for TIBCO Software Use Only!

**[Queue: DEV.BANK.CALCULATEBONITA.REQUEST](../msgs/dest_Id89.md) [Queue: DEV.BANK.CALCULATEBONITA.REQUEST](../msgs/dest_Id90.md)**

|**Action:**|Request|
|**Activity:**|Bonita JMSQueueRequestor \(BW Activity\)|
|**Source:**|[/ProcessDefinitions/AccountState](../../../projects/AccountState/ProcessDefinitions/AccountState.process.md) \(BW Process\)|
|**Queue Connection Factory:**|QueueConnectionFactory|
|**JMS Message Type:**|XMLText|
|**JNDI Context URL:**|tibjmsnaming://localhost:7222|
|**JMS Delivery Mode:**|Persistent|
|**JNDI Context Factory:**|com.tibco.tibjms.naming.TibjmsInitialContextFactory|
|**Topic Connection Factory:**|TopicConnectionFactory|
|**Priority:**|4|
|**Reply Destination:**|=concat\($\_globalVariables/ns1:GlobalVariables/ENV,$\_globalVariables/ns1:GlobalVariables/AccountStateJMSQueueName\)|
|**Expiration:**|0|
|**Transport Format:**|JMS|

Message:

-   InputParameters
    -   ?RealtyValue: i8
    -   ?Refund: i8
    -   ?MonthIncrement: i8
    -   ?Value: i8
    -   ?Name: string

Reply Message:

-   PretenderBonita
    -   ?Bonita: i8
    -   ?Name: string

**Parent topic:**[AccountState](../../../crossref/dest/projs/AccountState.md)

