# DEV.BANK.EXAMINATION.TEST {#destDEV.BANK.EXAMINATION.TEST .concept}

License for TIBCO Software Use Only!

Section contains list of middleware objects using “DEV.BANK.EXAMINATION.TEST”

![](dest_Id110.png)

-   **Project:** [GrantingCredit](../projs/GrantingCredit.md)
    -   **Source:**  BW Process [/ProcessDefinitions/Examination/ExaminationService](../../../projects/GrantingCredit/ProcessDefinitions/Examination/ExaminationService.process.md)
        -   **Activity:** [InputParameters JMSQueueReceiver](../projs/act_109.md)
        -   **Action Type:**ReceiveRequest
        -   **Transport Type:**
    -   **Source:**  BW Process [/ProcessDefinitions/Examination/ExaminationService](../../../projects/GrantingCredit/ProcessDefinitions/Examination/ExaminationService.process.md)
        -   **Activity:** [Result JMSQueueSender](../projs/act_114.md)
        -   **Action Type:**Send
        -   **Transport Type:**
    -   **Source:**  BW Process [/ProcessDefinitions/GrantingCredit](../../../projects/GrantingCredit/ProcessDefinitions/GrantingCredit.process.md)
        -   **Activity:** [InputParameters JMSQueueSender](../projs/act_119.md)
        -   **Action Type:**Send
        -   **Transport Type:**

**Parent topic:**[Queues](../../../crossref/dest/msgs/Group_Id152.md)

