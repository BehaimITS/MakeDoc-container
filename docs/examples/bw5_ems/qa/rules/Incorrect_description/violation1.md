# GrantingCredit {#violation1 .concept}

License for TIBCO Software Use Only!

Description of rule: Item doesn't contain any description or description too short

Violation appeared in following files:

**Parent topic:**[WARNING - Incorrect description](../../../qa/rules/WARNING_-_Incorrect_description.md)

## AE Schemas {#AE_Schemas}

-   */AESchemas/AppraisalAESchema.aeschema*
-   */AESchemas/CalculateBonitaAESchema.aeschema*
-   */AESchemas/GrantingCreditAESchema.aeschema*
-   [/AESchemas/ae.aeschema](../../../projects/GrantingCredit/AESchemas/ae.aeschema.md)
-   */AESchemas/baseDocument.aeschema*
-   [/AESchemas/corba.aeschema](../../../projects/GrantingCredit/AESchemas/corba.aeschema.md)
-   [/AESchemas/java.aeschema](../../../projects/GrantingCredit/AESchemas/java.aeschema.md)
-   [/AESchemas/sql.aeschema](../../../projects/GrantingCredit/AESchemas/sql.aeschema.md)

## Activities {#Activities}

-   */ProcessDefinitions/CalculateBonita.process* - activity UpdateDB
-   */ProcessDefinitions/CreateInputFile.process* - activity RenderXML InputParameters
-   */ProcessDefinitions/CreateInputFile.process* - activity WriteFile InputFile
-   */ProcessDefinitions/Examination.process* - activity GetMinRefund JavaCode
-   */ProcessDefinitions/Examination.process* - activity Interest Assign
-   */ProcessDefinitions/Examination.process* - activity UpdateCustomerDB
-   */ProcessDefinitions/ExaminationService.process* - activity Appraisal WaitForJMSQueueMessage
-   */ProcessDefinitions/ExaminationService.process* - activity Bonita JMSQueueRequestor
-   */ProcessDefinitions/ExaminationService.process* - activity Examination
-   */ProcessDefinitions/ExaminationService.process* - activity Negate Value
-   */ProcessDefinitions/ExaminationService.process* - activity Result JMSQueueSender
-   [/ProcessDefinitions/GrantingCredit.process](../../../projects/GrantingCredit/ProcessDefinitions/GrantingCredit.process.md) - activity Appraisal JMSQueueSender
-   [/ProcessDefinitions/GrantingCredit.process](../../../projects/GrantingCredit/ProcessDefinitions/GrantingCredit.process.md) - activity InputParameters JMSQueueSender
-   [/ProcessDefinitions/GrantingCredit.process](../../../projects/GrantingCredit/ProcessDefinitions/GrantingCredit.process.md) - activity InputParameters SOAPRequestReply
-   [/ProcessDefinitions/GrantingCredit.process](../../../projects/GrantingCredit/ProcessDefinitions/GrantingCredit.process.md) - activity InputParameters SendHTTPResponse
-   */ProcessDefinitions/HTMLOutput.process* - activity Result SendHTTPResponse
-   */ProcessDefinitions/HTMLOutput.process* - activity Wait for HTTP Request
-   */ProcessDefinitions/LoadParameterServiceTest.process* - activity SOAPRequestReply
-   */ProcessDefinitions/LoadParameters.process* - activity ParseXML as InputParameters
-   */ProcessDefinitions/LoadParameters.process* - activity ReadFile with InputName
-   */ProcessDefinitions/LoadParametersService.process* - activity InputParameters SOAPSendReply
-   */ProcessDefinitions/LoadParametersService.process* - activity LoadParameters

## Archives {#Archives}

-   */EAR/GrantingCredit.archive*

## Processes {#Processes}

-   */ProcessDefinitions/CreateInputFile.process*
-   */ProcessDefinitions/Examination.process*
-   */ProcessDefinitions/ExaminationService.process*
-   [/ProcessDefinitions/GrantingCredit.process](../../../projects/GrantingCredit/ProcessDefinitions/GrantingCredit.process.md)
-   */ProcessDefinitions/HTMLOutput.process*
-   */ProcessDefinitions/LoadParameterServiceTest.process*
-   */ProcessDefinitions/LoadParameters.process*
-   */ProcessDefinitions/LoadParametersService.process*

## Shared HTTP Connection {#Shared_HTTP_Connection}

-   [/SharedConnections/InputHTTPConnection.sharedhttp](../../../projects/GrantingCredit/SharedConnections/InputHTTPConnection.sharedhttp.md)
-   [/SharedConnections/OutputHTTPConnection.sharedhttp](../../../projects/GrantingCredit/SharedConnections/OutputHTTPConnection.sharedhttp.md)
-   [/SharedConnections/SOAPHTTPConnection.sharedhttp](../../../projects/GrantingCredit/SharedConnections/SOAPHTTPConnection.sharedhttp.md)

## Shared JDBC Connections {#Shared_JDBC_Connections}

-   [/SharedConnections/SharedTibco.sharedjdbc](../../../projects/GrantingCredit/SharedConnections/SharedTibco.sharedjdbc.md)

## Shared JMS Connections {#Shared_JMS_Connections}

-   [/SharedConnections/EMSConnection.sharedjmscon](../../../projects/GrantingCredit/SharedConnections/EMSConnection.sharedjmscon.md)

## Starter activity {#Starter_activity}

-   */ProcessDefinitions/ExaminationService.process* - starter activity InputParameters JMSQueueReceiver
-   [/ProcessDefinitions/GrantingCredit.process](../../../projects/GrantingCredit/ProcessDefinitions/GrantingCredit.process.md) - starter activity InputFileName HTTPReceiver
-   */ProcessDefinitions/HTMLOutput.process* - starter activity Result JMSQueueReceiver
-   */ProcessDefinitions/LoadParametersService.process* - starter activity InputFileName from SOAPEventSource

## WSDLs {#WSDLs}

-   [/SharedResources/LoadParametersServiceAbstractWSDL.wsdl](../../../projects/GrantingCredit/SharedResources/LoadParametersServiceAbstractWSDL.wsdl.md)
-   [/SharedResources/LoadParametersServiceConcreteWSDL.wsdl](../../../projects/GrantingCredit/SharedResources/LoadParametersServiceConcreteWSDL.wsdl.md)

