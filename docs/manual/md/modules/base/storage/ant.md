# ANT Interface {#StorageANT .concept}

Besides GUI Interface there is also command-line interface, that enables Administrators interact with Storage from scripts.

To use ANT Interface use following in User\_Home/MakeDocConfig directory:

```
ant -f commons storage.COMMAND
```

Following commands are available:

-   **storage.start** It starts storage process.
-   **storage.stop** It stops storage process.
-   **storage.drop** It completely wipes out complete storage.
-   **storage.cleanup** Storage can get into inconsistent state due to manual or administrative tasks. I.e. deletion of some records directly on disk. In this case it is necessary synchronized internal SQL database against disk directory. This can take a while on large installations.
-   **storage.portal** It recreates web portal interface. See more Portal Module documentation for more details.

**Parent topic:**[Storage](../../../modules/base/storage/index.md)

