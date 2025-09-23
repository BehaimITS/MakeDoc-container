# ObligatorsRegistrXSD {#Xsd .concept}

License for TIBCO Software Use Only!

Section contains description of XSD Schema ObligatorsRegistrXSD.xsd“[ObligatorsRegistrXSD.xsd](ObligatorsRegistrXSD.xsd)”

**Parent topic:**[XSD Schemas](../../../projects/AccountState/common/xsd.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
|AccountState|This application simulate get bank account state process which using rating of client bonita.|
|/SharedResources|Resorces shared by processes|

## Diagram: {#Diagram}

![Diagram
              ObligatorsRegistrXSD.xsd](ObligatorsRegistrXSD.xsd.png)

## Attributes {#Attributes}

-   *targetNamespace :* *http://www.tibco.com/schemas/GrantingCredit/SharedConnections/Schema1.xsd*
-   *elementFormDefault :* *qualified*
-   *attributeFormDefault :* *unqualified*

## Overview {#Overview}

### Elements {#Elements}

-   [ObligatorsList](#element_ObligatorsList)
-   [Obligator](#element_Obligator)
-   [Name](#element_Name)
-   [Value](#element_Value)
-   [Problem](#element_Problem)
-   [Refund](#element_Refund)

## Detail {#Detail}

### element ObligatorsList {#element_ObligatorsList}

-   element*ref* *Obligator* , *maxOccurs* *unbounded*

-   attribute Count*type* *xs:string* , *use* *required*

### element Obligator {#element_Obligator}

-   element*ref* *Name*

-   element*ref* *Value*

-   element*ref* *Problem*

-   element*ref* *Refund*

### element Name {#element_Name}

-   *type :* *xs:string*

### element Value {#element_Value}

-   *type :* *xs:long*

### element Problem {#element_Problem}

-   *type :* *xs:boolean*

### element Refund {#element_Refund}

-   *type :* *xs:long*

