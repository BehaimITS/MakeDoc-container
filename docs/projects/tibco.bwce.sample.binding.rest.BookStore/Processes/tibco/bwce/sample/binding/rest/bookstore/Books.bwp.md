# Books {#ProcessMain .concept}

License for TIBCO Software Use Only!

Section contains description of Process " Books.bwp " .

**Parent topic:**[Processes](../../../../../../../../../projects/tibco.bwce.sample.binding.rest.BookStore/common/process.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
| |No description|

## Process description: {#ProcessDescription}

|No description|

## Process definition: {#ProcessDefinition}

Full process path: tibco.bwce.sample.binding.rest.bookstore.Books

## Diagram: {#Diagram}

![](Books.bwp.png)

## Process starter activity: {#Starter}

### Name: ***OnMessageStart*** {#OnMessageStart}

-   Constructor: onMessageStart
-   xpdlId: c7ff3d8c-f94d-4eb8-8ae5-fd1690826565

### Name: ***OnMessageStart1*** {#OnMessageStart1}

-   Constructor: onMessageStart
-   xpdlId: 3bd1c454-1759-439b-bdf9-3e2577f54c12

### Name: ***OnMessageStart2*** {#OnMessageStart2}

-   Constructor: onMessageStart
-   xpdlId: 582319c7-4f27-4d54-940f-b32c9c04924e

### Name: ***OnMessageStart3*** {#OnMessageStart3}

-   Constructor: onMessageStart
-   xpdlId: c8fb5497-94b3-45b4-b2f8-ec017c7f04fd

### Name: ***OnMessageStart4*** {#OnMessageStart4}

-   Constructor: onMessageStart
-   xpdlId: a85cce64-e7a5-4be8-97b4-380e5981efaf

### Name: ***OnMessageStart5*** {#OnMessageStart5}

-   Constructor: onMessageStart
-   xpdlId: c37a4743-2641-4e68-99d2-9499d966775b

## Process end activity: {#EndActivity}

### Name: ***OnMessageEnd*** {#OnMessageEnd}

-   Constructor: onMessageEnd
-   xpdlId: 7a06679f-2a12-468e-86fc-bdf1ead928fb

### Name: ***OnMessageEnd1*** {#OnMessageEnd1}

-   Constructor: onMessageEnd
-   xpdlId: a26d8c83-dab0-4728-84c1-6a98090f0139

### Name: ***OnMessageEnd2*** {#OnMessageEnd2}

-   Constructor: onMessageEnd
-   xpdlId: 2397cb0c-106b-4184-a2a6-da8b2ee1cc64

### Name: ***OnMessageEnd3*** {#OnMessageEnd3}

-   Constructor: onMessageEnd
-   xpdlId: 23f9a069-64bb-4b69-b03f-4f5d6a295350

### Name: ***OnMessageEnd4*** {#OnMessageEnd4}

-   Constructor: onMessageEnd
-   xpdlId: d33059f0-b8ba-487e-a885-eea6c49cfb5f

### Name: ***OnMessageEnd5*** {#OnMessageEnd5}

-   Constructor: onMessageEnd
-   xpdlId: 5ac75116-38e4-4c78-9b48-c4d6fa2bf136

## Process properties and variables {#NoVariablesDefined}

No variables defined

## Activities: {#Activities}

### Name: ***addBooks*** {#addBooks}

-   Service: Service / operation: addBooks
-   Description:
-   Activity Timeout \(seconds\): Default Timeout
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:addBooksRequest****/parameters****/tns:addBooksRequest**|*/\[COPY-OF\] $post/item/tns1:Books/tns1:Book*|

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
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20140929140236" xmlns:tns1="http://www.example.org/Books" version="2.0">
   <xsl:param name="post"/>
   <xsl:template name="addBooks-input" match="/">
      <tns:addBooksRequest>
         <parameters>
            <tns:addBooksRequest>
               <xsl:copy-of select="$post/item/tns1:Books/tns1:Book"/>
            </tns:addBooksRequest>
         </parameters>
      </tns:addBooksRequest>
   </xsl:template>
</xsl:stylesheet>

        ```

|


### Name: ***deleteBook*** {#deleteBook}

-   Service: Service / operation: deleteBook
-   Description:
-   Activity Timeout \(seconds\): Default Timeout
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:deleteBookRequest****/parameters****/tns:deleteBookRequest****/ISBN**|$delete/parameters/tns1:BookParameters/ISBN|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns:deleteBookRequest
		 parameters
			tns:deleteBookRequest
			   ISBN = **$delete/parameters/tns1:BookParameters/ISBN
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20140929140236" xmlns:tns1="http://www.example.org/Books/REST/1411989492608/ConceptSchema" version="2.0">
   <xsl:param name="delete"/>
   <xsl:template name="deleteBook-input" match="/">
      <tns:deleteBookRequest>
         <parameters>
            <tns:deleteBookRequest>
               <ISBN>
                  <xsl:value-of select="$delete/parameters/tns1:BookParameters/ISBN"/>
               </ISBN>
            </tns:deleteBookRequest>
         </parameters>
      </tns:deleteBookRequest>
   </xsl:template>
</xsl:stylesheet>

        ```

|


### Name: ***deleteOut*** {#deleteOut}

-   Service: Book / operation: delete
-   ReplyWith: Output Message
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:deleteResponse****/msg**|$deleteBook/parameters/tns1:deleteBookResponse/out|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns:deleteResponse
		 msg = **$deleteBook/parameters/tns1:deleteBookResponse/out
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.example.org/Books/REST/1411989492608" xmlns:tns1="http://xmlns.example.com/20140929140236" version="2.0">
   <xsl:param name="deleteBook"/>
   <xsl:template name="deleteOut-input" match="/">
      <tns:deleteResponse>
         <msg>
            <xsl:value-of select="$deleteBook/parameters/tns1:deleteBookResponse/out"/>
         </msg>
      </tns:deleteResponse>
   </xsl:template>
</xsl:stylesheet>

        ```

|


### Name: ***getAllBooks*** {#getAllBooks}

-   Service: Service / operation: getAllBooks
-   Description:
-   Activity Timeout \(seconds\): Default Timeout
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:getAllBooksRequest****/parameters****/tns:getAllBooksRequest****/in**|"Get All Books"|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns:getAllBooksRequest
		 parameters
			tns:getAllBooksRequest
			   in = **&quot;Get All Books&quot;
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20140929140236" version="2.0">
   <xsl:template name="getAllBooks-input" match="/">
      <tns:getAllBooksRequest>
         <parameters>
            <tns:getAllBooksRequest>
               <in>
                  <xsl:value-of select="&quot;Get All Books&quot;"/>
               </in>
            </tns:getAllBooksRequest>
         </parameters>
      </tns:getAllBooksRequest>
   </xsl:template>
</xsl:stylesheet>

        ```

|


### Name: ***getBookByISBN*** {#getBookByISBN}

-   Service: Service / operation: getBookByISBN
-   Description:
-   Activity Timeout \(seconds\): Default Timeout
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:getBookByISBNRequest****/parameters****/tns:getBookByISBNRequest****/ISBN**|$get1/parameters/tns1:BookParameters/ISBN|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns:getBookByISBNRequest
		 parameters
			tns:getBookByISBNRequest
			   ISBN = **$get1/parameters/tns1:BookParameters/ISBN
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20140929140236" xmlns:tns1="http://www.example.org/Books/REST/1411989492608/ConceptSchema" version="2.0">
   <xsl:param name="get1"/>
   <xsl:template name="getBookByISBN-input" match="/">
      <tns:getBookByISBNRequest>
         <parameters>
            <tns:getBookByISBNRequest>
               <ISBN>
                  <xsl:value-of select="$get1/parameters/tns1:BookParameters/ISBN"/>
               </ISBN>
            </tns:getBookByISBNRequest>
         </parameters>
      </tns:getBookByISBNRequest>
   </xsl:template>
</xsl:stylesheet>

        ```

|


### Name: ***getEventByISBN*** {#getEventByISBN}

-   Service: Service1 / operation: getEventByISBN
-   Description:
-   Activity Timeout \(seconds\): Default Timeout
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:getEventByISBNRequest****/parameters****/tns:getEventByISBNRequest****/ISBN**|$get2/parameters/tns1:Book1Parameters/ISBN|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns:getEventByISBNRequest
		 parameters
			tns:getEventByISBNRequest
			   ISBN = **$get2/parameters/tns1:Book1Parameters/ISBN
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20141006121028" xmlns:tns1="http://www.example.org/Books/REST/1411989492608/ConceptSchema" version="2.0">
   <xsl:param name="get2"/>
   <xsl:template name="getEventByISBN-input" match="/">
      <tns:getEventByISBNRequest>
         <parameters>
            <tns:getEventByISBNRequest>
               <ISBN>
                  <xsl:value-of select="$get2/parameters/tns1:Book1Parameters/ISBN"/>
               </ISBN>
            </tns:getEventByISBNRequest>
         </parameters>
      </tns:getEventByISBNRequest>
   </xsl:template>
</xsl:stylesheet>

        ```

|


### Name: ***getOut*** {#getOut}

-   Service: Books / operation: get
-   ReplyWith: Output Message
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:getResponse****/item**|*/\[COPY-OF\] $getAllBooks/parameters/tns1:Books*|

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
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.example.org/Books/REST/1411989492608" xmlns:tns1="http://www.example.org/Books" version="2.0">
   <xsl:param name="getAllBooks"/>
   <xsl:template name="getOut-input" match="/">
      <tns:getResponse>
         <item>
            <xsl:copy-of select="$getAllBooks/parameters/tns1:Books"/>
         </item>
      </tns:getResponse>
   </xsl:template>
</xsl:stylesheet>

        ```

|


### Name: ***getOut1*** {#getOut1}

-   Service: Book / operation: get
-   ReplyWith: Output Message
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:getResponse1****/item**|*/\[COPY-OF\] $getBookByISBN/parameters/tns1:Book*|

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
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.example.org/Books/REST/1411989492608" xmlns:tns1="http://www.example.org/Books" version="2.0">
   <xsl:param name="getBookByISBN"/>
   <xsl:template name="getOut1-input" match="/">
      <tns:getResponse1>
         <item>
            <xsl:copy-of select="$getBookByISBN/parameters/tns1:Book"/>
         </item>
      </tns:getResponse1>
   </xsl:template>
</xsl:stylesheet>

        ```

|


### Name: ***getOut2*** {#getOut2}

-   Service: Book1 / operation: get
-   ReplyWith: Output Message
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:getResponse2****/item**|*/\[COPY-OF\] $getEventByISBN/parameters/tns2:Events*|

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
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.example.org/Books/REST/1411989492608" xmlns:tns1="http://www.example.org/Books/REST/1411989492608/ConceptSchema" xmlns:tns2="http://www.example.org/Events" version="2.0">
   <xsl:param name="getEventByISBN"/>
   <xsl:template name="getOut2-input" match="/">
      <tns:getResponse2>
         <item>
            <xsl:copy-of select="$getEventByISBN/parameters/tns2:Events"/>
         </item>
      </tns:getResponse2>
   </xsl:template>
</xsl:stylesheet>

        ```

|


### Name: ***Log*** {#Log_fc115440-6d6b-4e26-b2ad-980b8483a5a5}

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

        |Mapping|
        |-------|
        |        ```
**
	  tns:ActivityInput
		 msgCode = **&quot;1503&quot;**
		 message = **concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/pe/WriteToLogActivitySchema" version="2.0">
   <xsl:param name="FaultDetails"/>
   <xsl:param name="ServiceOp"/>
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

|


### Name: ***Log1*** {#Log1_d3c40cda-9353-4550-973b-4737251b1a61}

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

        |Mapping|
        |-------|
        |        ```
**
	  tns:ActivityInput
		 msgCode = **&quot;1503&quot;**
		 message = **concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/pe/WriteToLogActivitySchema" version="2.0">
   <xsl:param name="FaultDetails"/>
   <xsl:param name="ServiceOp"/>
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

|


### Name: ***Log2*** {#Log2_b5867d78-38f6-4282-acb3-e9feaeba7121}

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

        |Mapping|
        |-------|
        |        ```
**
	  tns:ActivityInput
		 msgCode = **&quot;1503&quot;**
		 message = **concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/pe/WriteToLogActivitySchema" version="2.0">
   <xsl:param name="FaultDetails"/>
   <xsl:param name="ServiceOp"/>
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

|


### Name: ***Log3*** {#Log3_a83c7a3e-ec1c-408e-b870-c856996bcda3}

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

        |Mapping|
        |-------|
        |        ```
**
	  tns:ActivityInput
		 msgCode = **&quot;1503&quot;**
		 message = **concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
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

|


### Name: ***Log4*** {#Log4_c9fb2654-b4cf-4413-b56b-3e88b8fc9655}

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

        |Mapping|
        |-------|
        |        ```
**
	  tns:ActivityInput
		 msgCode = **&quot;1503&quot;**
		 message = **concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
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

|


### Name: ***Log5*** {#Log5_6626a3cd-beef-467e-9372-0f26e3ee91a6}

-   Description: *No description*
-   Type: bw.generalactivities.log
-   Logger Name:
-   Log level: *Info*
-   Suppress Job Info: *true*
-   Input Variable: *Log5-input*
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:ActivityInput****/msgCode**|"1503"|
        |**/tns:ActivityInput****/message**|concat\($ServiceOp, " failed: ", $FaultDetails/Msg\)|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns:ActivityInput
		 msgCode = **&quot;1503&quot;**
		 message = **concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/pe/WriteToLogActivitySchema" version="2.0">
   <xsl:param name="ServiceOp"/>
   <xsl:param name="FaultDetails"/>
   <xsl:template name="Log5-input" match="/">
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

|


### Name: ***postOut*** {#postOut}

-   Service: Books / operation: post
-   ReplyWith: Output Message
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:postResponse****/item**|*/\[COPY-OF\] $addBooks/parameters/tns1:Books*|

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
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.example.org/Books/REST/1411989492608" xmlns:tns1="http://www.example.org/Books" version="2.0">
   <xsl:param name="addBooks"/>
   <xsl:template name="postOut-input" match="/">
      <tns:postResponse>
         <item>
            <xsl:copy-of select="$addBooks/parameters/tns1:Books"/>
         </item>
      </tns:postResponse>
   </xsl:template>
</xsl:stylesheet>

        ```

|


### Name: ***putOut*** {#putOut}

-   Service: Book / operation: put
-   ReplyWith: Output Message
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:putResponse****/item**|*/\[COPY-OF\] $updateBook/parameters/tns1:Book*|

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
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.example.org/Books/REST/1411989492608" xmlns:tns1="http://www.example.org/Books" version="2.0">
   <xsl:param name="updateBook"/>
   <xsl:template name="putOut-input" match="/">
      <tns:putResponse>
         <item>
            <xsl:copy-of select="$updateBook/parameters/tns1:Book"/>
         </item>
      </tns:putResponse>
   </xsl:template>
</xsl:stylesheet>

        ```

|


### Name: ***Reply*** {#Reply}

-   Service: Books / operation: post
-   ReplyWith:
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:post5XXFaultMessage****/serverError****/tns1:server5XXError****/statusCode**|xsd:integer\(bw:getModuleProperty\("ec\_ServiceUnavailable"\)\)|
        |**/tns:post5XXFaultMessage****/serverError****/tns1:server5XXError****/message**|concat\($ServiceOp, $FaultDetails/Msg\)|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns:post5XXFaultMessage
		 serverError
			tns1:server5XXError
			   statusCode = **xsd:integer(bw:getModuleProperty(&quot;ec_ServiceUnavailable&quot;))**
			   message = **concat($ServiceOp, $FaultDetails/Msg)
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.example.org/Books/REST/1411989492608" xmlns:tns1="http://tns.tibco.com/bw/REST" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:bw="http://www.tibco.com/bw/xpath/bw-custom-functions" version="2.0">
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
                  <xsl:value-of select="concat($ServiceOp, $FaultDetails/Msg)"/>
               </message>
            </tns1:server5XXError>
         </serverError>
      </tns:post5XXFaultMessage>
   </xsl:template>
</xsl:stylesheet>

        ```

|


### Name: ***Reply1*** {#Reply1}

-   Service: Books / operation: get
-   ReplyWith:
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:get5XXFaultMessage****/serverError****/tns1:server5XXError****/statusCode**|xsd:integer\(bw:getModuleProperty\("ec\_ServiceUnavailable"\)\)|
        |**/tns:get5XXFaultMessage****/serverError****/tns1:server5XXError****/message**|concat\($ServiceOp, " failed: ", $FaultDetails/Msg\)|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns:get5XXFaultMessage
		 serverError
			tns1:server5XXError
			   statusCode = **xsd:integer(bw:getModuleProperty(&quot;ec_ServiceUnavailable&quot;))**
			   message = **concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.example.org/Books/REST/1411989492608" xmlns:tns1="http://tns.tibco.com/bw/REST" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:bw="http://www.tibco.com/bw/xpath/bw-custom-functions" version="2.0">
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

|


### Name: ***Reply2*** {#Reply2}

-   Service: Book / operation: get
-   ReplyWith:
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:post5XXFaultMessage****/serverError****/tns1:server5XXError****/statusCode**|xsd:integer\(bw:getModuleProperty\("ec\_ServiceUnavailable"\)\)|
        |**/tns:post5XXFaultMessage****/serverError****/tns1:server5XXError****/message**|concat\($ServiceOp, " failed: ", $FaultDetails/Msg\)|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns:post5XXFaultMessage
		 serverError
			tns1:server5XXError
			   statusCode = **xsd:integer(bw:getModuleProperty(&quot;ec_ServiceUnavailable&quot;))**
			   message = **concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.example.org/Books/REST/1411989492608" xmlns:tns1="http://tns.tibco.com/bw/REST" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:bw="http://www.tibco.com/bw/xpath/bw-custom-functions" version="2.0">
   <xsl:param name="FaultDetails"/>
   <xsl:param name="ServiceOp"/>
   <xsl:template name="Reply2-input" match="/">
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

|


### Name: ***Reply3*** {#Reply3}

-   Service: Book / operation: put
-   ReplyWith:
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:put5XXFaultMessage****/serverError****/tns1:server5XXError****/statusCode**|xsd:integer\(bw:getModuleProperty\("ec\_ServiceUnavailable"\)\)|
        |**/tns:put5XXFaultMessage****/serverError****/tns1:server5XXError****/message**|concat\($ServiceOp, " failed: ", $FaultDetails/Msg\)|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns:put5XXFaultMessage
		 serverError
			tns1:server5XXError
			   statusCode = **xsd:integer(bw:getModuleProperty(&quot;ec_ServiceUnavailable&quot;))**
			   message = **concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.example.org/Books/REST/1411989492608" xmlns:tns1="http://tns.tibco.com/bw/REST" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:bw="http://www.tibco.com/bw/xpath/bw-custom-functions" version="2.0">
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

|


### Name: ***Reply4*** {#Reply4}

-   Service: Book / operation: delete
-   ReplyWith:
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:delete5XXFaultMessage****/serverError****/tns1:server5XXError****/statusCode**|xsd:integer\(bw:getModuleProperty\("ec\_ServiceUnavailable"\)\)|
        |**/tns:delete5XXFaultMessage****/serverError****/tns1:server5XXError****/message**|concat\($ServiceOp, " failed: ", $FaultDetails/Msg\)|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns:delete5XXFaultMessage
		 serverError
			tns1:server5XXError
			   statusCode = **xsd:integer(bw:getModuleProperty(&quot;ec_ServiceUnavailable&quot;))**
			   message = **concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.example.org/Books/REST/1411989492608" xmlns:tns1="http://tns.tibco.com/bw/REST" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:bw="http://www.tibco.com/bw/xpath/bw-custom-functions" version="2.0">
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

|


### Name: ***Reply5*** {#Reply5}

-   Service: Book1 / operation: get
-   ReplyWith:
-   Description:
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:get5XXFaultMessage2****/serverError****/tns1:server5XXError****/statusCode**|xsd:integer\(bw:getModuleProperty\("ec\_ServiceUnavailable"\)\)|
        |**/tns:get5XXFaultMessage2****/serverError****/tns1:server5XXError****/message**|concat\($ServiceOp, " failed: ", $FaultDetails/Msg\)|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns:get5XXFaultMessage2
		 serverError
			tns1:server5XXError
			   statusCode = **xsd:integer(bw:getModuleProperty(&quot;ec_ServiceUnavailable&quot;))**
			   message = **concat($ServiceOp, &quot; failed: &quot;, $FaultDetails/Msg)
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.example.org/Books/REST/1411989492608" xmlns:tns1="http://tns.tibco.com/bw/REST" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:bw="http://www.tibco.com/bw/xpath/bw-custom-functions" version="2.0">
   <xsl:param name="ServiceOp"/>
   <xsl:param name="FaultDetails"/>
   <xsl:template name="Reply5-input" match="/">
      <tns:get5XXFaultMessage2>
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
      </tns:get5XXFaultMessage2>
   </xsl:template>
</xsl:stylesheet>

        ```

|


### Name: ***updateBook*** {#updateBook}

-   Service: Service / operation: updateBook
-   Description:
-   Activity Timeout \(seconds\): Default Timeout
-   *Input bindings:*
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:updateBookRequest****/parameters****/tns2:Book****/tns2:isbn**|$put/parameters/tns1:BookParameters/ISBN|
        |**/tns:updateBookRequest****/parameters****/tns2:Book***/\[IF\] $put/item/tns2:Book/tns2:name***/tns2:name**|$put/item/tns2:Book/tns2:name|
        |**/tns:updateBookRequest****/parameters****/tns2:Book***/\[IF\] $put/item/tns2:Book/tns2:description***/tns2:description**|$put/item/tns2:Book/tns2:description|
        |**/tns:updateBookRequest****/parameters****/tns2:Book***/\[IF\] $put/item/tns2:Book/tns2:authorName***/tns2:authorName**|$put/item/tns2:Book/tns2:authorName|
        |**/tns:updateBookRequest****/parameters****/tns2:Book***/\[IF\] $put/item/tns2:Book/tns2:releaseDate***/tns2:releaseDate**|$put/item/tns2:Book/tns2:releaseDate|
        |**/tns:updateBookRequest****/parameters****/tns2:Book***/\[IF\] $put/item/tns2:Book/tns2:vintage***/tns2:vintage**|$put/item/tns2:Book/tns2:vintage|
        |**/tns:updateBookRequest****/parameters****/tns2:Book***/\[IF\] $put/item/tns2:Book/tns2:signed***/tns2:signed**|$put/item/tns2:Book/tns2:signed|
        |**/tns:updateBookRequest****/parameters****/tns2:Book***/\[IF\] $put/item/tns2:Book/tns2:price***/tns2:price**|$put/item/tns2:Book/tns2:price|

    -   Mapping tree

        |Mapping|
        |-------|
        |        ```
**
	  tns:updateBookRequest
		 parameters
			tns2:Book
			   tns2:isbn = **$put/parameters/tns1:BookParameters/ISBN**
			   xsl:if test="$put/item/tns2:Book/tns2:name"
				  tns2:name = **$put/item/tns2:Book/tns2:name**
			   xsl:if test="$put/item/tns2:Book/tns2:description"
				  tns2:description = **$put/item/tns2:Book/tns2:description**
			   xsl:if test="$put/item/tns2:Book/tns2:authorName"
				  tns2:authorName = **$put/item/tns2:Book/tns2:authorName**
			   xsl:if test="$put/item/tns2:Book/tns2:releaseDate"
				  tns2:releaseDate = **$put/item/tns2:Book/tns2:releaseDate**
			   xsl:if test="$put/item/tns2:Book/tns2:vintage"
				  tns2:vintage = **$put/item/tns2:Book/tns2:vintage**
			   xsl:if test="$put/item/tns2:Book/tns2:signed"
				  tns2:signed = **$put/item/tns2:Book/tns2:signed**
			   xsl:if test="$put/item/tns2:Book/tns2:price"
				  tns2:price = **$put/item/tns2:Book/tns2:price
        ```

|

    -   Source code

        |Mapping|
        |-------|
        |        ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20140929140236" xmlns:tns1="http://www.example.org/Books/REST/1411989492608/ConceptSchema" xmlns:tns2="http://www.example.org/Books" version="2.0">
   <xsl:param name="put"/>
   <xsl:template name="updateBook-input" match="/">
      <tns:updateBookRequest>
         <parameters>
            <tns2:Book>
               <tns2:isbn>
                  <xsl:value-of select="$put/parameters/tns1:BookParameters/ISBN"/>
               </tns2:isbn>
               <xsl:if test="$put/item/tns2:Book/tns2:name">
                  <tns2:name>
                     <xsl:value-of select="$put/item/tns2:Book/tns2:name"/>
                  </tns2:name>
               </xsl:if>
               <xsl:if test="$put/item/tns2:Book/tns2:description">
                  <tns2:description>
                     <xsl:value-of select="$put/item/tns2:Book/tns2:description"/>
                  </tns2:description>
               </xsl:if>
               <xsl:if test="$put/item/tns2:Book/tns2:authorName">
                  <tns2:authorName>
                     <xsl:value-of select="$put/item/tns2:Book/tns2:authorName"/>
                  </tns2:authorName>
               </xsl:if>
               <xsl:if test="$put/item/tns2:Book/tns2:releaseDate">
                  <tns2:releaseDate>
                     <xsl:value-of select="$put/item/tns2:Book/tns2:releaseDate"/>
                  </tns2:releaseDate>
               </xsl:if>
               <xsl:if test="$put/item/tns2:Book/tns2:vintage">
                  <tns2:vintage>
                     <xsl:value-of select="$put/item/tns2:Book/tns2:vintage"/>
                  </tns2:vintage>
               </xsl:if>
               <xsl:if test="$put/item/tns2:Book/tns2:signed">
                  <tns2:signed>
                     <xsl:value-of select="$put/item/tns2:Book/tns2:signed"/>
                  </tns2:signed>
               </xsl:if>
               <xsl:if test="$put/item/tns2:Book/tns2:price">
                  <tns2:price>
                     <xsl:value-of select="$put/item/tns2:Book/tns2:price"/>
                  </tns2:price>
               </xsl:if>
            </tns2:Book>
         </parameters>
      </tns:updateBookRequest>
   </xsl:template>
</xsl:stylesheet>

        ```

|


## References: {#References}

### Name: ***Service*** {#Service}

-   partnerLinkType: ns:ServicePLT
-   partnerRole: use
-   sca-bpel:ignore: true
-   sca-bpel:reference: Service
-   sca-bpel:wiredByImpl: false
-   dynamic: false
-   inline: false
-   processName: tibco.bwce.sample.binding.rest.bookstore.db.BooksDB
-   serviceName: BooksPersist

### Name: ***Service1*** {#Service1}

-   partnerLinkType: ns:ServicePLT1
-   partnerRole: use
-   sca-bpel:ignore: true
-   sca-bpel:reference: Service1
-   sca-bpel:wiredByImpl: false
-   dynamic: false
-   inline: false
-   processName: tibco.bwce.sample.binding.rest.bookstore.db.EventsDB
-   serviceName: EventsPersist

## Transitions: {#Transitions}

-   From: ***Log*** -To: ***Reply***
    -   Label: **
    -   Type: SUCCESS

-   From: ***addBooks*** -To: ***postOut***
    -   Label: **
    -   Type: SUCCESS

-   From: ***Log1*** -To: ***Reply1***
    -   Label: **
    -   Type: SUCCESS

-   From: ***getAllBooks*** -To: ***getOut***
    -   Label: **
    -   Type: SUCCESS

-   From: ***Log2*** -To: ***Reply2***
    -   Label: **
    -   Type: SUCCESS

-   From: ***getBookByISBN*** -To: ***getOut1***
    -   Label: **
    -   Type: SUCCESS

-   From: ***Log3*** -To: ***Reply3***
    -   Label: **
    -   Type: SUCCESS

-   From: ***updateBook*** -To: ***putOut***
    -   Label: **
    -   Type: SUCCESS

-   From: ***Log4*** -To: ***Reply4***
    -   Label: **
    -   Type: SUCCESS

-   From: ***deleteBook*** -To: ***deleteOut***
    -   Label: **
    -   Type: SUCCESS

-   From: ***Log5*** -To: ***Reply5***
    -   Label: **
    -   Type: SUCCESS

-   From: ***getEventByISBN*** -To: ***getOut2***
    -   Label: **
    -   Type: SUCCESS

