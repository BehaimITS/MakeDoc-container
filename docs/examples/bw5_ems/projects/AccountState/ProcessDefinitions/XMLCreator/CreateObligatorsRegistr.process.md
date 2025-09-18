# CreateObligatorsRegistr {#ProcessMain .concept}

License for TIBCO Software Use Only!

Section contains description of Process " CreateObligatorsRegistr.process " .

Source Library: " CalculateBonita "

**Parent topic:**[Processes](../../../../projects/AccountState/common/process.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
|AccountState|This application simulate get bank account state process which using rating of client bonita.|
|/ProcessDefinitions|All process definitions|
|/ProcessDefinitions/XMLCreator|Processes for creating default xml files|

## Process description: {#ProcessDescription}

|Create default basic ObligatorRegistr xml file|

## Process definition: {#ProcessDefinition}

Full process path: ProcessDefinitions/XMLCreator/CreateObligatorsRegistr.process

## Diagram: {#Diagram}

![](CreateObligatorsRegistr.process.png)

## Process starter activity: {#Starter}

Name: Start

Description: *Start of process*

## Process end activity: {#EndActivity}

Name: End

## Activities: {#Activities}

### Name: ***RenderXML ObligatorsList*** {#RenderXML_ObligatorsList}

-   Type: *com.tibco.plugin.xml.XMLRendererActivity*
-   Resource Type: *ae.activities.XMLRendererActivity*
-   Description: *Render string in XML format according to ObligatorsRegistr XSD schema*
-   *Configuration:*
    -   renderAsText = text
    -   validateInput = true
    -   renderDefaultPrefix = true
    -   textEncoding = UTF-8
    -   term
        -   - ObligatorsList \(XML Element Reference, required \)
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |/**ObligatorsList**/**@Count**|1|
        |/**ObligatorsList**/**Obligator**/**Name**|Jan Novak|
        |/**ObligatorsList**/**Obligator**/**Value**|100000|
        |/**ObligatorsList**/**Obligator**/**Problem**|0|
        |/**ObligatorsList**/**Obligator**/**Refund**|5000|

    -   Mapping tree

        ```
        
        **ObligatorsList**
         **@Count** = 1
         **Obligator**
          **Name** = "Jan Novak"
          **Value** = 100000
          **Problem** = 0
          **Refund** = 5000
        ```

    -   Source code

        ```
        
                    <pfx:ObligatorsList xmlns:pfx="http://www.tibco.com/schemas/GrantingCredit/SharedConnections/Schema1.xsd" xmlns:pd="http://xmlns.tibco.com/bw/process/2003" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:ns="http://www.tibco.com/pe/DeployedVarsType" xmlns:ns2="http://www.tibco.com/namespaces/tnt/plugins/file">
                        <xsl:attribute name="Count">
                            <xsl:value-of select="1"/>
                        </xsl:attribute>
                        <pfx:Obligator>
                            <pfx:Name>
                                <xsl:value-of select="&quot;Jan Novak&quot;"/>
                            </pfx:Name>
                            <pfx:Value>
                                <xsl:value-of select="100000"/>
                            </pfx:Value>
                            <pfx:Problem>
                                <xsl:value-of select="0"/>
                            </pfx:Problem>
                            <pfx:Refund>
                                <xsl:value-of select="5000"/>
                            </pfx:Refund>
                        </pfx:Obligator>
                    </pfx:ObligatorsList>
                
        ```


### Name: ***WriteFile ObligatorRegistr*** {#WriteFile_ObligatorRegistr}

-   Type: *com.tibco.plugin.file.FileWriteActivity*
-   Resource Type: *ae.activities.FileWriteActivity*
-   Description: *Save rendered xml string as file*
-   *Configuration:*
    -   encoding = text
    -   compressFile = None
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |/**WriteActivityInputTextClass**/**fileName**| |
        |/**WriteActivityInputTextClass**/**textContent**| |

    -   Mapping tree

        ```
        
        **WriteActivityInputTextClass**
         **fileName** = $_globalVariables/ns:GlobalVariables/DefaultObligatorsRegistrFile
         **textContent** = $RenderXML-ObligatorsList/xmlString
        ```

    -   Source code

        ```
        
                    <ns2:WriteActivityInputTextClass xmlns:ns2="http://www.tibco.com/namespaces/tnt/plugins/file" xmlns:pd="http://xmlns.tibco.com/bw/process/2003" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:ns="http://www.tibco.com/pe/DeployedVarsType" xmlns:pfx="http://www.tibco.com/schemas/GrantingCredit/SharedConnections/Schema1.xsd">
                        <fileName>
                            <xsl:value-of select="$_globalVariables/ns:GlobalVariables/DefaultObligatorsRegistrFile"/>
                        </fileName>
                        <textContent>
                            <xsl:value-of select="$RenderXML-ObligatorsList/xmlString"/>
                        </textContent>
                    </ns2:WriteActivityInputTextClass>
                
        ```


## Transitions: {#Transitions}

-   From: ***RenderXML ObligatorsList*** -To: ***WriteFile ObligatorRegistr***
    -   Label:
    -   Condition: *Success*
    -   Description:

-   From: ***Start*** -To: ***RenderXML ObligatorsList***
    -   Label:
    -   Condition: *Success*
    -   Description:

-   From: ***WriteFile ObligatorRegistr*** -To: ***End***
    -   Label:
    -   Condition: *Success*
    -   Description:

