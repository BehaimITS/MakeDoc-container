# BooksDBService {#Wsdl .concept}

License for TIBCO Software Use Only!

Section contains description of WSDL Schema “[BooksDBService.wsdl](BooksDBService.wsdl)”

Section contains description of WSDL Schema “BooksDBService.wsdl”

Service:

Documentation:

**Parent topic:**[WSDLs](../../../projects/tibco.bwce.sample.binding.rest.BookStore/common/wsdl.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
| |No description|

## Diagram: {#Diagram}

Diagram [BooksDBService.wsdl.svg](BooksDBService.wsdl.svg)

Diagram of BooksDBService.wsdl.

## Namespaces: {#Namespaces}

-   xmlns: extns - http://www.example.org/Books
-   xmlns: tns - http://xmlns.example.com/20140929140236
-   xmlns: wsdl - http://schemas.xmlsoap.org/wsdl/
-   xmlns: xml - http://www.w3.org/XML/1998/namespace
-   xmlns: xsd - http://www.w3.org/2001/XMLSchema

## Types: {#Types}

## Port configuration: {#PortConfig}

*Empty*

## Operations: {#Operations}

-   **Name:**addBooks
    -   **Parameters:**
        -   **Input:**[tns:addBooksRequest](#Messages)
        -   **Output:**[tns:addBooksResponse](#Messages)
        -   **Fault:**[tns:addBooksFault](#Messages)

-   **Name:**deleteBook
    -   **Parameters:**
        -   **Input:**[tns:deleteBookRequest](#Messages)
        -   **Output:**[tns:deleteBookResponse](#Messages)

-   **Name:**getAllBooks
    -   **Parameters:**
        -   **Input:**[tns:getAllBooksRequest](#Messages)
        -   **Output:**[tns:getAllBooksResponse](#Messages)

-   **Name:**getBookByISBN
    -   **Parameters:**
        -   **Input:**[tns:getBookByISBNRequest](#Messages)
        -   **Output:**[tns:getBookByISBNResponse](#Messages)

-   **Name:**getRecentBooks
    -   **Parameters:**
        -   **Input:**[tns:getRecentBooksRequest](#Messages)
        -   **Output:**[tns:getRecentBooksResponse](#Messages)

-   **Name:**updateBook
    -   **Parameters:**
        -   **Input:**[tns:updateBookRequest](#Messages)
        -   **Output:**[tns:updateBookResponse](#Messages)

## Messages: {#Messages}

-   **Name:**addBooksFault
    -   **Part Element:**tns:addBooksFault
    -   **Part Name:**parameters
-   **Name:**addBooksRequest
    -   **Part Element:**tns:addBooksRequest
    -   **Part Name:**parameters
-   **Name:**addBooksResponse
    -   **Part Element:**extns:Books
    -   **Part Name:**parameters
-   **Name:**deleteBookRequest
    -   **Part Element:**tns:deleteBookRequest
    -   **Part Name:**parameters
-   **Name:**deleteBookResponse
    -   **Part Element:**tns:deleteBookResponse
    -   **Part Name:**parameters
-   **Name:**getAllBooksRequest
    -   **Part Element:**tns:getAllBooksRequest
    -   **Part Name:**parameters
-   **Name:**getAllBooksResponse
    -   **Part Element:**extns:Books
    -   **Part Name:**parameters
-   **Name:**getBookByISBNRequest
    -   **Part Element:**tns:getBookByISBNRequest
    -   **Part Name:**parameters
-   **Name:**getBookByISBNResponse
    -   **Part Element:**extns:Book
    -   **Part Name:**parameters
-   **Name:**getRecentBooksRequest
    -   **Part Element:**tns:getRecentBooksRequest
    -   **Part Name:**parameters
-   **Name:**getRecentBooksResponse
    -   **Part Element:**extns:Books
    -   **Part Name:**parameters
-   **Name:**updateBookRequest
    -   **Part Element:**extns:Book
    -   **Part Name:**parameters
-   **Name:**updateBookResponse
    -   **Part Element:**extns:Book
    -   **Part Name:**parameters

