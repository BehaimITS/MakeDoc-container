# EventsDB {#ProcessMain .concept}

License for TIBCO Software Use Only!

Section contains description of Process " EventsDB.bwp " .

**Parent topic:**[Processes](../../../../../../../../../../projects/tibco.bwce.sample.binding.rest.BookStore/common/process.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
| |No description|

## Process description: {#ProcessDescription}

|No description|

## Process definition: {#ProcessDefinition}

Full process path: tibco.bwce.sample.binding.rest.bookstore.db.EventsDB

## Diagram: {#Diagram}

![](EventsDB.bwp.png)

## Process starter activity: {#Starter}

### Name: ***OnMessageStart*** {#OnMessageStart}

-   Constructor: onMessageStart
-   xpdlId: b990af01-d575-412f-bf1f-e77e4865b19f

### Name: ***OnMessageStart1*** {#OnMessageStart1}

-   Constructor: onMessageStart
-   xpdlId: 8ab01c75-4b87-453d-b1a7-ea609f1e87ff

### Name: ***OnMessageStart2*** {#OnMessageStart2}

-   Constructor: onMessageStart
-   xpdlId: 1cabb4ef-6ccc-47dd-aefc-57ebf9f0c77d

### Name: ***OnMessageStart3*** {#OnMessageStart3}

-   Constructor: onMessageStart
-   xpdlId: 79fcaa2e-4a51-4978-b3e1-702e117f93cf

### Name: ***OnMessageStart4*** {#OnMessageStart4}

-   Constructor: onMessageStart
-   xpdlId: 75267c35-bf5a-42ac-8a6d-6726c553c284

### Name: ***OnMessageStart5*** {#OnMessageStart5}

-   Constructor: onMessageStart
-   xpdlId: ea40bdb4-4203-44ac-aeb7-0a5b00816a96

## Process end activity: {#EndActivity}

### Name: ***OnMessageEnd*** {#OnMessageEnd}

-   Constructor: onMessageEnd
-   xpdlId: c7a2e13d-b0b7-485d-a786-c21cc1bfddb8

### Name: ***OnMessageEnd1*** {#OnMessageEnd1}

-   Constructor: onMessageEnd
-   xpdlId: 9632ae1c-f95f-4c78-9146-05880dacfe64

### Name: ***OnMessageEnd2*** {#OnMessageEnd2}

-   Constructor: onMessageEnd
-   xpdlId: 62e058f8-540f-49bb-9622-736382260dfc

### Name: ***OnMessageEnd3*** {#OnMessageEnd3}

-   Constructor: onMessageEnd
-   xpdlId: 7f26c1e9-6529-4ca1-bebb-280c473d3483

### Name: ***OnMessageEnd4*** {#OnMessageEnd4}

-   Constructor: onMessageEnd
-   xpdlId: 682b8e41-2ace-4c53-b0cf-20cd02257cf0

### Name: ***OnMessageEnd5*** {#OnMessageEnd5}

-   Constructor: onMessageEnd
-   xpdlId: 05e8037d-2a90-43ce-a745-055e2dd3e412

## Process properties and variables {#ProcessVariables}

|Name|Type|Property Source|Default Value|
|----|----|---------------|-------------|
|\_processContext| | | |
|getAllEvents| | | |
|getAllEventsOut-input| | | |
|addEvents| | | |
|addEventsOut-input| | | |
|getEventByID| | | |
|getEventByIDOut-input| | | |
|updateEvent| | | |
|updateEventOut-input| | | |
|deleteEvent| | | |
|deleteEventOut-input| | | |
|getEventByISBN| | | |
|getEventByISBNOut-input| | | |
|getAllEvents-input| | | |
|getAllEvents1| | | |
|jdbcProperty|xsd:string| |tibco.bwce.sample.binding.rest.BookStore.JDBCConnectionResource|
|addEvents-input| | | |
|addEvents1| | | |
|getEventByID-input| | | |
|getEventByID1| | | |
|updateEvent-input| | | |
|updateEvent1| | | |
|deleteEvent-input| | | |
|deleteEvent1| | | |
|getEventByISBN-input| | | |
|getEventByISBN1| | | |

## Activities: {#Activities}

### Name: ***addEvents*** {#addEvents}

-   Description: *No description*
-   Type: bw.jdbc.update
-   JDBC Shared Resource: [jdbcProperty](../../../../../../../../Resources/tibco/bwce/sample/binding/rest/BookStore/JDBCConnectionResource.jdbcResource.md)
-   Timeout \(sec\): 10
-   Statement: *INSERT INTO "public"."events" \("summary", "description", "authorName", "bookisbn", "date","id"\) VALUES \(?, ?, ?, ?, ?,?\)*
-   Parameters:

    No parameters

-   Thread Pool Shared Resource:
-   Insert if record doesn't exist: *false*
-   Override Transaction Behavior: *false*
-   Interpret Empty String As Null: *false*
-   Results Use Schema: *false*
-   Batch Update: *false*
-   Input Variable: *addEvents-input*
-   Output Variable: *addEvents1*
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:jdbcUpdateActivityInput****/summary***/\[CHOOSE\]**/\[WHEN\] exists\($addEvents/parameters/tns1:Events/tns1:Event\[$index\]/tns1:summary\)*|$addEvents/parameters/tns1:Events/tns1:Event\[$index\]/tns1:summary|
        |**/tns:jdbcUpdateActivityInput****/description***/\[CHOOSE\]**/\[WHEN\] exists\($addEvents/parameters/tns1:Events/tns1:Event\[$index\]/tns1:description\)*|$addEvents/parameters/tns1:Events/tns1:Event\[$index\]/tns1:description|
        |**/tns:jdbcUpdateActivityInput****/authorName***/\[CHOOSE\]**/\[WHEN\] exists\($addEvents/parameters/tns1:Events/tns1:Event\[$index\]/tns1:authorName\)*|$addEvents/parameters/tns1:Events/tns1:Event\[$index\]/tns1:authorName|
        |**/tns:jdbcUpdateActivityInput****/bookisbn***/\[CHOOSE\]**/\[WHEN\] exists\($addEvents/parameters/tns1:Events/tns1:Event\[$index\]/tns1:bookIsbn\)*|$addEvents/parameters/tns1:Events/tns1:Event\[$index\]/tns1:bookIsbn|
        |**/tns:jdbcUpdateActivityInput****/date***/\[CHOOSE\]**/\[WHEN\] exists\($addEvents/parameters/tns1:Events/tns1:Event\[$index\]/tns1:date\)*|$addEvents/parameters/tns1:Events/tns1:Event\[$index\]/tns1:date|
        |**/tns:jdbcUpdateActivityInput****/id***/\[CHOOSE\]**/\[WHEN\] exists\($addEvents/parameters/tns1:Events/tns1:Event\[$index\]/tns1:id\)*|$addEvents/parameters/tns1:Events/tns1:Event\[$index\]/tns1:id|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns:jdbcUpdateActivityInput
		 summary
			xsl:choose
			   xsl:when test="exists\($addEvents/parameters/tns1:Events/tns1:Event\[$index\]/tns1:summary\)" = **$addEvents/parameters/tns1:Events/tns1:Event[$index]/tns1:summary**
			   xsl:otherwise
				  xsl:attribute name="xsi:nil"
		 description
			xsl:choose
			   xsl:when test="exists\($addEvents/parameters/tns1:Events/tns1:Event\[$index\]/tns1:description\)" = **$addEvents/parameters/tns1:Events/tns1:Event[$index]/tns1:description**
			   xsl:otherwise
				  xsl:attribute name="xsi:nil"
		 authorName
			xsl:choose
			   xsl:when test="exists\($addEvents/parameters/tns1:Events/tns1:Event\[$index\]/tns1:authorName\)" = **$addEvents/parameters/tns1:Events/tns1:Event[$index]/tns1:authorName**
			   xsl:otherwise
				  xsl:attribute name="xsi:nil"
		 bookisbn
			xsl:choose
			   xsl:when test="exists\($addEvents/parameters/tns1:Events/tns1:Event\[$index\]/tns1:bookIsbn\)" = **$addEvents/parameters/tns1:Events/tns1:Event[$index]/tns1:bookIsbn**
			   xsl:otherwise
				  xsl:attribute name="xsi:nil"
		 date
			xsl:choose
			   xsl:when test="exists\($addEvents/parameters/tns1:Events/tns1:Event\[$index\]/tns1:date\)" = **$addEvents/parameters/tns1:Events/tns1:Event[$index]/tns1:date**
			   xsl:otherwise
				  xsl:attribute name="xsi:nil"
		 id
			xsl:choose
			   xsl:when test="exists\($addEvents/parameters/tns1:Events/tns1:Event\[$index\]/tns1:id\)" = **$addEvents/parameters/tns1:Events/tns1:Event[$index]/tns1:id
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/namespaces/tnt/plugins/jdbc+783ce8b8-cd03-4639-bd05-ed672b7fadb5+input" xmlns:tns1="http://www.example.org/Events" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0">
   <xsl:param name="index"/>
   <xsl:param name="addEvents"/>
   <xsl:template name="addEvents-input" match="/">
      <tns:jdbcUpdateActivityInput>
         <summary>
            <xsl:choose>
               <xsl:when test="exists($addEvents/parameters/tns1:Events/tns1:Event[$index]/tns1:summary)">
                  <xsl:value-of select="$addEvents/parameters/tns1:Events/tns1:Event[$index]/tns1:summary"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </summary>
         <description>
            <xsl:choose>
               <xsl:when test="exists($addEvents/parameters/tns1:Events/tns1:Event[$index]/tns1:description)">
                  <xsl:value-of select="$addEvents/parameters/tns1:Events/tns1:Event[$index]/tns1:description"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </description>
         <authorName>
            <xsl:choose>
               <xsl:when test="exists($addEvents/parameters/tns1:Events/tns1:Event[$index]/tns1:authorName)">
                  <xsl:value-of select="$addEvents/parameters/tns1:Events/tns1:Event[$index]/tns1:authorName"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </authorName>
         <bookisbn>
            <xsl:choose>
               <xsl:when test="exists($addEvents/parameters/tns1:Events/tns1:Event[$index]/tns1:bookIsbn)">
                  <xsl:value-of select="$addEvents/parameters/tns1:Events/tns1:Event[$index]/tns1:bookIsbn"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </bookisbn>
         <date>
            <xsl:choose>
               <xsl:when test="exists($addEvents/parameters/tns1:Events/tns1:Event[$index]/tns1:date)">
                  <xsl:value-of select="$addEvents/parameters/tns1:Events/tns1:Event[$index]/tns1:date"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </date>
         <id>
            <xsl:choose>
               <xsl:when test="exists($addEvents/parameters/tns1:Events/tns1:Event[$index]/tns1:id)">
                  <xsl:value-of select="$addEvents/parameters/tns1:Events/tns1:Event[$index]/tns1:id"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </id>
      </tns:jdbcUpdateActivityInput>
   </xsl:template>
</xsl:stylesheet>

        ```

|


### Name: ***addEventsOut*** {#addEventsOut}

-   Service: EventsPersist / operation: addEvents
-   ReplyWith: Output Message
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:addEventsResponse****/parameters**|*/\[COPY-OF\] $addEvents/parameters/tns1:Events*|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
** = **
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20141006121028" xmlns:tns1="http://www.example.org/Events" version="2.0">
   <xsl:param name="addEvents"/>
   <xsl:template name="addEventsOut-input" match="/">
      <tns:addEventsResponse>
         <parameters>
            <xsl:copy-of select="$addEvents/parameters/tns1:Events"/>
         </parameters>
      </tns:addEventsResponse>
   </xsl:template>
</xsl:stylesheet>

        ```

|


### Name: ***deleteEvent*** {#deleteEvent}

-   Description: *No description*
-   Type: bw.jdbc.update
-   JDBC Shared Resource: [jdbcProperty](../../../../../../../../Resources/tibco/bwce/sample/binding/rest/BookStore/JDBCConnectionResource.jdbcResource.md)
-   Timeout \(sec\): 10
-   Statement: *DELETE FROM "public"."events" WHERE "id" = ?*
-   Parameters:

    No parameters

-   Thread Pool Shared Resource:
-   Insert if record doesn't exist: *false*
-   Override Transaction Behavior: *false*
-   Interpret Empty String As Null: *false*
-   Results Use Schema: *false*
-   Batch Update: *false*
-   Input Variable: *deleteEvent-input*
-   Output Variable: *deleteEvent1*
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:jdbcUpdateActivityInput****/id**|$deleteEvent/parameters/tns1:deleteEventRequest/EventID|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns:jdbcUpdateActivityInput
		 id = **$deleteEvent/parameters/tns1:deleteEventRequest/EventID
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/namespaces/tnt/plugins/jdbc+e0409135-bc24-4d1e-aeb4-619d5c86bf44+input" xmlns:tns1="http://xmlns.example.com/20141006121028" version="2.0">
   <xsl:param name="deleteEvent"/>
   <xsl:template name="deleteEvent-input" match="/">
      <tns:jdbcUpdateActivityInput>
         <id>
            <xsl:value-of select="$deleteEvent/parameters/tns1:deleteEventRequest/EventID"/>
         </id>
      </tns:jdbcUpdateActivityInput>
   </xsl:template>
</xsl:stylesheet>

        ```

|


### Name: ***deleteEventOut*** {#deleteEventOut}

-   Service: EventsPersist / operation: deleteEvent
-   ReplyWith: Output Message
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:deleteEventResponse****/parameters****/tns:deleteEventResponse****/out**|concat\(" \{ deleted event: ", '"', $deleteEvent/parameters/tns:deleteEventRequest/EventID, '"', " \}"\)|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns:deleteEventResponse
		 parameters
			tns:deleteEventResponse
			   out = **concat(&quot; { deleted event: &quot;, '&quot;', $deleteEvent/parameters/tns:deleteEventRequest/EventID, '&quot;', &quot; }&quot;)
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20141006121028" version="2.0">
   <xsl:param name="deleteEvent"/>
   <xsl:template name="deleteEventOut-input" match="/">
      <tns:deleteEventResponse>
         <parameters>
            <tns:deleteEventResponse>
               <out>
                  <xsl:value-of select="concat(&quot; { deleted event: &quot;, '&quot;', $deleteEvent/parameters/tns:deleteEventRequest/EventID, '&quot;', &quot; }&quot;)"/>
               </out>
            </tns:deleteEventResponse>
         </parameters>
      </tns:deleteEventResponse>
   </xsl:template>
</xsl:stylesheet>

        ```

|


### Name: ***getAllEvents*** {#getAllEvents}

-   Description: *No description*
-   Type: bw.jdbc.JDBCQuery
-   JDBC Shared Resource: [jdbcProperty](../../../../../../../../Resources/tibco/bwce/sample/binding/rest/BookStore/JDBCConnectionResource.jdbcResource.md)
-   Timeout \(sec\): 10
-   Maximum rows: 100
-   Statement: *SELECT \* FROM "public"."events"*
-   Parameters:

    No parameters

-   Thread Pool Shared Resource:
-   Override Transaction Behavior: *false*
-   Override JDBC Connection: *false*
-   Use Nil: *false*
-   Interpret Empty String As Null: *false*
-   Process In Subsets: *false*
-   Input Variable: *getAllEvents-input*
-   Output Variable: *getAllEvents1*
-   *Input bindings:* Incomplete mapping

### Name: ***getAllEventsOut*** {#getAllEventsOut}

-   Service: EventsPersist / operation: getAllEvents
-   ReplyWith: Output Message
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:getAllEventsResponse****/parameters****/tns1:Events***/\[FOR-EACH\] $getAllEvents1/Record***/tns1:Event***/\[IF\] id***/tns1:id**|id|
        |**/tns:getAllEventsResponse****/parameters****/tns1:Events***/\[FOR-EACH\] $getAllEvents1/Record***/tns1:Event***/\[IF\] summary***/tns1:summary**|summary|
        |**/tns:getAllEventsResponse****/parameters****/tns1:Events***/\[FOR-EACH\] $getAllEvents1/Record***/tns1:Event***/\[IF\] description***/tns1:description**|description|
        |**/tns:getAllEventsResponse****/parameters****/tns1:Events***/\[FOR-EACH\] $getAllEvents1/Record***/tns1:Event***/\[IF\] authorName***/tns1:authorName**|authorName|
        |**/tns:getAllEventsResponse****/parameters****/tns1:Events***/\[FOR-EACH\] $getAllEvents1/Record***/tns1:Event***/\[IF\] bookisbn***/tns1:bookIsbn**|bookisbn|
        |**/tns:getAllEventsResponse****/parameters****/tns1:Events***/\[FOR-EACH\] $getAllEvents1/Record***/tns1:Event***/\[IF\] date***/tns1:date**|date|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns:getAllEventsResponse
		 parameters
			tns1:Events
			   xsl:for-each select="$getAllEvents1/Record"
				  tns1:Event
					 xsl:if test="id"
						tns1:id = **id**
					 xsl:if test="summary"
						tns1:summary = **summary**
					 xsl:if test="description"
						tns1:description = **description**
					 xsl:if test="authorName"
						tns1:authorName = **authorName**
					 xsl:if test="bookisbn"
						tns1:bookIsbn = **bookisbn**
					 xsl:if test="date"
						tns1:date = **date
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20141006121028" xmlns:tns1="http://www.example.org/Events" version="2.0">
   <xsl:param name="getAllEvents1"/>
   <xsl:template name="getAllEventsOut-input" match="/">
      <tns:getAllEventsResponse>
         <parameters>
            <tns1:Events>
               <xsl:for-each select="$getAllEvents1/Record">
                  <tns1:Event>
                     <xsl:if test="id">
                        <tns1:id>
                           <xsl:value-of select="id"/>
                        </tns1:id>
                     </xsl:if>
                     <xsl:if test="summary">
                        <tns1:summary>
                           <xsl:value-of select="summary"/>
                        </tns1:summary>
                     </xsl:if>
                     <xsl:if test="description">
                        <tns1:description>
                           <xsl:value-of select="description"/>
                        </tns1:description>
                     </xsl:if>
                     <xsl:if test="authorName">
                        <tns1:authorName>
                           <xsl:value-of select="authorName"/>
                        </tns1:authorName>
                     </xsl:if>
                     <xsl:if test="bookisbn">
                        <tns1:bookIsbn>
                           <xsl:value-of select="bookisbn"/>
                        </tns1:bookIsbn>
                     </xsl:if>
                     <xsl:if test="date">
                        <tns1:date>
                           <xsl:value-of select="date"/>
                        </tns1:date>
                     </xsl:if>
                  </tns1:Event>
               </xsl:for-each>
            </tns1:Events>
         </parameters>
      </tns:getAllEventsResponse>
   </xsl:template>
</xsl:stylesheet>

        ```

|


### Name: ***getEventByID*** {#getEventByID}

-   Description: *No description*
-   Type: bw.jdbc.JDBCQuery
-   JDBC Shared Resource: [jdbcProperty](../../../../../../../../Resources/tibco/bwce/sample/binding/rest/BookStore/JDBCConnectionResource.jdbcResource.md)
-   Timeout \(sec\): 10
-   Maximum rows: 100
-   Statement: *SELECT \* FROM "public"."events" WHERE "id" = ?*
-   Parameters:

    No parameters

-   Thread Pool Shared Resource:
-   Override Transaction Behavior: *false*
-   Override JDBC Connection: *false*
-   Use Nil: *false*
-   Interpret Empty String As Null: *false*
-   Process In Subsets: *false*
-   Input Variable: *getEventByID-input*
-   Output Variable: *getEventByID1*
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:jdbcQueryActivityInput****/id**|$getEventByID/parameters/tns1:getEventByIDRequest/EventID|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns:jdbcQueryActivityInput
		 id = **$getEventByID/parameters/tns1:getEventByIDRequest/EventID
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/namespaces/tnt/plugins/jdbc+14d24a1b-f90a-4069-bb81-e5d3118f28b9+input" xmlns:tns1="http://xmlns.example.com/20141006121028" version="2.0">
   <xsl:param name="getEventByID"/>
   <xsl:template name="getEventByID-input" match="/">
      <tns:jdbcQueryActivityInput>
         <id>
            <xsl:value-of select="$getEventByID/parameters/tns1:getEventByIDRequest/EventID"/>
         </id>
      </tns:jdbcQueryActivityInput>
   </xsl:template>
</xsl:stylesheet>

        ```

|


### Name: ***getEventByIDOut*** {#getEventByIDOut}

-   Service: EventsPersist / operation: getEventByID
-   ReplyWith: Output Message
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:getEventByIDResponse****/parameters***/\[FOR-EACH\] $getEventByID1/Record***/tns1:Event***/\[IF\] id***/tns1:id**|id|
        |**/tns:getEventByIDResponse****/parameters***/\[FOR-EACH\] $getEventByID1/Record***/tns1:Event***/\[IF\] summary***/tns1:summary**|summary|
        |**/tns:getEventByIDResponse****/parameters***/\[FOR-EACH\] $getEventByID1/Record***/tns1:Event***/\[IF\] description***/tns1:description**|description|
        |**/tns:getEventByIDResponse****/parameters***/\[FOR-EACH\] $getEventByID1/Record***/tns1:Event***/\[IF\] authorName***/tns1:authorName**|authorName|
        |**/tns:getEventByIDResponse****/parameters***/\[FOR-EACH\] $getEventByID1/Record***/tns1:Event***/\[IF\] bookisbn***/tns1:bookIsbn**|bookisbn|
        |**/tns:getEventByIDResponse****/parameters***/\[FOR-EACH\] $getEventByID1/Record***/tns1:Event***/\[IF\] date***/tns1:date**|date|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns:getEventByIDResponse
		 parameters
			xsl:for-each select="$getEventByID1/Record"
			   tns1:Event
				  xsl:if test="id"
					 tns1:id = **id**
				  xsl:if test="summary"
					 tns1:summary = **summary**
				  xsl:if test="description"
					 tns1:description = **description**
				  xsl:if test="authorName"
					 tns1:authorName = **authorName**
				  xsl:if test="bookisbn"
					 tns1:bookIsbn = **bookisbn**
				  xsl:if test="date"
					 tns1:date = **date
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20141006121028" xmlns:tns1="http://www.example.org/Events" version="2.0">
   <xsl:param name="getEventByID1"/>
   <xsl:template name="getEventByIDOut-input" match="/">
      <tns:getEventByIDResponse>
         <parameters>
            <xsl:for-each select="$getEventByID1/Record">
               <tns1:Event>
                  <xsl:if test="id">
                     <tns1:id>
                        <xsl:value-of select="id"/>
                     </tns1:id>
                  </xsl:if>
                  <xsl:if test="summary">
                     <tns1:summary>
                        <xsl:value-of select="summary"/>
                     </tns1:summary>
                  </xsl:if>
                  <xsl:if test="description">
                     <tns1:description>
                        <xsl:value-of select="description"/>
                     </tns1:description>
                  </xsl:if>
                  <xsl:if test="authorName">
                     <tns1:authorName>
                        <xsl:value-of select="authorName"/>
                     </tns1:authorName>
                  </xsl:if>
                  <xsl:if test="bookisbn">
                     <tns1:bookIsbn>
                        <xsl:value-of select="bookisbn"/>
                     </tns1:bookIsbn>
                  </xsl:if>
                  <xsl:if test="date">
                     <tns1:date>
                        <xsl:value-of select="date"/>
                     </tns1:date>
                  </xsl:if>
               </tns1:Event>
            </xsl:for-each>
         </parameters>
      </tns:getEventByIDResponse>
   </xsl:template>
</xsl:stylesheet>

        ```

|


### Name: ***getEventByISBN*** {#getEventByISBN}

-   Description: *No description*
-   Type: bw.jdbc.JDBCQuery
-   JDBC Shared Resource: [jdbcProperty](../../../../../../../../Resources/tibco/bwce/sample/binding/rest/BookStore/JDBCConnectionResource.jdbcResource.md)
-   Timeout \(sec\): 10
-   Maximum rows: 100
-   Statement: *SELECT \* FROM "public"."events" WHERE "bookisbn" = ?*
-   Parameters:

    No parameters

-   Thread Pool Shared Resource:
-   Override Transaction Behavior: *false*
-   Override JDBC Connection: *false*
-   Use Nil: *false*
-   Interpret Empty String As Null: *false*
-   Process In Subsets: *false*
-   Input Variable: *getEventByISBN-input*
-   Output Variable: *getEventByISBN1*
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:jdbcQueryActivityInput****/isbn**|$getEventByISBN/parameters/tns1:getEventByISBNRequest/ISBN|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns:jdbcQueryActivityInput
		 isbn = **$getEventByISBN/parameters/tns1:getEventByISBNRequest/ISBN
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/namespaces/tnt/plugins/jdbc+d653b034-be20-4e67-bfa9-214a74b8d945+input" xmlns:tns1="http://xmlns.example.com/20141006121028" version="2.0">
   <xsl:param name="getEventByISBN"/>
   <xsl:template name="getEventByISBN-input" match="/">
      <tns:jdbcQueryActivityInput>
         <isbn>
            <xsl:value-of select="$getEventByISBN/parameters/tns1:getEventByISBNRequest/ISBN"/>
         </isbn>
      </tns:jdbcQueryActivityInput>
   </xsl:template>
</xsl:stylesheet>

        ```

|


### Name: ***getEventByISBNOut*** {#getEventByISBNOut}

-   Service: EventsPersist / operation: getEventByISBN
-   ReplyWith: Output Message
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:getEventByISBNResponse****/parameters****/tns1:Events***/\[FOR-EACH\] $getEventByISBN1/Record***/tns1:Event***/\[IF\] id***/tns1:id**|id|
        |**/tns:getEventByISBNResponse****/parameters****/tns1:Events***/\[FOR-EACH\] $getEventByISBN1/Record***/tns1:Event***/\[IF\] summary***/tns1:summary**|summary|
        |**/tns:getEventByISBNResponse****/parameters****/tns1:Events***/\[FOR-EACH\] $getEventByISBN1/Record***/tns1:Event***/\[IF\] description***/tns1:description**|description|
        |**/tns:getEventByISBNResponse****/parameters****/tns1:Events***/\[FOR-EACH\] $getEventByISBN1/Record***/tns1:Event***/\[IF\] authorName***/tns1:authorName**|authorName|
        |**/tns:getEventByISBNResponse****/parameters****/tns1:Events***/\[FOR-EACH\] $getEventByISBN1/Record***/tns1:Event***/\[IF\] bookisbn***/tns1:bookIsbn**|bookisbn|
        |**/tns:getEventByISBNResponse****/parameters****/tns1:Events***/\[FOR-EACH\] $getEventByISBN1/Record***/tns1:Event***/\[IF\] date***/tns1:date**|date|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns:getEventByISBNResponse
		 parameters
			tns1:Events
			   xsl:for-each select="$getEventByISBN1/Record"
				  tns1:Event
					 xsl:if test="id"
						tns1:id = **id**
					 xsl:if test="summary"
						tns1:summary = **summary**
					 xsl:if test="description"
						tns1:description = **description**
					 xsl:if test="authorName"
						tns1:authorName = **authorName**
					 xsl:if test="bookisbn"
						tns1:bookIsbn = **bookisbn**
					 xsl:if test="date"
						tns1:date = **date
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20141006121028" xmlns:tns1="http://www.example.org/Events" version="2.0">
   <xsl:param name="getEventByISBN1"/>
   <xsl:template name="getEventByISBNOut-input" match="/">
      <tns:getEventByISBNResponse>
         <parameters>
            <tns1:Events>
               <xsl:for-each select="$getEventByISBN1/Record">
                  <tns1:Event>
                     <xsl:if test="id">
                        <tns1:id>
                           <xsl:value-of select="id"/>
                        </tns1:id>
                     </xsl:if>
                     <xsl:if test="summary">
                        <tns1:summary>
                           <xsl:value-of select="summary"/>
                        </tns1:summary>
                     </xsl:if>
                     <xsl:if test="description">
                        <tns1:description>
                           <xsl:value-of select="description"/>
                        </tns1:description>
                     </xsl:if>
                     <xsl:if test="authorName">
                        <tns1:authorName>
                           <xsl:value-of select="authorName"/>
                        </tns1:authorName>
                     </xsl:if>
                     <xsl:if test="bookisbn">
                        <tns1:bookIsbn>
                           <xsl:value-of select="bookisbn"/>
                        </tns1:bookIsbn>
                     </xsl:if>
                     <xsl:if test="date">
                        <tns1:date>
                           <xsl:value-of select="date"/>
                        </tns1:date>
                     </xsl:if>
                  </tns1:Event>
               </xsl:for-each>
            </tns1:Events>
         </parameters>
      </tns:getEventByISBNResponse>
   </xsl:template>
</xsl:stylesheet>

        ```

|


### Name: ***updateEvent*** {#updateEvent}

-   Description: *No description*
-   Type: bw.jdbc.update
-   JDBC Shared Resource: [jdbcProperty](../../../../../../../../Resources/tibco/bwce/sample/binding/rest/BookStore/JDBCConnectionResource.jdbcResource.md)
-   Timeout \(sec\): 10
-   Statement: *UPDATE "public"."events" SET \("summary", "description", "authorName", "bookisbn", "date"\) = \(?, ?, ?, ?, ?\) where "id" = ?*
-   Parameters:

    No parameters

-   Thread Pool Shared Resource:
-   Insert if record doesn't exist: *false*
-   Override Transaction Behavior: *false*
-   Interpret Empty String As Null: *false*
-   Results Use Schema: *false*
-   Batch Update: *false*
-   Input Variable: *updateEvent-input*
-   Output Variable: *updateEvent1*
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:jdbcUpdateActivityInput****/summary***/\[CHOOSE\]**/\[WHEN\] exists\($updateEvent/parameters/tns1:Event/tns1:summary\)*|$updateEvent/parameters/tns1:Event/tns1:summary|
        |**/tns:jdbcUpdateActivityInput****/description***/\[CHOOSE\]**/\[WHEN\] exists\($updateEvent/parameters/tns1:Event/tns1:description\)*|$updateEvent/parameters/tns1:Event/tns1:description|
        |**/tns:jdbcUpdateActivityInput****/authorName***/\[CHOOSE\]**/\[WHEN\] exists\($updateEvent/parameters/tns1:Event/tns1:authorName\)*|$updateEvent/parameters/tns1:Event/tns1:authorName|
        |**/tns:jdbcUpdateActivityInput****/bookisbn***/\[CHOOSE\]**/\[WHEN\] exists\($updateEvent/parameters/tns1:Event/tns1:bookIsbn\)*|$updateEvent/parameters/tns1:Event/tns1:bookIsbn|
        |**/tns:jdbcUpdateActivityInput****/date***/\[CHOOSE\]**/\[WHEN\] exists\($updateEvent/parameters/tns1:Event/tns1:date\)*|$updateEvent/parameters/tns1:Event/tns1:date|
        |**/tns:jdbcUpdateActivityInput****/id***/\[CHOOSE\]**/\[WHEN\] exists\($updateEvent/parameters/tns1:Event/tns1:id\)*|$updateEvent/parameters/tns1:Event/tns1:id|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns:jdbcUpdateActivityInput
		 summary
			xsl:choose
			   xsl:when test="exists\($updateEvent/parameters/tns1:Event/tns1:summary\)" = **$updateEvent/parameters/tns1:Event/tns1:summary**
			   xsl:otherwise
				  xsl:attribute name="xsi:nil"
		 description
			xsl:choose
			   xsl:when test="exists\($updateEvent/parameters/tns1:Event/tns1:description\)" = **$updateEvent/parameters/tns1:Event/tns1:description**
			   xsl:otherwise
				  xsl:attribute name="xsi:nil"
		 authorName
			xsl:choose
			   xsl:when test="exists\($updateEvent/parameters/tns1:Event/tns1:authorName\)" = **$updateEvent/parameters/tns1:Event/tns1:authorName**
			   xsl:otherwise
				  xsl:attribute name="xsi:nil"
		 bookisbn
			xsl:choose
			   xsl:when test="exists\($updateEvent/parameters/tns1:Event/tns1:bookIsbn\)" = **$updateEvent/parameters/tns1:Event/tns1:bookIsbn**
			   xsl:otherwise
				  xsl:attribute name="xsi:nil"
		 date
			xsl:choose
			   xsl:when test="exists\($updateEvent/parameters/tns1:Event/tns1:date\)" = **$updateEvent/parameters/tns1:Event/tns1:date**
			   xsl:otherwise
				  xsl:attribute name="xsi:nil"
		 id
			xsl:choose
			   xsl:when test="exists\($updateEvent/parameters/tns1:Event/tns1:id\)" = **$updateEvent/parameters/tns1:Event/tns1:id
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/namespaces/tnt/plugins/jdbc+3e35c374-0a30-406b-bba2-264e36f8de3f+input" xmlns:tns1="http://www.example.org/Events" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0">
   <xsl:param name="updateEvent"/>
   <xsl:template name="updateEvent-input" match="/">
      <tns:jdbcUpdateActivityInput>
         <summary>
            <xsl:choose>
               <xsl:when test="exists($updateEvent/parameters/tns1:Event/tns1:summary)">
                  <xsl:value-of select="$updateEvent/parameters/tns1:Event/tns1:summary"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </summary>
         <description>
            <xsl:choose>
               <xsl:when test="exists($updateEvent/parameters/tns1:Event/tns1:description)">
                  <xsl:value-of select="$updateEvent/parameters/tns1:Event/tns1:description"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </description>
         <authorName>
            <xsl:choose>
               <xsl:when test="exists($updateEvent/parameters/tns1:Event/tns1:authorName)">
                  <xsl:value-of select="$updateEvent/parameters/tns1:Event/tns1:authorName"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </authorName>
         <bookisbn>
            <xsl:choose>
               <xsl:when test="exists($updateEvent/parameters/tns1:Event/tns1:bookIsbn)">
                  <xsl:value-of select="$updateEvent/parameters/tns1:Event/tns1:bookIsbn"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </bookisbn>
         <date>
            <xsl:choose>
               <xsl:when test="exists($updateEvent/parameters/tns1:Event/tns1:date)">
                  <xsl:value-of select="$updateEvent/parameters/tns1:Event/tns1:date"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </date>
         <id>
            <xsl:choose>
               <xsl:when test="exists($updateEvent/parameters/tns1:Event/tns1:id)">
                  <xsl:value-of select="$updateEvent/parameters/tns1:Event/tns1:id"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </id>
      </tns:jdbcUpdateActivityInput>
   </xsl:template>
</xsl:stylesheet>

        ```

|


### Name: ***updateEventOut*** {#updateEventOut}

-   Service: EventsPersist / operation: updateEvent
-   ReplyWith: Output Message
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:updateEventResponse****/parameters**|*/\[COPY-OF\] $updateEvent/parameters/tns1:Event*|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
** = **
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20141006121028" xmlns:tns1="http://www.example.org/Events" version="2.0">
   <xsl:param name="updateEvent"/>
   <xsl:template name="updateEventOut-input" match="/">
      <tns:updateEventResponse>
         <parameters>
            <xsl:copy-of select="$updateEvent/parameters/tns1:Event"/>
         </parameters>
      </tns:updateEventResponse>
   </xsl:template>
</xsl:stylesheet>

        ```

|


## References: {#References}

## Transitions: {#Transitions}

-   From: ***getAllEvents*** -To: ***getAllEventsOut***
    -   Label: **
    -   Type: SUCCESS

-   From: ***ForEach*** -To: ***addEventsOut***
    -   Label: **
    -   Type: SUCCESS

-   From: ***OnMessageStart1*** -To: ***ForEach***
    -   Label: **
    -   Type: SUCCESS

-   From: ***GroupStart*** -To: ***addEvents***
    -   Label: **
    -   Type: SUCCESS

-   From: ***addEvents*** -To: ***GroupEnd***
    -   Label: **
    -   Type: SUCCESS

-   From: ***getEventByID*** -To: ***getEventByIDOut***
    -   Label: **
    -   Type: SUCCESS

-   From: ***updateEvent*** -To: ***updateEventOut***
    -   Label: **
    -   Type: SUCCESS

-   From: ***deleteEvent*** -To: ***deleteEventOut***
    -   Label: **
    -   Type: SUCCESS

-   From: ***getEventByISBN*** -To: ***getEventByISBNOut***
    -   Label: **
    -   Type: SUCCESS

