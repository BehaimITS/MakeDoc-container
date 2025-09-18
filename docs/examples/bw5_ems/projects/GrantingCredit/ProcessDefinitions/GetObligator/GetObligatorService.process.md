# GetObligatorService {#ProcessMain .concept}

License for TIBCO Software Use Only!

Section contains description of Process " GetObligatorService.process " .

Source Library: " CalculateBonita "

**Parent topic:**[Processes](../../../../projects/GrantingCredit/common/process.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
|GrantingCredit|The application Granting credit provides resolution whether a credit \(or mortgage\) can be granded to a user. Information about user is the input of the application.|
|/ProcessDefinitions|All process definitions|
|/ProcessDefinitions/GetObligator|Processes for obtaining informations about loan of obligator.|

## Process description: {#ProcessDescription}

|Ensure SOAP I/O operation for GetObligator process.|

## Process definition: {#ProcessDefinition}

Full process path: ProcessDefinitions/GetObligator/GetObligatorService.process

## Diagram: {#Diagram}

![](GetObligatorService.process.png)

## Process starter activity: {#Starter}

Name: ObligatorName SOAPEventSource

-   Property Name: ***ObligatorName SOAPEventSource***
    -   Type: *com.tibco.plugin.soap.SOAPEventSource*
    -   Resource Type: *ae.activities.SOAPEventSourceUI*
    -   Description: *Get input parameters from SOAP for GetObligator process*
    -   *Configuration:*
        -   service = pfx:GetObligatorServicePort
        -   wsdlNamespaceRoot = http://xmlns.example.com/1171360277608/GetObligatorServiceOperationImpl
        -   operation = GetObligatorServiceOperation
        -   portAddressPrefix =
        -   operationStyle = document
        -   soapUse = literal
        -   embedWsdlComponents = true
        -   embedSchemaComponents = true
        -   soapAction = /ProcessDefinitions/GetObligator/GetObligatorService
        -   sharedChannel = [/SharedConnections/CalculateBonitaSOAPHTTPConnection.sharedhttp](../../SharedConnections/CalculateBonitaSOAPHTTPConnection.sharedhttp.md)

## Process end activity: {#EndActivity}

Name: End

## Activities: {#Activities}

### Name: ***GetObligator*** {#GetObligator}

-   Type: *com.tibco.pe.core.CallProcessActivity*
-   Resource Type: *ae.process.subprocess*
-   Description: *Read informations about obligator loan from xml file*
-   *Configuration:*
    -   processName = [/ProcessDefinitions/GetObligator/GetObligator.process](GetObligator.process.md)
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |/**Name**| |

    -   Mapping tree

        ```
        
        **Name** = $ObligatorName-SOAPEventSource/inputMessage/ns:Name
        ```

    -   Source code

        ```
        
                    <ns:Name xmlns:ns="http://www.tibco.com/schemas/GrantingCredit/SharedConnections/Schema1.xsd" xmlns:pd="http://xmlns.tibco.com/bw/process/2003" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:pfx="http://xmlns.example.com/1171360277608" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/">
                        <xsl:value-of select="$ObligatorName-SOAPEventSource/inputMessage/ns:Name"/>
                    </ns:Name>
                
        ```


### Name: ***ObligatorInfo SOAPSendReply*** {#ObligatorInfo_SOAPSendReply}

-   Type: *com.tibco.plugin.soap.SOAPSendReplyActivity*
-   Resource Type: *ae.activities.SOAPSendReplyUI*
-   Description: *Send SOAP reply with GetObligator result*
-   *Configuration:*
    -   eventSource = ObligatorName SOAPEventSource
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |/**outputMessage**|*\[COPY-OF\] < $GetObligator/ns:Obligator \>*|

    -   Mapping tree

        ```
        
        **outputMessage****
         Obligator** = *\[COPY-OF\] *< $GetObligator/ns:Obligator >
        ```

    -   Source code

        ```
        
                    <outputMessage xmlns:pd="http://xmlns.tibco.com/bw/process/2003" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:pfx="http://xmlns.example.com/1171360277608" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:ns="http://www.tibco.com/schemas/GrantingCredit/SharedConnections/Schema1.xsd">
                        <xsl:copy-of select="$GetObligator/ns:Obligator"/>
                    </outputMessage>
                
        ```


## Transitions: {#Transitions}

-   From: ***GetObligator*** -To: ***ObligatorInfo SOAPSendReply***
    -   Label:
    -   Condition: *Success*
    -   Description:

-   From: ***ObligatorInfo SOAPSendReply*** -To: ***End***
    -   Label:
    -   Condition: *Success*
    -   Description:

-   From: ***ObligatorName SOAPEventSource*** -To: ***GetObligator***
    -   Label:
    -   Condition: *Success*
    -   Description:

