# LogProcess {#ProcessMain .concept}

License for TIBCO Software Use Only!

Section contains description of Process " LogProcess.bwp " .

**Parent topic:**[Processes](../../../../../../../../../projects/tibco.bwce.sample.binding.rest.BookStore/common/process.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
| |No description|

## Process description: {#ProcessDescription}

|No description|

## Process definition: {#ProcessDefinition}

Full process path: tibco.bwce.sample.binding.rest.bookstore.LogProcess

## Diagram: {#Diagram}

![](LogProcess.bwp.png)

## Process starter activity: {#Starter}

### Name: ***Start*** {#Start}

-   Create Instance: yes
-   Description:

## Process properties and variables {#NoVariablesDefined}

No variables defined

## Activities: {#Activities}

### Name: ***End*** {#End}

-   Description: *No description*
-   Type: bw.internal.end
-   *Input bindings:* No mapping

### Name: ***Log*** {#Log}

-   Description: *No description*
-   Type: bw.generalactivities.log
-   Logger Name:
-   Log level: *Info*
-   Suppress Job Info: *true*
-   Input Variable: *Log-input*
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:ActivityInput****/message**|""|

    -   Mapping tree

        ```
        **tns:ActivityInputmessage = **&quot;&quot;
        ```

    -   Source code

        ```
        <?xml version="1.0" encoding="UTF-8"?>
        <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/pe/WriteToLogActivitySchema" version="2.0"><xsl:template name="Log-input" match="/"><tns:ActivityInput><message><xsl:value-of select="&quot;&quot;"/></message></tns:ActivityInput></xsl:template></xsl:stylesheet>
        ```


## Transitions: {#Transitions}

-   From: ***Start*** -To: ***Log***
    -   Label: **
    -   Type: SUCCESS

-   From: ***Log*** -To: ***End***
    -   Label: **
    -   Type: SUCCESS

