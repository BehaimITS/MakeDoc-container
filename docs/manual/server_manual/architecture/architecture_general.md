# General description {#architecture_general .concept}

MakeDoc Server editon consist of six componets. These components are

-   **Tomcat servlet container** - an open source software implementation of the Java Servlet and JavaServer Pages technologies, [website.](http://tomcat.apache.org/)
-   **Jenkins CI** - extendable open source continuous integration server, [website.](http://jenkins-ci.org)
-   **MakeDoc plugin for Jenkins CI** - MakeDoc interface for Jenkins.
-   **MakeDoc Portal** - dynamically generated website for centralized access to generated documentation

These components are called *server side* components in terms of MakeDoc server.

-   **MakeDoc application** - eclipse platform based application
-   **MakeDoc storage** - database used to maintain records related to generated documentation

These components are *core components*.

Core and server components comunicate via **Ant interface**, [website.](http://ant.apache.org)

Following figure describes releationship and communication between these components.

![](images/architecture_schema.png "MakeDoc server architecture")

Blue marked components serve as web-based MakeDoc server user interface. Jenkins CI as interface for administrators and MakeDoc portal as interface for regular users to provide them simple and straightforward way how to view generated documentation. In the next parts of this manual we will introduce all components.

**Parent topic:**[Architecture](../architecture/architecture.md)

