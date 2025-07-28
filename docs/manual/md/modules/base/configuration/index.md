# Configuration {#BaseModule .concept}

Base Module defines principles that are common for all other modules.

Main MakeDoc configuration location is

```
${user_home}/MakeDocConfig
```

. Every module has its own configuration file stored under this directory. For module specific configuration please refer Module's documentation.

Base Module configuration is stored in file

```
general.properties.
```

. There are several important properties.

|Parameter|Default value|Description|
|---------|-------------|-----------|
|general.makedoc.prod|Set during installation.|Location where MakeDoc is installed.|
|general.licence.file|$\{user.home\}/MakeDocConfig/license/customer.key|Location of license key.|
|general.storages.register|JSON format|Register of storages, their locations. For details refer Storage documentation.|
|general.storages.portal.\*| |Location of Portal templates and output directory. For details refer Portal documentation.|

**Parent topic:**[Base Module](../../../modules/base/index.md)

