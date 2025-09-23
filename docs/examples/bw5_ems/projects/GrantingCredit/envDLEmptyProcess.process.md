# envDLEmptyProcess {#ProcessMain .concept}

License for TIBCO Software Use Only!

Section contains description of Process " envDLEmptyProcess.process " .

Source Library: " envDL "

**Parent topic:**[Processes](../../projects/GrantingCredit/common/process.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
|GrantingCredit|The application Granting credit provides resolution whether a credit \(or mortgage\) can be granded to a user. Information about user is the input of the application.|

## Process description: {#ProcessDescription}

|No description|

## Process definition: {#ProcessDefinition}

Full process path: envDLEmptyProcess.process

## Diagram: {#Diagram}

![](envDLEmptyProcess.process.png)

## Process starter activity: {#Starter}

Name: Start

Description:

## Process end activity: {#EndActivity}

Name: End

## Activities: {#Activities}

### Name: ***Null*** {#Null}

-   Type: *com.tibco.plugin.timer.NullActivity*
-   Resource Type: *ae.activities.null*
-   Description:

## Transitions: {#Transitions}

-   From: ***Null*** -To: ***End***
    -   Label:
    -   Condition: *Success*
    -   Description:

-   From: ***Start*** -To: ***Null***
    -   Label:
    -   Condition: *Success*
    -   Description:

