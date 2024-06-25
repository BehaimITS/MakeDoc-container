# Books {#Xsd .concept}

License for TIBCO Software Use Only!

Section contains description of XSD Schema Books.xsd“[Books.xsd](Books.xsd)”

**Parent topic:**[XSD Schemas](../../../projects/tibco.bwce.sample.binding.rest.BookStore/common/xsd.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
| |No description|

## Diagram: {#Diagram}

![Diagram
              Books.xsd](Books.xsd.png)

## Attributes {#Attributes}

-   *elementFormDefault :**qualified*
-   *targetNamespace :**http://www.example.org/Books*

## Overview {#Overview}

### Elements {#Elements}

-   [Book](#element_Book)
-   [Books](#element_Books)

### Complex Types {#ComplexTypes}

-   [Book](#type_Book)
-   [Books](#type_Books)

## Detail {#Detail}

### complexType Book {#type_Book}

-   element isbn*minOccurs**0* , *type**string*

-   element name*minOccurs**0* , *type**string*

-   element description*minOccurs**0* , *type**string*

-   element authorName*minOccurs**0* , *type**string*

-   element releaseDate*minOccurs**0* , *type**date*

-   element vintage*minOccurs**0* , *type**boolean*

-   element signed*minOccurs**0* , *type**boolean*

-   element price*minOccurs**0* , *type**float*

### element Book {#element_Book}

-   *type :**tns:Book*

### complexType Books {#type_Books}

-   element*maxOccurs**unbounded* , *minOccurs**0* , *ref**tns:Book*

### element Books {#element_Books}

-   *type :**tns:Books*

