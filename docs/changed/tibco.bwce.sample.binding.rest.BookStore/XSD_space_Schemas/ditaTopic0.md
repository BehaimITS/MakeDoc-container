# Books {#Books.xsd.dita .concept}

License for TIBCO Software Use Only!

Section contains documentation of changed XSD Schema Books \( [2024/07/09 13:28](../../../../../1720531707774/html/index.html?go=projects/tibco.bwce.sample.binding.rest.BookStore/Schemas/Books.xsd.md) , [2024/07/10 13:13](../../../../../1720617195969/html/index.html?go=projects/tibco.bwce.sample.binding.rest.BookStore/Schemas/Books.xsd.md) \).

**repositoryAnalyticsAdded:** Added element

**repositoryAnalyticsRemoved:** Deleted element

**Parent topic:**[XSD Schemas](../../../changed/tibco.bwce.sample.binding.rest.BookStore/XSD_space_Schemas/files.md)

## Changes: {#Books.xsd.dita_xmlComp}

### Books {#Xsd}

License for TIBCO Software Use Only!

Section contains description of XSD Schema Books.xsd “Books.xsd”

#### Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
||No description|

#### Diagram: {#Diagram}

#### Attributes {#Attributes}

-   elementFormDefault : qualified
-   targetNamespace : http://www.example.org/Books

#### Overview {#Overview}

##### Elements {#Elements}

-   Book
-   Books

##### Complex Types {#ComplexTypes}

-   Book
-   Books

#### Detail {#Detail}

##### complexType Book {#type_Book}

-   element isbn minOccurs 0 , type string

-   element name minOccurs 0 , type string

-   element description minOccurs 0 , type string

-   element authorName minOccurs 0 , type string

-   element releaseDate minOccurs 0 , type date

-   element vintage minOccurs 0 , type boolean

-   element signed minOccurs 0 , type boolean

-   element price minOccurs 0 , type float

**repositoryAnalyticsAdded:**

-   element CHANGE minOccurs 0 , type float

##### element Book {#element_Book}

-   type : tns:Book

##### complexType Books {#type_Books}

-   element maxOccurs unbounded , minOccurs 0 , ref tns:Book

##### element Books {#element_Books}

-   type : tns:Books

