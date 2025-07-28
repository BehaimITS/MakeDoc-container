# Setup {#BaseModule .concept}

Portal using template engine that enables generate several views to MakeDoc repository. It comes out of the box with predefined templates. Beside these predefined templates end-user also can create own templates. The engine is FreeMarker so the templates has to comply FreeMarker Templates Language.

Portal requires two directories as input. The first contains all templates. The second directory is output directory for generated html. Location of these directories is stored in general.properties file:

```

        general.storages.portal.src=${user.home}/MakeDocConfig/portal/src
        general.storages.portal.out=${user.home}/MakeDocConfig/portal/out
      
```

**Parent topic:**[Portal](../../../../modules/base/portal/index.md)

