# Job anatomy {#job_anatomy .concept}

Job is basic workunit in Jenkins. Job design is divided into sections.

These sections are

-   General section
-   Source code management
-   Build triggers
-   Build steps
-   Post-build steps

Most important section is **Build steps**. Job can be seen as set of build steps and configuration values needed to perform defined activity.

-   **Generic Jenkins build steps** - designed to perform generic task such as calling scripts for instance *Execute Windows batch command* or *Execute shell*
-   **MakeDoc-specific steps** - designed specially for MakeDoc, for instance *Run MakeDoc BW documentation*

Let's create first job using **New Job**. Type name, choose **MakeDoc documentation job** and click Ok.

-   **[General section](../../jenkins/job_anatomy/general.md)**  

-   **[Source code management](../../jenkins/job_anatomy/source_code_management.md)**  

-   **[Build triggers](../../jenkins/job_anatomy/build_triggers.md)**  

-   **[Build steps](../../jenkins/job_anatomy/build_steps.md)**  

-   **[Post-build steps](../../jenkins/job_anatomy/post_build_steps.md)**  


**Parent topic:**[Jenkins](../../jenkins/jenkins.md)

