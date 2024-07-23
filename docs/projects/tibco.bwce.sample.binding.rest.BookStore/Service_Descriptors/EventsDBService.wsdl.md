# EventsDBService {#Wsdl .concept}

License for TIBCO Software Use Only!

Section contains description of WSDL Schema “[EventsDBService.wsdl](EventsDBService.wsdl)”

Service:

Documentation:

**Parent topic:**[WSDLs](../../../projects/tibco.bwce.sample.binding.rest.BookStore/common/wsdl.md)

## Folder description: {#FolderDescription}

|Folder|Description|
|------|-----------|
| |No description|

## Diagram: {#Diagram}

Diagram [EventsDBService.wsdl.svg](EventsDBService.wsdl.svg)

Diagram of EventsDBService.wsdl.

## Namespaces: {#Namespaces}

-   xmlns: extns - http://www.example.org/Events
-   xmlns: tns - http://xmlns.example.com/20141006121028
-   xmlns: wsdl - http://schemas.xmlsoap.org/wsdl/
-   xmlns: xml - http://www.w3.org/XML/1998/namespace
-   xmlns: xsd - http://www.w3.org/2001/XMLSchema

## Types: {#Types}

### Namespace: http://xmlns.example.com/20141006121028 {#http___xmlns.example.com_20141006121028}

-   schema
    -   tns : getAllEventsRequest
    -   tns : getAllEventsResponse
    -   tns : getAllEventsFault
    -   tns : addEventsRequest
    -   tns : addEventsResponse
    -   tns : getEventByIDRequest
    -   tns : getEventByIDResponse
    -   tns : updateEventRequest
    -   tns : updateEventResponse
    -   tns : deleteEventRequest
    -   tns : deleteEventResponse
    -   tns : getEventByISBNRequest
    -   tns : getEventByISBNResponse

## Port configuration: {#PortConfig}

*Empty*

## Operations: {#Operations}

-   **Name:**addEvents
    -   **Parameters:**
        -   **Input:**[tns:addEventsRequest](#Messages)
        -   **Output:**[tns:addEventsResponse](#Messages)

-   **Name:**deleteEvent
    -   **Parameters:**
        -   **Input:**[tns:deleteEventRequest](#Messages)
        -   **Output:**[tns:deleteEventResponse](#Messages)

-   **Name:**getAllEvents
    -   **Parameters:**
        -   **Input:**[tns:getAllEventsRequest](#Messages)
        -   **Output:**[tns:getAllEventsResponse](#Messages)
        -   **Fault:**[tns:getAllEventsFault](#Messages)

-   **Name:**getEventByID
    -   **Parameters:**
        -   **Input:**[tns:getEventByIDRequest](#Messages)
        -   **Output:**[tns:getEventByIDResponse](#Messages)

-   **Name:**getEventByISBN
    -   **Parameters:**
        -   **Input:**[tns:getEventByISBNRequest](#Messages)
        -   **Output:**[tns:getEventByISBNResponse](#Messages)

-   **Name:**updateEvent
    -   **Parameters:**
        -   **Input:**[tns:updateEventRequest](#Messages)
        -   **Output:**[tns:updateEventResponse](#Messages)

## Messages: {#Messages}

-   **Name:**addEventsRequest
    -   **Part Element:**extns:Events
    -   **Part Name:**parameters
-   **Name:**addEventsResponse
    -   **Part Element:**extns:Events
    -   **Part Name:**parameters
-   **Name:**deleteEventRequest
    -   **Part Element:**tns:deleteEventRequest
    -   **Part Name:**parameters
-   **Name:**deleteEventResponse
    -   **Part Element:**tns:deleteEventResponse
    -   **Part Name:**parameters
-   **Name:**getAllEventsFault
    -   **Part Element:**tns:getAllEventsFault
    -   **Part Name:**parameters
-   **Name:**getAllEventsRequest
    -   **Part Element:**tns:getAllEventsRequest
    -   **Part Name:**parameters
-   **Name:**getAllEventsResponse
    -   **Part Element:**extns:Events
    -   **Part Name:**parameters
-   **Name:**getEventByIDRequest
    -   **Part Element:**tns:getEventByIDRequest
    -   **Part Name:**parameters
-   **Name:**getEventByIDResponse
    -   **Part Element:**extns:Event
    -   **Part Name:**parameters
-   **Name:**getEventByISBNRequest
    -   **Part Element:**tns:getEventByISBNRequest
    -   **Part Name:**parameters
-   **Name:**getEventByISBNResponse
    -   **Part Element:**extns:Events
    -   **Part Name:**parameters
-   **Name:**updateEventRequest
    -   **Part Element:**extns:Event
    -   **Part Name:**parameters
-   **Name:**updateEventResponse
    -   **Part Element:**extns:Event
    -   **Part Name:**parameters

