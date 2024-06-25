# Events {#Xsd .concept}

License for TIBCO Software Use Only!

Section contains description of XSD Schema Events.xsd“[Events.xsd](Events.xsd)”

**Parent topic:**[XSD Schemas](../../../projects/tibco.bwce.sample.binding.rest.BookStore/common/xsd.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
| |No description|

## Diagram: {#Diagram}

![Diagram
              Events.xsd](Events.xsd.png)

## Attributes {#Attributes}

-   *elementFormDefault :**qualified*
-   *targetNamespace :**http://www.example.org/Events*

## Overview {#Overview}

### Elements {#Elements}

-   [Event](#element_Event)
-   [Events](#element_Events)

### Complex Types {#ComplexTypes}

-   [Event](#type_Event)
-   [Events](#type_Events)

## Detail {#Detail}

### complexType Event {#type_Event}

-   element id*minOccurs**0* , *type**string*

-   element summary*minOccurs**0* , *type**string*

-   element description*minOccurs**0* , *type**string*

-   element authorName*minOccurs**0* , *type**string*

-   element bookIsbn*minOccurs**0* , *type**string*

-   element date*minOccurs**0* , *type**string*

### element Event {#element_Event}

-   *type :**tns:Event*

### complexType Events {#type_Events}

-   element*maxOccurs**unbounded* , *minOccurs**0* , *ref**tns:Event*

### element Events {#element_Events}

-   *type :**tns:Events*

