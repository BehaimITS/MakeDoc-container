# GrantingCredit {#violation2 .concept}

Description of rule: Activity has hardcoded timeout property

Violation appeared in following files:

**Parent topic:**[ERROR - Hardcoded activities timeout](../../../../../../modules/demo_Enterprise/dita/qa/rules/ERROR_-_Hardcoded_activities_timeout.md)

## JDBC activities {#JDBC_activities}

-   */ProcessDefinitions/CalculateBonita.process* - activity UpdateDB
-   */ProcessDefinitions/Examination.process* - activity UpdateCustomerDB

## RequestReply activities {#RequestReply_activities}

-   */ProcessDefinitions/CalculateBonitaService.process* - activity Obligators SOAPRequestReply
-   [/ProcessDefinitions/GrantingCredit.process](../../../projects/GrantingCredit/ProcessDefinitions/GrantingCredit.process.md) - activity InputParameters SOAPRequestReply
-   */ProcessDefinitions/LoadParameterServiceTest.process* - activity SOAPRequestReply

