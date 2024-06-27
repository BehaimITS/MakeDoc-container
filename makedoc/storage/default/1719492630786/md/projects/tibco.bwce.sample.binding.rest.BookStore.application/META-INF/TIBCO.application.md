# Application {#ApplicationMain .concept}

License for TIBCO Software Use Only!

Section contains description of Application " TIBCO.xml " .

**Parent topic:**[Application settings](../../../projects/tibco.bwce.sample.binding.rest.BookStore.application/common/application.md)

## Overview {#Overview}

-   ID: tibco.bwce.sample.binding.rest.BookStore.application
-   Version: 1.0.0.qualifier
-   Name: Tibco BWCE Sample Binding Rest BookStore Application
-   Vendor: TIBCO Software Inc.
-   Description: Using REST to Manage Books for a Bookstore

## Module Profiles {#ModuleProfile}

|Module Property Name|default|local|docker|
|--------------------|-------|-----|------|
|**//tibco.bwce.sample.binding.rest.BookStore//BW.APPNODE.NAME**| | | |
|**//tibco.bwce.sample.binding.rest.BookStore//BW.HOST.NAME**|localhost|localhost|localhost|
|**//tibco.bwce.sample.binding.rest.BookStore//BW.MODULE.VERSION**| | | |
|**//tibco.bwce.sample.binding.rest.BookStore//BW.DEPLOYMENTUNIT.NAME**| | | |
|**//tibco.bwce.sample.binding.rest.BookStore//BW.DEPLOYMENTUNIT.VERSION**| | | |
|**//tibco.bwce.sample.binding.rest.BookStore//BW.MODULE.NAME**| | | |
|**//tibco.bwce.sample.binding.rest.BookStore//dbDriver**|org.postgresql.Driver|org.postgresql.Driver|dbDriver|
|**//tibco.bwce.sample.binding.rest.BookStore//dbURL**|jdbc:postgresql://3.6.236.114:5432/postgres|jdbc:postgresql://10.97.106.28:5432/postgres|dbURL|
|**//tibco.bwce.sample.binding.rest.BookStore//dbPassword**|!QGg8qpD/DiuORP0rkq9eaEI+vZRPauvjmJFV2BmAPSU=|!GGJ+JL88lZfUCyq9BUmk92uzoH5HOM2XBF+Rv+JtedM=|dbPassword|
|**//tibco.bwce.sample.binding.rest.BookStore//dbUserName**|postgres|postgres|dbUserName|
|**//tibco.bwce.sample.binding.rest.BookStore//BW.CLOUD.PORT**|8080|8080|8080|
|**dbURL**|jdbc:postgresql://10.97.106.28:5432/postgres| | |

## Module Properties {#Module}

|Name|Type|Public Access|Scalable|Override|
|----|----|-------------|--------|--------|
|//tibco.bwce.sample.binding.rest.BookStore//BW.APPNODE.NAME|xsd:string|private|true|false|
|//tibco.bwce.sample.binding.rest.BookStore//BW.HOST.NAME|xsd:string|private|true|false|
|//tibco.bwce.sample.binding.rest.BookStore//BW.MODULE.VERSION|xsd:string|private|true|false|
|//tibco.bwce.sample.binding.rest.BookStore//BW.DEPLOYMENTUNIT.NAME|xsd:string|private|true|false|
|//tibco.bwce.sample.binding.rest.BookStore//BW.DEPLOYMENTUNIT.VERSION|xsd:string|private|true|false|
|//tibco.bwce.sample.binding.rest.BookStore//BW.MODULE.NAME|xsd:string|private|true|false|
|//tibco.bwce.sample.binding.rest.BookStore//dbDriver|xsd:string|public|true|false|
|//tibco.bwce.sample.binding.rest.BookStore//dbURL|xsd:string|public|true|false|
|//tibco.bwce.sample.binding.rest.BookStore//dbPassword|property:password|public|true|false|
|//tibco.bwce.sample.binding.rest.BookStore//dbUserName|xsd:string|public|true|false|
|//tibco.bwce.sample.binding.rest.BookStore//BW.CLOUD.PORT|xsd:int|private|true|false|
|dbURL|xsd:string|public|true|false|

## Module Includes {#ModuleIncludes}

|Name|Type|Version|
|----|----|-------|
|tibco.bwce.sample.binding.rest.BookStore|bw-appmodule,osgi-bundle|1.0.0.qualifier|

