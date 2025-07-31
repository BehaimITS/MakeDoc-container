# /ProcessDefinitions/LoadParameters/LoadParametersService {#dest_ProcessDefinitions_LoadParameters_LoadParametersService .concept}

Section contains list of middleware objects using “/ProcessDefinitions/LoadParameters/LoadParametersService”

![](dest_Id119.png)

-   **Project:** [GrantingCredit](../projs/GrantingCredit.md)
    -   **Source:**BW Process [/ProcessDefinitions/GrantingCredit](../../../projects/GrantingCredit/ProcessDefinitions/GrantingCredit.process.md)
        -   **Activity:** [InputParameters SOAPRequestReply](../projs/act_118.md)
        -   **Action Type:**RequestReply
        -   **Transport Type:**
    -   **Source:**BW Process [/ProcessDefinitions/LoadParameters/LoadParametersService](../../../projects/GrantingCredit/ProcessDefinitions/LoadParameters/LoadParametersService.process.md)
        -   **Activity:** [InputFileName from SOAPEventSource](../projs/act_120.md)
        -   **Action Type:**Receive
        -   **Transport Type:**
    -   **Source:**BW Process [/ProcessDefinitions/LoadParameters/LoadParametersService](../../../projects/GrantingCredit/ProcessDefinitions/LoadParameters/LoadParametersService.process.md)
        -   **Activity:** [InputParameters SOAPSendReply](../projs/act_122.md)
        -   **Action Type:**Reply
        -   **Transport Type:**
    -   **Source:**BW Process [/ProcessDefinitions/Tests/LoadParameterServiceTest](../../../projects/GrantingCredit/ProcessDefinitions/Tests/LoadParameterServiceTest.process.md)
        -   **Activity:** [SOAPRequestReply](../projs/act_126.md)
        -   **Action Type:**RequestReply
        -   **Transport Type:**

**Parent topic:**[SOAP URL](../../../../../../modules/demo_Enterprise/dita/crossref/dest/msgs/Group_Id145.md)

