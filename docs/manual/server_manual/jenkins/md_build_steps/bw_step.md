# BusinessWorks build step {#bw_build_step .concept}

**Run BW documentation** step generates documentation for TIBCO BusinessWorks projects or deployments.

![](images/md_steps_bw_documentation.png "Run BW documentation step")

Run BW documentation parameters:

-   **Project name:** name used by core application
-   **Description:** short description \(used by core application\)
-   **HTML,PDF,DOCX:** generate this output format or not
-   **Storage:** storage to save generated output
-   **Group:** group generated documentation belongs to
-   **Repository:** repository generated documentation belongs to, see Chapter Portal for portal layers explanation
-   **Paper format:** A4 or Letter
-   **Input bindings type:** all, table, tree, raw \(various ways how to display input bindings, see\)
-   **Filter:** allows to skip defined objects, for predefined filters see Filters chapter
-   **Profile:** profile to use, see Profiles chapter for default available profiles
-   **Automatically generate QA:** generate QA report or not
-   **Projects directory:** directory on MakeDoc server machine where MakeDoc resursively search for projects and deployments
-   **EARs:** include EARs to documentation process when seeking for sources in projects directory
-   **Folders:** include folders when seeking for sources in projects directory
-   **Use DTL:** include Design time libraries
-   **Cleanup Projects directory:** clean projects input directory after when documentation process finishes or not

**Parent topic:**[MakeDoc build steps](../../jenkins/md_build_steps/md_build_steps.md)

