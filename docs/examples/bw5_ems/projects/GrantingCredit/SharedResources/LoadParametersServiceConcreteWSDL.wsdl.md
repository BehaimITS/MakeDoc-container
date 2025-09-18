# LoadParametersServiceConcreteWSDL {#Wsdl .concept}

License for TIBCO Software Use Only!

Section contains description of WSDL Schema “[LoadParametersServiceConcreteWSDL.wsdl](LoadParametersServiceConcreteWSDL.wsdl)”

Service: LoadParametersService

Documentation:

**Parent topic:**[WSDLs](../../../projects/GrantingCredit/common/wsdl.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
|GrantingCredit|The application Granting credit provides resolution whether a credit \(or mortgage\) can be granded to a user. Information about user is the input of the application.|

## Diagram: {#Diagram}

Diagram [LoadParametersServiceConcreteWSDL.wsdl.svg](LoadParametersServiceConcreteWSDL.wsdl.svg)

Diagram of LoadParametersServiceConcreteWSDL.wsdl.

## Namespaces: {#Namespaces}

-   xmlns: ns0 - http://www.tibco.com/schemas/GrantingCredit/SharedConnections/Schema.xsd
-   xmlns: soap - http://schemas.xmlsoap.org/wsdl/soap/
-   xmlns: tns - http://xmlns.example.com/1171295149828/LoadParametersServiceOperationImpl
-   xmlns: wsdl - http://schemas.xmlsoap.org/wsdl/
-   xmlns: xml - http://www.w3.org/XML/1998/namespace

## Types: {#Types}

### Namespace: http://www.tibco.com/schemas/GrantingCredit/SharedConnections/Schema.xsd {#http___www.tibco.com_schemas_GrantingCredit_SharedConnections_Schema.xsd}

-   schema
    -   ns0 : FileName - xs:string
    -   ns0 : InputFile
    -   ns0 : InputParameters
    -   ns0 : Name - xs:string
    -   ns0 : Pawn - xs:boolean
    -   ns0 : RealtyDetail - xs:string
    -   ns0 : RealtyValue - xs:long
    -   ns0 : Refund - xs:long
    -   ns0 : Salary - xs:long
    -   ns0 : Value - xs:long

## Port configuration: {#PortConfig}

-   **Binding:**tns:InputFileName\_sp\_from\_sp\_SOAPEventSourceBinding
-   **Name:**InputFileName\_sp\_from\_sp\_SOAPEventSource
-   **Soap Address:**http://localhost:9998/ProcessDefinitions/LoadParameters/LoadParametersService

## Operations: {#Operations}

-   **Name:**LoadParametersServiceOperation
    -   **Parameters:**
        -   **Input:**[tns:LoadParametersServiceInputMessage](#Messages)
        -   **Output:**[tns:LoadParametersServiceOutputMessage](#Messages)

## Messages: {#Messages}

-   **Name:**LoadParametersServiceInputMessage
    -   **Part Element:**ns0:InputFile
    -   **Part Name:**part1
-   **Name:**LoadParametersServiceOutputMessage
    -   **Part Element:**ns0:InputParameters
    -   **Part Name:**part1

