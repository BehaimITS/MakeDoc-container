# GetAccountStateAbstractWSDL {#Wsdl .concept}

License for TIBCO Software Use Only!

Section contains description of WSDL Schema “[GetAccountStateAbstractWSDL.wsdl](GetAccountStateAbstractWSDL.wsdl)”

Service:

Documentation:

**Parent topic:**[WSDLs](../../../projects/AccountState/common/wsdl.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
|AccountState|This application simulate get bank account state process which using rating of client bonita.|
|/SharedResources|Resorces shared by processes|

## Diagram: {#Diagram}

Diagram [GetAccountStateAbstractWSDL.wsdl.svg](GetAccountStateAbstractWSDL.wsdl.svg)

Diagram of GetAccountStateAbstractWSDL.wsdl.

## Namespaces: {#Namespaces}

-   xmlns: - http://schemas.xmlsoap.org/wsdl/
-   xmlns: ns - http://www.tibco.com/schemas/AccountState/SharedResources/Schema.xsd
-   xmlns: tns - http://xmlns.example.com/1171610171437
-   xmlns: xml - http://www.w3.org/XML/1998/namespace
-   xmlns: xsd - http://www.w3.org/2001/XMLSchema

## Types: {#Types}

## Port configuration: {#PortConfig}

*Empty*

## Operations: {#Operations}

-   **Name:** GetAccountStateOperation
    -   **Parameters:**
        -   **Input:** [tns:GetAccountStateServiceInputMessage](#Messages)
        -   **Output:** [tns:GetAccountStateServiceOutputMessage](#Messages)

## Messages: {#Messages}

-   **Name:** GetAccountStateServiceInputMessage
    -   **Part Element:** ns:Name
    -   **Part Name:** part1
-   **Name:** GetAccountStateServiceOutputMessage
    -   **Part Element:** ns:Account
    -   **Part Name:** part1

