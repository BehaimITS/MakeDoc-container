# Jenkins plugins {#bw_build_step .concept}

**Jenkins CI** can be extended using plugins. Many plugins are available to download and install from central Jenkins plugins repository. Extending Jenkins CI can be useful for example when there is plugin available for specific VCS we need to fetch data from.

To install new plugin

-   go to **Manage Jenkins -\> Manage plugins -\> Available**
-   check plugin to be installed
-   Click install without restart

![](images/jenkins_manage_plugins.png "Manage Jenkins -> Manage plugins")

Example of useful plugins - VCS support:

-   **Visual SourceSafe**: [plugin page.](https://wiki.jenkins-ci.org/display/JENKINS/Visual+SourceSafe+Plugin)
-   **IBM Clearcase**: [plugin page.](https://wiki.jenkins-ci.org/display/JENKINS/ClearCase+Plugin)

Other:

-   **Sectioned view:** allows to divide Jenkins view to sections, [plugin page.](https://wiki.jenkins-ci.org/display/JENKINS/Sectioned+View+Plugin)
-   **Build flow:** allows to create meta jobs with interesting logic, [plugin page.](https://wiki.jenkins-ci.org/display/JENKINS/Build+Flow+Plugin)

**WARNING: MakeDoc support cannot guarantee proper functionality of plugins available on Jenkins plugins download site. Please be careful when installing new plugins on MakeDoc server.**

**Parent topic:**[Advanced](../../jenkins/advanced/advanced.md)

