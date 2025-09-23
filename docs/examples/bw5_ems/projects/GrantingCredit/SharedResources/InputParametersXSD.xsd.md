# InputParametersXSD {#Xsd .concept}

License for TIBCO Software Use Only!

Section contains description of XSD Schema InputParametersXSD.xsd“[InputParametersXSD.xsd](InputParametersXSD.xsd)”

**Parent topic:**[XSD Schemas](../../../projects/GrantingCredit/common/xsd.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
|GrantingCredit|The application Granting credit provides resolution whether a credit \(or mortgage\) can be granded to a user. Information about user is the input of the application.|

## Diagram: {#Diagram}

![Diagram
              InputParametersXSD.xsd](InputParametersXSD.xsd.png)

## Attributes {#Attributes}

-   *targetNamespace :* *http://www.tibco.com/schemas/GrantingCredit/SharedConnections/Schema.xsd*
-   *elementFormDefault :* *qualified*
-   *attributeFormDefault :* *unqualified*

## Overview {#Overview}

### Elements {#Elements}

-   [InputFile](#element_InputFile)
-   [FileName](#element_FileName)
-   [InputParameters](#element_InputParameters)
-   [Name](#element_Name)
-   [Value](#element_Value)
-   [Salary](#element_Salary)
-   [Pawn](#element_Pawn)
-   [RealtyDetail](#element_RealtyDetail)
-   [RealtyValue](#element_RealtyValue)
-   [Refund](#element_Refund)

## Detail {#Detail}

### element InputFile {#element_InputFile}

-   element*ref* *FileName*

### element FileName {#element_FileName}

-   *type :* *xs:string*

### element InputParameters {#element_InputParameters}

-   element*ref* *Name*

-   element*ref* *Value*

-   element*ref* *Refund*

-   element*ref* *Salary*

-   element*ref* *Pawn*

-   element*ref* *RealtyDetail*

-   element*ref* *RealtyValue*

### element Name {#element_Name}

-   *type :* *xs:string*

### element Value {#element_Value}

-   *type :* *xs:long*

### element Salary {#element_Salary}

-   *type :* *xs:long*

### element Pawn {#element_Pawn}

-   *type :* *xs:boolean*

### element RealtyDetail {#element_RealtyDetail}

-   *type :* *xs:string*

### element RealtyValue {#element_RealtyValue}

-   *type :* *xs:long*

### element Refund {#element_Refund}

-   *type :* *xs:long*

