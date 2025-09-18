# GetAccountStateConcreteWSDL {#Wsdl .concept}

License for TIBCO Software Use Only!

Section contains description of WSDL Schema “[GetAccountStateConcreteWSDL.wsdl](GetAccountStateConcreteWSDL.wsdl)”

Service: GetAccountStateService

Documentation:

**Parent topic:**[WSDLs](../../../projects/AccountState/common/wsdl.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
|AccountState|This application simulate get bank account state process which using rating of client bonita.|
|/SharedResources|Resorces shared by processes|

## Diagram: {#Diagram}

Diagram [GetAccountStateConcreteWSDL.wsdl.svg](GetAccountStateConcreteWSDL.wsdl.svg)

Diagram of GetAccountStateConcreteWSDL.wsdl.

## Namespaces: {#Namespaces}

-   xmlns: ns0 - http://www.tibco.com/schemas/AccountState/SharedResources/Schema.xsd
-   xmlns: soap - http://schemas.xmlsoap.org/wsdl/soap/
-   xmlns: tns - http://xmlns.example.com/1171610171437/GetAccountStateOperationImpl
-   xmlns: wsdl - http://schemas.xmlsoap.org/wsdl/
-   xmlns: xml - http://www.w3.org/XML/1998/namespace

## Types: {#Types}

### Namespace: http://www.tibco.com/schemas/AccountState/SharedResources/Schema.xsd {#http___www.tibco.com_schemas_AccountState_SharedResources_Schema.xsd}

-   schema
    -   ns0 : Account
    -   ns0 : AccountsList
    -   ns0 : MonthIncrement - xs:long
    -   ns0 : Name - xs:string
    -   ns0 : Number - xs:string
    -   ns0 : Password - xs:string
    -   ns0 : Value - xs:long

## Port configuration: {#PortConfig}

-   **Binding:**tns:UserName\_sp\_SOAPEventSourceBinding
-   **Name:**UserName\_sp\_SOAPEventSource
-   **Soap Address:**http://localhost:9998/ProcessDefinitions/GetAccountState/GetAccountStateService

## Operations: {#Operations}

-   **Name:**GetAccountStateOperation
    -   **Parameters:**
        -   **Input:**[tns:GetAccountStateServiceInputMessage](#Messages)
        -   **Output:**[tns:GetAccountStateServiceOutputMessage](#Messages)

## Messages: {#Messages}

-   **Name:**GetAccountStateServiceInputMessage
    -   **Part Element:**ns0:Name
    -   **Part Name:**part1
-   **Name:**GetAccountStateServiceOutputMessage
    -   **Part Element:**ns0:Account
    -   **Part Name:**part1

