# AccountsXSD {#Xsd .concept}

License for TIBCO Software Use Only!

Section contains description of XSD Schema AccountsXSD.xsd“[AccountsXSD.xsd](AccountsXSD.xsd)”

**Parent topic:**[XSD Schemas](../../../projects/AccountState/common/xsd.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
|AccountState|This application simulate get bank account state process which using rating of client bonita.|
|/SharedResources|Resorces shared by processes|

## Diagram: {#Diagram}

![Diagram
              AccountsXSD.xsd](AccountsXSD.xsd.png)

## Attributes {#Attributes}

-   *targetNamespace :**http://www.tibco.com/schemas/AccountState/SharedResources/Schema.xsd*
-   *elementFormDefault :**qualified*
-   *attributeFormDefault :**unqualified*

## Overview {#Overview}

### Elements {#Elements}

-   [AccountsList](#element_AccountsList)
-   [Account](#element_Account)
-   [Name](#element_Name)
-   [Value](#element_Value)
-   [Number](#element_Number)
-   [MonthIncrement](#element_MonthIncrement)
-   [Password](#element_Password)

## Detail {#Detail}

### element AccountsList {#element_AccountsList}

-   element*ref**Account* , *maxOccurs**unbounded*

-   attribute Count*type**xs:string* , *use**required*

### element Account {#element_Account}

-   element*ref**Number*

-   element*ref**Name*

-   element*ref**Value*

-   element*ref**MonthIncrement*

-   element*ref**Password*

### element Name {#element_Name}

-   *type :**xs:string*

### element Value {#element_Value}

-   *type :**xs:long*

### element Number {#element_Number}

-   *type :**xs:string*

### element MonthIncrement {#element_MonthIncrement}

-   *type :**xs:long*

### element Password {#element_Password}

-   *type :**xs:string*

