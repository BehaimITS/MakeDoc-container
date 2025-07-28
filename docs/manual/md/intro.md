# Preface {#preface .concept}

MakeDoc for TIBCO is used to generate HTML, PDF and DOCX formatted documentation for TIBCO BusinessWorks, TIBCO BusinessEvents, TIBCO iProcess projects and TIBCO EMS Servers. The application is written in Java and is portable among different operating systems. Documentation can be generated from a TIBCO BW/BE/iProcess project folder, EMS Servers, TIBCO Designer EAR archives. MakeDoc for TIBCO can generate documentation from related design-time libraries \(.projlib files\) when configured properly.

The generated documentation is detailed and well organized. Text documentation is generated for all important components of TIBCO BW/BE/iProcess projects and EMS servers. The graphical representation of TIBCO BW processes, BE state machines and BE concept views is similar to the TIBCO Designer. XSD and WSDL diagrams are generated as well.

MakeDoc for TIBCO first creates the document in DITA format. The DITA format is transformed into the user selected formats: HTML, PDF and DOCX.

The **HTML document** is hyper-linked, which makes navigation easy and fast. The document consists of HTML documents organized in a tree structure. The main document index.html is stored in the snapshot\_dir\\html folder. Other files associated with the HTML document are saved in subfolders.

The **PDF document** is hyper-linked too. The contents of this document is also displayed in bookmarks. The document is stored in the snapshot\_dir\\pdf folder.

The **Microsoft Office Word 2007 Open XML Macro-Enabled Document** \(.docm\) file can be generated as well. The Microsoft Office Word is professional-looking document, which allows user fully customize generated documentation. The document is stored in the snapshot\_dir\\docx folder.

The generated document has the same contents in all output formats.

MakeDoc also provides **Quality Assurance** feature. This tool is able to check whether defined rules were followed in chosen projects and shows all occurences of violations of these rules. Quality Assurance output is generated with Project and Cross-reference part of documentation or as a standalone HTML document, which can be also opened from MakeDoc main window.

The next feature is **CrossReference**. This tool is able to start generating documentation of more then one documentation project type. It means that you can generate documentation of BW projects, BE projects in one step. And also make link between these projects.

The last but not least is **Repository Analyst** feature. This tool is able to compare two generated documentation and identify changes between these outputs.

