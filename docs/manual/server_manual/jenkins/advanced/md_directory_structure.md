# Main directory structure {#jenkins .concept}

MakeDoc Server binaries, configuration and outputs are stored are stored in two directories.

-   **$MAKEDOC\_ROOT** - contains MakeDoc core binaries, configuration, outputs
-   **$JENKINS\_HOME** - contains MakeDoc server configuration, plugins

$MAKEDOC\_ROOT directory has following structure:

-   **bin** - MakeDoc core binaries
-   **cfg** - MakeDoc core configuration
-   **doc** - MakeDoc server documentation
-   **jenkins\_resources** - theme resources for MakeDoc server
-   **logs** - MakeDoc logs
-   **portal** - templates for portal and latest generated portal
-   **projects** - locally stored projects for documenting
-   **scripts** - MakeDoc server scripts \(ant interface\)
-   **storage** - generated outputs
-   **ws** - locally stored MakeDoc projects created at the beginning of documentation runs

$JENKINS\_HOME most important directory:

-   **plugins** - all plugins installed on MakeDoc server including MakeDoc plugin

**Parent topic:**[Advanced](../../jenkins/advanced/advanced.md)

