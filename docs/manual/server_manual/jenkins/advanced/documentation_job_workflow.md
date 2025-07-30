# In detail: MakeDoc documentation job workflow {#doc_job_workflow .concept}

Each documentation on MakeDoc server is generated using some job we have previously defined. This part explains in detail how documentation job works.

Let's assume we have defined documentation job to document some BusinessWorks projects using **MakeDoc documentation job** project and have added at least one step **Run MakeDoc BW documentation**.

This is what will happen after pressing **Build** now or **Schedule build** button on the Dashboard:

-   MakeDoc documentation project is automatically created based on MakeDoc Build step configuration
    -   appropriate project template is copied to ws \(workspace\) directory under $MAKEDOC\_ROOT directory, see MakeDoc server directory structure
    -   Enterprise profile is configured based on current "Run MakeDoc BW documentation" build step configuration \(eg. name, group, storage, output formats to generate etc.\)
    -   all sources \(projects or EARs\) located in project source directory are imported to MakeDoc documentation project
    -   QA rules are registered
    -   projects are registered to profile to be documented
-   MakeDoc core applications is called to generate documentation using created MakeDoc profile
    -   inputs are checked
    -   new storage record is created
    -   appropriate module is called to generate documentation \(project documentation, CrossReference, QA\) - DITA files \(XML\) are generated
    -   output formats are generated using DITA files
-   MakeDoc portal update is performed to reflect last generation run

**Parent topic:**[Advanced](../../jenkins/advanced/advanced.md)

