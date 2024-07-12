# Books {#Books.wsdl.dita .concept}

License for TIBCO Software Use Only!

Section contains documentation of changed WSDL Books \( [2024/07/10 13:13](../../../../../1720617195969/html/index.html?go=projects/tibco.bwce.sample.binding.rest.BookStore/Service_Descriptors/Books.wsdl.md) , [2024/07/12 13:24](../../../../../1720790684513/html/index.html?go=projects/tibco.bwce.sample.binding.rest.BookStore/Service_Descriptors/Books.wsdl.md) \).

**repositoryAnalyticsAdded:** Added element

**repositoryAnalyticsRemoved:** Deleted element

**Parent topic:**[WSDLs](../../../changed/tibco.bwce.sample.binding.rest.BookStore/WSDLs/files.md)

## Changes: {#Books.wsdl.dita_xmlComp}

### Books {#Wsdl}

License for TIBCO Software Use Only!

Section contains description of WSDL Schema “Books.wsdl”

Service:

Documentation:

#### Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
||No description|

#### Diagram: {#Diagram}

Diagram Books.wsdl.svg

Diagram of Books.wsdl.

#### Namespaces: {#Namespaces}

-   xmlns: extns1 - http://tns.tibco.com/bw/REST
-   xmlns: extns2 - http://www.example.org/Books/REST/1411989492608/ConceptSchema
-   xmlns: extns3 - http://www.example.org/Events
-   xmlns: extns - http://www.example.org/Books
-   xmlns: tibex - http://www.tibco.com/bpel/2007/extensions
-   xmlns: tns - http://www.example.org/Books/REST/1411989492608
-   xmlns: wsdl - http://schemas.xmlsoap.org/wsdl/
-   xmlns: xml - http://www.w3.org/XML/1998/namespace
-   xmlns: xsd - http://www.w3.org/2001/XMLSchema

#### Types: {#Types}

#### Port configuration: {#PortConfig}

Empty

#### Operations: {#Operations}

-   **Name:** delete
    -   **Parameters:**
        -   **Input:** tns:deleteRequest
        -   **Output:** tns:deleteResponse
        -   **Fault:** tns:delete4XXFaultMessage
        -   **Fault:** tns:delete5XXFaultMessage

-   **Name:** get
    -   **Parameters:**
        -   **Input:** tns:getRequest
        -   **Output:** tns:getResponse
        -   **Fault:** tns:get4XXFaultMessage
        -   **Fault:** tns:get5XXFaultMessage

-   **Name:** get
    -   **Parameters:**
        -   **Input:** tns:getRequest1
        -   **Output:** tns:getResponse1
        -   **Fault:** tns:get4XXFaultMessage1
        -   **Fault:** tns:get5XXFaultMessage1

-   **Name:** get
    -   **Parameters:**
        -   **Input:** tns:getRequest2
        -   **Output:** tns:getResponse2
        -   **Fault:** tns:get4XXFaultMessage2
        -   **Fault:** tns:get5XXFaultMessage2

-   **Name:** post
    -   **Parameters:**
        -   **Input:** tns:postRequest
        -   **Output:** tns:postResponse
        -   **Fault:** tns:post4XXFaultMessage
        -   **Fault:** tns:post5XXFaultMessage

-   **Name:** put
    -   **Parameters:**
        -   **Input:** tns:putRequest
        -   **Output:** tns:putResponse
        -   **Fault:** tns:put4XXFaultMessage
        -   **Fault:** tns:put5XXFaultMessage

#### Messages: {#Messages}

-   **Name:** delete4XXFaultMessage
    -   **Part Element:** extns1:client4XXError
    -   **Part Name:** clientError
-   **Name:** delete5XXFaultMessage
    -   **Part Element:** extns1:server5XXError
    -   **Part Name:** serverError
-   **Name:** deleteRequest
    -   **Part Element:** extns1:httpHeaders
    -   **Part Name:** httpHeaders
    -   **Part Element:** extns2:BookParameters
    -   **Part Name:** parameters
-   **Name:** deleteResponse
    -   **Part Element:**
    -   **Part Name:** msg
-   **Name:** get4XXFaultMessage
    -   **Part Element:** extns1:client4XXError
    -   **Part Name:** clientError
-   **Name:** get4XXFaultMessage1
    -   **Part Element:** extns1:client4XXError
    -   **Part Name:** clientError
-   **Name:** get4XXFaultMessage2
    -   **Part Element:** extns1:client4XXError
    -   **Part Name:** clientError
-   **Name:** get5XXFaultMessage
    -   **Part Element:** extns1:server5XXError
    -   **Part Name:** serverError
-   **Name:** get5XXFaultMessage1
    -   **Part Element:** extns1:server5XXError
    -   **Part Name:** serverError
-   **Name:** get5XXFaultMessage2
    -   **Part Element:** extns1:server5XXError
    -   **Part Name:** serverError
-   **Name:** getRequest
    -   **Part Element:** extns1:httpHeaders
    -   **Part Name:** httpHeaders
-   **Name:** getRequest1
    -   **Part Element:** extns1:httpHeaders
    -   **Part Name:** httpHeaders
    -   **Part Element:** extns2:BookParameters
    -   **Part Name:** parameters
-   **Name:** getRequest2
    -   **Part Element:** extns1:httpHeaders
    -   **Part Name:** httpHeaders
    -   **Part Element:** extns2:Book1Parameters
    -   **Part Name:** parameters
-   **Name:** getResponse
    -   **Part Element:** extns:Books
    -   **Part Name:** item
-   **Name:** getResponse1
    -   **Part Element:** extns:Book
    -   **Part Name:** item
-   **Name:** getResponse2
    -   **Part Element:** extns3:Events
    -   **Part Name:** item
-   **Name:** post4XXFaultMessage
    -   **Part Element:** extns1:client4XXError
    -   **Part Name:** clientError
-   **Name:** post5XXFaultMessage
    -   **Part Element:** extns1:server5XXError
    -   **Part Name:** serverError
-   **Name:** postRequest
    -   **Part Element:** extns:Books
    -   **Part Name:** item
    -   **Part Element:** extns1:httpHeaders
    -   **Part Name:** httpHeaders
-   **Name:** postResponse
    -   **Part Element:** extns:Books
    -   **Part Name:** item
-   **Name:** put4XXFaultMessage
    -   **Part Element:** extns1:client4XXError
    -   **Part Name:** clientError
-   **Name:** put5XXFaultMessage
    -   **Part Element:** extns1:server5XXError
    -   **Part Name:** serverError
-   **Name:** putRequest
    -   **Part Element:** extns:Book
    -   **Part Name:** item
    -   **Part Element:** extns1:httpHeaders
    -   **Part Name:** httpHeaders
    -   **Part Element:** extns2:BookParameters
    -   **Part Name:** parameters
-   **Name:** putResponse
    -   **Part Element:** extns:Book
    -   **Part Name:** item
-   **repositoryAnalyticsRemoved:** **Name:**

    **repositoryAnalyticsRemoved:** CHANGE

    **repositoryAnalyticsRemoved:**

    -   **Part Element:** extns:CHANGE
    -   **Part Name:** CHANGE

