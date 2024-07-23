# Events {#ProcessMain .concept}

License for TIBCO Software Use Only!

Section contains description of Process " Events.bwp " .

**Parent topic:**[Processes](../../../../../../../../../projects/tibco.bwce.sample.binding.rest.BookStore/common/process.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
| |No description|

## Process description: {#ProcessDescription}

|No description|

## Process definition: {#ProcessDefinition}

Full process path: tibco.bwce.sample.binding.rest.bookstore.Events

## Diagram: {#Diagram}

![](Events.bwp.png)

## Process starter activity: {#Starter}

### Name: ***OnMessageStart*** {#OnMessageStart}

-   Constructor: onMessageStart
-   xpdlId: 95806ab1-fb08-40b8-b87f-82de33805bbb

### Name: ***OnMessageStart1*** {#OnMessageStart1}

-   Constructor: onMessageStart
-   xpdlId: 70d055d1-fa2f-4c45-96dd-061b8d047c0c

### Name: ***OnMessageStart2*** {#OnMessageStart2}

-   Constructor: onMessageStart
-   xpdlId: bed59b7f-bfa8-45d0-8cca-06d7558324d7

### Name: ***OnMessageStart3*** {#OnMessageStart3}

-   Constructor: onMessageStart
-   xpdlId: 1ad486c4-db53-49a9-98fb-c5376d3c743a

### Name: ***OnMessageStart4*** {#OnMessageStart4}

-   Constructor: onMessageStart
-   xpdlId: f596347d-dddc-4e00-98d0-15e804f7ac0f

## Process end activity: {#EndActivity}

### Name: ***OnMessageEnd*** {#OnMessageEnd}

-   Constructor: onMessageEnd
-   xpdlId: 953ba909-f7be-4c99-9b95-fd1e65b13863

### Name: ***OnMessageEnd1*** {#OnMessageEnd1}

-   Constructor: onMessageEnd
-   xpdlId: f6399dcf-9e68-4e9d-9093-1bc6a1c4435c

### Name: ***OnMessageEnd2*** {#OnMessageEnd2}

-   Constructor: onMessageEnd
-   xpdlId: 51dc75f8-7ad9-4971-9a76-6fb911393670

### Name: ***OnMessageEnd3*** {#OnMessageEnd3}

-   Constructor: onMessageEnd
-   xpdlId: fc10f60e-b149-4e90-97cd-8d25cf3b93dc

### Name: ***OnMessageEnd4*** {#OnMessageEnd4}

-   Constructor: onMessageEnd
-   xpdlId: 3ce4019b-3d51-480b-9bf2-0775a0824022

## Process properties and variables {#NoVariablesDefined}

No variables defined

## Activities: {#Activities}

### Name: ***addEvents*** {#addEvents}

-   Service: Service / operation: addEvents
-   Description:
-   Activity Timeout \(seconds\): Default Timeout
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:addEventsRequest****/parameters**|*/\[COPY-OF\] $post/item/tns1:Events*|

    -   Mapping tree

        ```
        ** = **
        ```

    -   Source code

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20141006121028" xmlns:tns1="http://www.example.org/Events" version="2.0">
           <xsl:param name="post"/>
           <xsl:template name="addEvents-input" match="/">
              <tns:addEventsRequest>
                 <parameters>
                    <xsl:copy-of select="$post/item/tns1:Events"/>
                 </parameters>
              </tns:addEventsRequest>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


### Name: ***deleteEvent*** {#deleteEvent}

-   Service: Service / operation: deleteEvent
-   Description:
-   Activity Timeout \(seconds\): Default Timeout
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:deleteEventRequest****/parameters****/tns:deleteEventRequest****/EventID**|$delete/parameters/tns1:EventParameters/EventID|

    -   Mapping tree

        ```
        **
        	  tns:deleteEventRequest
        		 parameters
        			tns:deleteEventRequest
        			   EventID = **$delete/parameters/tns1:EventParameters/EventID
        ```

    -   Source code

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20141006121028" xmlns:tns1="http://www.example.org/Events/REST/1412583816215/ConceptSchema" version="2.0">
           <xsl:param name="delete"/>
           <xsl:template name="deleteEvent-input" match="/">
              <tns:deleteEventRequest>
                 <parameters>
                    <tns:deleteEventRequest>
                       <EventID>
                          <xsl:value-of select="$delete/parameters/tns1:EventParameters/EventID"/>
                       </EventID>
                    </tns:deleteEventRequest>
                 </parameters>
              </tns:deleteEventRequest>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


### Name: ***deleteOut*** {#deleteOut}

-   Service: Event / operation: delete
-   ReplyWith: Output Message
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:deleteResponse****/msg**|$deleteEvent/parameters/tns1:deleteEventResponse/out|

    -   Mapping tree

        ```
        **
        	  tns:deleteResponse
        		 msg = **$deleteEvent/parameters/tns1:deleteEventResponse/out
        ```

    -   Source code

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.example.org/Events/REST/1412583816215" xmlns:tns1="http://xmlns.example.com/20141006121028" version="2.0">
           <xsl:param name="deleteEvent"/>
           <xsl:template name="deleteOut-input" match="/">
              <tns:deleteResponse>
                 <msg>
                    <xsl:value-of select="$deleteEvent/parameters/tns1:deleteEventResponse/out"/>
                 </msg>
              </tns:deleteResponse>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


### Name: ***getAllEvents*** {#getAllEvents}

-   Service: Service / operation: getAllEvents
-   Description:
-   Activity Timeout \(seconds\): Default Timeout
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:getAllEventsRequest****/parameters****/tns:getAllEventsRequest****/in**|"Get All Events"|

    -   Mapping tree

        ```
        **
        	  tns:getAllEventsRequest
        		 parameters
        			tns:getAllEventsRequest
        			   in = **&quot;Get All Events&quot;
        ```

    -   Source code

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20141006121028" version="2.0">
           <xsl:template name="getAllEvents-input" match="/">
              <tns:getAllEventsRequest>
                 <parameters>
                    <tns:getAllEventsRequest>
                       <in>
                          <xsl:value-of select="&quot;Get All Events&quot;"/>
                       </in>
                    </tns:getAllEventsRequest>
                 </parameters>
              </tns:getAllEventsRequest>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


### Name: ***getEventByID*** {#getEventByID}

-   Service: Service / operation: getEventByID
-   Description:
-   Activity Timeout \(seconds\): Default Timeout
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:getEventByIDRequest****/parameters****/tns:getEventByIDRequest****/EventID**|$get1/parameters/tns1:EventParameters/EventID|

    -   Mapping tree

        ```
        **
        	  tns:getEventByIDRequest
        		 parameters
        			tns:getEventByIDRequest
        			   EventID = **$get1/parameters/tns1:EventParameters/EventID
        ```

    -   Source code

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20141006121028" xmlns:tns1="http://www.example.org/Events/REST/1412583816215/ConceptSchema" version="2.0">
           <xsl:param name="get1"/>
           <xsl:template name="getEventByID-input" match="/">
              <tns:getEventByIDRequest>
                 <parameters>
                    <tns:getEventByIDRequest>
                       <EventID>
                          <xsl:value-of select="$get1/parameters/tns1:EventParameters/EventID"/>
                       </EventID>
                    </tns:getEventByIDRequest>
                 </parameters>
              </tns:getEventByIDRequest>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


### Name: ***getOut*** {#getOut}

-   Service: Events / operation: get
-   ReplyWith: Output Message
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:getResponse****/item**|*/\[COPY-OF\] $getAllEvents/parameters/tns1:Events*|

    -   Mapping tree

        ```
        ** = **
        ```

    -   Source code

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.example.org/Events/REST/1412583816215" xmlns:tns1="http://www.example.org/Events" version="2.0">
           <xsl:param name="getAllEvents"/>
           <xsl:template name="getOut-input" match="/">
              <tns:getResponse>
                 <item>
                    <xsl:copy-of select="$getAllEvents/parameters/tns1:Events"/>
                 </item>
              </tns:getResponse>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


### Name: ***getOut1*** {#getOut1}

-   Service: Event / operation: get
-   ReplyWith: Output Message
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:getResponse1****/item**|*/\[COPY-OF\] $getEventByID/parameters/tns1:Event*|

    -   Mapping tree

        ```
        ** = **
        ```

    -   Source code

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.example.org/Events/REST/1412583816215" xmlns:tns1="http://www.example.org/Events" version="2.0">
           <xsl:param name="getEventByID"/>
           <xsl:template name="getOut1-input" match="/">
              <tns:getResponse1>
                 <item>
                    <xsl:copy-of select="$getEventByID/parameters/tns1:Event"/>
                 </item>
              </tns:getResponse1>
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
        |**/tns:ActivityInput****/msgCode**|"1503"|
        |**/tns:ActivityInput****/message**|concat\($ServiceOp, " failed: ", $FaultDetails/Msg\)|

    -   Mapping tree

        ```
        **
        	  tns:ActivityInput
        		 msgCode = **&quot;1503&quot;**
        		 message = **concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)
        ```

    -   Source code

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/pe/WriteToLogActivitySchema" version="2.0">
           <xsl:param name="ServiceOp"/>
           <xsl:param name="FaultDetails"/>
           <xsl:template name="Log-input" match="/">
              <tns:ActivityInput>
                 <msgCode>
                    <xsl:value-of select="&quot;1503&quot;"/>
                 </msgCode>
                 <message>
                    <xsl:value-of select="concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)"/>
                 </message>
              </tns:ActivityInput>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


### Name: ***Log1*** {#Log1}

-   Description: *No description*
-   Type: bw.generalactivities.log
-   Logger Name:
-   Log level: *Info*
-   Suppress Job Info: *true*
-   Input Variable: *Log1-input*
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:ActivityInput****/msgCode**|"1503"|
        |**/tns:ActivityInput****/message**|concat\($ServiceOp, " failed: ", $FaultDetails/Msg\)|

    -   Mapping tree

        ```
        **
        	  tns:ActivityInput
        		 msgCode = **&quot;1503&quot;**
        		 message = **concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)
        ```

    -   Source code

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/pe/WriteToLogActivitySchema" version="2.0">
           <xsl:param name="ServiceOp"/>
           <xsl:param name="FaultDetails"/>
           <xsl:template name="Log1-input" match="/">
              <tns:ActivityInput>
                 <msgCode>
                    <xsl:value-of select="&quot;1503&quot;"/>
                 </msgCode>
                 <message>
                    <xsl:value-of select="concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)"/>
                 </message>
              </tns:ActivityInput>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


### Name: ***Log2*** {#Log2}

-   Description: *No description*
-   Type: bw.generalactivities.log
-   Logger Name:
-   Log level: *Info*
-   Suppress Job Info: *true*
-   Input Variable: *Log2-input*
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:ActivityInput****/msgCode**|"1503"|
        |**/tns:ActivityInput****/message**|concat\($ServiceOp, " failed: ", $FaultDetails/Msg\)|

    -   Mapping tree

        ```
        **
        	  tns:ActivityInput
        		 msgCode = **&quot;1503&quot;**
        		 message = **concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)
        ```

    -   Source code

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/pe/WriteToLogActivitySchema" version="2.0">
           <xsl:param name="ServiceOp"/>
           <xsl:param name="FaultDetails"/>
           <xsl:template name="Log2-input" match="/">
              <tns:ActivityInput>
                 <msgCode>
                    <xsl:value-of select="&quot;1503&quot;"/>
                 </msgCode>
                 <message>
                    <xsl:value-of select="concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)"/>
                 </message>
              </tns:ActivityInput>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


### Name: ***Log3*** {#Log3}

-   Description: *No description*
-   Type: bw.generalactivities.log
-   Logger Name:
-   Log level: *Info*
-   Suppress Job Info: *true*
-   Input Variable: *Log3-input*
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:ActivityInput****/msgCode**|"1503"|
        |**/tns:ActivityInput****/message**|concat\($ServiceOp, " failed: ", $FaultDetails/Msg\)|

    -   Mapping tree

        ```
        **
        	  tns:ActivityInput
        		 msgCode = **&quot;1503&quot;**
        		 message = **concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)
        ```

    -   Source code

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/pe/WriteToLogActivitySchema" version="2.0">
           <xsl:param name="ServiceOp"/>
           <xsl:param name="FaultDetails"/>
           <xsl:template name="Log3-input" match="/">
              <tns:ActivityInput>
                 <msgCode>
                    <xsl:value-of select="&quot;1503&quot;"/>
                 </msgCode>
                 <message>
                    <xsl:value-of select="concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)"/>
                 </message>
              </tns:ActivityInput>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


### Name: ***Log4*** {#Log4}

-   Description: *No description*
-   Type: bw.generalactivities.log
-   Logger Name:
-   Log level: *Info*
-   Suppress Job Info: *true*
-   Input Variable: *Log4-input*
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:ActivityInput****/msgCode**|"1503"|
        |**/tns:ActivityInput****/message**|concat\($ServiceOp, " failed: ", $FaultDetails/Msg\)|

    -   Mapping tree

        ```
        **
        	  tns:ActivityInput
        		 msgCode = **&quot;1503&quot;**
        		 message = **concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)
        ```

    -   Source code

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/pe/WriteToLogActivitySchema" version="2.0">
           <xsl:param name="ServiceOp"/>
           <xsl:param name="FaultDetails"/>
           <xsl:template name="Log4-input" match="/">
              <tns:ActivityInput>
                 <msgCode>
                    <xsl:value-of select="&quot;1503&quot;"/>
                 </msgCode>
                 <message>
                    <xsl:value-of select="concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)"/>
                 </message>
              </tns:ActivityInput>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


### Name: ***postOut*** {#postOut}

-   Service: Events / operation: post
-   ReplyWith: Output Message
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:postResponse****/item**|*/\[COPY-OF\] $addEvents/parameters/tns1:Events*|

    -   Mapping tree

        ```
        ** = **
        ```

    -   Source code

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.example.org/Events/REST/1412583816215" xmlns:tns1="http://www.example.org/Events" version="2.0">
           <xsl:param name="addEvents"/>
           <xsl:template name="postOut-input" match="/">
              <tns:postResponse>
                 <item>
                    <xsl:copy-of select="$addEvents/parameters/tns1:Events"/>
                 </item>
              </tns:postResponse>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


### Name: ***putOut*** {#putOut}

-   Service: Event / operation: put
-   ReplyWith: Output Message
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:putResponse****/item**|*/\[COPY-OF\] $updateEvent/parameters/tns1:Event*|

    -   Mapping tree

        ```
        ** = **
        ```

    -   Source code

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.example.org/Events/REST/1412583816215" xmlns:tns1="http://www.example.org/Events" version="2.0">
           <xsl:param name="updateEvent"/>
           <xsl:template name="putOut-input" match="/">
              <tns:putResponse>
                 <item>
                    <xsl:copy-of select="$updateEvent/parameters/tns1:Event"/>
                 </item>
              </tns:putResponse>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


### Name: ***Reply*** {#Reply}

-   Service: Events / operation: post
-   ReplyWith:
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:post5XXFaultMessage****/serverError****/tns1:server5XXError****/statusCode**|xsd:integer\(bw:getModuleProperty\("ec\_ServiceUnavailable"\)\)|
        |**/tns:post5XXFaultMessage****/serverError****/tns1:server5XXError****/message**|concat\($ServiceOp, " failed: ", $FaultDetails/Msg\)|

    -   Mapping tree

        ```
        **
        	  tns:post5XXFaultMessage
        		 serverError
        			tns1:server5XXError
        			   statusCode = **xsd:integer(bw:getModuleProperty(&quot;ec_ServiceUnavailable&quot;))**
        			   message = **concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)
        ```

    -   Source code

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.example.org/Events/REST/1412583816215" xmlns:tns1="http://tns.tibco.com/bw/REST" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:bw="http://www.tibco.com/bw/xpath/bw-custom-functions" version="2.0">
           <xsl:param name="ServiceOp"/>
           <xsl:param name="FaultDetails"/>
           <xsl:template name="Reply-input" match="/">
              <tns:post5XXFaultMessage>
                 <serverError>
                    <tns1:server5XXError>
                       <statusCode>
                          <xsl:value-of select="xsd:integer(bw:getModuleProperty(&quot;ec_ServiceUnavailable&quot;))"/>
                       </statusCode>
                       <message>
                          <xsl:value-of select="concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)"/>
                       </message>
                    </tns1:server5XXError>
                 </serverError>
              </tns:post5XXFaultMessage>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


### Name: ***Reply1*** {#Reply1}

-   Service: Events / operation: get
-   ReplyWith:
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:get5XXFaultMessage****/serverError****/tns1:server5XXError****/statusCode**|xsd:integer\(bw:getModuleProperty\("ec\_ServiceUnavailable"\)\)|
        |**/tns:get5XXFaultMessage****/serverError****/tns1:server5XXError****/message**|concat\($ServiceOp, " failed: ", $FaultDetails/Msg\)|

    -   Mapping tree

        ```
        **
        	  tns:get5XXFaultMessage
        		 serverError
        			tns1:server5XXError
        			   statusCode = **xsd:integer(bw:getModuleProperty(&quot;ec_ServiceUnavailable&quot;))**
        			   message = **concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)
        ```

    -   Source code

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.example.org/Events/REST/1412583816215" xmlns:tns1="http://tns.tibco.com/bw/REST" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:bw="http://www.tibco.com/bw/xpath/bw-custom-functions" version="2.0">
           <xsl:param name="ServiceOp"/>
           <xsl:param name="FaultDetails"/>
           <xsl:template name="Reply1-input" match="/">
              <tns:get5XXFaultMessage>
                 <serverError>
                    <tns1:server5XXError>
                       <statusCode>
                          <xsl:value-of select="xsd:integer(bw:getModuleProperty(&quot;ec_ServiceUnavailable&quot;))"/>
                       </statusCode>
                       <message>
                          <xsl:value-of select="concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)"/>
                       </message>
                    </tns1:server5XXError>
                 </serverError>
              </tns:get5XXFaultMessage>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


### Name: ***Reply2*** {#Reply2}

-   Service: Event / operation: get
-   ReplyWith:
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:get5XXFaultMessage1****/serverError****/tns1:server5XXError****/statusCode**|xsd:integer\(bw:getModuleProperty\("ec\_ServiceUnavailable"\)\)|
        |**/tns:get5XXFaultMessage1****/serverError****/tns1:server5XXError****/message**|concat\($ServiceOp, " failed: ", $FaultDetails/Msg\)|

    -   Mapping tree

        ```
        **
        	  tns:get5XXFaultMessage1
        		 serverError
        			tns1:server5XXError
        			   statusCode = **xsd:integer(bw:getModuleProperty(&quot;ec_ServiceUnavailable&quot;))**
        			   message = **concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)
        ```

    -   Source code

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.example.org/Events/REST/1412583816215" xmlns:tns1="http://tns.tibco.com/bw/REST" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:bw="http://www.tibco.com/bw/xpath/bw-custom-functions" version="2.0">
           <xsl:param name="ServiceOp"/>
           <xsl:param name="FaultDetails"/>
           <xsl:template name="Reply2-input" match="/">
              <tns:get5XXFaultMessage1>
                 <serverError>
                    <tns1:server5XXError>
                       <statusCode>
                          <xsl:value-of select="xsd:integer(bw:getModuleProperty(&quot;ec_ServiceUnavailable&quot;))"/>
                       </statusCode>
                       <message>
                          <xsl:value-of select="concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)"/>
                       </message>
                    </tns1:server5XXError>
                 </serverError>
              </tns:get5XXFaultMessage1>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


### Name: ***Reply3*** {#Reply3}

-   Service: Event / operation: put
-   ReplyWith:
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:put5XXFaultMessage****/serverError****/tns1:server5XXError****/statusCode**|xsd:integer\(bw:getModuleProperty\("ec\_ServiceUnavailable"\)\)|
        |**/tns:put5XXFaultMessage****/serverError****/tns1:server5XXError****/message**|concat\($ServiceOp, " failed: ", $FaultDetails/Msg\)|

    -   Mapping tree

        ```
        **
        	  tns:put5XXFaultMessage
        		 serverError
        			tns1:server5XXError
        			   statusCode = **xsd:integer(bw:getModuleProperty(&quot;ec_ServiceUnavailable&quot;))**
        			   message = **concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)
        ```

    -   Source code

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.example.org/Events/REST/1412583816215" xmlns:tns1="http://tns.tibco.com/bw/REST" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:bw="http://www.tibco.com/bw/xpath/bw-custom-functions" version="2.0">
           <xsl:param name="ServiceOp"/>
           <xsl:param name="FaultDetails"/>
           <xsl:template name="Reply3-input" match="/">
              <tns:put5XXFaultMessage>
                 <serverError>
                    <tns1:server5XXError>
                       <statusCode>
                          <xsl:value-of select="xsd:integer(bw:getModuleProperty(&quot;ec_ServiceUnavailable&quot;))"/>
                       </statusCode>
                       <message>
                          <xsl:value-of select="concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)"/>
                       </message>
                    </tns1:server5XXError>
                 </serverError>
              </tns:put5XXFaultMessage>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


### Name: ***Reply4*** {#Reply4}

-   Service: Event / operation: delete
-   ReplyWith:
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:delete5XXFaultMessage****/serverError****/tns1:server5XXError****/statusCode**|xsd:integer\(bw:getModuleProperty\("ec\_ServiceUnavailable"\)\)|
        |**/tns:delete5XXFaultMessage****/serverError****/tns1:server5XXError****/message**|concat\($ServiceOp, " failed: ", $FaultDetails/Msg\)|

    -   Mapping tree

        ```
        **
        	  tns:delete5XXFaultMessage
        		 serverError
        			tns1:server5XXError
        			   statusCode = **xsd:integer(bw:getModuleProperty(&quot;ec_ServiceUnavailable&quot;))**
        			   message = **concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)
        ```

    -   Source code

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.example.org/Events/REST/1412583816215" xmlns:tns1="http://tns.tibco.com/bw/REST" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:bw="http://www.tibco.com/bw/xpath/bw-custom-functions" version="2.0">
           <xsl:param name="ServiceOp"/>
           <xsl:param name="FaultDetails"/>
           <xsl:template name="Reply4-input" match="/">
              <tns:delete5XXFaultMessage>
                 <serverError>
                    <tns1:server5XXError>
                       <statusCode>
                          <xsl:value-of select="xsd:integer(bw:getModuleProperty(&quot;ec_ServiceUnavailable&quot;))"/>
                       </statusCode>
                       <message>
                          <xsl:value-of select="concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)"/>
                       </message>
                    </tns1:server5XXError>
                 </serverError>
              </tns:delete5XXFaultMessage>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


### Name: ***updateEvent*** {#updateEvent}

-   Service: Service / operation: updateEvent
-   Description:
-   Activity Timeout \(seconds\): Default Timeout
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:updateEventRequest****/parameters****/tns2:Event****/tns2:id**|$put/parameters/tns1:EventParameters/EventID|
        |**/tns:updateEventRequest****/parameters****/tns2:Event***/\[IF\] $put/item/tns2:Event/tns2:summary***/tns2:summary**|$put/item/tns2:Event/tns2:summary|
        |**/tns:updateEventRequest****/parameters****/tns2:Event***/\[IF\] $put/item/tns2:Event/tns2:description***/tns2:description**|$put/item/tns2:Event/tns2:description|
        |**/tns:updateEventRequest****/parameters****/tns2:Event***/\[IF\] $put/item/tns2:Event/tns2:authorName***/tns2:authorName**|$put/item/tns2:Event/tns2:authorName|
        |**/tns:updateEventRequest****/parameters****/tns2:Event***/\[IF\] $put/item/tns2:Event/tns2:bookIsbn***/tns2:bookIsbn**|$put/item/tns2:Event/tns2:bookIsbn|
        |**/tns:updateEventRequest****/parameters****/tns2:Event***/\[IF\] $put/item/tns2:Event/tns2:date***/tns2:date**|$put/item/tns2:Event/tns2:date|

    -   Mapping tree

        ```
        **
        	  tns:updateEventRequest
        		 parameters
        			tns2:Event
        			   tns2:id = **$put/parameters/tns1:EventParameters/EventID**
        			   xsl:if test="$put/item/tns2:Event/tns2:summary"
        				  tns2:summary = **$put/item/tns2:Event/tns2:summary**
        			   xsl:if test="$put/item/tns2:Event/tns2:description"
        				  tns2:description = **$put/item/tns2:Event/tns2:description**
        			   xsl:if test="$put/item/tns2:Event/tns2:authorName"
        				  tns2:authorName = **$put/item/tns2:Event/tns2:authorName**
        			   xsl:if test="$put/item/tns2:Event/tns2:bookIsbn"
        				  tns2:bookIsbn = **$put/item/tns2:Event/tns2:bookIsbn**
        			   xsl:if test="$put/item/tns2:Event/tns2:date"
        				  tns2:date = **$put/item/tns2:Event/tns2:date
        ```

    -   Source code

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20141006121028" xmlns:tns1="http://www.example.org/Events/REST/1412583816215/ConceptSchema" xmlns:tns2="http://www.example.org/Events" version="2.0">
           <xsl:param name="put"/>
           <xsl:template name="updateEvent-input" match="/">
              <tns:updateEventRequest>
                 <parameters>
                    <tns2:Event>
                       <tns2:id>
                          <xsl:value-of select="$put/parameters/tns1:EventParameters/EventID"/>
                       </tns2:id>
                       <xsl:if test="$put/item/tns2:Event/tns2:summary">
                          <tns2:summary>
                             <xsl:value-of select="$put/item/tns2:Event/tns2:summary"/>
                          </tns2:summary>
                       </xsl:if>
                       <xsl:if test="$put/item/tns2:Event/tns2:description">
                          <tns2:description>
                             <xsl:value-of select="$put/item/tns2:Event/tns2:description"/>
                          </tns2:description>
                       </xsl:if>
                       <xsl:if test="$put/item/tns2:Event/tns2:authorName">
                          <tns2:authorName>
                             <xsl:value-of select="$put/item/tns2:Event/tns2:authorName"/>
                          </tns2:authorName>
                       </xsl:if>
                       <xsl:if test="$put/item/tns2:Event/tns2:bookIsbn">
                          <tns2:bookIsbn>
                             <xsl:value-of select="$put/item/tns2:Event/tns2:bookIsbn"/>
                          </tns2:bookIsbn>
                       </xsl:if>
                       <xsl:if test="$put/item/tns2:Event/tns2:date">
                          <tns2:date>
                             <xsl:value-of select="$put/item/tns2:Event/tns2:date"/>
                          </tns2:date>
                       </xsl:if>
                    </tns2:Event>
                 </parameters>
              </tns:updateEventRequest>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


## References: {#References}

### Name: ***Service*** {#Service}

-   partnerLinkType: ns:ServicePLT
-   partnerRole: use
-   sca-bpel:ignore: true
-   sca-bpel:reference: Service
-   sca-bpel:wiredByImpl: false
-   dynamic: false
-   inline: false
-   processName: tibco.bwce.sample.binding.rest.bookstore.db.EventsDB
-   serviceName: EventsPersist

## Transitions: {#Transitions}

-   From: ***Log*** -To: ***Reply***
    -   Label: **
    -   Type: SUCCESS

-   From: ***addEvents*** -To: ***postOut***
    -   Label: **
    -   Type: SUCCESS

-   From: ***Log1*** -To: ***Reply1***
    -   Label: **
    -   Type: SUCCESS

-   From: ***getAllEvents*** -To: ***getOut***
    -   Label: **
    -   Type: SUCCESS

-   From: ***Log2*** -To: ***Reply2***
    -   Label: **
    -   Type: SUCCESS

-   From: ***getEventByID*** -To: ***getOut1***
    -   Label: **
    -   Type: SUCCESS

-   From: ***Log3*** -To: ***Reply3***
    -   Label: **
    -   Type: SUCCESS

-   From: ***updateEvent*** -To: ***putOut***
    -   Label: **
    -   Type: SUCCESS

-   From: ***Log4*** -To: ***Reply4***
    -   Label: **
    -   Type: SUCCESS

-   From: ***deleteEvent*** -To: ***deleteOut***
    -   Label: **
    -   Type: SUCCESS

