# BooksDB {#BooksDB.bwp.dita .concept}

License for TIBCO Software Use Only!

Section contains documentation of changed Process BooksDB \( [2024/07/16 08:15](../../../../../1721117756264/html/index.html?go=projects/tibco.bwce.sample.binding.rest.BookStore/Processes/tibco/bwce/sample/binding/rest/bookstore/db/BooksDB.bwp.md) , [2024/07/16 13:24](../../../../../1721136250430/html/index.html?go=projects/tibco.bwce.sample.binding.rest.BookStore/Processes/tibco/bwce/sample/binding/rest/bookstore/db/BooksDB.bwp.md) \).

**repositoryAnalyticsAdded:** Added element

**repositoryAnalyticsRemoved:** Deleted element

**Parent topic:**[Processes](../../../changed/tibco.bwce.sample.binding.rest.BookStore/Processes/files.md)

## Changes: {#BooksDB.bwp.dita_xmlComp}

### BooksDB {#ProcessMain}

License for TIBCO Software Use Only!

Section contains description of Process " BooksDB.bwp " .

#### Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
||No description|

#### Process description: {#ProcessDescription}

|No description|

#### Process definition: {#ProcessDefinition}

Full process path: tibco.bwce.sample.binding.rest.bookstore.db.BooksDB

#### Diagram: {#Diagram}

#### Process starter activity: {#Starter}

##### Name: **OnMessageStart** {#OnMessageStart}

-   Constructor: onMessageStart
-   xpdlId: f22acfca-dc29-453e-bd23-246f83c45499

##### Name: **OnMessageStart1** {#OnMessageStart1}

-   Constructor: onMessageStart
-   xpdlId: 00c97cfe-9655-4f44-93a2-745d4be182d2

##### Name: **OnMessageStart2** {#OnMessageStart2}

-   Constructor: onMessageStart
-   xpdlId: c19c279f-deda-42c4-869d-478fa120d7c5

##### Name: **OnMessageStart3** {#OnMessageStart3}

-   Constructor: onMessageStart
-   xpdlId: 86b69e76-0d41-4090-820a-806c417ee981

##### Name: **OnMessageStart4** {#OnMessageStart4}

-   Constructor: onMessageStart
-   xpdlId: ca9e2fbf-d1f9-40c2-9571-005a1d445fba

##### Name: **OnMessageStart5** {#OnMessageStart5}

-   Constructor: onMessageStart
-   xpdlId: 5ef6d415-d629-4a67-94b4-d7be79167cd4

#### Process end activity: {#EndActivity}

##### Name: **OnMessageEnd** {#OnMessageEnd}

-   Constructor: onMessageEnd
-   xpdlId: db1e39ef-5906-4d85-9a4d-709261410768

##### Name: **OnMessageEnd1** {#OnMessageEnd1}

-   Constructor: onMessageEnd
-   xpdlId: c5fc75f3-6c87-4acc-85aa-5d90dfadc211

##### Name: **OnMessageEnd2** {#OnMessageEnd2}

-   Constructor: onMessageEnd
-   xpdlId: ae3fdaad-436f-4bdc-b51a-27af155d73f9

##### Name: **OnMessageEnd3** {#OnMessageEnd3}

-   Constructor: onMessageEnd
-   xpdlId: 3fb30e4a-5075-4d14-b238-c63bd23df26b

##### Name: **OnMessageEnd4** {#OnMessageEnd4}

-   Constructor: onMessageEnd
-   xpdlId: ca4ffc2c-5358-4a0d-8b6d-a356ead19b95

##### Name: **OnMessageEnd5** {#OnMessageEnd5}

-   Constructor: onMessageEnd
-   xpdlId: 0d1c17e9-0170-4d15-aa2c-054c54ff9870

#### Process properties and variables {#ProcessVariables}

|Name|Type|Property Source|Default Value|
|----|----|---------------|-------------|
|\_processContext||||
|addBooks||||
|addBooksOut-input||||
|getAllBooks||||
|getAllBooksOut-input||||
|getBookByISBN||||
|getBookByISBNOut-input||||
|updateBook||||
|updateBookOut-input||||
|deleteBook||||
|deleteBookOut-input||||
|getRecentBooks||||
|getRecentBooksOut-input||||
|addBooks-input||||
|addBooks1||||
|jdbcProperty|xsd:string||tibco.bwce.sample.binding.rest.BookStore.JDBCConnectionResource|
|getBooks-input||||
|getBooks||||
|getBookByISBN-input||||
|getBookByISBN1||||
|updateBook-input||||
|updateBook1||||
|JDBCQuery-input||||
|JDBCQuery||||
|deleteBook-input||||
|deleteBook1||||
|getRecentBooks-input||||
|getRecentBooks1||||

#### Activities: {#Activities}

##### Name: **addBooks** {#addBooks}

-   Description: No description

    **repositoryAnalyticsRemoved:**

    |Mapping|
    |-------|
    |    ```

                                **
	  tns:jdbcUpdateActivityInput
		 isbn
			xsl:choose
			   xsl:when test="exists\($addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:isbn\)" = **
                                $addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:isbn
                                **
			   xsl:otherwise
				  xsl:attribute name="xsi:nil"
		 name
			xsl:choose
			   xsl:when test="exists\($addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:name\)" = **
                                $addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:name
                                **
			   xsl:otherwise
				  xsl:attribute name="xsi:nil"
		 description
			xsl:choose
			   xsl:when test="exists\($addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:description\)" = **
                                $addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:description
                                **
			   xsl:otherwise
				  xsl:attribute name="xsi:nil"
		 authorName
			xsl:choose
			   xsl:when test="exists\($addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:authorName\)" = **
                                $addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:authorName
                                **
			   xsl:otherwise
				  xsl:attribute name="xsi:nil"
		 releaseDate
			xsl:choose
			   xsl:when test="exists\($addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:releaseDate\)" = **
                                $addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:releaseDate
                                **
			   xsl:otherwise
				  xsl:attribute name="xsi:nil"
		 vintage
			xsl:choose
			   xsl:when test="exists\($addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:vintage\)" = **
                                $addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:vintage
                                **
			   xsl:otherwise
				  xsl:attribute name="xsi:nil"
		 signed
			xsl:choose
			   xsl:when test="exists\($addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:signed\)" = **
                                $addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:signed
                                **
			   xsl:otherwise
				  xsl:attribute name="xsi:nil"
		 price
			xsl:choose
			   xsl:when test="exists\($addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:price\)" = **
                                $addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:price
                              
    ```

|

    **repositoryAnalyticsRemoved:**

    |Mapping|
    |-------|
    |    ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/namespaces/tnt/plugins/jdbc+61f76f17-e519-4c59-a608-07f138a8479a+input" xmlns:tns1="http://www.example.org/Books" xmlns:tns2="http://xmlns.example.com/20140929140236" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0">
   <xsl:param name="index"/>
   <xsl:param name="addBooks"/>
   <xsl:template name="addBooks-input" match="/">
      <tns:jdbcUpdateActivityInput>
         <isbn>
            <xsl:choose>
               <xsl:when test="exists($addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:isbn)">
                  <xsl:value-of select="$addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:isbn"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </isbn>
         <name>
            <xsl:choose>
               <xsl:when test="exists($addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:name)">
                  <xsl:value-of select="$addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:name"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </name>
         <description>
            <xsl:choose>
               <xsl:when test="exists($addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:description)">
                  <xsl:value-of select="$addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:description"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </description>
         <authorName>
            <xsl:choose>
               <xsl:when test="exists($addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:authorName)">
                  <xsl:value-of select="$addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:authorName"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </authorName>
         <releaseDate>
            <xsl:choose>
               <xsl:when test="exists($addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:releaseDate)">
                  <xsl:value-of select="$addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:releaseDate"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </releaseDate>
         <vintage>
            <xsl:choose>
               <xsl:when test="exists($addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:vintage)">
                  <xsl:value-of select="$addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:vintage"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </vintage>
         <signed>
            <xsl:choose>
               <xsl:when test="exists($addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:signed)">
                  <xsl:value-of select="$addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:signed"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </signed>
         <price>
            <xsl:choose>
               <xsl:when test="exists($addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:price)">
                  <xsl:value-of select="$addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:price"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </price>
      </tns:jdbcUpdateActivityInput>
   </xsl:template>
</xsl:stylesheet>

    ```

|

-   Type: bw.jdbc.update
-   JDBC Shared Resource: jdbcProperty
-   Timeout \(sec\): 10
-   Statement: INSERT INTO "public"."books" \("isbn", "name", "description", "authorName", "releaseDate", "vintage", "signed", "price"\) VALUES \(?, ?, ?, ?, ?, ?, ?, ?\)
-   Parameters:

    No parameters

-   Thread Pool Shared Resource:
-   Insert if record doesn't exist: false
-   Override Transaction Behavior: false
-   Interpret Empty String As Null: false
-   Results Use Schema: false
-   Batch Update: false
-   Input Variable: addBooks-input
-   Output Variable: addBooks1
-   Input bindings:
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:jdbcUpdateActivityInput** **/isbn** /\[CHOOSE\]/\[WHEN\] exists\($addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:isbn\)|$addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:isbn|
        |**/tns:jdbcUpdateActivityInput** **/name** /\[CHOOSE\]/\[WHEN\] exists\($addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:name\)|$addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:name|
        |**/tns:jdbcUpdateActivityInput** **/description** /\[CHOOSE\]/\[WHEN\] exists\($addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:description\)|$addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:description|
        |**/tns:jdbcUpdateActivityInput** **/authorName** /\[CHOOSE\]/\[WHEN\] exists\($addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:authorName\)|$addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:authorName|
        |**/tns:jdbcUpdateActivityInput** **/releaseDate** /\[CHOOSE\]/\[WHEN\] exists\($addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:releaseDate\)|$addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:releaseDate|
        |**/tns:jdbcUpdateActivityInput** **/vintage** /\[CHOOSE\]/\[WHEN\] exists\($addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:vintage\)|$addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:vintage|
        |**/tns:jdbcUpdateActivityInput** **/signed** /\[CHOOSE\]/\[WHEN\] exists\($addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:signed\)|$addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:signed|
        |**/tns:jdbcUpdateActivityInput** **/price** /\[CHOOSE\]/\[WHEN\] exists\($addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:price\)|$addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:price|

    -   Mapping tree

        **repositoryAnalyticsAdded:**

        ```
        
                                  **
        	  tns:jdbcUpdateActivityInput
        		 isbn
        			xsl:choose
        			   xsl:when test="exists\($addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:isbn\)" = **
                                  $addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:isbn
                                  **
        			   xsl:otherwise
        				  xsl:attribute name="xsi:nil"
        		 name
        			xsl:choose
        			   xsl:when test="exists\($addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:name\)" = **
                                  $addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:name
                                  **
        			   xsl:otherwise
        				  xsl:attribute name="xsi:nil"
        		 description
        			xsl:choose
        			   xsl:when test="exists\($addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:description\)" = **
                                  $addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:description
                                  **
        			   xsl:otherwise
        				  xsl:attribute name="xsi:nil"
        		 authorName
        			xsl:choose
        			   xsl:when test="exists\($addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:authorName\)" = **
                                  $addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:authorName
                                  **
        			   xsl:otherwise
        				  xsl:attribute name="xsi:nil"
        		 releaseDate
        			xsl:choose
        			   xsl:when test="exists\($addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:releaseDate\)" = **
                                  $addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:releaseDate
                                  **
        			   xsl:otherwise
        				  xsl:attribute name="xsi:nil"
        		 vintage
        			xsl:choose
        			   xsl:when test="exists\($addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:vintage\)" = **
                                  $addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:vintage
                                  **
        			   xsl:otherwise
        				  xsl:attribute name="xsi:nil"
        		 signed
        			xsl:choose
        			   xsl:when test="exists\($addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:signed\)" = **
                                  $addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:signed
                                  **
        			   xsl:otherwise
        				  xsl:attribute name="xsi:nil"
        		 price
        			xsl:choose
        			   xsl:when test="exists\($addBooks/parameters/tns2:addBooksRequest/tns1:Book\[$index\]/tns1:price\)" = **
                                  $addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:price
                                
        ```

    -   Source code

        **repositoryAnalyticsAdded:**

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/namespaces/tnt/plugins/jdbc+61f76f17-e519-4c59-a608-07f138a8479a+input" xmlns:tns1="http://www.example.org/Books" xmlns:tns2="http://xmlns.example.com/20140929140236" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0">
           <xsl:param name="index"/>
           <xsl:param name="addBooks"/>
           <xsl:template name="addBooks-input" match="/">
              <tns:jdbcUpdateActivityInput>
                 <isbn>
                    <xsl:choose>
                       <xsl:when test="exists($addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:isbn)">
                          <xsl:value-of select="$addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:isbn"/>
                       </xsl:when>
                       <xsl:otherwise>
                          <xsl:attribute name="xsi:nil">true</xsl:attribute>
                       </xsl:otherwise>
                    </xsl:choose>
                 </isbn>
                 <name>
                    <xsl:choose>
                       <xsl:when test="exists($addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:name)">
                          <xsl:value-of select="$addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:name"/>
                       </xsl:when>
                       <xsl:otherwise>
                          <xsl:attribute name="xsi:nil">true</xsl:attribute>
                       </xsl:otherwise>
                    </xsl:choose>
                 </name>
                 <description>
                    <xsl:choose>
                       <xsl:when test="exists($addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:description)">
                          <xsl:value-of select="$addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:description"/>
                       </xsl:when>
                       <xsl:otherwise>
                          <xsl:attribute name="xsi:nil">true</xsl:attribute>
                       </xsl:otherwise>
                    </xsl:choose>
                 </description>
                 <authorName>
                    <xsl:choose>
                       <xsl:when test="exists($addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:authorName)">
                          <xsl:value-of select="$addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:authorName"/>
                       </xsl:when>
                       <xsl:otherwise>
                          <xsl:attribute name="xsi:nil">true</xsl:attribute>
                       </xsl:otherwise>
                    </xsl:choose>
                 </authorName>
                 <releaseDate>
                    <xsl:choose>
                       <xsl:when test="exists($addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:releaseDate)">
                          <xsl:value-of select="$addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:releaseDate"/>
                       </xsl:when>
                       <xsl:otherwise>
                          <xsl:attribute name="xsi:nil">true</xsl:attribute>
                       </xsl:otherwise>
                    </xsl:choose>
                 </releaseDate>
                 <vintage>
                    <xsl:choose>
                       <xsl:when test="exists($addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:vintage)">
                          <xsl:value-of select="$addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:vintage"/>
                       </xsl:when>
                       <xsl:otherwise>
                          <xsl:attribute name="xsi:nil">true</xsl:attribute>
                       </xsl:otherwise>
                    </xsl:choose>
                 </vintage>
                 <signed>
                    <xsl:choose>
                       <xsl:when test="exists($addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:signed)">
                          <xsl:value-of select="$addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:signed"/>
                       </xsl:when>
                       <xsl:otherwise>
                          <xsl:attribute name="xsi:nil">true</xsl:attribute>
                       </xsl:otherwise>
                    </xsl:choose>
                 </signed>
                 <price>
                    <xsl:choose>
                       <xsl:when test="exists($addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:price)">
                          <xsl:value-of select="$addBooks/parameters/tns2:addBooksRequest/tns1:Book[$index]/tns1:price"/>
                       </xsl:when>
                       <xsl:otherwise>
                          <xsl:attribute name="xsi:nil">true</xsl:attribute>
                       </xsl:otherwise>
                    </xsl:choose>
                 </price>
              </tns:jdbcUpdateActivityInput>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


##### Name: **addBooksOut** {#addBooksOut}

-   Service: BooksPersist / operation: addBooks

    **repositoryAnalyticsRemoved:**

    |Mapping|
    |-------|
    |    ```

                                ** = **
                              
    ```

|

    **repositoryAnalyticsRemoved:**

    |Mapping|
    |-------|
    |    ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20140929140236" xmlns:tns1="http://www.example.org/Books" version="2.0">
   <xsl:param name="addBooks"/>
   <xsl:template name="addBooksOut-input" match="/">
      <tns:addBooksResponse>
         <parameters>
            <tns1:Books>
               <xsl:copy-of select="$addBooks/parameters/tns:addBooksRequest/tns1:Book"/>
            </tns1:Books>
         </parameters>
      </tns:addBooksResponse>
   </xsl:template>
</xsl:stylesheet>

    ```

|

-   ReplyWith: Output Message
-   Description:
-   Input bindings:
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:addBooksResponse** **/parameters** **/tns1:Books**|/\[COPY-OF\] $addBooks/parameters/tns:addBooksRequest/tns1:Book|

    -   Mapping tree

        **repositoryAnalyticsAdded:**

        ```
        
                                  ** = **
                                
        ```

    -   Source code

        **repositoryAnalyticsAdded:**

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20140929140236" xmlns:tns1="http://www.example.org/Books" version="2.0">
           <xsl:param name="addBooks"/>
           <xsl:template name="addBooksOut-input" match="/">
              <tns:addBooksResponse>
                 <parameters>
                    <tns1:Books>
                       <xsl:copy-of select="$addBooks/parameters/tns:addBooksRequest/tns1:Book"/>
                    </tns1:Books>
                 </parameters>
              </tns:addBooksResponse>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


##### Name: **Assign** {#Assign}

-   Description: No description
-   Type: bw.generalactivities.bwassign
-   Process Variable to Set: BookCnt
-   Input Variable: BookCnt
-   Output Variable: BookCnt
-   Input bindings: Incomplete mapping

##### Name: **deleteBook** {#deleteBook}

-   Description: No description

    **repositoryAnalyticsRemoved:**

    |Mapping|
    |-------|
    |    ```

                                **
	  tns:jdbcUpdateActivityInput
		 isbn = **
                                $deleteBook/parameters/tns1:deleteBookRequest/ISBN
                              
    ```

|

    **repositoryAnalyticsRemoved:**

    |Mapping|
    |-------|
    |    ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/namespaces/tnt/plugins/jdbc+f4f28f1b-79dd-418b-a8c7-138a8f8e8e89+input" xmlns:tns1="http://xmlns.example.com/20140929140236" version="2.0">
   <xsl:param name="deleteBook"/>
   <xsl:template name="deleteBook-input" match="/">
      <tns:jdbcUpdateActivityInput>
         <isbn>
            <xsl:value-of select="$deleteBook/parameters/tns1:deleteBookRequest/ISBN"/>
         </isbn>
      </tns:jdbcUpdateActivityInput>
   </xsl:template>
</xsl:stylesheet>

    ```

|

-   Type: bw.jdbc.update
-   JDBC Shared Resource: jdbcProperty
-   Timeout \(sec\): 10
-   Statement: DELETE FROM "public"."books" WHERE "isbn" = ?
-   Parameters:

    No parameters

-   Thread Pool Shared Resource:
-   Insert if record doesn't exist: false
-   Override Transaction Behavior: false
-   Interpret Empty String As Null: false
-   Results Use Schema: false
-   Batch Update: false
-   Input Variable: deleteBook-input
-   Output Variable: deleteBook1
-   Input bindings:
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:jdbcUpdateActivityInput** **/isbn**|$deleteBook/parameters/tns1:deleteBookRequest/ISBN|

    -   Mapping tree

        **repositoryAnalyticsAdded:**

        ```
        
                                  **
        	  tns:jdbcUpdateActivityInput
        		 isbn = **
                                  $deleteBook/parameters/tns1:deleteBookRequest/ISBN
                                
        ```

    -   Source code

        **repositoryAnalyticsAdded:**

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/namespaces/tnt/plugins/jdbc+f4f28f1b-79dd-418b-a8c7-138a8f8e8e89+input" xmlns:tns1="http://xmlns.example.com/20140929140236" version="2.0">
           <xsl:param name="deleteBook"/>
           <xsl:template name="deleteBook-input" match="/">
              <tns:jdbcUpdateActivityInput>
                 <isbn>
                    <xsl:value-of select="$deleteBook/parameters/tns1:deleteBookRequest/ISBN"/>
                 </isbn>
              </tns:jdbcUpdateActivityInput>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


##### Name: **deleteBookOut** {#deleteBookOut}

-   Service: BooksPersist / operation: deleteBook

    **repositoryAnalyticsRemoved:**

    |Mapping|
    |-------|
    |    ```

                                **
	  tns:deleteBookResponse
		 parameters
			tns:deleteBookResponse
			   out = **
                                concat(&quot;Deleted book with ISBN - &quot;,$deleteBook/parameters/tns:deleteBookRequest/ISBN)
                              
    ```

|

    **repositoryAnalyticsRemoved:**

    |Mapping|
    |-------|
    |    ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20140929140236" version="2.0">
   <xsl:param name="deleteBook"/>
   <xsl:template name="deleteBookOut-input" match="/">
      <tns:deleteBookResponse>
         <parameters>
            <tns:deleteBookResponse>
               <out>
                  <xsl:value-of select="concat(&quot;Deleted book with ISBN - &quot;,$deleteBook/parameters/tns:deleteBookRequest/ISBN)"/>
               </out>
            </tns:deleteBookResponse>
         </parameters>
      </tns:deleteBookResponse>
   </xsl:template>
</xsl:stylesheet>

    ```

|

-   ReplyWith: Output Message
-   Description:
-   Input bindings:
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:deleteBookResponse** **/parameters** **/tns:deleteBookResponse** **/out**|concat\("Deleted book with ISBN - ",$deleteBook/parameters/tns:deleteBookRequest/ISBN\)|

    -   Mapping tree

        **repositoryAnalyticsAdded:**

        ```
        
                                  **
        	  tns:deleteBookResponse
        		 parameters
        			tns:deleteBookResponse
        			   out = **
                                  concat(&quot;Deleted book with ISBN - &quot;,$deleteBook/parameters/tns:deleteBookRequest/ISBN)
                                
        ```

    -   Source code

        **repositoryAnalyticsAdded:**

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20140929140236" version="2.0">
           <xsl:param name="deleteBook"/>
           <xsl:template name="deleteBookOut-input" match="/">
              <tns:deleteBookResponse>
                 <parameters>
                    <tns:deleteBookResponse>
                       <out>
                          <xsl:value-of select="concat(&quot;Deleted book with ISBN - &quot;,$deleteBook/parameters/tns:deleteBookRequest/ISBN)"/>
                       </out>
                    </tns:deleteBookResponse>
                 </parameters>
              </tns:deleteBookResponse>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


##### Name: **getAllBooksOut** {#getAllBooksOut}

-   Service: BooksPersist / operation: getAllBooks

    **repositoryAnalyticsRemoved:**

    |Mapping|
    |-------|
    |    ```

                                **
	  tns:getAllBooksResponse
		 parameters
			tns1:Books
			   xsl:for-each select="$getBooks/Record"
				  tns1:Book
					 xsl:if test="isbn"
						tns1:isbn = **
                                isbn
                                **
					 xsl:if test="name"
						tns1:name = **
                                name
                                **
					 xsl:if test="description"
						tns1:description = **
                                description
                                **
					 xsl:if test="authorName"
						tns1:authorName = **
                                authorName
                                **
					 xsl:if test="releaseDate"
						tns1:releaseDate = **
                                releaseDate
                                **
					 xsl:if test="vintage"
						tns1:vintage = **
                                vintage
                                **
					 xsl:if test="signed"
						tns1:signed = **
                                signed
                                **
					 tns1:price = **
                                xsd:float(price)
                              
    ```

|

    **repositoryAnalyticsRemoved:**

    |Mapping|
    |-------|
    |    ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20140929140236" xmlns:tns1="http://www.example.org/Books" xmlns:xsd="http://www.w3.org/2001/XMLSchema" version="2.0">
   <xsl:param name="getBooks"/>
   <xsl:template name="getAllBooksOut-input" match="/">
      <tns:getAllBooksResponse>
         <parameters>
            <tns1:Books>
               <xsl:for-each select="$getBooks/Record">
                  <tns1:Book>
                     <xsl:if test="isbn">
                        <tns1:isbn>
                           <xsl:value-of select="isbn"/>
                        </tns1:isbn>
                     </xsl:if>
                     <xsl:if test="name">
                        <tns1:name>
                           <xsl:value-of select="name"/>
                        </tns1:name>
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
                     <xsl:if test="releaseDate">
                        <tns1:releaseDate>
                           <xsl:value-of select="releaseDate"/>
                        </tns1:releaseDate>
                     </xsl:if>
                     <xsl:if test="vintage">
                        <tns1:vintage>
                           <xsl:value-of select="vintage"/>
                        </tns1:vintage>
                     </xsl:if>
                     <xsl:if test="signed">
                        <tns1:signed>
                           <xsl:value-of select="signed"/>
                        </tns1:signed>
                     </xsl:if>
                     <tns1:price>
                        <xsl:value-of select="xsd:float(price)"/>
                     </tns1:price>
                  </tns1:Book>
               </xsl:for-each>
            </tns1:Books>
         </parameters>
      </tns:getAllBooksResponse>
   </xsl:template>
</xsl:stylesheet>

    ```

|

-   ReplyWith: Output Message
-   Description:
-   Input bindings:
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:getAllBooksResponse** **/parameters** **/tns1:Books** /\[FOR-EACH\] $getBooks/Record **/tns1:Book** /\[IF\] isbn **/tns1:isbn**|isbn|
        |**/tns:getAllBooksResponse** **/parameters** **/tns1:Books** /\[FOR-EACH\] $getBooks/Record **/tns1:Book** /\[IF\] name **/tns1:name**|name|
        |**/tns:getAllBooksResponse** **/parameters** **/tns1:Books** /\[FOR-EACH\] $getBooks/Record **/tns1:Book** /\[IF\] description **/tns1:description**|description|
        |**/tns:getAllBooksResponse** **/parameters** **/tns1:Books** /\[FOR-EACH\] $getBooks/Record **/tns1:Book** /\[IF\] authorName **/tns1:authorName**|authorName|
        |**/tns:getAllBooksResponse** **/parameters** **/tns1:Books** /\[FOR-EACH\] $getBooks/Record **/tns1:Book** /\[IF\] releaseDate **/tns1:releaseDate**|releaseDate|
        |**/tns:getAllBooksResponse** **/parameters** **/tns1:Books** /\[FOR-EACH\] $getBooks/Record **/tns1:Book** /\[IF\] vintage **/tns1:vintage**|vintage|
        |**/tns:getAllBooksResponse** **/parameters** **/tns1:Books** /\[FOR-EACH\] $getBooks/Record **/tns1:Book** /\[IF\] signed **/tns1:signed**|signed|
        |**/tns:getAllBooksResponse** **/parameters** **/tns1:Books** /\[FOR-EACH\] $getBooks/Record **/tns1:Book** **/tns1:price**|xsd:float\(price\)|

    -   Mapping tree

        **repositoryAnalyticsAdded:**

        ```
        
                                  **
        	  tns:getAllBooksResponse
        		 parameters
        			tns1:Books
        			   xsl:for-each select="$getBooks/Record"
        				  tns1:Book
        					 xsl:if test="isbn"
        						tns1:isbn = **
                                  isbn
                                  **
        					 xsl:if test="name"
        						tns1:name = **
                                  name
                                  **
        					 xsl:if test="description"
        						tns1:description = **
                                  description
                                  **
        					 xsl:if test="authorName"
        						tns1:authorName = **
                                  authorName
                                  **
        					 xsl:if test="releaseDate"
        						tns1:releaseDate = **
                                  releaseDate
                                  **
        					 xsl:if test="vintage"
        						tns1:vintage = **
                                  vintage
                                  **
        					 xsl:if test="signed"
        						tns1:signed = **
                                  signed
                                  **
        					 tns1:price = **
                                  xsd:float(price)
                                
        ```

    -   Source code

        **repositoryAnalyticsAdded:**

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20140929140236" xmlns:tns1="http://www.example.org/Books" xmlns:xsd="http://www.w3.org/2001/XMLSchema" version="2.0">
           <xsl:param name="getBooks"/>
           <xsl:template name="getAllBooksOut-input" match="/">
              <tns:getAllBooksResponse>
                 <parameters>
                    <tns1:Books>
                       <xsl:for-each select="$getBooks/Record">
                          <tns1:Book>
                             <xsl:if test="isbn">
                                <tns1:isbn>
                                   <xsl:value-of select="isbn"/>
                                </tns1:isbn>
                             </xsl:if>
                             <xsl:if test="name">
                                <tns1:name>
                                   <xsl:value-of select="name"/>
                                </tns1:name>
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
                             <xsl:if test="releaseDate">
                                <tns1:releaseDate>
                                   <xsl:value-of select="releaseDate"/>
                                </tns1:releaseDate>
                             </xsl:if>
                             <xsl:if test="vintage">
                                <tns1:vintage>
                                   <xsl:value-of select="vintage"/>
                                </tns1:vintage>
                             </xsl:if>
                             <xsl:if test="signed">
                                <tns1:signed>
                                   <xsl:value-of select="signed"/>
                                </tns1:signed>
                             </xsl:if>
                             <tns1:price>
                                <xsl:value-of select="xsd:float(price)"/>
                             </tns1:price>
                          </tns1:Book>
                       </xsl:for-each>
                    </tns1:Books>
                 </parameters>
              </tns:getAllBooksResponse>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


##### Name: **getBookByISBN** {#getBookByISBN}

-   Description: No description

    **repositoryAnalyticsRemoved:**

    |Mapping|
    |-------|
    |    ```

                                **
	  tns:jdbcQueryActivityInput
		 isbn = **
                                $getBookByISBN/parameters/tns1:getBookByISBNRequest/ISBN
                              
    ```

|

    **repositoryAnalyticsRemoved:**

    |Mapping|
    |-------|
    |    ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/namespaces/tnt/plugins/jdbc+426eab4f-07d7-4abd-9ce4-52a7191b6c86+input" xmlns:tns1="http://xmlns.example.com/20140929140236" version="2.0">
   <xsl:param name="getBookByISBN"/>
   <xsl:template name="getBookByISBN-input" match="/">
      <tns:jdbcQueryActivityInput>
         <isbn>
            <xsl:value-of select="$getBookByISBN/parameters/tns1:getBookByISBNRequest/ISBN"/>
         </isbn>
      </tns:jdbcQueryActivityInput>
   </xsl:template>
</xsl:stylesheet>

    ```

|

-   Type: bw.jdbc.JDBCQuery
-   JDBC Shared Resource: jdbcProperty
-   Timeout \(sec\): 10
-   Maximum rows: 100
-   Statement: SELECT \* FROM "public"."books" WHERE "isbn" = ?
-   Parameters:

    No parameters

-   Thread Pool Shared Resource:
-   Override Transaction Behavior: false
-   Override JDBC Connection: false
-   Use Nil: false
-   Interpret Empty String As Null: false
-   Process In Subsets: false
-   Input Variable: getBookByISBN-input
-   Output Variable: getBookByISBN1
-   Input bindings:
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:jdbcQueryActivityInput** **/isbn**|$getBookByISBN/parameters/tns1:getBookByISBNRequest/ISBN|

    -   Mapping tree

        **repositoryAnalyticsAdded:**

        ```
        
                                  **
        	  tns:jdbcQueryActivityInput
        		 isbn = **
                                  $getBookByISBN/parameters/tns1:getBookByISBNRequest/ISBN
                                
        ```

    -   Source code

        **repositoryAnalyticsAdded:**

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/namespaces/tnt/plugins/jdbc+426eab4f-07d7-4abd-9ce4-52a7191b6c86+input" xmlns:tns1="http://xmlns.example.com/20140929140236" version="2.0">
           <xsl:param name="getBookByISBN"/>
           <xsl:template name="getBookByISBN-input" match="/">
              <tns:jdbcQueryActivityInput>
                 <isbn>
                    <xsl:value-of select="$getBookByISBN/parameters/tns1:getBookByISBNRequest/ISBN"/>
                 </isbn>
              </tns:jdbcQueryActivityInput>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


##### Name: **getBookByISBNOut** {#getBookByISBNOut}

-   Service: BooksPersist / operation: getBookByISBN

    **repositoryAnalyticsRemoved:**

    |Mapping|
    |-------|
    |    ```

                                **
	  tns:getBookByISBNResponse
		 parameters
			xsl:for-each select="$getBookByISBN1/Record"
			   tns1:Book
				  xsl:if test="isbn"
					 tns1:isbn = **
                                isbn
                                **
				  xsl:if test="name"
					 tns1:name = **
                                name
                                **
				  xsl:if test="description"
					 tns1:description = **
                                description
                                **
				  xsl:if test="authorName"
					 tns1:authorName = **
                                authorName
                                **
				  xsl:if test="releaseDate"
					 tns1:releaseDate = **
                                releaseDate
                                **
				  xsl:if test="vintage"
					 tns1:vintage = **
                                vintage
                                **
				  xsl:if test="signed"
					 tns1:signed = **
                                signed
                                **
				  tns1:price = **
                                xsd:float(price)
                              
    ```

|

    **repositoryAnalyticsRemoved:**

    |Mapping|
    |-------|
    |    ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20140929140236" xmlns:tns1="http://www.example.org/Books" xmlns:xsd="http://www.w3.org/2001/XMLSchema" version="2.0">
   <xsl:param name="getBookByISBN1"/>
   <xsl:template name="getBookByISBNOut-input" match="/">
      <tns:getBookByISBNResponse>
         <parameters>
            <xsl:for-each select="$getBookByISBN1/Record">
               <tns1:Book>
                  <xsl:if test="isbn">
                     <tns1:isbn>
                        <xsl:value-of select="isbn"/>
                     </tns1:isbn>
                  </xsl:if>
                  <xsl:if test="name">
                     <tns1:name>
                        <xsl:value-of select="name"/>
                     </tns1:name>
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
                  <xsl:if test="releaseDate">
                     <tns1:releaseDate>
                        <xsl:value-of select="releaseDate"/>
                     </tns1:releaseDate>
                  </xsl:if>
                  <xsl:if test="vintage">
                     <tns1:vintage>
                        <xsl:value-of select="vintage"/>
                     </tns1:vintage>
                  </xsl:if>
                  <xsl:if test="signed">
                     <tns1:signed>
                        <xsl:value-of select="signed"/>
                     </tns1:signed>
                  </xsl:if>
                  <tns1:price>
                     <xsl:value-of select="xsd:float(price)"/>
                  </tns1:price>
               </tns1:Book>
            </xsl:for-each>
         </parameters>
      </tns:getBookByISBNResponse>
   </xsl:template>
</xsl:stylesheet>

    ```

|

-   ReplyWith: Output Message
-   Description:
-   Input bindings:
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:getBookByISBNResponse** **/parameters** /\[FOR-EACH\] $getBookByISBN1/Record **/tns1:Book** /\[IF\] isbn **/tns1:isbn**|isbn|
        |**/tns:getBookByISBNResponse** **/parameters** /\[FOR-EACH\] $getBookByISBN1/Record **/tns1:Book** /\[IF\] name **/tns1:name**|name|
        |**/tns:getBookByISBNResponse** **/parameters** /\[FOR-EACH\] $getBookByISBN1/Record **/tns1:Book** /\[IF\] description **/tns1:description**|description|
        |**/tns:getBookByISBNResponse** **/parameters** /\[FOR-EACH\] $getBookByISBN1/Record **/tns1:Book** /\[IF\] authorName **/tns1:authorName**|authorName|
        |**/tns:getBookByISBNResponse** **/parameters** /\[FOR-EACH\] $getBookByISBN1/Record **/tns1:Book** /\[IF\] releaseDate **/tns1:releaseDate**|releaseDate|
        |**/tns:getBookByISBNResponse** **/parameters** /\[FOR-EACH\] $getBookByISBN1/Record **/tns1:Book** /\[IF\] vintage **/tns1:vintage**|vintage|
        |**/tns:getBookByISBNResponse** **/parameters** /\[FOR-EACH\] $getBookByISBN1/Record **/tns1:Book** /\[IF\] signed **/tns1:signed**|signed|
        |**/tns:getBookByISBNResponse** **/parameters** /\[FOR-EACH\] $getBookByISBN1/Record **/tns1:Book** **/tns1:price**|xsd:float\(price\)|

    -   Mapping tree

        **repositoryAnalyticsAdded:**

        ```
        
                                  **
        	  tns:getBookByISBNResponse
        		 parameters
        			xsl:for-each select="$getBookByISBN1/Record"
        			   tns1:Book
        				  xsl:if test="isbn"
        					 tns1:isbn = **
                                  isbn
                                  **
        				  xsl:if test="name"
        					 tns1:name = **
                                  name
                                  **
        				  xsl:if test="description"
        					 tns1:description = **
                                  description
                                  **
        				  xsl:if test="authorName"
        					 tns1:authorName = **
                                  authorName
                                  **
        				  xsl:if test="releaseDate"
        					 tns1:releaseDate = **
                                  releaseDate
                                  **
        				  xsl:if test="vintage"
        					 tns1:vintage = **
                                  vintage
                                  **
        				  xsl:if test="signed"
        					 tns1:signed = **
                                  signed
                                  **
        				  tns1:price = **
                                  xsd:float(price)
                                
        ```

    -   Source code

        **repositoryAnalyticsAdded:**

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20140929140236" xmlns:tns1="http://www.example.org/Books" xmlns:xsd="http://www.w3.org/2001/XMLSchema" version="2.0">
           <xsl:param name="getBookByISBN1"/>
           <xsl:template name="getBookByISBNOut-input" match="/">
              <tns:getBookByISBNResponse>
                 <parameters>
                    <xsl:for-each select="$getBookByISBN1/Record">
                       <tns1:Book>
                          <xsl:if test="isbn">
                             <tns1:isbn>
                                <xsl:value-of select="isbn"/>
                             </tns1:isbn>
                          </xsl:if>
                          <xsl:if test="name">
                             <tns1:name>
                                <xsl:value-of select="name"/>
                             </tns1:name>
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
                          <xsl:if test="releaseDate">
                             <tns1:releaseDate>
                                <xsl:value-of select="releaseDate"/>
                             </tns1:releaseDate>
                          </xsl:if>
                          <xsl:if test="vintage">
                             <tns1:vintage>
                                <xsl:value-of select="vintage"/>
                             </tns1:vintage>
                          </xsl:if>
                          <xsl:if test="signed">
                             <tns1:signed>
                                <xsl:value-of select="signed"/>
                             </tns1:signed>
                          </xsl:if>
                          <tns1:price>
                             <xsl:value-of select="xsd:float(price)"/>
                          </tns1:price>
                       </tns1:Book>
                    </xsl:for-each>
                 </parameters>
              </tns:getBookByISBNResponse>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


##### Name: **getBooks** {#getBooks}

-   Description: No description
-   Type: bw.jdbc.JDBCQuery
-   JDBC Shared Resource: jdbcProperty
-   Timeout \(sec\): 10
-   Maximum rows: 100
-   Statement: SELECT \* FROM "public"."books"
-   Parameters:

    No parameters

-   Thread Pool Shared Resource:
-   Override Transaction Behavior: false
-   Override JDBC Connection: false
-   Use Nil: false
-   Interpret Empty String As Null: false
-   Process In Subsets: false
-   Input Variable: getBooks-input
-   Output Variable: getBooks
-   Input bindings: Incomplete mapping

##### Name: **getRecentBooks** {#getRecentBooks}

-   Description: No description
-   Type: bw.jdbc.JDBCQuery
-   JDBC Shared Resource: jdbcProperty
-   Timeout \(sec\): 10
-   Maximum rows: 100
-   Statement: SELECT \* FROM "public"."books" ORDER BY "books"."releaseDate" DESC LIMIT 2
-   Parameters:

    No parameters

-   Thread Pool Shared Resource:
-   Override Transaction Behavior: false
-   Override JDBC Connection: false
-   Use Nil: false
-   Interpret Empty String As Null: false
-   Process In Subsets: false
-   Input Variable: getRecentBooks-input
-   Output Variable: getRecentBooks1
-   Input bindings: Incomplete mapping

##### Name: **getRecentBooksOut** {#getRecentBooksOut}

-   Service: BooksPersist / operation: getRecentBooks

    **repositoryAnalyticsRemoved:**

    |Mapping|
    |-------|
    |    ```

                                **
	  tns:getRecentBooksResponse
		 parameters
			tns1:Books
			   tns1:Book
				  xsl:if test="$getRecentBooks1/Record\[1\]/isbn"
					 tns1:isbn = **
                                $getRecentBooks1/Record[1]/isbn
                                **
				  xsl:if test="$getRecentBooks1/Record\[1\]/name"
					 tns1:name = **
                                $getRecentBooks1/Record[1]/name
                                **
				  xsl:if test="$getRecentBooks1/Record\[1\]/description"
					 tns1:description = **
                                $getRecentBooks1/Record[1]/description
                                **
				  xsl:if test="$getRecentBooks1/Record\[1\]/authorName"
					 tns1:authorName = **
                                $getRecentBooks1/Record[1]/authorName
                                **
				  xsl:if test="$getRecentBooks1/Record\[1\]/releaseDate"
					 tns1:releaseDate = **
                                $getRecentBooks1/Record[1]/releaseDate
                                **
				  xsl:if test="$getRecentBooks1/Record\[1\]/vintage"
					 tns1:vintage = **
                                $getRecentBooks1/Record[1]/vintage
                                **
				  xsl:if test="$getRecentBooks1/Record\[1\]/signed"
					 tns1:signed = **
                                $getRecentBooks1/Record[1]/signed
                                **
				  tns1:price = **
                                xsd:float($getRecentBooks1/Record[1]/price)
                              
    ```

|

    **repositoryAnalyticsRemoved:**

    |Mapping|
    |-------|
    |    ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20140929140236" xmlns:tns1="http://www.example.org/Books" xmlns:xsd="http://www.w3.org/2001/XMLSchema" version="2.0">
   <xsl:param name="getRecentBooks1"/>
   <xsl:template name="getRecentBooksOut-input" match="/">
      <tns:getRecentBooksResponse>
         <parameters>
            <tns1:Books>
               <tns1:Book>
                  <xsl:if test="$getRecentBooks1/Record[1]/isbn">
                     <tns1:isbn>
                        <xsl:value-of select="$getRecentBooks1/Record[1]/isbn"/>
                     </tns1:isbn>
                  </xsl:if>
                  <xsl:if test="$getRecentBooks1/Record[1]/name">
                     <tns1:name>
                        <xsl:value-of select="$getRecentBooks1/Record[1]/name"/>
                     </tns1:name>
                  </xsl:if>
                  <xsl:if test="$getRecentBooks1/Record[1]/description">
                     <tns1:description>
                        <xsl:value-of select="$getRecentBooks1/Record[1]/description"/>
                     </tns1:description>
                  </xsl:if>
                  <xsl:if test="$getRecentBooks1/Record[1]/authorName">
                     <tns1:authorName>
                        <xsl:value-of select="$getRecentBooks1/Record[1]/authorName"/>
                     </tns1:authorName>
                  </xsl:if>
                  <xsl:if test="$getRecentBooks1/Record[1]/releaseDate">
                     <tns1:releaseDate>
                        <xsl:value-of select="$getRecentBooks1/Record[1]/releaseDate"/>
                     </tns1:releaseDate>
                  </xsl:if>
                  <xsl:if test="$getRecentBooks1/Record[1]/vintage">
                     <tns1:vintage>
                        <xsl:value-of select="$getRecentBooks1/Record[1]/vintage"/>
                     </tns1:vintage>
                  </xsl:if>
                  <xsl:if test="$getRecentBooks1/Record[1]/signed">
                     <tns1:signed>
                        <xsl:value-of select="$getRecentBooks1/Record[1]/signed"/>
                     </tns1:signed>
                  </xsl:if>
                  <tns1:price>
                     <xsl:value-of select="xsd:float($getRecentBooks1/Record[1]/price)"/>
                  </tns1:price>
               </tns1:Book>
            </tns1:Books>
         </parameters>
      </tns:getRecentBooksResponse>
   </xsl:template>
</xsl:stylesheet>

    ```

|

-   ReplyWith: Output Message
-   Description:
-   Input bindings:
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:getRecentBooksResponse** **/parameters** **/tns1:Books** **/tns1:Book** /\[IF\] $getRecentBooks1/Record\[1\]/isbn **/tns1:isbn**|$getRecentBooks1/Record\[1\]/isbn|
        |**/tns:getRecentBooksResponse** **/parameters** **/tns1:Books** **/tns1:Book** /\[IF\] $getRecentBooks1/Record\[1\]/name **/tns1:name**|$getRecentBooks1/Record\[1\]/name|
        |**/tns:getRecentBooksResponse** **/parameters** **/tns1:Books** **/tns1:Book** /\[IF\] $getRecentBooks1/Record\[1\]/description **/tns1:description**|$getRecentBooks1/Record\[1\]/description|
        |**/tns:getRecentBooksResponse** **/parameters** **/tns1:Books** **/tns1:Book** /\[IF\] $getRecentBooks1/Record\[1\]/authorName **/tns1:authorName**|$getRecentBooks1/Record\[1\]/authorName|
        |**/tns:getRecentBooksResponse** **/parameters** **/tns1:Books** **/tns1:Book** /\[IF\] $getRecentBooks1/Record\[1\]/releaseDate **/tns1:releaseDate**|$getRecentBooks1/Record\[1\]/releaseDate|
        |**/tns:getRecentBooksResponse** **/parameters** **/tns1:Books** **/tns1:Book** /\[IF\] $getRecentBooks1/Record\[1\]/vintage **/tns1:vintage**|$getRecentBooks1/Record\[1\]/vintage|
        |**/tns:getRecentBooksResponse** **/parameters** **/tns1:Books** **/tns1:Book** /\[IF\] $getRecentBooks1/Record\[1\]/signed **/tns1:signed**|$getRecentBooks1/Record\[1\]/signed|
        |**/tns:getRecentBooksResponse** **/parameters** **/tns1:Books** **/tns1:Book** **/tns1:price**|xsd:float\($getRecentBooks1/Record\[1\]/price\)|

    -   Mapping tree

        **repositoryAnalyticsAdded:**

        ```
        
                                  **
        	  tns:getRecentBooksResponse
        		 parameters
        			tns1:Books
        			   tns1:Book
        				  xsl:if test="$getRecentBooks1/Record\[1\]/isbn"
        					 tns1:isbn = **
                                  $getRecentBooks1/Record[1]/isbn
                                  **
        				  xsl:if test="$getRecentBooks1/Record\[1\]/name"
        					 tns1:name = **
                                  $getRecentBooks1/Record[1]/name
                                  **
        				  xsl:if test="$getRecentBooks1/Record\[1\]/description"
        					 tns1:description = **
                                  $getRecentBooks1/Record[1]/description
                                  **
        				  xsl:if test="$getRecentBooks1/Record\[1\]/authorName"
        					 tns1:authorName = **
                                  $getRecentBooks1/Record[1]/authorName
                                  **
        				  xsl:if test="$getRecentBooks1/Record\[1\]/releaseDate"
        					 tns1:releaseDate = **
                                  $getRecentBooks1/Record[1]/releaseDate
                                  **
        				  xsl:if test="$getRecentBooks1/Record\[1\]/vintage"
        					 tns1:vintage = **
                                  $getRecentBooks1/Record[1]/vintage
                                  **
        				  xsl:if test="$getRecentBooks1/Record\[1\]/signed"
        					 tns1:signed = **
                                  $getRecentBooks1/Record[1]/signed
                                  **
        				  tns1:price = **
                                  xsd:float($getRecentBooks1/Record[1]/price)
                                
        ```

    -   Source code

        **repositoryAnalyticsAdded:**

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20140929140236" xmlns:tns1="http://www.example.org/Books" xmlns:xsd="http://www.w3.org/2001/XMLSchema" version="2.0">
           <xsl:param name="getRecentBooks1"/>
           <xsl:template name="getRecentBooksOut-input" match="/">
              <tns:getRecentBooksResponse>
                 <parameters>
                    <tns1:Books>
                       <tns1:Book>
                          <xsl:if test="$getRecentBooks1/Record[1]/isbn">
                             <tns1:isbn>
                                <xsl:value-of select="$getRecentBooks1/Record[1]/isbn"/>
                             </tns1:isbn>
                          </xsl:if>
                          <xsl:if test="$getRecentBooks1/Record[1]/name">
                             <tns1:name>
                                <xsl:value-of select="$getRecentBooks1/Record[1]/name"/>
                             </tns1:name>
                          </xsl:if>
                          <xsl:if test="$getRecentBooks1/Record[1]/description">
                             <tns1:description>
                                <xsl:value-of select="$getRecentBooks1/Record[1]/description"/>
                             </tns1:description>
                          </xsl:if>
                          <xsl:if test="$getRecentBooks1/Record[1]/authorName">
                             <tns1:authorName>
                                <xsl:value-of select="$getRecentBooks1/Record[1]/authorName"/>
                             </tns1:authorName>
                          </xsl:if>
                          <xsl:if test="$getRecentBooks1/Record[1]/releaseDate">
                             <tns1:releaseDate>
                                <xsl:value-of select="$getRecentBooks1/Record[1]/releaseDate"/>
                             </tns1:releaseDate>
                          </xsl:if>
                          <xsl:if test="$getRecentBooks1/Record[1]/vintage">
                             <tns1:vintage>
                                <xsl:value-of select="$getRecentBooks1/Record[1]/vintage"/>
                             </tns1:vintage>
                          </xsl:if>
                          <xsl:if test="$getRecentBooks1/Record[1]/signed">
                             <tns1:signed>
                                <xsl:value-of select="$getRecentBooks1/Record[1]/signed"/>
                             </tns1:signed>
                          </xsl:if>
                          <tns1:price>
                             <xsl:value-of select="xsd:float($getRecentBooks1/Record[1]/price)"/>
                          </tns1:price>
                       </tns1:Book>
                    </tns1:Books>
                 </parameters>
              </tns:getRecentBooksResponse>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


##### Name: **JDBCQuery** {#JDBCQuery}

-   Description: No description

    **repositoryAnalyticsRemoved:**

    |Mapping|
    |-------|
    |    ```

                                **
	  tns:jdbcQueryActivityInput
		 isbn
			xsl:choose
			   xsl:when test="exists\($updateBook/parameters/tns1:Book/tns1:isbn\)" = **
                                $updateBook/parameters/tns1:Book/tns1:isbn
                              
    ```

|

    **repositoryAnalyticsRemoved:**

    |Mapping|
    |-------|
    |    ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/namespaces/tnt/plugins/jdbc+d7bef9be-32ee-440d-becf-03121e4c20cb+input" xmlns:tns1="http://www.example.org/Books" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0">
   <xsl:param name="updateBook"/>
   <xsl:template name="JDBCQuery-input" match="/">
      <tns:jdbcQueryActivityInput>
         <isbn>
            <xsl:choose>
               <xsl:when test="exists($updateBook/parameters/tns1:Book/tns1:isbn)">
                  <xsl:value-of select="$updateBook/parameters/tns1:Book/tns1:isbn"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </isbn>
      </tns:jdbcQueryActivityInput>
   </xsl:template>
</xsl:stylesheet>

    ```

|

-   Type: bw.jdbc.JDBCQuery
-   JDBC Shared Resource: jdbcProperty
-   Timeout \(sec\): 10
-   Maximum rows: 100
-   Statement: SELECT \* FROM "public"."books" WHERE "isbn" = ?
-   Parameters:

    No parameters

-   Thread Pool Shared Resource:
-   Override Transaction Behavior: false
-   Override JDBC Connection: false
-   Use Nil: false
-   Interpret Empty String As Null: false
-   Process In Subsets: false
-   Input Variable: JDBCQuery-input
-   Output Variable: JDBCQuery
-   Input bindings:
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:jdbcQueryActivityInput** **/isbn** /\[CHOOSE\]/\[WHEN\] exists\($updateBook/parameters/tns1:Book/tns1:isbn\)|$updateBook/parameters/tns1:Book/tns1:isbn|

    -   Mapping tree

        **repositoryAnalyticsAdded:**

        ```
        
                                  **
        	  tns:jdbcQueryActivityInput
        		 isbn
        			xsl:choose
        			   xsl:when test="exists\($updateBook/parameters/tns1:Book/tns1:isbn\)" = **
                                  $updateBook/parameters/tns1:Book/tns1:isbn
                                
        ```

    -   Source code

        **repositoryAnalyticsAdded:**

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/namespaces/tnt/plugins/jdbc+d7bef9be-32ee-440d-becf-03121e4c20cb+input" xmlns:tns1="http://www.example.org/Books" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0">
           <xsl:param name="updateBook"/>
           <xsl:template name="JDBCQuery-input" match="/">
              <tns:jdbcQueryActivityInput>
                 <isbn>
                    <xsl:choose>
                       <xsl:when test="exists($updateBook/parameters/tns1:Book/tns1:isbn)">
                          <xsl:value-of select="$updateBook/parameters/tns1:Book/tns1:isbn"/>
                       </xsl:when>
                       <xsl:otherwise>
                          <xsl:attribute name="xsi:nil">true</xsl:attribute>
                       </xsl:otherwise>
                    </xsl:choose>
                 </isbn>
              </tns:jdbcQueryActivityInput>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


##### Name: **updateBook** {#updateBook}

-   Description: No description

    **repositoryAnalyticsRemoved:**

    |Mapping|
    |-------|
    |    ```

                                **
	  tns:jdbcUpdateActivityInput
		 name
			xsl:choose
			   xsl:when test="exists\(if\(empty\($updateBook/parameters/tns1:Book/tns1:name\)\) then $JDBCQuery/Record\[1\]/name else $updateBook/parameters/tns1:Book/tns1:name\)" = **
                                if(empty($updateBook/parameters/tns1:Book/tns1:name)) then $JDBCQuery/Record[1]/name else $updateBook/parameters/tns1:Book/tns1:name
                                **
			   xsl:otherwise
				  xsl:attribute name="xsi:nil"
		 description
			xsl:choose
			   xsl:when test="exists\(if\(empty\($updateBook/parameters/tns1:Book/tns1:description\)\) then $JDBCQuery/Record\[1\]/description else $updateBook/parameters/tns1:Book/tns1:description\)" = **
                                if(empty($updateBook/parameters/tns1:Book/tns1:description)) then $JDBCQuery/Record[1]/description else $updateBook/parameters/tns1:Book/tns1:description
                                **
			   xsl:otherwise
				  xsl:attribute name="xsi:nil"
		 authorName
			xsl:choose
			   xsl:when test="exists\(if\(empty\($updateBook/parameters/tns1:Book/tns1:authorName\)\) then $JDBCQuery/Record\[1\]/authorName else $updateBook/parameters/tns1:Book/tns1:authorName\)" = **
                                if(empty($updateBook/parameters/tns1:Book/tns1:authorName)) then $JDBCQuery/Record[1]/authorName else $updateBook/parameters/tns1:Book/tns1:authorName
                                **
			   xsl:otherwise
				  xsl:attribute name="xsi:nil"
		 releaseDate
			xsl:choose
			   xsl:when test="exists\(if\(empty\($updateBook/parameters/tns1:Book/tns1:releaseDate\)\) then $JDBCQuery/Record\[1\]/releaseDate else $updateBook/parameters/tns1:Book/tns1:releaseDate\)" = **
                                if(empty($updateBook/parameters/tns1:Book/tns1:releaseDate)) then $JDBCQuery/Record[1]/releaseDate else $updateBook/parameters/tns1:Book/tns1:releaseDate
                                **
			   xsl:otherwise
				  xsl:attribute name="xsi:nil"
		 vintage
			xsl:choose
			   xsl:when test="exists\(if\(empty\($updateBook/parameters/tns1:Book/tns1:vintage\)\) then $JDBCQuery/Record\[1\]/vintage else $updateBook/parameters/tns1:Book/tns1:vintage\)" = **
                                if(empty($updateBook/parameters/tns1:Book/tns1:vintage)) then $JDBCQuery/Record[1]/vintage else $updateBook/parameters/tns1:Book/tns1:vintage
                                **
			   xsl:otherwise
				  xsl:attribute name="xsi:nil"
		 signed
			xsl:choose
			   xsl:when test="exists\(if\(empty\($updateBook/parameters/tns1:Book/tns1:signed\)\) then $JDBCQuery/Record\[1\]/signed else $updateBook/parameters/tns1:Book/tns1:signed\)" = **
                                if(empty($updateBook/parameters/tns1:Book/tns1:signed)) then $JDBCQuery/Record[1]/signed else $updateBook/parameters/tns1:Book/tns1:signed
                                **
			   xsl:otherwise
				  xsl:attribute name="xsi:nil"
		 price = **
                                xsd:double(if(empty($updateBook/parameters/tns1:Book/tns1:price)) then $JDBCQuery/Record[1]/price	else $updateBook/parameters/tns1:Book/tns1:price)
                                **
		 isbn
			xsl:choose
			   xsl:when test="exists\($updateBook/parameters/tns1:Book/tns1:isbn\)" = **
                                $updateBook/parameters/tns1:Book/tns1:isbn
                              
    ```

|

    **repositoryAnalyticsRemoved:**

    |Mapping|
    |-------|
    |    ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/namespaces/tnt/plugins/jdbc+a3a36799-77f4-4471-9d52-b5927db93771+input" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tns1="http://www.example.org/Books" xmlns:xsd="http://www.w3.org/2001/XMLSchema" version="2.0">
   <xsl:param name="updateBook"/>
   <xsl:param name="JDBCQuery"/>
   <xsl:template name="updateBook-input" match="/">
      <tns:jdbcUpdateActivityInput>
         <name>
            <xsl:choose>
               <xsl:when test="exists(if(empty($updateBook/parameters/tns1:Book/tns1:name)) then $JDBCQuery/Record[1]/name else $updateBook/parameters/tns1:Book/tns1:name)">
                  <xsl:value-of select="if(empty($updateBook/parameters/tns1:Book/tns1:name)) then $JDBCQuery/Record[1]/name else $updateBook/parameters/tns1:Book/tns1:name"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </name>
         <description>
            <xsl:choose>
               <xsl:when test="exists(if(empty($updateBook/parameters/tns1:Book/tns1:description)) then $JDBCQuery/Record[1]/description else $updateBook/parameters/tns1:Book/tns1:description)">
                  <xsl:value-of select="if(empty($updateBook/parameters/tns1:Book/tns1:description)) then $JDBCQuery/Record[1]/description else $updateBook/parameters/tns1:Book/tns1:description"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </description>
         <authorName>
            <xsl:choose>
               <xsl:when test="exists(if(empty($updateBook/parameters/tns1:Book/tns1:authorName)) then $JDBCQuery/Record[1]/authorName else $updateBook/parameters/tns1:Book/tns1:authorName)">
                  <xsl:value-of select="if(empty($updateBook/parameters/tns1:Book/tns1:authorName)) then $JDBCQuery/Record[1]/authorName else $updateBook/parameters/tns1:Book/tns1:authorName"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </authorName>
         <releaseDate>
            <xsl:choose>
               <xsl:when test="exists(if(empty($updateBook/parameters/tns1:Book/tns1:releaseDate)) then $JDBCQuery/Record[1]/releaseDate else $updateBook/parameters/tns1:Book/tns1:releaseDate)">
                  <xsl:value-of select="if(empty($updateBook/parameters/tns1:Book/tns1:releaseDate)) then $JDBCQuery/Record[1]/releaseDate else $updateBook/parameters/tns1:Book/tns1:releaseDate"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </releaseDate>
         <vintage>
            <xsl:choose>
               <xsl:when test="exists(if(empty($updateBook/parameters/tns1:Book/tns1:vintage)) then $JDBCQuery/Record[1]/vintage else $updateBook/parameters/tns1:Book/tns1:vintage)">
                  <xsl:value-of select="if(empty($updateBook/parameters/tns1:Book/tns1:vintage)) then $JDBCQuery/Record[1]/vintage else $updateBook/parameters/tns1:Book/tns1:vintage"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </vintage>
         <signed>
            <xsl:choose>
               <xsl:when test="exists(if(empty($updateBook/parameters/tns1:Book/tns1:signed)) then $JDBCQuery/Record[1]/signed else $updateBook/parameters/tns1:Book/tns1:signed)">
                  <xsl:value-of select="if(empty($updateBook/parameters/tns1:Book/tns1:signed)) then $JDBCQuery/Record[1]/signed else $updateBook/parameters/tns1:Book/tns1:signed"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </signed>
         <price>
            <xsl:value-of select="xsd:double(if(empty($updateBook/parameters/tns1:Book/tns1:price)) then $JDBCQuery/Record[1]/price    else $updateBook/parameters/tns1:Book/tns1:price)"/>
         </price>
         <isbn>
            <xsl:choose>
               <xsl:when test="exists($updateBook/parameters/tns1:Book/tns1:isbn)">
                  <xsl:value-of select="$updateBook/parameters/tns1:Book/tns1:isbn"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="xsi:nil">true</xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </isbn>
      </tns:jdbcUpdateActivityInput>
   </xsl:template>
</xsl:stylesheet>

    ```

|

-   Type: bw.jdbc.update
-   JDBC Shared Resource: jdbcProperty
-   Timeout \(sec\): 10
-   Statement: UPDATE "public"."books" SET \("name", "description", "authorName", "releaseDate", "vintage", "signed", "price"\) = \(?, ?, ?, ?, ?, ?, ?\) WHERE "isbn" = ?
-   Parameters:

    No parameters

-   Thread Pool Shared Resource:
-   Insert if record doesn't exist: false
-   Override Transaction Behavior: false
-   Interpret Empty String As Null: false
-   Results Use Schema: false
-   Batch Update: false
-   Input Variable: updateBook-input
-   Output Variable: updateBook1
-   Input bindings:
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:jdbcUpdateActivityInput** **/name** /\[CHOOSE\]/\[WHEN\] exists\(if\(empty\($updateBook/parameters/tns1:Book/tns1:name\)\) then $JDBCQuery/Record\[1\]/name else $updateBook/parameters/tns1:Book/tns1:name\)|if\(empty\($updateBook/parameters/tns1:Book/tns1:name\)\) then $JDBCQuery/Record\[1\]/name else $updateBook/parameters/tns1:Book/tns1:name|
        |**/tns:jdbcUpdateActivityInput** **/description** /\[CHOOSE\]/\[WHEN\] exists\(if\(empty\($updateBook/parameters/tns1:Book/tns1:description\)\) then $JDBCQuery/Record\[1\]/description else $updateBook/parameters/tns1:Book/tns1:description\)|if\(empty\($updateBook/parameters/tns1:Book/tns1:description\)\) then $JDBCQuery/Record\[1\]/description else $updateBook/parameters/tns1:Book/tns1:description|
        |**/tns:jdbcUpdateActivityInput** **/authorName** /\[CHOOSE\]/\[WHEN\] exists\(if\(empty\($updateBook/parameters/tns1:Book/tns1:authorName\)\) then $JDBCQuery/Record\[1\]/authorName else $updateBook/parameters/tns1:Book/tns1:authorName\)|if\(empty\($updateBook/parameters/tns1:Book/tns1:authorName\)\) then $JDBCQuery/Record\[1\]/authorName else $updateBook/parameters/tns1:Book/tns1:authorName|
        |**/tns:jdbcUpdateActivityInput** **/releaseDate** /\[CHOOSE\]/\[WHEN\] exists\(if\(empty\($updateBook/parameters/tns1:Book/tns1:releaseDate\)\) then $JDBCQuery/Record\[1\]/releaseDate else $updateBook/parameters/tns1:Book/tns1:releaseDate\)|if\(empty\($updateBook/parameters/tns1:Book/tns1:releaseDate\)\) then $JDBCQuery/Record\[1\]/releaseDate else $updateBook/parameters/tns1:Book/tns1:releaseDate|
        |**/tns:jdbcUpdateActivityInput** **/vintage** /\[CHOOSE\]/\[WHEN\] exists\(if\(empty\($updateBook/parameters/tns1:Book/tns1:vintage\)\) then $JDBCQuery/Record\[1\]/vintage else $updateBook/parameters/tns1:Book/tns1:vintage\)|if\(empty\($updateBook/parameters/tns1:Book/tns1:vintage\)\) then $JDBCQuery/Record\[1\]/vintage else $updateBook/parameters/tns1:Book/tns1:vintage|
        |**/tns:jdbcUpdateActivityInput** **/signed** /\[CHOOSE\]/\[WHEN\] exists\(if\(empty\($updateBook/parameters/tns1:Book/tns1:signed\)\) then $JDBCQuery/Record\[1\]/signed else $updateBook/parameters/tns1:Book/tns1:signed\)|if\(empty\($updateBook/parameters/tns1:Book/tns1:signed\)\) then $JDBCQuery/Record\[1\]/signed else $updateBook/parameters/tns1:Book/tns1:signed|
        |**/tns:jdbcUpdateActivityInput** **/price**|xsd:double\(if\(empty\($updateBook/parameters/tns1:Book/tns1:price\)\) then $JDBCQuery/Record\[1\]/price else $updateBook/parameters/tns1:Book/tns1:price\)|
        |**/tns:jdbcUpdateActivityInput** **/isbn** /\[CHOOSE\]/\[WHEN\] exists\($updateBook/parameters/tns1:Book/tns1:isbn\)|$updateBook/parameters/tns1:Book/tns1:isbn|

    -   Mapping tree

        **repositoryAnalyticsAdded:**

        ```
        
                                  **
        	  tns:jdbcUpdateActivityInput
        		 name
        			xsl:choose
        			   xsl:when test="exists\(if\(empty\($updateBook/parameters/tns1:Book/tns1:name\)\) then $JDBCQuery/Record\[1\]/name else $updateBook/parameters/tns1:Book/tns1:name\)" = **
                                  if(empty($updateBook/parameters/tns1:Book/tns1:name)) then $JDBCQuery/Record[1]/name else $updateBook/parameters/tns1:Book/tns1:name
                                  **
        			   xsl:otherwise
        				  xsl:attribute name="xsi:nil"
        		 description
        			xsl:choose
        			   xsl:when test="exists\(if\(empty\($updateBook/parameters/tns1:Book/tns1:description\)\) then $JDBCQuery/Record\[1\]/description else $updateBook/parameters/tns1:Book/tns1:description\)" = **
                                  if(empty($updateBook/parameters/tns1:Book/tns1:description)) then $JDBCQuery/Record[1]/description else $updateBook/parameters/tns1:Book/tns1:description
                                  **
        			   xsl:otherwise
        				  xsl:attribute name="xsi:nil"
        		 authorName
        			xsl:choose
        			   xsl:when test="exists\(if\(empty\($updateBook/parameters/tns1:Book/tns1:authorName\)\) then $JDBCQuery/Record\[1\]/authorName else $updateBook/parameters/tns1:Book/tns1:authorName\)" = **
                                  if(empty($updateBook/parameters/tns1:Book/tns1:authorName)) then $JDBCQuery/Record[1]/authorName else $updateBook/parameters/tns1:Book/tns1:authorName
                                  **
        			   xsl:otherwise
        				  xsl:attribute name="xsi:nil"
        		 releaseDate
        			xsl:choose
        			   xsl:when test="exists\(if\(empty\($updateBook/parameters/tns1:Book/tns1:releaseDate\)\) then $JDBCQuery/Record\[1\]/releaseDate else $updateBook/parameters/tns1:Book/tns1:releaseDate\)" = **
                                  if(empty($updateBook/parameters/tns1:Book/tns1:releaseDate)) then $JDBCQuery/Record[1]/releaseDate else $updateBook/parameters/tns1:Book/tns1:releaseDate
                                  **
        			   xsl:otherwise
        				  xsl:attribute name="xsi:nil"
        		 vintage
        			xsl:choose
        			   xsl:when test="exists\(if\(empty\($updateBook/parameters/tns1:Book/tns1:vintage\)\) then $JDBCQuery/Record\[1\]/vintage else $updateBook/parameters/tns1:Book/tns1:vintage\)" = **
                                  if(empty($updateBook/parameters/tns1:Book/tns1:vintage)) then $JDBCQuery/Record[1]/vintage else $updateBook/parameters/tns1:Book/tns1:vintage
                                  **
        			   xsl:otherwise
        				  xsl:attribute name="xsi:nil"
        		 signed
        			xsl:choose
        			   xsl:when test="exists\(if\(empty\($updateBook/parameters/tns1:Book/tns1:signed\)\) then $JDBCQuery/Record\[1\]/signed else $updateBook/parameters/tns1:Book/tns1:signed\)" = **
                                  if(empty($updateBook/parameters/tns1:Book/tns1:signed)) then $JDBCQuery/Record[1]/signed else $updateBook/parameters/tns1:Book/tns1:signed
                                  **
        			   xsl:otherwise
        				  xsl:attribute name="xsi:nil"
        		 price = **
                                  xsd:double(if(empty($updateBook/parameters/tns1:Book/tns1:price)) then $JDBCQuery/Record[1]/price	else $updateBook/parameters/tns1:Book/tns1:price)
                                  **
        		 isbn
        			xsl:choose
        			   xsl:when test="exists\($updateBook/parameters/tns1:Book/tns1:isbn\)" = **
                                  $updateBook/parameters/tns1:Book/tns1:isbn
                                
        ```

    -   Source code

        **repositoryAnalyticsAdded:**

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://www.tibco.com/namespaces/tnt/plugins/jdbc+a3a36799-77f4-4471-9d52-b5927db93771+input" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:tns1="http://www.example.org/Books" xmlns:xsd="http://www.w3.org/2001/XMLSchema" version="2.0">
           <xsl:param name="updateBook"/>
           <xsl:param name="JDBCQuery"/>
           <xsl:template name="updateBook-input" match="/">
              <tns:jdbcUpdateActivityInput>
                 <name>
                    <xsl:choose>
                       <xsl:when test="exists(if(empty($updateBook/parameters/tns1:Book/tns1:name)) then $JDBCQuery/Record[1]/name else $updateBook/parameters/tns1:Book/tns1:name)">
                          <xsl:value-of select="if(empty($updateBook/parameters/tns1:Book/tns1:name)) then $JDBCQuery/Record[1]/name else $updateBook/parameters/tns1:Book/tns1:name"/>
                       </xsl:when>
                       <xsl:otherwise>
                          <xsl:attribute name="xsi:nil">true</xsl:attribute>
                       </xsl:otherwise>
                    </xsl:choose>
                 </name>
                 <description>
                    <xsl:choose>
                       <xsl:when test="exists(if(empty($updateBook/parameters/tns1:Book/tns1:description)) then $JDBCQuery/Record[1]/description else $updateBook/parameters/tns1:Book/tns1:description)">
                          <xsl:value-of select="if(empty($updateBook/parameters/tns1:Book/tns1:description)) then $JDBCQuery/Record[1]/description else $updateBook/parameters/tns1:Book/tns1:description"/>
                       </xsl:when>
                       <xsl:otherwise>
                          <xsl:attribute name="xsi:nil">true</xsl:attribute>
                       </xsl:otherwise>
                    </xsl:choose>
                 </description>
                 <authorName>
                    <xsl:choose>
                       <xsl:when test="exists(if(empty($updateBook/parameters/tns1:Book/tns1:authorName)) then $JDBCQuery/Record[1]/authorName else $updateBook/parameters/tns1:Book/tns1:authorName)">
                          <xsl:value-of select="if(empty($updateBook/parameters/tns1:Book/tns1:authorName)) then $JDBCQuery/Record[1]/authorName else $updateBook/parameters/tns1:Book/tns1:authorName"/>
                       </xsl:when>
                       <xsl:otherwise>
                          <xsl:attribute name="xsi:nil">true</xsl:attribute>
                       </xsl:otherwise>
                    </xsl:choose>
                 </authorName>
                 <releaseDate>
                    <xsl:choose>
                       <xsl:when test="exists(if(empty($updateBook/parameters/tns1:Book/tns1:releaseDate)) then $JDBCQuery/Record[1]/releaseDate else $updateBook/parameters/tns1:Book/tns1:releaseDate)">
                          <xsl:value-of select="if(empty($updateBook/parameters/tns1:Book/tns1:releaseDate)) then $JDBCQuery/Record[1]/releaseDate else $updateBook/parameters/tns1:Book/tns1:releaseDate"/>
                       </xsl:when>
                       <xsl:otherwise>
                          <xsl:attribute name="xsi:nil">true</xsl:attribute>
                       </xsl:otherwise>
                    </xsl:choose>
                 </releaseDate>
                 <vintage>
                    <xsl:choose>
                       <xsl:when test="exists(if(empty($updateBook/parameters/tns1:Book/tns1:vintage)) then $JDBCQuery/Record[1]/vintage else $updateBook/parameters/tns1:Book/tns1:vintage)">
                          <xsl:value-of select="if(empty($updateBook/parameters/tns1:Book/tns1:vintage)) then $JDBCQuery/Record[1]/vintage else $updateBook/parameters/tns1:Book/tns1:vintage"/>
                       </xsl:when>
                       <xsl:otherwise>
                          <xsl:attribute name="xsi:nil">true</xsl:attribute>
                       </xsl:otherwise>
                    </xsl:choose>
                 </vintage>
                 <signed>
                    <xsl:choose>
                       <xsl:when test="exists(if(empty($updateBook/parameters/tns1:Book/tns1:signed)) then $JDBCQuery/Record[1]/signed else $updateBook/parameters/tns1:Book/tns1:signed)">
                          <xsl:value-of select="if(empty($updateBook/parameters/tns1:Book/tns1:signed)) then $JDBCQuery/Record[1]/signed else $updateBook/parameters/tns1:Book/tns1:signed"/>
                       </xsl:when>
                       <xsl:otherwise>
                          <xsl:attribute name="xsi:nil">true</xsl:attribute>
                       </xsl:otherwise>
                    </xsl:choose>
                 </signed>
                 <price>
                    <xsl:value-of select="xsd:double(if(empty($updateBook/parameters/tns1:Book/tns1:price)) then $JDBCQuery/Record[1]/price    else $updateBook/parameters/tns1:Book/tns1:price)"/>
                 </price>
                 <isbn>
                    <xsl:choose>
                       <xsl:when test="exists($updateBook/parameters/tns1:Book/tns1:isbn)">
                          <xsl:value-of select="$updateBook/parameters/tns1:Book/tns1:isbn"/>
                       </xsl:when>
                       <xsl:otherwise>
                          <xsl:attribute name="xsi:nil">true</xsl:attribute>
                       </xsl:otherwise>
                    </xsl:choose>
                 </isbn>
              </tns:jdbcUpdateActivityInput>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


##### Name: **updateBookOut** {#updateBookOut}

-   Service: BooksPersist / operation: updateBook

    **repositoryAnalyticsRemoved:**

    |Mapping|
    |-------|
    |    ```

                                ** = **
                              
    ```

|

    **repositoryAnalyticsRemoved:**

    |Mapping|
    |-------|
    |    ```
<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20140929140236" xmlns:tns1="http://www.example.org/Books" version="2.0">
   <xsl:param name="updateBook"/>
   <xsl:template name="updateBookOut-input" match="/">
      <tns:updateBookResponse>
         <parameters>
            <xsl:copy-of select="$updateBook/parameters/tns1:Book"/>
         </parameters>
      </tns:updateBookResponse>
   </xsl:template>
</xsl:stylesheet>

    ```

|

-   ReplyWith: Output Message
-   Description:
-   Input bindings:
    -   Mapping table

        |Target|Source|
        |------|------|
        |**/tns:updateBookResponse** **/parameters**|/\[COPY-OF\] $updateBook/parameters/tns1:Book|

    -   Mapping tree

        **repositoryAnalyticsAdded:**

        ```
        
                                  ** = **
                                
        ```

    -   Source code

        **repositoryAnalyticsAdded:**

        ```
        <?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tns="http://xmlns.example.com/20140929140236" xmlns:tns1="http://www.example.org/Books" version="2.0">
           <xsl:param name="updateBook"/>
           <xsl:template name="updateBookOut-input" match="/">
              <tns:updateBookResponse>
                 <parameters>
                    <xsl:copy-of select="$updateBook/parameters/tns1:Book"/>
                 </parameters>
              </tns:updateBookResponse>
           </xsl:template>
        </xsl:stylesheet>
        
        ```


#### References: {#References}

#### Transitions: {#Transitions}

-   From: **OnMessageStart** -To: **Assign**
    -   Label:
    -   Type: SUCCESS

-   From: **Assign** -To: **ForEach**
    -   Label:
    -   Type: SUCCESS

-   From: **ForEach** -To: **addBooksOut**
    -   Label:
    -   Type: SUCCESS

-   From: **GroupStart** -To: **addBooks**
    -   Label:
    -   Type: SUCCESS

-   From: **addBooks** -To: **GroupEnd**
    -   Label:
    -   Type: SUCCESS

-   From: **getBooks** -To: **getAllBooksOut**
    -   Label:
    -   Type: SUCCESS

-   From: **getBookByISBN** -To: **getBookByISBNOut**
    -   Label:
    -   Type: SUCCESS

-   From: **updateBook** -To: **updateBookOut**
    -   Label:
    -   Type: SUCCESS

-   From: **JDBCQuery** -To: **updateBook**
    -   Label:
    -   Type: SUCCESS

-   From: **deleteBook** -To: **deleteBookOut**
    -   Label:
    -   Type: SUCCESS

-   From: **getRecentBooks** -To: **getRecentBooksOut**
    -   Label:
    -   Type: SUCCESS

