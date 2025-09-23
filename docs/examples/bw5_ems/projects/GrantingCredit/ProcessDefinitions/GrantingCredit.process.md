# GrantingCredit {#ProcessMain .concept}

License for TIBCO Software Use Only!

Section contains description of Process " GrantingCredit.process " .

**Parent topic:**[Processes](../../../projects/GrantingCredit/common/process.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
|GrantingCredit|The application Granting credit provides resolution whether a credit \(or mortgage\) can be granded to a user. Information about user is the input of the application.|
|/ProcessDefinitions|All process definitions|

## Process description: {#ProcessDescription}

|No description|

## Process definition: {#ProcessDefinition}

Full process path: ProcessDefinitions/GrantingCredit.process

## Diagram: {#Diagram}

![](GrantingCredit.process.png)

## Process starter activity: {#Starter}

Name: InputFileName HTTPReceiver

-   Property Name: ***InputFileName HTTPReceiver***
    -   Type: *com.tibco.plugin.http.HTTPEventSource*
    -   Resource Type: *httppalette.httpEventSource*
    -   Description:
    -   *Configuration:*
        -   outputMode = String
        -   defaultEncoding = UTF8
        -   inputOutputVersion = 5.3.0
        -   newMimeSupport = true
        -   sharedChannel = [/SharedConnections/InputHTTPConnection.sharedhttp](../SharedConnections/InputHTTPConnection.sharedhttp.md)
        -   customField
            -   row
                -   attribute = InputParameters
                -   attributeType = string
                -   attributeCard = optional
        -   Headers
            -   + root \(Complex Type, required \)
                -   - Accept\(xsd:string,optional\)
                -   - Accept-Charset\(xsd:string,optional\)
                -   - Accept-Encoding\(xsd:string,optional\)
                -   - Content-Type\(xsd:string,optional\)
                -   - Content-Length\(xsd:string,optional\)
                -   - Connection\(xsd:string,optional\)
                -   - Cookie\(xsd:string,optional\)
                -   - Pragma\(xsd:string,optional\)

## Process end activity: {#EndActivity}

Name: End

## Activities: {#Activities}

### Name: ***Appraisal JMSQueueSender*** {#Appraisal_JMSQueueSender}

-   Type: *com.tibco.plugin.jms.JMSQueueSendActivity*
-   Resource Type: *ae.activities.JMSQueueSendActivity*
-   Description:
-   *Configuration:*
    -   PermittedMessageType = XML Text
    -   SessionAttributes
        -   transacted = false
        -   acknowledgeMode = 1
        -   maxSessions = 1
        -   destination = %%ENV%%.%%AppraisalJMSQueueRequestName%%
    -   ConfigurableHeaders
        -   JMSDeliveryMode = PERSISTENT
        -   JMSExpiration = 0
        -   JMSPriority = 4
    -   ConnectionReference = [/SharedConnections/EMSConnection.sharedjmscon](../SharedConnections/EMSConnection.sharedjmscon.md)
    -   ApplicationProperties =
    -   InDataxsdString
        -   - AppraisalRequest \(XML Element Reference, required \)
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |/**ActivityInput**/**Body**/**AppraisalRequest**/**Name**| |
        |/**ActivityInput**/**Body**/**AppraisalRequest**/**RealtyDetail**| |
        |/**ActivityInput**/**Body**/**AppraisalRequest**/**Pawn**| |

    -   Mapping tree

        ```
        
        ActivityInput
         Body
          AppraisalRequest
           Name = $InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:Name
           RealtyDetail = $InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:RealtyDetail
           Pawn = $InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:Pawn
        ```

    -   Source code

        ```
        
                    <ns2:ActivityInput xmlns:ns2="http://www.tibco.com/namespaces/tnt/plugins/jms" xmlns:pd="http://xmlns.tibco.com/bw/process/2003" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:pfx="http://xmlns.example.com/1171295149828/LoadParametersServiceOperationImpl" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:ns="http://www.tibco.com/schemas/GrantingCredit/SharedConnections/Schema.xsd" xmlns:ns1="http://www.tibco.com/pe/DeployedVarsType" xmlns:pfx2="http://www.tibco.com/xmlns/ae2xsd/2002/05/EMS/AESchema" xmlns:pfx3="http://www.tibco.com/xmlns/ae2xsd/2002/05/EMS/GrantingCreditAESchema" xmlns:pfx4="http://www.tibco.com/xmlns/ae2xsd/2002/05/EMS/CalculateBonitaAESchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:pfx5="http://www.tibco.com/xmlns/ae2xsd/2002/05/Appraisal/AppraisalAESchema">
                        <Body>
                            <pfx5:AppraisalRequest>
                                <Name>
                                    <xsl:value-of select="$InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:Name"/>
                                </Name>
                                <RealtyDetail>
                                    <xsl:value-of select="$InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:RealtyDetail"/>
                                </RealtyDetail>
                                <Pawn>
                                    <xsl:value-of select="$InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:Pawn"/>
                                </Pawn>
                            </pfx5:AppraisalRequest>
                        </Body>
                    </ns2:ActivityInput>
                
        ```


### Name: ***InputParameters JMSQueueSender*** {#InputParameters_JMSQueueSender}

-   Type: *com.tibco.plugin.jms.JMSQueueSendActivity*
-   Resource Type: *ae.activities.JMSQueueSendActivity*
-   Description:
-   *Configuration:*
    -   PermittedMessageType = XML Text
    -   SessionAttributes
        -   transacted = false
        -   acknowledgeMode = 1
        -   maxSessions = 1
        -   destination = %%ENV%%.%%JMSQueueName%%
    -   ConfigurableHeaders
        -   JMSDeliveryMode = PERSISTENT
        -   JMSExpiration = 0
        -   JMSPriority = 4
        -   JMSReplyTo =
    -   ConnectionReference = [/SharedConnections/EMSConnection.sharedjmscon](../SharedConnections/EMSConnection.sharedjmscon.md)
    -   ApplicationProperties = /SharedResources/JMSApplicationProperties.sharedjmsapp
    -   InDataxsdString
        -   - InputParameters \(XML Element Reference, required \)
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |/**ActivityInput**/**OtherProperties**/**Part**|InputParameters|
        |/**ActivityInput**/**Body**/**InputParameters**/**Name**| |
        |/**ActivityInput**/**Body**/**InputParameters**/**Value**| |
        |/**ActivityInput**/**Body**/**InputParameters**/**Salary**| |
        |/**ActivityInput**/**Body**/**InputParameters**/**Refund**| |
        |/**ActivityInput**/**Body**/**InputParameters**/**Pawn**| |
        |/**ActivityInput**/**Body**/**InputParameters**/**RealtyDetail**| |
        |/**ActivityInput**/**Body**/**InputParameters**/**RealtyValue**| |

    -   Mapping tree

        ```
        
        ActivityInput
         OtherProperties
          Part = "InputParameters"
         Body
          InputParameters
           Name = $InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:Name
           Value = $InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:Value
           Salary = $InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:Salary
           Refund = $InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:Refund
           Pawn = $InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:Pawn
           RealtyDetail = $InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:RealtyDetail
           RealtyValue = $InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:RealtyValue
        ```

    -   Source code

        ```
        
                    <ns2:ActivityInput xmlns:ns2="http://www.tibco.com/namespaces/tnt/plugins/jms" xmlns:pd="http://xmlns.tibco.com/bw/process/2003" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:pfx="http://xmlns.example.com/1171295149828/LoadParametersServiceOperationImpl" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:ns="http://www.tibco.com/schemas/GrantingCredit/SharedConnections/Schema.xsd" xmlns:ns1="http://www.tibco.com/pe/DeployedVarsType" xmlns:pfx2="http://www.tibco.com/xmlns/ae2xsd/2002/05/EMS/AESchema" xmlns:pfx3="http://www.tibco.com/xmlns/ae2xsd/2002/05/EMS/GrantingCreditAESchema" xmlns:pfx4="http://www.tibco.com/xmlns/ae2xsd/2002/05/EMS/CalculateBonitaAESchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:pfx5="http://www.tibco.com/xmlns/ae2xsd/2002/05/Appraisal/AppraisalAESchema">
                        <OtherProperties>
                            <Part>
                                <xsl:value-of select="&quot;InputParameters&quot;"/>
                            </Part>
                        </OtherProperties>
                        <Body>
                            <pfx3:InputParameters>
                                <Name>
                                    <xsl:value-of select="$InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:Name"/>
                                </Name>
                                <Value>
                                    <xsl:value-of select="$InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:Value"/>
                                </Value>
                                <Salary>
                                    <xsl:value-of select="$InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:Salary"/>
                                </Salary>
                                <Refund>
                                    <xsl:value-of select="$InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:Refund"/>
                                </Refund>
                                <Pawn>
                                    <xsl:value-of select="$InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:Pawn"/>
                                </Pawn>
                                <RealtyDetail>
                                    <xsl:value-of select="$InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:RealtyDetail"/>
                                </RealtyDetail>
                                <RealtyValue>
                                    <xsl:value-of select="$InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:RealtyValue"/>
                                </RealtyValue>
                            </pfx3:InputParameters>
                        </Body>
                    </ns2:ActivityInput>
                
        ```


### Name: ***InputParameters SendHTTPResponse*** {#InputParameters_SendHTTPResponse}

-   Type: *com.tibco.plugin.http.HTTPResponseActivity*
-   Resource Type: *httppalette.httpWebResponse*
-   Description:
-   *Configuration:*
    -   closeConnection = true
    -   eventSource = InputFileName HTTPReceiver
    -   Headers
        -   + root \(Complex Type, required \)
            -   - StatusLine\(xsd:string,optional\)
            -   - Content-Type\(xsd:string,optional\)
            -   - Set-Cookie\(xsd:string,optional\)
            -   - Pragma\(xsd:string,optional\)
            -   - Location\(xsd:string,optional\)
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |/**ResponseActivityInput**/**asciiContent**| |

    -   Mapping tree

        ```
        
        ResponseActivityInput
         asciiContent = concat("<H1>InputParameters:</H1><B>Name:</B>  ",
         $InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:Name,
         "<BR><B>Value: </B>", 
        $InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:Value,
        "<BR><B>Refund: </B>",
        $InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:Refund,
        "<BR><B>Salary: </B>",  
         $InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:Salary,
         "<BR><B>Pawn: </B>", 
        $InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:Pawn,
         "<BR><B>RealtyDetail: </B>", 
        $InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:RealtyDetail,
         "<BR><B>RealtyValue: </B>", 
        $InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:RealtyValue)
        ```

    -   Source code

        ```
        
                    <ResponseActivityInput xmlns:pd="http://xmlns.tibco.com/bw/process/2003" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:pfx="http://xmlns.example.com/1171295149828/LoadParametersServiceOperationImpl" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:ns="http://www.tibco.com/schemas/GrantingCredit/SharedConnections/Schema.xsd" xmlns:ns1="http://www.tibco.com/pe/DeployedVarsType" xmlns:ns2="http://www.tibco.com/namespaces/tnt/plugins/jms" xmlns:pfx2="http://www.tibco.com/xmlns/ae2xsd/2002/05/EMS/AESchema" xmlns:pfx3="http://www.tibco.com/xmlns/ae2xsd/2002/05/EMS/GrantingCreditAESchema" xmlns:pfx4="http://www.tibco.com/xmlns/ae2xsd/2002/05/EMS/CalculateBonitaAESchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:pfx5="http://www.tibco.com/xmlns/ae2xsd/2002/05/Appraisal/AppraisalAESchema">
                        <asciiContent>
                            <xsl:value-of select="concat(&quot;&lt;H1&gt;InputParameters:&lt;/H1&gt;&lt;B&gt;Name:&lt;/B&gt;  &quot;,&#10; $InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:Name,&#10; &quot;&lt;BR&gt;&lt;B&gt;Value: &lt;/B&gt;&quot;, &#10;$InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:Value,&#10;&quot;&lt;BR&gt;&lt;B&gt;Refund: &lt;/B&gt;&quot;,&#10;$InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:Refund,&#10;&quot;&lt;BR&gt;&lt;B&gt;Salary: &lt;/B&gt;&quot;,  &#10; $InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:Salary,&#10; &quot;&lt;BR&gt;&lt;B&gt;Pawn: &lt;/B&gt;&quot;, &#10;$InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:Pawn,&#10; &quot;&lt;BR&gt;&lt;B&gt;RealtyDetail: &lt;/B&gt;&quot;, &#10;$InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:RealtyDetail,&#10; &quot;&lt;BR&gt;&lt;B&gt;RealtyValue: &lt;/B&gt;&quot;, &#10;$InputParameters-SOAPRequestReply/outputMessage/ns:InputParameters/ns:RealtyValue)"/>
                        </asciiContent>
                    </ResponseActivityInput>
                
        ```


### Name: ***InputParameters SOAPRequestReply*** {#InputParameters_SOAPRequestReply}

-   Type: *com.tibco.plugin.soap.SOAPSendReceiveActivity*
-   Resource Type: *ae.activities.SOAPSendReceiveUI*
-   Description:
-   *Configuration:*
    -   timeout = 0
    -   service = pfx:LoadParametersService
    -   servicePort = InputFileName\_sp\_from\_sp\_SOAPEventSource
    -   operation = LoadParametersServiceOperation
    -   soapAction = /ProcessDefinitions/LoadParameters/LoadParametersService
    -   endpointURL = %%LoadParametersServiceEndpointURL%%
    -   useProxy = false
    -   requireBasicAuth = false
    -   basicHttpAuthIdentity =
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |/**inputMessage**/**InputFile**/**FileName**| |

    -   Mapping tree

        ```
        
        inputMessage
         InputFile
          FileName = $InputFileName-HTTPReceiver/ProcessStarterOutput/parameters/InputParameters
        ```

    -   Source code

        ```
        
                    <inputMessage xmlns:pd="http://xmlns.tibco.com/bw/process/2003" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:pfx="http://xmlns.example.com/1171295149828/LoadParametersServiceOperationImpl" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:ns="http://www.tibco.com/schemas/GrantingCredit/SharedConnections/Schema.xsd" xmlns:ns1="http://www.tibco.com/pe/DeployedVarsType" xmlns:ns2="http://www.tibco.com/namespaces/tnt/plugins/jms" xmlns:pfx2="http://www.tibco.com/xmlns/ae2xsd/2002/05/EMS/AESchema" xmlns:pfx3="http://www.tibco.com/xmlns/ae2xsd/2002/05/EMS/GrantingCreditAESchema" xmlns:pfx4="http://www.tibco.com/xmlns/ae2xsd/2002/05/EMS/CalculateBonitaAESchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:pfx5="http://www.tibco.com/xmlns/ae2xsd/2002/05/Appraisal/AppraisalAESchema">
                        <ns:InputFile>
                            <ns:FileName>
                                <xsl:value-of select="$InputFileName-HTTPReceiver/ProcessStarterOutput/parameters/InputParameters"/>
                            </ns:FileName>
                        </ns:InputFile>
                    </inputMessage>
                
        ```


## Transitions: {#Transitions}

-   From: ***Appraisal JMSQueueSender*** -To: ***InputParameters JMSQueueSender***
    -   Label:
    -   Condition: *Success*
    -   Description:

-   From: ***InputFileName HTTPReceiver*** -To: ***InputParameters SOAPRequestReply***
    -   Label:
    -   Condition: *Success*
    -   Description:

-   From: ***InputParameters JMSQueueSender*** -To: ***End***
    -   Label:
    -   Condition: *Success*
    -   Description:

-   From: ***InputParameters SendHTTPResponse*** -To: ***Appraisal JMSQueueSender***
    -   Label:
    -   Condition: *Success*
    -   Description:

-   From: ***InputParameters SOAPRequestReply*** -To: ***InputParameters SendHTTPResponse***
    -   Label:
    -   Condition: *Success*
    -   Description:

