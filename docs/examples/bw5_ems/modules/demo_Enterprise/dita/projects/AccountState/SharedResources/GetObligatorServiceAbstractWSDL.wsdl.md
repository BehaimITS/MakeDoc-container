# GetObligatorServiceAbstractWSDL {#Wsdl .concept}

Section contains description of WSDL Schema " GetObligatorServiceAbstractWSDL.wsdl " “[GetObligatorServiceAbstractWSDL.wsdl](GetObligatorServiceAbstractWSDL.wsdl)”

Source Library: " CalculateBonita "

Service:

Documentation:

**Parent topic:**[WSDLs](../../../../../../modules/demo_Enterprise/dita/projects/AccountState/common/wsdl.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
|AccountState|This application simulate get bank account state process which using rating of client bonita.|
|\\SharedResources|Resorces shared by processes|

## Diagram: {#Diagram}

Diagram [GetObligatorServiceAbstractWSDL.wsdl.svg](GetObligatorServiceAbstractWSDL.wsdl.svg)

Diagram of GetObligatorServiceAbstractWSDL.wsdl.

## Namespaces: {#Namespaces}

-   xmlns: - http://schemas.xmlsoap.org/wsdl/
-   xmlns: ns - http://www.tibco.com/schemas/GrantingCredit/SharedConnections/Schema1.xsd
-   xmlns: tns - http://xmlns.example.com/1171360277608
-   xmlns: xml - http://www.w3.org/XML/1998/namespace
-   xmlns: xsd - http://www.w3.org/2001/XMLSchema

## Types: {#Types}

## Port configuration: {#PortConfig}

*Empty*

## Operations: {#Operations}

-   **Name:**GetObligatorServiceOperation
    -   **Parameters:**
        -   **Input:**[tns:GetObligatorServiceInputMessage](#Messages)
        -   **Output:**[tns:GetObligatorServiceOutputMessage](#Messages)

## Messages: {#Messages}

-   **Name:**GetObligatorServiceInputMessage
    -   **Part Element:**ns:Name
    -   **Part Name:**part1
-   **Name:**GetObligatorServiceOutputMessage
    -   **Part Element:**ns:Obligator
    -   **Part Name:**part1

