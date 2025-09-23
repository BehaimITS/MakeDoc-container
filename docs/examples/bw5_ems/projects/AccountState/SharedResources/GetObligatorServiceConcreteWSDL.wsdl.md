# GetObligatorServiceConcreteWSDL {#Wsdl .concept}

Section contains description of WSDL Schema " GetObligatorServiceConcreteWSDL.wsdl " “[GetObligatorServiceConcreteWSDL.wsdl](GetObligatorServiceConcreteWSDL.wsdl)”

Source Library: " CalculateBonita "

Service: GetObligatorService

Documentation:

**Parent topic:**[WSDLs](../../../projects/AccountState/common/wsdl.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
|AccountState|This application simulate get bank account state process which using rating of client bonita.|
|/SharedResources|Resorces shared by processes|

## Diagram: {#Diagram}

Diagram [GetObligatorServiceConcreteWSDL.wsdl.svg](GetObligatorServiceConcreteWSDL.wsdl.svg)

Diagram of GetObligatorServiceConcreteWSDL.wsdl.

## Namespaces: {#Namespaces}

-   xmlns: ns0 - http://www.tibco.com/schemas/GrantingCredit/SharedConnections/Schema1.xsd
-   xmlns: soap - http://schemas.xmlsoap.org/wsdl/soap/
-   xmlns: tns - http://xmlns.example.com/1171360277608/GetObligatorServiceOperationImpl
-   xmlns: wsdl - http://schemas.xmlsoap.org/wsdl/
-   xmlns: xml - http://www.w3.org/XML/1998/namespace

## Types: {#Types}

### Namespace: http://www.tibco.com/schemas/GrantingCredit/SharedConnections/Schema1.xsd {#http___www.tibco.com_schemas_GrantingCredit_SharedConnections_Schema1.xsd}

-   schema
    -   ns0 : Name - xs:string
    -   ns0 : Obligator
    -   ns0 : ObligatorsList
    -   ns0 : Problem - xs:boolean
    -   ns0 : Refund - xs:long
    -   ns0 : Value - xs:long

## Port configuration: {#PortConfig}

-   **Binding:** tns:ObligatorName\_sp\_SOAPEventSourceBinding
-   **Name:** ObligatorName\_sp\_SOAPEventSource
-   **Soap Address:** http://localhost:9997/ProcessDefinitions/GetObligator/GetObligatorService

## Operations: {#Operations}

-   **Name:** GetObligatorServiceOperation
    -   **Parameters:**
        -   **Input:** [tns:GetObligatorServiceInputMessage](#Messages)
        -   **Output:** [tns:GetObligatorServiceOutputMessage](#Messages)

## Messages: {#Messages}

-   **Name:** GetObligatorServiceInputMessage
    -   **Part Element:** ns0:Name
    -   **Part Name:** part1
-   **Name:** GetObligatorServiceOutputMessage
    -   **Part Element:** ns0:Obligator
    -   **Part Name:** part1

