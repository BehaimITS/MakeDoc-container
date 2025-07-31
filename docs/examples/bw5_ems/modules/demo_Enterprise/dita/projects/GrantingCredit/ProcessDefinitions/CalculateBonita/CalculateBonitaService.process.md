# CalculateBonitaService {#ProcessMain .concept}

Section contains description of Process " CalculateBonitaService.process " .

Source Library: " CalculateBonita "

**Parent topic:**[Processes](../../../../../../../modules/demo_Enterprise/dita/projects/GrantingCredit/common/process.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
|GrantingCredit|The application Granting credit provides resolution whether a credit \(or mortgage\) can be granded to a user. Information about user is the input of the application.|
|\\ProcessDefinitions|All process definitions|
|\\ProcessDefinitions\\CalculateBonita|Main CalculateBonita processes|

## Process description: {#ProcessDescription}

|Get and prepare input parameters for process CalculateBonita. Then send request with calculated bonita.|

## Process definition: {#ProcessDefinition}

Full process path: ProcessDefinitions/CalculateBonita/CalculateBonitaService.process

## Diagram: {#Diagram}

![](CalculateBonitaService.process.png)

## Process starter activity: {#Starter}

Name: InputParameters JMSQueueReceiver

-   Property Name: ***InputParameters JMSQueueReceiver***
    -   Type: *com.tibco.plugin.jms.JMSQueueEventSource*
    -   Resource Type: *ae.activities.JMSQueueEventSource*
    -   Description: *Get JMS message with CalculateBonita message selector and InputParameters*
    -   *Configuration:*
        -   PermittedMessageType = XML Text
        -   SessionAttributes
            -   transacted = false
            -   acknowledgeMode = 1 \(Auto\)
            -   maxSessions = 1
            -   destination = %%ENV%%.%%CalculateBonitaJMSQueueName%%
            -   selector = Part='CalculateBonita'
        -   ConfigurableHeaders
            -   JMSDeliveryMode = PERSISTENT
            -   JMSExpiration = 0
            -   JMSPriority = 4
        -   ConnectionReference = [/SharedConnections/CalculateBonitaEMSConnection.sharedjmscon](../../SharedConnections/CalculateBonitaEMSConnection.sharedjmscon.md)
        -   ApplicationProperties = /SharedResources/JMSApplicationProperties.sharedjmsapp
        -   OutDataxsdString
            -   - [InputParameters](../../AESchemas/EMS/CalculateBonitaAESchema.aeschema.md#) \(XML Element Reference, required \)

## Process end activity: {#EndActivity}

Name: End

## Activities: {#Activities}

### Name: ***CalculateBonita*** {#CalculateBonita}

-   Type: *com.tibco.pe.core.CallProcessActivity*
-   Resource Type: *ae.process.subprocess*
-   Description: *Calculate pretender's bonita from InputParameters and Obligator records*
-   *Configuration:*
    -   processName = [/ProcessDefinitions/CalculateBonita/CalculateBonita.process](CalculateBonita.process.md)
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/InputParameters****/MonthIncrement**|$InputParameters-JMSQueueReceiver/ns:ActivityOutput/Body/pfx:InputParameters/MonthIncrement|
        |**/InputParameters****/Value**|$InputParameters-JMSQueueReceiver/ns:ActivityOutput/Body/pfx:InputParameters/Value|
        |**/InputParameters****/RealtyValue**|$InputParameters-JMSQueueReceiver/ns:ActivityOutput/Body/pfx:InputParameters/RealtyValue|
        |**/InputParameters****/Problem**|$Obligators-SOAPRequestReply/outputMessage/ns2:Obligator/ns2:Problem|
        |**/InputParameters****/Loan**|$Obligators-SOAPRequestReply/outputMessage/ns2:Obligator/ns2:Value|
        |**/InputParameters****/Refund**|$Obligators-SOAPRequestReply/outputMessage/ns2:Obligator/ns2:Refund + $InputParameters-JMSQueueReceiver/ns:ActivityOutput/Body/pfx:InputParameters/Refund|

    -   Mapping tree

        ```
        
        **InputParameters**
         **MonthIncrement** = $InputParameters-JMSQueueReceiver/ns:ActivityOutput/Body/pfx:InputParameters/MonthIncrement
         **Value** = $InputParameters-JMSQueueReceiver/ns:ActivityOutput/Body/pfx:InputParameters/Value
         **RealtyValue** = $InputParameters-JMSQueueReceiver/ns:ActivityOutput/Body/pfx:InputParameters/RealtyValue
         **Problem** = $Obligators-SOAPRequestReply/outputMessage/ns2:Obligator/ns2:Problem
         **Loan** = $Obligators-SOAPRequestReply/outputMessage/ns2:Obligator/ns2:Value
         **Refund** = $Obligators-SOAPRequestReply/outputMessage/ns2:Obligator/ns2:Refund + $InputParameters-JMSQueueReceiver/ns:ActivityOutput/Body/pfx:InputParameters/Refund
        ```

    -   Source code

        ```
        
                    <InputParameters xmlns:pd="http://xmlns.tibco.com/bw/process/2003" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:pfx2="http://xmlns.example.com/1171360277608/GetObligatorServiceOperationImpl" xmlns:ns="http://www.tibco.com/namespaces/tnt/plugins/jms" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:ns2="http://www.tibco.com/schemas/GrantingCredit/SharedConnections/Schema1.xsd" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:ns1="http://www.tibco.com/pe/DeployedVarsType" xmlns:pfx="http://www.tibco.com/xmlns/ae2xsd/2002/05/EMS/CalculateBonitaAESchema" xmlns:pfx3="http://www.tibco.com/xmlns/ae2xsd/2002/05/EMS/AESchema">
                        <MonthIncrement>
                            <xsl:value-of select="$InputParameters-JMSQueueReceiver/ns:ActivityOutput/Body/pfx:InputParameters/MonthIncrement"/>
                        </MonthIncrement>
                        <Value>
                            <xsl:value-of select="$InputParameters-JMSQueueReceiver/ns:ActivityOutput/Body/pfx:InputParameters/Value"/>
                        </Value>
                        <RealtyValue>
                            <xsl:value-of select="$InputParameters-JMSQueueReceiver/ns:ActivityOutput/Body/pfx:InputParameters/RealtyValue"/>
                        </RealtyValue>
                        <Problem>
                            <xsl:value-of select="$Obligators-SOAPRequestReply/outputMessage/ns2:Obligator/ns2:Problem"/>
                        </Problem>
                        <Loan>
                            <xsl:value-of select="$Obligators-SOAPRequestReply/outputMessage/ns2:Obligator/ns2:Value"/>
                        </Loan>
                        <Refund>
                            <xsl:value-of select="$Obligators-SOAPRequestReply/outputMessage/ns2:Obligator/ns2:Refund + $InputParameters-JMSQueueReceiver/ns:ActivityOutput/Body/pfx:InputParameters/Refund"/>
                        </Refund>
                    </InputParameters>
                
        ```


### Name: ***Obligators SOAPRequestReply*** {#Obligators_SOAPRequestReply}

-   Type: *com.tibco.plugin.soap.SOAPSendReceiveActivity*
-   Resource Type: *ae.activities.SOAPSendReceiveUI*
-   Description: *SOAPRequest on GetObligator process and get reply with result*
-   *Configuration:*
    -   timeout = 0
    -   service = pfx2:GetObligatorService
    -   servicePort = ObligatorName\_sp\_SOAPEventSource
    -   operation = GetObligatorServiceOperation
    -   soapAction = /ProcessDefinitions/GetObligator/GetObligatorService
    -   endpointURL = %%GetObligatorServiceEndpointURL%%
    -   useProxy = false
    -   requireBasicAuth = false
    -   basicHttpAuthIdentity =
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/inputMessage****/Name**|$InputParameters-JMSQueueReceiver/ns:ActivityOutput/Body/pfx:InputParameters/Name|

    -   Mapping tree

        ```
        
        **inputMessage**
         **Name** = $InputParameters-JMSQueueReceiver/ns:ActivityOutput/Body/pfx:InputParameters/Name
        ```

    -   Source code

        ```
        
                    <inputMessage xmlns:pd="http://xmlns.tibco.com/bw/process/2003" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:pfx2="http://xmlns.example.com/1171360277608/GetObligatorServiceOperationImpl" xmlns:ns="http://www.tibco.com/namespaces/tnt/plugins/jms" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:ns2="http://www.tibco.com/schemas/GrantingCredit/SharedConnections/Schema1.xsd" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:ns1="http://www.tibco.com/pe/DeployedVarsType" xmlns:pfx="http://www.tibco.com/xmlns/ae2xsd/2002/05/EMS/CalculateBonitaAESchema" xmlns:pfx3="http://www.tibco.com/xmlns/ae2xsd/2002/05/EMS/AESchema">
                        <ns2:Name>
                            <xsl:value-of select="$InputParameters-JMSQueueReceiver/ns:ActivityOutput/Body/pfx:InputParameters/Name"/>
                        </ns2:Name>
                    </inputMessage>
                
        ```


### Name: ***Reply to JMS Message*** {#Reply_to_JMS_Message}

-   Type: *com.tibco.plugin.jms.JMSReplyActivity*
-   Resource Type: *ae.activities.JMSReplyActivity*
-   Description: *Send JMS reply with calculated bonita*
-   *Configuration:*
    -   PermittedMessageType = XML Text
    -   SessionAttributes
        -   transacted = false
        -   acknowledgeMode = 1
        -   maxSessions = 1
    -   ConfigurableHeaders
        -   JMSDeliveryMode = PERSISTENT
        -   JMSExpiration = 0
        -   JMSPriority = 4
        -   EventSource = InputParameters JMSQueueReceiver
    -   ApplicationProperties = /SharedResources/JMSApplicationProperties.sharedjmsapp
    -   InDataxsdString
        -   - [PretenderBonita](../../AESchemas/EMS/CalculateBonitaAESchema.aeschema.md#) \(XML Element Reference, required \)
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/ActivityInput****/OtherProperties****/Part**|"CalculateBonita"|
        |**/ActivityInput****/Body****/PretenderBonita***/\[IF\]<$InputParameters-JMSQueueReceiver/ns:ActivityOutput/Body/pfx:InputParameters/Name\>***/Name**|*\[COPY-OF\] < $InputParameters-JMSQueueReceiver/ns:ActivityOutput/Body/pfx:InputParameters/Name/@xsi:nil \>*|
        |**/ActivityInput****/Body****/PretenderBonita***/\[IF\]<$InputParameters-JMSQueueReceiver/ns:ActivityOutput/Body/pfx:InputParameters/Name\>***/Name**|$InputParameters-JMSQueueReceiver/ns:ActivityOutput/Body/pfx:InputParameters/Name|
        |**/ActivityInput****/Body****/PretenderBonita****/Bonita**|$CalculateBonita/Bonita|

    -   Mapping tree

        ```
        
        **ActivityInput**
         **OtherProperties**
          **Part** = "CalculateBonita"
         **Body**
          **PretenderBonita**
           *\[IF\] *< $InputParameters-JMSQueueReceiver/ns:ActivityOutput/Body/pfx:InputParameters/Name >
            **Name** = $InputParameters-JMSQueueReceiver/ns:ActivityOutput/Body/pfx:InputParameters/Name**
             nil** = *\[COPY-OF\] *< $InputParameters-JMSQueueReceiver/ns:ActivityOutput/Body/pfx:InputParameters/Name/@xsi:nil >
           **Bonita** = $CalculateBonita/Bonita
        ```

    -   Source code

        ```
        
                    <ns:ActivityInput xmlns:ns="http://www.tibco.com/namespaces/tnt/plugins/jms" xmlns:pd="http://xmlns.tibco.com/bw/process/2003" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:pfx2="http://xmlns.example.com/1171360277608/GetObligatorServiceOperationImpl" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:ns2="http://www.tibco.com/schemas/GrantingCredit/SharedConnections/Schema1.xsd" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:ns1="http://www.tibco.com/pe/DeployedVarsType" xmlns:pfx="http://www.tibco.com/xmlns/ae2xsd/2002/05/EMS/CalculateBonitaAESchema" xmlns:pfx3="http://www.tibco.com/xmlns/ae2xsd/2002/05/EMS/AESchema">
                        <OtherProperties>
                            <Part>
                                <xsl:value-of select="&quot;CalculateBonita&quot;"/>
                            </Part>
                        </OtherProperties>
                        <Body>
                            <pfx:PretenderBonita>
                                <xsl:if test="$InputParameters-JMSQueueReceiver/ns:ActivityOutput/Body/pfx:InputParameters/Name">
                                    <Name>
                                        <xsl:copy-of select="$InputParameters-JMSQueueReceiver/ns:ActivityOutput/Body/pfx:InputParameters/Name/@xsi:nil"/>
                                        <xsl:value-of select="$InputParameters-JMSQueueReceiver/ns:ActivityOutput/Body/pfx:InputParameters/Name"/>
                                    </Name>
                                </xsl:if>
                                <Bonita>
                                    <xsl:value-of select="$CalculateBonita/Bonita"/>
                                </Bonita>
                            </pfx:PretenderBonita>
                        </Body>
                    </ns:ActivityInput>
                
        ```


## Transitions: {#Transitions}

-   From: ***CalculateBonita*** -To: ***Reply to JMS Message***
    -   Label:
    -   Condition: *Success*
    -   Description:

-   From: ***InputParameters JMSQueueReceiver*** -To: ***Obligators SOAPRequestReply***
    -   Label:
    -   Condition: *Success*
    -   Description:

-   From: ***Obligators SOAPRequestReply*** -To: ***CalculateBonita***
    -   Label:
    -   Condition: *Success*
    -   Description:

-   From: ***Reply to JMS Message*** -To: ***End***
    -   Label:
    -   Condition: *Success*
    -   Description:

