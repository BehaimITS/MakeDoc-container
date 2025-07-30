# Configuration {#StorageConfig .concept}

Configuration of all storages are kept in ~/MakeDocConfig/general.properties file. Example of code:

```

general.storages.register=
{"storages":[
      {
         "name":"default",
         "dbLocation":"~/MakeDocConfig/storages/default.db",
         "recLocation":"~/MakeDocConfig/storages/default"
      }
]}

```

There can be defined more than one storage. Typically only one "default" storage is sufficient. Several modules like RepositoryAnalyst or CrossReference can work only on records stored within one storage.

**Parent topic:**[Storage](../../../modules/base/storage/index.md)

