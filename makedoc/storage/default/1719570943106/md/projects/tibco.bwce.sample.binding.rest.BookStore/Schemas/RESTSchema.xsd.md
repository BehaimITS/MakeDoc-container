# RESTSchema {#Xsd .concept}

License for TIBCO Software Use Only!

Section contains description of XSD Schema RESTSchema.xsd“[RESTSchema.xsd](RESTSchema.xsd)”

**Parent topic:**[XSD Schemas](../../../projects/tibco.bwce.sample.binding.rest.BookStore/common/xsd.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
| |No description|

## Diagram: {#Diagram}

![Diagram
              RESTSchema.xsd](RESTSchema.xsd.png)

## Attributes {#Attributes}

-   *targetNamespace :**http://tns.tibco.com/bw/REST*

## Overview {#Overview}

### Elements {#Elements}

-   [messageBody](#element_messageBody)
-   [httpHeaders](#element_httpHeaders)
-   [statusLine](#element_statusLine)
-   [client4XXError](#element_client4XXError)
-   [server5XXError](#element_server5XXError)

### Complex Types {#ComplexTypes}

-   [httpTransportHeaders](#type_httpTransportHeaders)
-   [dynamicHeadersTypeDetails](#type_dynamicHeadersTypeDetails)
-   [dynamicHeadersType](#type_dynamicHeadersType)
-   [statusLineType](#type_statusLineType)
-   [client4XXErrorType](#type_client4XXErrorType)
-   [server5XXErrorType](#type_server5XXErrorType)

### Simple Types {#SimpleTypes}

-   [tmessageBody](#type_tmessageBody)

## Detail {#Detail}

### element messageBody {#element_messageBody}

-   *type :**tns:tmessageBody*

### simpleType tmessageBody {#type_tmessageBody}

-   restriction*base**string*

### complexType httpTransportHeaders {#type_httpTransportHeaders}

-   element Accept*form**unqualified* , *minOccurs**0* , *type**string*

-   element Accept-Charset*form**unqualified* , *minOccurs**0* , *type**string*

-   element Accept-Encoding*form**unqualified* , *minOccurs**0* , *type**string*

-   element Content-Type*form**unqualified* , *minOccurs**0* , *type**string*

-   element Content-Length*form**unqualified* , *minOccurs**0* , *type**string*

-   element Connection*form**unqualified* , *minOccurs**0* , *type**string*

-   element Cookie*form**unqualified* , *minOccurs**0* , *type**string*

-   element Pragma*form**unqualified* , *minOccurs**0* , *type**string*

-   element Authorization*form**unqualified* , *minOccurs**0* , *type**string*

-   element DynamicHeaders*maxOccurs**1* , *minOccurs**0* , *type**tns:dynamicHeadersType*

### complexType dynamicHeadersTypeDetails {#type_dynamicHeadersTypeDetails}

-   element Name*form**unqualified* , *maxOccurs**1* , *minOccurs**1* , *type**string*

-   element Value*form**unqualified* , *maxOccurs**1* , *minOccurs**1* , *type**string*

### complexType dynamicHeadersType {#type_dynamicHeadersType}

-   element Header*form**unqualified* , *maxOccurs**unbounded* , *minOccurs**0* , *type**tns:dynamicHeadersTypeDetails*

### element httpHeaders {#element_httpHeaders}

-   *type :**tns:httpTransportHeaders*

### complexType statusLineType {#type_statusLineType}

-   element statusCode*form**unqualified* , *maxOccurs**1* , *minOccurs**1* , *type**integer*

### element statusLine {#element_statusLine}

-   *type :**tns:statusLineType*

### complexType client4XXErrorType {#type_client4XXErrorType}

-   element statusCode*form**unqualified* , *maxOccurs**1* , *minOccurs**1* , *type**integer*

-   element message*form**unqualified* , *maxOccurs**1* , *minOccurs**0* , *type**string*

### element client4XXError {#element_client4XXError}

-   *type :**tns:client4XXErrorType*

### complexType server5XXErrorType {#type_server5XXErrorType}

-   element statusCode*form**unqualified* , *maxOccurs**1* , *minOccurs**1* , *type**integer*

-   element message*form**unqualified* , *maxOccurs**1* , *minOccurs**0* , *type**string*

### element server5XXError {#element_server5XXError}

-   *type :**tns:server5XXErrorType*

