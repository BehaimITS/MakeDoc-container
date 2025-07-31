# DEV.BANK.CALCULATEBONITA.REQUEST {#Destination .concept}

Section contains list of middleware objects using JMS Connection with provider URL="DEV.BANK.CALCULATEBONITA.REQUEST"

![](Dest_1.png)

-   **Project:** [AccountState](../../modules/demo_Enterprise/dita/projects/AccountState/AccountState.md)
    -   **Source:**BW Process [AccountState](../../modules/demo_Enterprise/dita/projects/AccountState/ProcessDefinitions/AccountState.process.md)
        -   **Action Type:**Send
        -   **Direction:**In

-   **Project:** [ems](../../modules/emsdemo_Enterprise/dita/servers/ems/ems.server.md)
    -   **Source:**EMS Server [tcp://localhost:7222](../../modules/emsdemo_Enterprise/dita/servers/ems/ems.server.md)
        -   **Action Type:**Contains
        -   **Direction:**In
        -   **Direct Link:**[DEV.BANK.CALCULATEBONITA.REQUEST](../../modules/emsdemo_Enterprise/dita/servers/ems/Queues/DEV.BANK.CALCULATEBONITA.REQUEST.queue.md)

-   **Project:** [GrantingCredit](../../modules/demo_Enterprise/dita/projects/GrantingCredit/GrantingCredit.md)
    -   **Source:**BW Process [ExaminationService](../../modules/demo_Enterprise/dita/projects/GrantingCredit/ProcessDefinitions/Examination/ExaminationService.process.md)
        -   **Action Type:**Send
        -   **Direction:**In

**Parent topic:**[JMSQueues Documentation](../../crusader/JMSQueues/JMSQueues.md)

