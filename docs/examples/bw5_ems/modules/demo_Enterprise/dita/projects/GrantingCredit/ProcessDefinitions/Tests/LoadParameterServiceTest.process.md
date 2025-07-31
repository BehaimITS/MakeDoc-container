# LoadParameterServiceTest {#ProcessMain .concept}

Section contains description of Process " LoadParameterServiceTest.process " .

**Parent topic:**[Processes](../../../../../../../modules/demo_Enterprise/dita/projects/GrantingCredit/common/process.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
|GrantingCredit|The application Granting credit provides resolution whether a credit \(or mortgage\) can be granded to a user. Information about user is the input of the application.|
|\\ProcessDefinitions|All process definitions|

## Process description: {#ProcessDescription}

|No description|

## Process definition: {#ProcessDefinition}

Full process path: ProcessDefinitions/Tests/LoadParameterServiceTest.process

## Diagram: {#Diagram}

![](LoadParameterServiceTest.process.png)

## Process starter activity: {#Starter}

Name: Start

Description:

## Process end activity: {#EndActivity}

Name: End

## Activities: {#Activities}

### Name: ***SOAPRequestReply*** {#SOAPRequestReply}

-   Type: *com.tibco.plugin.soap.SOAPSendReceiveActivity*
-   Resource Type: *ae.activities.SOAPSendReceiveUI*
-   Description:
-   *Configuration:*
    -   timeout = 0
    -   service = pfx:LoadParametersService
    -   servicePort = InputFileName\_sp\_from\_sp\_SOAPEventSource
    -   operation = LoadParametersServiceOperation
    -   soapAction = /ProcessDefinitions/LoadParameters/LoadParametersService
    -   endpointURL = http://localhost:%%HTTPSOAPPort%%/ProcessDefinitions/LoadParameters/LoadParametersService
    -   useProxy = false
    -   requireBasicAuth = false
    -   basicHttpAuthIdentity =
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/inputMessage****/InputFile****/FileName**|$\_globalVariables/ns:GlobalVariables/DefaultInputParametersFile|

    -   Mapping tree

        ```
        
        **inputMessage**
         **InputFile**
          **FileName** = $_globalVariables/ns:GlobalVariables/DefaultInputParametersFile
        ```

    -   Source code

        ```
        
                    <inputMessage xmlns:ns2="http://www.tibco.com/schemas/GrantingCredit/SharedConnections/Schema.xsd" xmlns:pd="http://xmlns.tibco.com/bw/process/2003" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns="http://www.tibco.com/pe/DeployedVarsType" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:pfx="http://xmlns.example.com/1171295149828/LoadParametersServiceOperationImpl">
                        <ns2:InputFile>
                            <ns2:FileName>
                                <xsl:value-of select="$_globalVariables/ns:GlobalVariables/DefaultInputParametersFile"/>
                            </ns2:FileName>
                        </ns2:InputFile>
                    </inputMessage>
                
        ```


## Transitions: {#Transitions}

-   From: ***SOAPRequestReply*** -To: ***End***
    -   Label:
    -   Condition: *Success*
    -   Description:

-   From: ***Start*** -To: ***SOAPRequestReply***
    -   Label:
    -   Condition: *Success*
    -   Description:

