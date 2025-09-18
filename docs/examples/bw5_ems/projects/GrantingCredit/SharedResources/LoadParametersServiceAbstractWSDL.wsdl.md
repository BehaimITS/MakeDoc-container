# LoadParametersServiceAbstractWSDL {#Wsdl .concept}

License for TIBCO Software Use Only!

Section contains description of WSDL Schema “[LoadParametersServiceAbstractWSDL.wsdl](LoadParametersServiceAbstractWSDL.wsdl)”

Service:

Documentation:

**Parent topic:**[WSDLs](../../../projects/GrantingCredit/common/wsdl.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
|GrantingCredit|The application Granting credit provides resolution whether a credit \(or mortgage\) can be granded to a user. Information about user is the input of the application.|

## Diagram: {#Diagram}

Diagram [LoadParametersServiceAbstractWSDL.wsdl.svg](LoadParametersServiceAbstractWSDL.wsdl.svg)

Diagram of LoadParametersServiceAbstractWSDL.wsdl.

## Namespaces: {#Namespaces}

-   xmlns: - http://schemas.xmlsoap.org/wsdl/
-   xmlns: ns - http://www.tibco.com/schemas/GrantingCredit/SharedConnections/Schema.xsd
-   xmlns: tns - http://xmlns.example.com/1171295149828
-   xmlns: xml - http://www.w3.org/XML/1998/namespace
-   xmlns: xsd - http://www.w3.org/2001/XMLSchema

## Types: {#Types}

## Port configuration: {#PortConfig}

*Empty*

## Operations: {#Operations}

-   **Name:**LoadParametersServiceOperation
    -   **Parameters:**
        -   **Input:**[tns:LoadParametersServiceInputMessage](#Messages)
        -   **Output:**[tns:LoadParametersServiceOutputMessage](#Messages)

## Messages: {#Messages}

-   **Name:**LoadParametersServiceInputMessage
    -   **Part Element:**ns:InputFile
    -   **Part Name:**part1
-   **Name:**LoadParametersServiceOutputMessage
    -   **Part Element:**ns:InputParameters
    -   **Part Name:**part1

