# iProcess build step {#ip_build_step .concept}

**Run iProcess documentation** step generates documentation for TIBCO iProcess projects exported to HTML from TIBCO iProcess Workspace.

![](images/md_steps_iprocess_documentation.png "Run iProcess documentation step")

Run iProcess documentation parameters:

-   **Project name:** name used by core application
-   **Description:** short description \(used by core application\)
-   **HTML,PDF,DOCX:** generate this output format or not
-   **Storage:** storage to save generated output
-   **Group:** group generated documentation belongs to
-   **Repository:** repository generated documentation belongs to, see Chapter Portal for portal layers explanation
-   **Paper format:** A4 or Letter
-   **Profile:** profile to use, see Profiles chapter for default available profiles
-   **Projects directory:** directory on MakeDoc server machine where MakeDoc resursively search for exported iProcess HTML sources
-   **Cleanup Projects directory:** clean projects input directory after when documentation process finishes or not

**Parent topic:**[MakeDoc build steps](../../jenkins/md_build_steps/md_build_steps.md)

