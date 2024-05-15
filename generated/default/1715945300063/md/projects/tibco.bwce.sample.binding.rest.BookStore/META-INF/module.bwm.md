# Module {#ModuleMain .concept}

License for TIBCO Software Use Only!

Section contains Module properties " /home/makedoc/projects/tibco.bwce.sample.binding.rest.BookStore/tibco.bwce.sample.binding.rest.BookStore/META-INF/module.bwm " .

Name: tibco.bwce.sample.binding.rest.BookStore

**Parent topic:**[Module Descriptor](../../../projects/tibco.bwce.sample.binding.rest.BookStore/common/moduleDescriptor.md)

## Overview {#Overview}

-   ID: tibco.bwce.sample.binding.rest.BookStore
-   Version: 1.0.0.qualifier
-   Name: Tibco Bw Sample Binding Rest BookStore Module
-   Vendor: TIBCO Software Inc.
-   Description: Using REST to Manage Books for a Bookstore

## Module Properties {#Module}

|Name|Type|Public Access|Scalable|Description|
|----|----|-------------|--------|-----------|
|BW.APPNODE.NAME|XMLSchema:string|false|true| |
|BW.HOST.NAME|XMLSchema:string|false|true| |
|BW.MODULE.VERSION|XMLSchema:string|false|true| |
|BW.DEPLOYMENTUNIT.NAME|XMLSchema:string|false|true| |
|BW.DEPLOYMENTUNIT.VERSION|XMLSchema:string|false|true| |
|BW.MODULE.NAME|XMLSchema:string|false|true| |
|dbDriver|XMLSchema:string|true|true| |
|dbPassword|property:password|true|true| |
|dbURL|XMLSchema:string|true|true| |
|dbUserName|XMLSchema:string|true|true| |
|BW.CLOUD.PORT|XMLSchema:int|false|true| |

## Module Components {#ModuleComponents}

|Name|Process Name|Version|
|----|------------|-------|
|ComponentBooks|tibco.bwce.sample.binding.rest.bookstore.Books|1.0.0.qualifier|
|ComponentEvents|tibco.bwce.sample.binding.rest.bookstore.Events|1.0.0.qualifier|
|ComponentActivator|tibco.bwce.sample.binding.rest.bookstore.Activator|1.0.0.qualifier|

## Module Shared Variables {#ModuleMSV}

## Module Job Shared Variables {#ModuleJSV}

## Module Dependencies {#ModuleMF}

|Namespace|Module Filter|
|---------|-------------|
|com.tibco.bw.model|filter:="\(name=bwext\)"|
|com.tibco.bw.sharedresource.model|filter:="\(name=bw.httpconnector\)"|
|com.tibco.bw.binding.model|filter:="\(name=bw.rest\)"|
|com.tibco.bw.sharedresource.model|filter:="\(name=bw.jdbc\)"|
|com.tibco.bw.palette|filter:="\(name=bw.generalactivities\)"|

