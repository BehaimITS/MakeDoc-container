# Activator {#ProcessMain .concept}

License for TIBCO Software Use Only!

Section contains description of Process " Activator.bwp " .

**Parent topic:**[Processes](../../../../../../../../../projects/tibco.bwce.sample.binding.rest.BookStore/common/process.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
| |No description|

## Process description: {#ProcessDescription}

|No description|

## Process definition: {#ProcessDefinition}

Full process path: tibco.bwce.sample.binding.rest.bookstore.Activator

## Diagram: {#Diagram}

![](Activator.bwp.png)

## Process starter activity: {#Starter}

### Name: ***OnMessageStart*** {#OnMessageStart}

-   Constructor: onMessageStart
-   xpdlId: 79e1b9f0-e800-4503-b8c9-7fc6da565325

### Name: ***OnMessageStart1*** {#OnMessageStart1}

-   Constructor: onMessageStart
-   xpdlId: 5097d35a-1b3f-4bf0-a4a1-0fc58a1e49bb

## Process end activity: {#EndActivity}

### Name: ***OnMessageEnd*** {#OnMessageEnd}

-   Constructor: onMessageEnd
-   xpdlId: 3e222161-75e7-4be8-8610-1a38704d8b18

### Name: ***OnMessageEnd1*** {#OnMessageEnd1}

-   Constructor: onMessageEnd
-   xpdlId: 4cae5b29-d44c-4e3d-93d0-cff37cc96e99

## Process properties and variables {#ProcessVariables}

|Name|Type|Property Source|Default Value|
|----|----|---------------|-------------|
|\_processContext| | | |
|onStartup| | | |
|onShutdown| | | |
|create\_books\_table-input| | | |
|create\_books\_table| | | |
|jdbcProperty|xsd:string| |tibco.bwce.sample.binding.rest.BookStore.JDBCConnectionResource|
|create\_table\_events-input| | | |
|create\_table\_events| | | |
|FaultName|xsd:string| | |
|FaultDetails| | | |
|Log-input| | | |
|insert\_into\_books-input| | | |
|insert\_into\_books| | | |
|CHANGED-input| | | |

## Activities: {#Activities}

### Name: ***CHANGED*** {#CHANGED}

-   Description: *No description*
-   Type: bw.generalactivities.log
-   Logger Name:
-   Log level: *Info*
-   Suppress Job Info: *true*
-   Input Variable: *CHANGED-input*
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
        <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/pe/WriteToLogActivitySchema" version="2.0"><xsl:template name="CHANGED-input" match="/"><tns:ActivityInput><message><xsl:value-of select="&quot;&quot;"/></message></tns:ActivityInput></xsl:template></xsl:stylesheet>
        ```


### Name: ***create\_books\_table*** {#create_books_table}

-   Description: *No description*
-   Type: bw.jdbc.SQLDirect
-   JDBC Shared Resource: [jdbcProperty](../../../../../../../Resources/tibco/bwce/sample/binding/rest/BookStore/JDBCConnectionResource.jdbcResource.md)
-   Timeout \(sec\): 10
-   Maximum rows: 100
-   Thread Pool Shared Resource:
-   Override Transaction Behavior: *false*
-   Override JDBC Connection: *false*
-   Input Variable: *create\_books\_table-input*
-   Output Variable: *create\_books\_table*
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns1:ActivityInputType****/statement**|'CREATE TABLE IF NOT EXISTS public.books \( isbn text, name text, description text, "authorName" text, "releaseDate" date, vintage boolean, signed boolean, price double precision \) WITH \( OIDS=FALSE \)'|

    -   Mapping tree

        ```
        **
                tns1:ActivityInputType
                    statement = **'CREATE TABLE IF NOT EXISTS public.books (&#xA;  isbn text,&#xA;  name text,&#xA;  description text,&#xA;  &quot;authorName&quot; text,&#xA;  &quot;releaseDate&quot; date,&#xA;  vintage boolean,&#xA;  signed boolean,&#xA;  price double precision&#xA;)&#xA;WITH (&#xA;  OIDS=FALSE&#xA;)'
        ```

    -   Source code

        ```
        <?xml version="1.0" encoding="UTF-8"?>
        <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns1="http://www.tibco.com/namespaces/tnt/plugins/jdbc+6bce79bd-a67c-4a10-9d5b-9802683b746d+input" version="2.0">
            <xsl:template name="create_books_table-input" match="/">
                <tns1:ActivityInputType>
                    <statement>
                        <xsl:value-of select="'CREATE TABLE IF NOT EXISTS public.books (&#xA;  isbn text,&#xA;  name text,&#xA;  description text,&#xA;  &quot;authorName&quot; text,&#xA;  &quot;releaseDate&quot; date,&#xA;  vintage boolean,&#xA;  signed boolean,&#xA;  price double precision&#xA;)&#xA;WITH (&#xA;  OIDS=FALSE&#xA;)'"/>
                    </statement>
                </tns1:ActivityInputType>
            </xsl:template>
        </xsl:stylesheet>
        ```


### Name: ***create\_table\_events*** {#create_table_events}

-   Description: *No description*
-   Type: bw.jdbc.SQLDirect
-   JDBC Shared Resource: [jdbcProperty](../../../../../../../Resources/tibco/bwce/sample/binding/rest/BookStore/JDBCConnectionResource.jdbcResource.md)
-   Timeout \(sec\): 10
-   Maximum rows: 100
-   Thread Pool Shared Resource:
-   Override Transaction Behavior: *false*
-   Override JDBC Connection: *false*
-   Input Variable: *create\_table\_events-input*
-   Output Variable: *create\_table\_events*
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns1:ActivityInputType****/statement**|'CREATE TABLE IF NOT EXISTS public.events \( summary text, description text, "authorName" text, bookisbn text, date text, id text \) WITH \( OIDS=FALSE \);'|

    -   Mapping tree

        ```
        **
                tns1:ActivityInputType
                    statement = **'CREATE TABLE IF NOT EXISTS public.events ( summary text, description text, &quot;authorName&quot; text, bookisbn text, date text, id&#xA;text ) WITH ( OIDS=FALSE );'
        ```

    -   Source code

        ```
        <?xml version="1.0" encoding="UTF-8"?>
        <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns1="http://www.tibco.com/namespaces/tnt/plugins/jdbc+69412307-fbc4-4b65-8f42-4be7e5febb22+input" version="2.0">
            <xsl:template name="create_table_events-input" match="/">
                <tns1:ActivityInputType>
                    <statement>
                        <xsl:value-of select="'CREATE TABLE IF NOT EXISTS public.events ( summary text, description text, &quot;authorName&quot; text, bookisbn text, date text, id&#xA;text ) WITH ( OIDS=FALSE );'"/>
                    </statement>
                </tns1:ActivityInputType>
            </xsl:template>
        </xsl:stylesheet>
        ```


### Name: ***insert\_into\_books*** {#insert_into_books}

-   Description: *No description*
-   Type: bw.jdbc.SQLDirect
-   JDBC Shared Resource: [jdbcProperty](../../../../../../../Resources/tibco/bwce/sample/binding/rest/BookStore/JDBCConnectionResource.jdbcResource.md)
-   Timeout \(sec\): 10
-   Maximum rows: 100
-   Thread Pool Shared Resource:
-   Override Transaction Behavior: *false*
-   Override JDBC Connection: *false*
-   Input Variable: *insert\_into\_books-input*
-   Output Variable: *insert\_into\_books*
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns1:ActivityInputType****/statement**|"INSERT INTO public.books values\('0071450149', 'The Power to Predict', 'How Real Time Businesses Anticipate Customer Needs, Create Opportunities, and Beat the Competition', 'Vivek Ranadive', '2006/01/26', false, true, 15.90\);INSERT INTO public.books values\('0061122416', 'The Alchemist', 'Every few decades a book is published that changes the lives of its readers forever. The Alchemist is such a book', 'Paul Coelho', '2006/04/25', true, true, 11.90\);"|

    -   Mapping tree

        ```
        **
                tns1:ActivityInputType
                    statement = **&quot;INSERT INTO public.books values('0071450149', 'The Power to Predict', 'How Real Time Businesses Anticipate Customer Needs, Create Opportunities, and Beat the Competition', 'Vivek Ranadive', '2006/01/26', false, true, 15.90);INSERT INTO public.books values('0061122416', 'The Alchemist', 'Every few decades a book is published that changes the lives of its readers forever. The Alchemist is such a book', 'Paul Coelho', '2006/04/25', true, true, 11.90);&quot;
        ```

    -   Source code

        ```
        <?xml version="1.0" encoding="UTF-8"?>
        <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns1="http://www.tibco.com/namespaces/tnt/plugins/jdbc+360b9e74-0243-4ec8-be5f-c63824e82a05+input" version="2.0">
            <xsl:template name="insert_into_books-input" match="/">
                <tns1:ActivityInputType>
                    <statement>
                        <xsl:value-of select="&quot;INSERT INTO public.books values('0071450149', 'The Power to Predict', 'How Real Time Businesses Anticipate Customer Needs, Create Opportunities, and Beat the Competition', 'Vivek Ranadive', '2006/01/26', false, true, 15.90);INSERT INTO public.books values('0061122416', 'The Alchemist', 'Every few decades a book is published that changes the lives of its readers forever. The Alchemist is such a book', 'Paul Coelho', '2006/04/25', true, true, 11.90);&quot;"/>
                    </statement>
                </tns1:ActivityInputType>
            </xsl:template>
        </xsl:stylesheet>
        ```


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
        |**/tns:ActivityInput****/message**|concat\("Caught Another Exception", " ===", $FaultDetails/ActivityName\)|

    -   Mapping tree

        ```
        **tns:ActivityInputmessage = **concat(&quot;Caught Another Exception&quot;, &quot; ===&quot;, $FaultDetails/ActivityName)
        ```

    -   Source code

        ```
        <?xml version="1.0" encoding="UTF-8"?>
        <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/pe/WriteToLogActivitySchema" version="2.0"><xsl:param name="FaultDetails"/><xsl:template name="Log-input" match="/"><tns:ActivityInput><message><xsl:value-of select="concat(&quot;Caught Another Exception&quot;, &quot; ===&quot;, $FaultDetails/ActivityName)"/></message></tns:ActivityInput></xsl:template></xsl:stylesheet>
        ```


## References: {#References}

## Transitions: {#Transitions}

-   From: ***Log*** -To: ***CHANGED***
    -   Label: **
    -   Type: SUCCESS

-   From: ***create\_books\_table*** -To: ***insert\_into\_books***
    -   Label: **
    -   Type: SUCCESS

-   From: ***insert\_into\_books*** -To: ***create\_table\_events***
    -   Label: **
    -   Type: SUCCESS

