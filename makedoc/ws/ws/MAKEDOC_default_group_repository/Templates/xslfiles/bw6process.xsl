<?xml version="1.0" encoding="utf-8"?>
<!-- ===================================================================================== -->
<!--                                                                                       -->
<!--                             BEHAIM IT Solutions                                       -->
<!--                                                                                       -->
<!--                            All Rights Reserved                                        -->
<!--                                                                                       -->
<!--                                                                                       -->
<!-- project         : MakeDoc                                                             -->
<!-- filename        : bw6process.xsl                                                      -->
<!-- originator      : jkaspar															   -->
<!-- creation date   : 2015/09/09                                                          -->
<!-- description     : XSL template transfers BW XML file of type .bwp into        		   -->
<!--                   DITA format.                                                        -->
<!-- ===================================================================================== -->
<!-- ================================== NOTES: ===========================================  		STRUCTURE: 		- main concept ProcessMain contains concepts: 			- Process 			- ProcessDefinition 		- subconcept ProcessDefinitions contains concepts: 			- ProcessDescription 			- Diagram 			- Starter 			- EndActivity 			- ProcessVariables 			- ErrorSchemas 			- Activities 			- Transitions 			- Groups 		 		TODO: 		- opravit root element stylesheet (atributy: xmlns:xsd, xmlns:pd) 		- nahradit tag <pre>- opravit chybu java funkce: CustomFunctions:getSchemaDocumentationLinkFromProjectRelativeReference     ======================================================================================= -->
<!-- xmlns:xsd, xmlns:pd -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:java="http://xml.apache.org/xalan/java"
                xmlns:dyn="http://exslt.org/dynamic"
                xmlns:common="http://exslt.org/common"
                xmlns:str="http://exslt.org/strings"
                xmlns:ncname="com.pikeelectronic.xsl.NCName"
                xmlns:xsdb="com.behaim.commons.xsl.XSDTransitiveBrowser"
                xmlns:CustomFunctions="com.behaim.commons.xsl.CustomFunctions"
                xmlns:CustomFunctionsEagle="com.behaim.commons.eagle.CustomFunctions"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:bpws="http://docs.oasis-open.org/wsbpel/2.0/process/executable"
                xmlns:tibex="http://www.tibco.com/bpel/2007/extensions"
                xmlns:bwext="http://tns.tibco.com/bw/model/core/bwext"
                xmlns:sca-bpel="http://docs.oasis-open.org/ns/opencsa/sca-bpel/200801"
                version="1.0"
                exclude-result-prefixes="java CustomFunctions CustomFunctionsEagle ncname xsdb bwext tibex bpws sca-bpel common dyn str xsd">
    <xsl:output encoding="utf-8" method="xml"/>
    <!-- Parameters passed by java XSL transformer launcher -->
    <xsl:param name="mdcfg"/>
    <xsl:param name="heading"/>
    <xsl:param name="level"/>
    <xsl:param name="designLib"/>
    <xsl:param name="isUseInputBindings"/>
    <xsl:param name="inputFileName"/>
    <xsl:param name="outputFileName"/>
    <xsl:param name="projectRoot"/>
    <!-- added by jrozsypalova, for purposes of founding out if refered files
		exist in source project -->
    <xsl:param name="relativePath"/>
    <!-- added by jsalomoun - relative path of the file in project directory -->
    <xsl:param name="displayPathInTopicName" select="false"/>
    <!-- added by jsalomoun - for displaying whole relative path - default value:
		'false' -->
    <xsl:param name="ImageMapFolder"/>
    <!-- added by mrozsypal - folder where is imagemap file -->

    <!-- added by mrozsypal - for displaying last modification time of object
		(system time) -->
    <xsl:param name="ModificationTime"/>
    <xsl:param name="folderDescription"/>
    <!--  type odf mapping - table, tree, raw -->
    <xsl:param name="mappingType" select="'table'"/>
    <xsl:param name="projectName"/>
    <xsl:param name="applicationName"/>
    <!-- Special folder names -->
    <xsl:param name="wsdlFolder"/>
    <xsl:param name="processesFolder"/>
    <xsl:param name="schemasFolder"/>
    <xsl:param name="policiesFolder"/>
    <xsl:param name="resourcesFolder"/>
    <!-- added by jmatena - initialize XSDTransitiveBrowser for searching elements
		in included XSDs -->
    <xsl:variable name="XSDBrowser" select="xsdb:new()"/>
    <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

    <!-- Match document root tag -->
    <xsl:template match="/">
        <xsl:variable name="processName">
            <xsl:call-template name="substring-before-last">
                <xsl:with-param name="string1" select="$heading"/>
                <xsl:with-param name="string2" select="'.bwp'"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE concept PUBLIC "-//OASIS//DTD DITA Concept//EN" "]]></xsl:text><xsl:value-of select="concat($mdcfg,'/dtd','/concept.dtd')"/><xsl:text disable-output-escaping="yes">"></xsl:text>

        <concept id="ProcessMain" xml:lang="en-us">
            <title>
                <xsl:value-of select="$processName"/>
            </title>
            <titlealts>
                <navtitle>
                    <xsl:choose>
                        <xsl:when test="$displayPathInTopicName">
                            <xsl:call-template name="substring-before-last">
                                <xsl:with-param name="string1" select="$relativePath"/>
                                <xsl:with-param name="string2" select="'.bwp'"/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$processName"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </navtitle>
            </titlealts>
            <xsl:choose>
                <xsl:when test="$designLib != ''">
                    <conbody>
                        <p>
                            <xsl:value-of select="CustomFunctions:initializeTemplate('process.xsl')"/>
                        </p>
                        <p>
                            Section contains description of Process "
                            <xsl:value-of select="$heading"/>
                            " .
                        </p>
                        <xsl:if test="CustomFunctions:shallGeneratePart('process/modificationTime')">
                            <p>
                                Modification time:
                                <xsl:value-of select="$ModificationTime"/>
                            </p>
                        </xsl:if>
                        <p>
                            Source Library: "
                            <xsl:value-of select="$designLib"/>
                            "
                        </p>
                    </conbody>
                </xsl:when>
                <xsl:otherwise>
                    <conbody>
                        <p>
                            <xsl:value-of select="CustomFunctions:initializeTemplate('bw6process.xsl')"/>
                        </p>
                        <p>
                            Section contains description of Process "
                            <xsl:value-of select="$heading"/>
                            " .
                        </p>
                        <xsl:if test="CustomFunctions:shallGeneratePart('process/modificationTime')">
                            <p>
                                Modification time:
                                <xsl:value-of select="$ModificationTime"/>
                            </p>
                        </xsl:if>
                    </conbody>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:value-of select="local-name()"/>
            <xsl:apply-templates select="bpws:process"/>
        </concept>
    </xsl:template>
    <!-- Match <ProcessDefinition>tag, contains all other tags -->
    <xsl:template match="bpws:process">
        <xsl:variable name="processName">
            <xsl:value-of select="@name"/>
        </xsl:variable>
        <xsl:variable name="processDescription" select="./tibex:ProcessInfo/@description"/>
        <xsl:variable name="processImageName"
                      select="CustomFunctions:getImageNameFromProcessFileName(string($inputFileName))" />
        <xsl:value-of
                select="CustomFunctions:checkNoDescription(string($inputFileName),string($processName),string($processDescription),'process/process')" />
        <xsl:if	test="CustomFunctions:shallGeneratePart('process/folderDescription')">
            <concept id="FolderDescription" xml:lang="en-us">
                <title>Folder description:</title>
                <conbody>
                    <table>
                        <tgroup cols="2">
                            <colspec colname="folder" colwidth="75*"/>
                            <colspec colname="desc" colwidth="175*"/>
                            <thead>
                                <row>
                                    <entry colname="folder" valign="top">Folder</entry>
                                    <entry colname="desc" valign="top">Description</entry>
                                </row>
                            </thead>

                            <tbody>
                                <xsl:choose>
                                    <xsl:when test="string-length($folderDescription)=0">
                                        <row><entry></entry><entry>No description</entry></row>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of disable-output-escaping="yes" select="$folderDescription"/>
                                    </xsl:otherwise>
                                </xsl:choose>

                            </tbody>
                        </tgroup>
                    </table>
                </conbody>
            </concept>
        </xsl:if>
        <concept id="ProcessDescription" xml:lang="en-us">
            <title>Process description:</title>
            <conbody>
                <table>
                    <tgroup cols="1">
                        <tbody>
                            <row>
                                <entry>
                                    <xsl:choose>
                                        <xsl:when test="string-length(./tibex:ProcessInfo/@description) > 0">
                                            <xsl:value-of select="$processDescription"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            No description
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </entry>
                            </row>
                        </tbody>
                    </tgroup>
                </table>
            </conbody>
        </concept>

        <concept id="ProcessDefinition" xml:lang="en-us">
            <title>Process definition:</title>
            <conbody>
                <p>
                    Full process path:
                    <xsl:value-of select="$processName"/>
                </p>
            </conbody>
        </concept>
        <xsl:if test="CustomFunctions:shallGeneratePart('process/diagram')">
            <concept id="Diagram" xml:lang="en-us">
                <title>Diagram:</title>
                <!-- Show image with process diagram -->
                <conbody>
                    <xsl:variable name="ImageMapFile">
                        <xsl:if
                                test="concat($ImageMapFolder,'/',ncname:transformToNCName($processImageName),'.imagemap')">
                            <xsl:value-of
                                    select="concat($ImageMapFolder,'/',ncname:transformToNCName($processImageName),'.imagemap')" />
                        </xsl:if>
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when
                                test="document($ImageMapFile)/imagemap/activity and (CustomFunctions:shallGeneratePart('process/activity/starterActivity') or CustomFunctions:shallGeneratePart('process/activity/endActivity') or CustomFunctions:shallGeneratePart('process/activity/others'))">
                            <xsl:element name="imagemap">
                                <xsl:element name="image">
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="$processImageName"/>
                                    </xsl:attribute>
                                </xsl:element>
                                <xsl:for-each select="document($ImageMapFile)/imagemap/activity">
                                    <xsl:if
                                            test="position()=1 and CustomFunctions:shallGeneratePart('process/activity/starterActivity')">
                                        <area>
                                            <shape>circle</shape>
                                            <coords>
                                                <xsl:value-of select="attribute::x"/>
                                                ,
                                                <xsl:value-of select="attribute::y"/>
                                                ,40
                                            </coords>
                                            <xsl:element name="xref">
                                                <xsl:attribute name="format">html</xsl:attribute>
                                                <xsl:attribute name="href">#<xsl:value-of
                                                        select="ncname:transformToNCName(attribute::name)" /></xsl:attribute>
                                                <xsl:value-of select="attribute::name"/>
                                            </xsl:element>
                                        </area>
                                    </xsl:if>
                                    <xsl:if
                                            test="position()=2 and CustomFunctions:shallGeneratePart('process/activity/endActivity')">
                                        <area>
                                            <shape>circle</shape>
                                            <coords>
                                                <xsl:value-of select="attribute::x"/>
                                                ,
                                                <xsl:value-of select="attribute::y"/>
                                                ,40
                                            </coords>
                                            <xsl:element name="xref">
                                                <xsl:attribute name="format">html</xsl:attribute>
                                                <xsl:attribute name="href">#<xsl:value-of
                                                        select="ncname:transformToNCName(attribute::name)" /></xsl:attribute>
                                                <xsl:value-of select="attribute::name"/>
                                            </xsl:element>
                                        </area>
                                    </xsl:if>
                                    <xsl:if
                                            test="position()>2 and CustomFunctions:shallGeneratePart('process/activity/others')">
                                        <area>
                                            <shape>circle</shape>
                                            <coords>
                                                <xsl:value-of select="attribute::x"/>
                                                ,
                                                <xsl:value-of select="attribute::y"/>
                                                ,28
                                            </coords>
                                            <xsl:element name="xref">
                                                <xsl:attribute name="format">html</xsl:attribute>
                                                <xsl:attribute name="href">#<xsl:value-of
                                                        select="ncname:transformToNCName(attribute::name)" />
                                                </xsl:attribute>
                                                <xsl:value-of select="attribute::name"/>
                                            </xsl:element>
                                        </area>
                                    </xsl:if>
                                </xsl:for-each>
                                <xsl:if
                                        test="document($ImageMapFile)/imagemap/transition and CustomFunctions:shallGeneratePart('process/transition')">
                                    <xsl:for-each
                                            select="document($ImageMapFile)/imagemap/transition">
                                        <xsl:if
                                                test="(attribute::y1)&lt;(attribute::y2) and (attribute::x1)&lt;(attribute::x2)">
                                            <area>
                                                <shape>poly</shape>
                                                <coords>
                                                    <xsl:value-of select="(attribute::x1)-5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y1)+5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x2)-5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y2)+5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x2)+5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y2)-5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x1)+5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y1)-5"/>
                                                </coords>
                                                <xsl:element name="xref">
                                                    <xsl:attribute name="format">html</xsl:attribute>
                                                    <xsl:attribute name="href"><xsl:value-of
                                                            select="concat('#','Transitions__',ncname:transformToNCName(attribute::from),'_',ncname:transformToNCName(attribute::to))" /></xsl:attribute>
                                                    <xsl:text>From: </xsl:text>
                                                    <xsl:value-of select="attribute::from"/>
                                                    <xsl:text> To: </xsl:text>
                                                    <xsl:value-of select="attribute::to"/>
                                                </xsl:element>
                                            </area>
                                        </xsl:if>
                                        <xsl:if
                                                test="(attribute::y1)&lt;(attribute::y2) and (attribute::x1)&gt;(attribute::x2)">
                                            <area>
                                                <shape>poly</shape>
                                                <coords>
                                                    <xsl:value-of select="(attribute::x1)-5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y1)+5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x2)-5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y2)+5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x2)+5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y2)-5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x1)+5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y1)-5"/>
                                                </coords>
                                                <xsl:element name="xref">
                                                    <xsl:attribute name="format">html</xsl:attribute>
                                                    <xsl:attribute name="href"><xsl:value-of
                                                            select="concat('#','Transitions__',ncname:transformToNCName(attribute::from),'_',ncname:transformToNCName(attribute::to))" /></xsl:attribute>
                                                    <xsl:text>From: </xsl:text>
                                                    <xsl:value-of select="attribute::from"/>
                                                    <xsl:text> To: </xsl:text>
                                                    <xsl:value-of select="attribute::to"/>
                                                </xsl:element>
                                            </area>
                                        </xsl:if>
                                        <xsl:if
                                                test="(attribute::y1)&gt;(attribute::y2) and (attribute::x1)&lt;(attribute::x2)">
                                            <area>
                                                <shape>poly</shape>
                                                <coords>
                                                    <xsl:value-of select="(attribute::x1)+5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y1)+5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x2)+5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y2)+5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x2)-5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y2)-5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x1)-5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y1)-5"/>
                                                </coords>
                                                <xsl:element name="xref">
                                                    <xsl:attribute name="format">html</xsl:attribute>
                                                    <xsl:attribute name="href"><xsl:value-of
                                                            select="concat('#','Transitions__',ncname:transformToNCName(attribute::from),'_',ncname:transformToNCName(attribute::to))" /></xsl:attribute>
                                                    <xsl:text>From: </xsl:text>
                                                    <xsl:value-of select="attribute::from"/>
                                                    <xsl:text> To: </xsl:text>
                                                    <xsl:value-of select="attribute::to"/>
                                                </xsl:element>
                                            </area>
                                        </xsl:if>
                                        <xsl:if
                                                test="(attribute::y1)&gt;(attribute::y2) and (attribute::x1)&gt;(attribute::x2)">
                                            <area>
                                                <shape>poly</shape>
                                                <coords>
                                                    <xsl:value-of select="(attribute::x1)+5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y1)-5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x2)+5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y2)-5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x2)-5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y2)+5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x1)-5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y1)+5"/>
                                                </coords>
                                                <xsl:element name="xref">
                                                    <xsl:attribute name="format">html</xsl:attribute>
                                                    <xsl:attribute name="href"><xsl:value-of
                                                            select="concat('#','Transitions__',ncname:transformToNCName(attribute::from),'_',ncname:transformToNCName(attribute::to))" /></xsl:attribute>
                                                    <xsl:text>From: </xsl:text>
                                                    <xsl:value-of select="attribute::from"/>
                                                    <xsl:text> To: </xsl:text>
                                                    <xsl:value-of select="attribute::to"/>
                                                </xsl:element>
                                            </area>
                                        </xsl:if>
                                        <xsl:if
                                                test="(attribute::y1)=(attribute::y2) and (attribute::x1)&lt;(attribute::x2)">
                                            <area>
                                                <shape>poly</shape>
                                                <coords>
                                                    <xsl:value-of select="(attribute::x1)"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y1)+5"/>
                                                    ,
                                                    <xsl:value-of select="attribute::x2"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y2)+5"/>
                                                    ,
                                                    <xsl:value-of select="attribute::x2"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y2)-5"/>
                                                    ,
                                                    <xsl:value-of select="attribute::x1"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y1)-5"/>
                                                </coords>
                                                <xsl:element name="xref">
                                                    <xsl:attribute name="format">html</xsl:attribute>
                                                    <xsl:attribute name="href"><xsl:value-of
                                                            select="concat('#','Transitions__',ncname:transformToNCName(attribute::from),'_',ncname:transformToNCName(attribute::to))" /></xsl:attribute>
                                                    <xsl:text>From: </xsl:text>
                                                    <xsl:value-of select="attribute::from"/>
                                                    <xsl:text> To: </xsl:text>
                                                    <xsl:value-of select="attribute::to"/>
                                                </xsl:element>
                                            </area>
                                        </xsl:if>
                                        <xsl:if
                                                test="(attribute::y1)=(attribute::y2) and (attribute::x1)&gt;(attribute::x2)">
                                            <area>
                                                <shape>poly</shape>
                                                <coords>
                                                    <xsl:value-of select="(attribute::x1)"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y1)+5"/>
                                                    ,
                                                    <xsl:value-of select="attribute::x2"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y2)+5"/>
                                                    ,
                                                    <xsl:value-of select="attribute::x2"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y2)-5"/>
                                                    ,
                                                    <xsl:value-of select="attribute::x1"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y1)-5"/>
                                                </coords>
                                                <xsl:element name="xref">
                                                    <xsl:attribute name="format">html</xsl:attribute>
                                                    <xsl:attribute name="href"><xsl:value-of
                                                            select="concat('#','Transitions__',ncname:transformToNCName(attribute::from),'_',ncname:transformToNCName(attribute::to))" /></xsl:attribute>
                                                    <xsl:text>From: </xsl:text>
                                                    <xsl:value-of select="attribute::from"/>
                                                    <xsl:text> To: </xsl:text>
                                                    <xsl:value-of select="attribute::to"/>
                                                </xsl:element>
                                            </area>
                                        </xsl:if>
                                        <xsl:if
                                                test="(attribute::y1)&lt;(attribute::y2) and (attribute::x1)=(attribute::x2)">
                                            <area>
                                                <shape>poly</shape>
                                                <coords>
                                                    <xsl:value-of select="(attribute::x1)-5"/>
                                                    ,
                                                    <xsl:value-of select="attribute::y1"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x2)-5"/>
                                                    ,
                                                    <xsl:value-of select="attribute::y2"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x2)+5"/>
                                                    ,
                                                    <xsl:value-of select="attribute::y2"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x1)+5"/>
                                                    ,
                                                    <xsl:value-of select="attribute::y1"/>
                                                </coords>
                                                <xsl:element name="xref">
                                                    <xsl:attribute name="format">html</xsl:attribute>
                                                    <xsl:attribute name="href"><xsl:value-of
                                                            select="concat('#','Transitions__',ncname:transformToNCName(attribute::from),'_',ncname:transformToNCName(attribute::to))" /></xsl:attribute>
                                                    <xsl:text>From: </xsl:text>
                                                    <xsl:value-of select="attribute::from"/>
                                                    <xsl:text> To: </xsl:text>
                                                    <xsl:value-of select="attribute::to"/>
                                                </xsl:element>
                                            </area>
                                        </xsl:if>
                                        <xsl:if
                                                test="(attribute::y1)&gt;(attribute::y2) and (attribute::x1)=(attribute::x2)">
                                            <area>
                                                <shape>poly</shape>
                                                <coords>
                                                    <xsl:value-of select="(attribute::x1)-5"/>
                                                    ,
                                                    <xsl:value-of select="attribute::y1"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x2)-5"/>
                                                    ,
                                                    <xsl:value-of select="attribute::y2"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x2)+5"/>
                                                    ,
                                                    <xsl:value-of select="attribute::y2"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x1)+5"/>
                                                    ,
                                                    <xsl:value-of select="attribute::y1"/>
                                                </coords>
                                                <xsl:element name="xref">
                                                    <xsl:attribute name="format">html</xsl:attribute>
                                                    <xsl:attribute name="href"><xsl:value-of
                                                            select="concat('#','Transitions__',ncname:transformToNCName(attribute::from),'_',ncname:transformToNCName(attribute::to))" /></xsl:attribute>
                                                    <xsl:text>From: </xsl:text>
                                                    <xsl:value-of select="attribute::from"/>
                                                    <xsl:text> To: </xsl:text>
                                                    <xsl:value-of select="attribute::to"/>
                                                </xsl:element>
                                            </area>
                                        </xsl:if>
                                    </xsl:for-each>
                                </xsl:if>
                                <!-- start of process imagemap -->
                                <xsl:if
                                        test="document($ImageMapFile)/imagemap/process">
                                    <xsl:for-each
                                            select="document($ImageMapFile)/imagemap/process">
                                        <xsl:if
                                                test="(attribute::y1)&lt;(attribute::y2) and (attribute::x1)&lt;(attribute::x2)">
                                            <area>
                                                <shape>poly</shape>
                                                <coords>
                                                    <xsl:value-of select="(attribute::x1)-5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y1)+8"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x2)-5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y2)+8"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x2)+5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y2)-8"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x1)+5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y1)-8"/>
                                                </coords>
                                                <xsl:element name="xref">
                                                    <xsl:attribute name="format">html</xsl:attribute>
                                                    <xsl:attribute name="href">#<xsl:value-of
                                                            select="ncname:transformToNCName(attribute::name)" />
                                                    </xsl:attribute>
                                                    <xsl:value-of select="attribute::name"/>
                                                </xsl:element>
                                            </area>
                                        </xsl:if>
                                        <xsl:if
                                                test="(attribute::y1)&lt;(attribute::y2) and (attribute::x1)&gt;(attribute::x2)">
                                            <area>
                                                <shape>poly</shape>
                                                <coords>
                                                    <xsl:value-of select="(attribute::x1)-5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y1)+8"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x2)-5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y2)+8"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x2)+5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y2)-8"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x1)+5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y1)-8"/>
                                                </coords>
                                                <xsl:element name="xref">
                                                    <xsl:attribute name="format">html</xsl:attribute>
                                                    <xsl:attribute name="href">#<xsl:value-of
                                                            select="ncname:transformToNCName(attribute::name)" />
                                                    </xsl:attribute>
                                                    <xsl:value-of select="attribute::name"/>
                                                </xsl:element>
                                            </area>
                                        </xsl:if>
                                        <xsl:if
                                                test="(attribute::y1)&gt;(attribute::y2) and (attribute::x1)&lt;(attribute::x2)">
                                            <area>
                                                <shape>poly</shape>
                                                <coords>
                                                    <xsl:value-of select="(attribute::x1)+5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y1)+8"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x2)+5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y2)+8"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x2)-5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y2)-8"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x1)-5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y1)-8"/>
                                                </coords>
                                                <xsl:element name="xref">
                                                    <xsl:attribute name="format">html</xsl:attribute>
                                                    <xsl:attribute name="href">#<xsl:value-of
                                                            select="ncname:transformToNCName(attribute::name)" />
                                                    </xsl:attribute>
                                                    <xsl:value-of select="attribute::name"/>
                                                </xsl:element>
                                            </area>
                                        </xsl:if>
                                        <xsl:if
                                                test="(attribute::y1)&gt;(attribute::y2) and (attribute::x1)&gt;(attribute::x2)">
                                            <area>
                                                <shape>poly</shape>
                                                <coords>
                                                    <xsl:value-of select="(attribute::x1)+5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y1)-8"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x2)+5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y2)-8"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x2)-5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y2)+8"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x1)-5"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y1)+8"/>
                                                </coords>
                                                <xsl:element name="xref">
                                                    <xsl:attribute name="format">html</xsl:attribute>
                                                    <xsl:attribute name="href">#<xsl:value-of
                                                            select="ncname:transformToNCName(attribute::name)" />
                                                    </xsl:attribute>
                                                    <xsl:value-of select="attribute::name"/>
                                                </xsl:element>
                                            </area>
                                        </xsl:if>
                                        <xsl:if
                                                test="(attribute::y1)=(attribute::y2) and (attribute::x1)&lt;(attribute::x2)">
                                            <area>
                                                <shape>poly</shape>
                                                <coords>
                                                    <xsl:value-of select="(attribute::x1)"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y1)+8"/>
                                                    ,
                                                    <xsl:value-of select="attribute::x2"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y2)+8"/>
                                                    ,
                                                    <xsl:value-of select="attribute::x2"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y2)-8"/>
                                                    ,
                                                    <xsl:value-of select="attribute::x1"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y1)-8"/>
                                                </coords>
                                                <xsl:element name="xref">
                                                    <xsl:attribute name="format">html</xsl:attribute>
                                                    <xsl:attribute name="href">#<xsl:value-of
                                                            select="ncname:transformToNCName(attribute::name)" />
                                                    </xsl:attribute>
                                                    <xsl:value-of select="attribute::name"/>
                                                </xsl:element>
                                            </area>
                                        </xsl:if>
                                        <xsl:if
                                                test="(attribute::y1)=(attribute::y2) and (attribute::x1)&gt;(attribute::x2)">
                                            <area>
                                                <shape>poly</shape>
                                                <coords>
                                                    <xsl:value-of select="(attribute::x1)"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y1)+8"/>
                                                    ,
                                                    <xsl:value-of select="attribute::x2"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y2)+8"/>
                                                    ,
                                                    <xsl:value-of select="attribute::x2"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y2)-8"/>
                                                    ,
                                                    <xsl:value-of select="attribute::x1"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::y1)-5"/>
                                                </coords>
                                                <xsl:element name="xref">
                                                    <xsl:attribute name="format">html</xsl:attribute>
                                                    <xsl:attribute name="href">#<xsl:value-of
                                                            select="ncname:transformToNCName(attribute::name)" />
                                                    </xsl:attribute>
                                                    <xsl:value-of select="attribute::name"/>
                                                </xsl:element>
                                            </area>
                                        </xsl:if>
                                        <xsl:if
                                                test="(attribute::y1)&lt;(attribute::y2) and (attribute::x1)=(attribute::x2)">
                                            <area>
                                                <shape>poly</shape>
                                                <coords>
                                                    <xsl:value-of select="(attribute::x1)-5"/>
                                                    ,
                                                    <xsl:value-of select="attribute::y1"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x2)-5"/>
                                                    ,
                                                    <xsl:value-of select="attribute::y2"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x2)+5"/>
                                                    ,
                                                    <xsl:value-of select="attribute::y2"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x1)+5"/>
                                                    ,
                                                    <xsl:value-of select="attribute::y1"/>
                                                </coords>
                                                <xsl:element name="xref">
                                                    <xsl:attribute name="format">html</xsl:attribute>
                                                    <xsl:attribute name="href">#<xsl:value-of
                                                            select="ncname:transformToNCName(attribute::name)" />
                                                    </xsl:attribute>
                                                    <xsl:value-of select="attribute::name"/>
                                                </xsl:element>
                                            </area>
                                        </xsl:if>
                                        <xsl:if
                                                test="(attribute::y1)&gt;(attribute::y2) and (attribute::x1)=(attribute::x2)">
                                            <area>
                                                <shape>poly</shape>
                                                <coords>
                                                    <xsl:value-of select="(attribute::x1)-5"/>
                                                    ,
                                                    <xsl:value-of select="attribute::y1"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x2)-5"/>
                                                    ,
                                                    <xsl:value-of select="attribute::y2"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x2)+5"/>
                                                    ,
                                                    <xsl:value-of select="attribute::y2"/>
                                                    ,
                                                    <xsl:value-of select="(attribute::x1)+5"/>
                                                    ,
                                                    <xsl:value-of select="attribute::y1"/>
                                                </coords>
                                                <xsl:element name="xref">
                                                    <xsl:attribute name="format">html</xsl:attribute>
                                                    <xsl:attribute name="href">#<xsl:value-of
                                                            select="ncname:transformToNCName(attribute::name)" />
                                                    </xsl:attribute>
                                                    <xsl:value-of select="attribute::name"/>
                                                </xsl:element>
                                            </area>
                                        </xsl:if>
                                    </xsl:for-each>
                                </xsl:if>
                                <!-- end of process imagemap -->

                            </xsl:element>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:element name="image">
                                <xsl:attribute name="href">
                                    <xsl:value-of select="$processImageName"/>
                                </xsl:attribute>
                                <alt>
                                    <xsl:value-of select="concat(processName,' ')"/>
                                </alt>
                            </xsl:element>
                        </xsl:otherwise>
                    </xsl:choose>
                </conbody>
            </concept>
        </xsl:if>
        <!-- STARTER -->
        <xsl:if
                test="((./bpws:scope/bpws:flow/bpws:receive) or (./bpws:scope/bpws:flow/bpws:pick/bpws:onMessage/bpws:scope/bpws:flow/bpws:empty) or (./bpws:scope/bpws:flow/bpws:extensionActivity/tibex:*[@createInstance='yes']))">
            <concept id="Starter" xml:lang="en-us">
                <title>Process starter activity:</title>
                <!-- conbody-->
                <!--xsl:if test="./bpws:scope/bpws:flow/bpws:extensionActivity/tibex:receiveEvent/tibex:eventSource/bwext:BWActivity/@activityTypeID='bw.generalactivities.timer'">
							<xsl:call-template name="timer"/>
						</xsl:if-->
                <xsl:if test="./bpws:scope/bpws:flow/bpws:receive">
                    <xsl:apply-templates select="./bpws:scope/bpws:flow/bpws:receive"/>
                </xsl:if>
                <xsl:if test="./bpws:scope/bpws:flow/bpws:pick/bpws:onMessage/bpws:scope/bpws:flow/bpws:empty/@tibex:constructor[contains(.,'Start')]/..">
                    <xsl:apply-templates select="./bpws:scope/bpws:flow/bpws:pick/bpws:onMessage/bpws:scope/bpws:flow/bpws:empty/@tibex:constructor[contains(.,'Start')]/.."/>
                </xsl:if>
                <xsl:apply-templates select="./bpws:scope/bpws:flow/bpws:extensionActivity/tibex:*[@createInstance='yes']"/>

                <!-- /conbody-->
            </concept>
        </xsl:if>
        <!-- END ACTIVITY -->
        <xsl:if
                test="((./bpws:scope/bpws:flow/bpws:reply) or (./bpws:scope/bpws:flow/bpws:pick/bpws:onMessage/bpws:scope/bpws:flow/bpws:empty/@tibex:constructor[contains(.,'End')]/..))">
            <concept id="EndActivity" xml:lang="en-us">
                <title>Process end activity:</title>
                <!--conbody-->
                <xsl:apply-templates select="./bpws:scope/bpws:flow/bpws:reply"/>
                <!-- 					<xsl:if	test="CustomFunctions:shallGeneratePart('process/activity/inputbindings')"> -->

                <!-- 					</xsl:if> -->
                <xsl:choose>
                    <xsl:when test="./bpws:scope/bpws:flow/bpws:pick/bpws:onMessage/bpws:scope/bpws:flow/bpws:empty/@tibex:constructor[contains(.,'End')]/..">
                        <xsl:apply-templates select="./bpws:scope/bpws:flow/bpws:pick/bpws:onMessage/bpws:scope/bpws:flow/bpws:empty/@tibex:constructor[contains(.,'End')]/.."/>
                    </xsl:when>
                </xsl:choose>
                <!--/conbody-->
            </concept>
        </xsl:if>
        <!-- PROCESS VARIABLES and CustomFunctions:shallGeneratePart('process/processVariables')-->
        <xsl:if
                test="bpws:variables">

            <xsl:choose>
                <xsl:when test="count(bpws:variables/bpws:variable[not(@sca-bpel:internal)])!=0">
	                <concept id="ProcessVariables" xml:lang="en-us">
		                <title>Process properties and variables</title>
		                <conbody>
		                	<xsl:apply-templates select="bpws:variables"/>
	                	</conbody>
	                </concept>
                </xsl:when>
                <xsl:otherwise>
                    <concept id="NoVariablesDefined" xml:lang="en-us">
                        <title>Process properties and variables</title>
                        <conbody>
                            <p>No variables defined</p>
                        </conbody>
                    </concept>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        <!-- ERROR SCHEMAS -->
        <xsl:if test="*[local-name()='errorSchemas']/*">
            <concept id="ErrorSchemas" xml:lang="en-us">
                <title>Error schemas:</title>
                <conbody>
                    <xsl:apply-templates select="*[local-name()='errorSchemas']"/>
                </conbody>
            </concept>
        </xsl:if>
        <!-- ACTIVITIES and CustomFunctions:shallGeneratePart('process/activity/others')-->
        <xsl:if
                test="./bpws:scope/bpws:flow//*[local-name()='activityExtension' or local-name()='reply' or local-name()='receive' or local-name()='invoke' or local-name()='receiveEvent' or local-name()='extActivity' or local-name()='throw' or local-name()='rethrow']">
            <concept id="Activities" xml:lang="en-us">
                <title>Activities:</title>
                <xsl:for-each select="./bpws:scope/bpws:flow//*[local-name()='activityExtension' or local-name()='reply' or local-name()='receive' or local-name()='invoke' or local-name()='receiveEvent' or local-name()='extActivity' or local-name()='throw' or local-name()='rethrow']">
                    <xsl:sort select="@name"/>
                    <xsl:if test="not(./@createInstance) and not(self::*[local-name()='reply'] and parent::*/parent::*/parent::*[local-name()='process'])">
                        <xsl:apply-templates select="."/>
                    </xsl:if>
                </xsl:for-each>
            </concept>
        </xsl:if>
        <!--  REFERENCES  -->
        <xsl:if
                test="./bpws:partnerLinks/bpws:partnerLink">
            <concept id="References" xml:lang="en-us">
                <title>References:</title>
                <xsl:for-each select="./bpws:partnerLinks/bpws:partnerLink/tibex:ReferenceWire/..">
                    <xsl:sort select="@name"/>
                    <!--xsl:if test="not(./@createInstance) and not(self::*[local-name()='reply'] and parent::*/parent::*/parent::*[local-name()='process'])">
						<xsl:apply-templates select="."/>
					</xsl:if-->
                    <xsl:apply-templates select="."/>
                </xsl:for-each>
            </concept>
        </xsl:if>
        <!-- TRANSITIONS and CustomFunctions:shallGeneratePart('process/transition')-->

        <xsl:call-template name="Transitions"/>
        <!--xsl:apply-templates select="//bpws:scope/bpws:flow/bpws:links"/-->
        <!--xsl:if
 			test="//bpws:scope">
			<xsl:apply-templates select="//bpws:scope"/>
 		</xsl:if-->

        <!-- GROUPS  and CustomFunctions:shallGeneratePart('process/groups')-->
        <xsl:if test="./bpws:scope/bpws:flow/bpws:*[local-name()='flow' or local-name()='scope']">
            <concept id="Groups" xml:lang="en-us">
                <title>Groups:</title>
                <conbody>
                    <xsl:apply-templates select="./bpws:scope/bpws:flow/bpws:*[local-name()='flow' or local-name()='scope']"/>
                </conbody>
            </concept>
        </xsl:if>
        <!-- 		<xsl:if -->
        <!-- 			test="bpws:*[local-name()='scope' or local-name()='flow']"> -->

        <!-- 		</xsl:if> -->
    </xsl:template>
    <xsl:template name="Transitions">
        <concept id="Transitions" xml:lang="en-us">
            <title>Transitions:</title>
            <conbody>
                <xsl:for-each select="//bpws:scope/bpws:flow/bpws:links/bpws:link">
                    <xsl:variable name="linkName" select="@name"/>
                    <xsl:variable name="transFrom">
                        <xsl:choose>
                            <xsl:when test="//bpws:extensionActivity/tibex:*[bpws:sources/bpws:source/@linkName=$linkName]">
                                <xsl:value-of select="//bpws:extensionActivity/tibex:*[bpws:sources/bpws:source/@linkName=$linkName]/@name"/>
                            </xsl:when>
                            <xsl:when test="//bpws:receive[bpws:sources/bpws:source/@linkName=$linkName]">
                                <xsl:value-of select="//bpws:receive[bpws:sources/bpws:source/@linkName=$linkName]/@name"/>
                            </xsl:when>
                            <xsl:when test="//bpws:reply[bpws:sources/bpws:source/@linkName=$linkName]">
                                <xsl:value-of select="//bpws:reply[bpws:sources/bpws:source/@linkName=$linkName]/@name"/>
                            </xsl:when>
                            <xsl:when test="//bpws:invoke[bpws:sources/bpws:source/@linkName=$linkName]">
                                <xsl:value-of select="//bpws:invoke[bpws:sources/bpws:source/@linkName=$linkName]/@name"/>
                            </xsl:when>
                            <xsl:when test="//bpws:empty[bpws:sources/bpws:source/@linkName=$linkName]">
                                <xsl:value-of select="//bpws:empty[bpws:sources/bpws:source/@linkName=$linkName]/@name"/>
                            </xsl:when>
                            <xsl:when test="//bpws:scope[bpws:sources/bpws:source/@linkName=$linkName]">
                                <xsl:value-of select="//bpws:scope[bpws:sources/bpws:source/@linkName=$linkName]/@name"/>
                            </xsl:when>
                            <xsl:when test="//bpws:flow[bpws:sources/bpws:source/@linkName=$linkName]">
                                <xsl:value-of select="//bpws:flow[bpws:sources/bpws:source/@linkName=$linkName]/@name"/>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:variable name="transTo">
                        <xsl:choose>
                            <xsl:when test="//bpws:extensionActivity/tibex:*[bpws:targets/bpws:target/@linkName=$linkName]">
                                <xsl:value-of select="//bpws:extensionActivity/tibex:*[bpws:targets/bpws:target/@linkName=$linkName]/@name"/>
                            </xsl:when>
                            <xsl:when test="//bpws:receive[bpws:targets/bpws:target/@linkName=$linkName]">
                                <xsl:value-of select="//bpws:receive[bpws:targets/bpws:target/@linkName=$linkName]/@name"/>
                            </xsl:when>
                            <xsl:when test="//bpws:reply[bpws:targets/bpws:target/@linkName=$linkName]">
                                <xsl:value-of select="//bpws:reply[bpws:targets/bpws:target/@linkName=$linkName]/@name"/>
                            </xsl:when>
                            <xsl:when test="//bpws:invoke[bpws:targets/bpws:target/@linkName=$linkName]">
                                <xsl:value-of select="//bpws:invoke[bpws:targets/bpws:target/@linkName=$linkName]/@name"/>
                            </xsl:when>
                            <xsl:when test="//bpws:exit[bpws:targets/bpws:target/@linkName=$linkName]">
                                <xsl:value-of select="//bpws:exit[bpws:targets/bpws:target/@linkName=$linkName]/@name"/>
                            </xsl:when>
                            <xsl:when test="//bpws:empty[bpws:targets/bpws:target/@linkName=$linkName]">
                                <xsl:value-of select="//bpws:empty[bpws:targets/bpws:target/@linkName=$linkName]/@name"/>
                            </xsl:when>
                            <xsl:when test="//bpws:throw[bpws:targets/bpws:target/@linkName=$linkName]">
                                <xsl:value-of select="//bpws:throw[bpws:targets/bpws:target/@linkName=$linkName]/@name"/>
                            </xsl:when>
                            <xsl:when test="//bpws:flow[bpws:targets/bpws:target/@linkName=$linkName]">
                                <xsl:value-of select="//bpws:flow[bpws:targets/bpws:target/@linkName=$linkName]/@name"/>
                            </xsl:when>
                            <xsl:when test="//bpws:scope[bpws:targets/bpws:target/@linkName=$linkName]">
                                <xsl:value-of select="//bpws:scope[bpws:targets/bpws:target/@linkName=$linkName]/@name"/>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:element name="ul">
                        <xsl:attribute name="id"><xsl:value-of
                                select="concat(ncname:transformToNCName($transFrom),'_',ncname:transformToNCName($transTo))" /></xsl:attribute>
                        <li>
                            From:
                            <xsl:call-template name="getBoldItalicValue">
                                <xsl:with-param name="value" select="$transFrom"/>
                            </xsl:call-template>
                            -To:
                            <xsl:call-template name="getBoldItalicValue">
                                <xsl:with-param name="value" select="$transTo"/>
                            </xsl:call-template>
                            <p>
                                <ul>
                                    <li>
                                        Label:
                                        <xsl:call-template name="getItalicValue">
                                            <xsl:with-param name="value"
                                                            select="@tibex:label" />
                                        </xsl:call-template>
                                    </li>
                                    <li>Type: <xsl:value-of select="@tibex:linkType"/></li>
                                    <xsl:if test="@tibex:linkType='SUCCESSWITHCONDITION'">
                                        <li>
                                            Condition:
                                            <xsl:call-template name="getItalicValue">
                                                <xsl:with-param name="value" select="//tibex:activityExtension/bpws:sources/bpws:source[@linkName=$linkName]/tibex:DesignExpression/tibex:expression/@expression"/>
                                            </xsl:call-template>
                                        </li>
                                    </xsl:if>
                                </ul>
                            </p>
                        </li>
                    </xsl:element>
                </xsl:for-each>
            </conbody>
        </concept>
    </xsl:template>
    <!-- GROUP TEMPLATE -->
    <xsl:template match="bpws:*[local-name()='flow' or local-name()='scope']">
        <ul>
            <li>
                Name:
                <xsl:call-template name="getBoldItalicValue">
                    <xsl:with-param name="value" select="@name"/>
                </xsl:call-template>
                <p>
                    <ul>
                        <li>
                            Group Type:
                            <xsl:call-template name="getItalicValue">
                                <xsl:with-param name="value" select="@tibex:group"/>
                            </xsl:call-template>
                        </li>
                        <xsl:if test="@tibex:group!='localTX'">
                            <li>Description: <xsl:value-of select="./bpws:documentation"/></li>
                            <li>Error handling: <xsl:choose><xsl:when test="./bpws:faultHandlers/bpws:catch"><xsl:value-of select="./bpws:faultHandlers/bpws:catch/@faultVariable"/></xsl:when><xsl:when test="./bpws:faultHandlers/bpws:catchAll">Catch All - Exception</xsl:when><xsl:otherwise><i>No Error Handling</i></xsl:otherwise></xsl:choose></li>
                        </xsl:if>

                        <xsl:choose>
                            <xsl:when test="@tibex:group='localTX'">
                                <li>Transaction Transport: <xsl:value-of select="@tibex:txGroup"/></li>
                            </xsl:when>
                            <xsl:when test="@tibex:group='critical'">
                                <li>Timeout: <xsl:value-of select="./tibex:criticalSection/activityTimeout"/></li>
                                <li>Shared Lock: <xsl:value-of select="./tibex:criticalSection/@sharedLock"/></li>
                                <!-- TODO  type of shared variable - via java CustomFunctions -->
                                <li>Sahred Variable: <xsl:value-of select="./tibex:criticalSection/@variableName"/></li>
                            </xsl:when>
                        </xsl:choose>
                        <li>Variables:
                            <xsl:choose>
                                <xsl:when test="count(./bpws:variables/bpws:variable[not(@sca-bpel:internal)])!=0">
                                    <xsl:apply-templates select="./bpws:variables"/>
                                </xsl:when>
                                <xsl:otherwise><p>No variables</p></xsl:otherwise>
                            </xsl:choose>
                        </li>
                    </ul>
                </p>
            </li>
        </ul>
    </xsl:template>
    <!-- Details for SIMPLE PROCS ENDER -->
    <xsl:template match="bpws:reply">
        <concept>
            <xsl:attribute name="id">
                <xsl:value-of select="ncname:transformToNCName(@name)"/>
            </xsl:attribute>

            <xsl:variable name="var" select="@variable"/>
            <title>Name:
                <xsl:call-template name="getBoldItalicValue">
                    <xsl:with-param name="value" select="@name"/>
                </xsl:call-template>
            </title>
            <conbody>
                <p>
                    <ul>
                        <li>Service: <xsl:value-of select="./@partnerLink"/><xsl:text> / operation: </xsl:text><xsl:value-of select="./@operation"/></li>
                        <li>ReplyWith: <xsl:choose><xsl:when test="@faultName"><xsl:if test="@faultName='Fault'">Fault: <xsl:value-of select="//bpws:variable[@name=$var]/@messageType"/></xsl:if><xsl:if test="@faultName='UndeclaredFault'">Undeclared Fault</xsl:if></xsl:when><xsl:otherwise>Output Message</xsl:otherwise></xsl:choose></li>
                        <li>Description: <xsl:value-of select="bpws:documentation"/></li>
                        <li><i>Input bindings:</i>
                            <xsl:apply-templates select="./tibex:inputBindings/tibex:partBinding"/>
                        </li>
                        <xsl:apply-templates select="./bwext:BWActivity"/>
                    </ul>
                </p>
            </conbody>
        </concept>
    </xsl:template>
    <!-- Invoke Activity -->
    <xsl:template match="bpws:invoke">
        <concept>
            <xsl:attribute name="id">
                <xsl:value-of select="ncname:transformToNCName(@name)"/>
            </xsl:attribute>

            <xsl:variable name="var" select="@variable"/>
            <title>Name:
                <xsl:call-template name="getBoldItalicValue">
                    <xsl:with-param name="value" select="@name"/>
                </xsl:call-template>
            </title>
            <conbody>
                <p>
                    <ul>
                        <li>Service: <xsl:value-of select="./@partnerLink"/><xsl:text> / operation: </xsl:text><xsl:value-of select="./@operation"/></li>
                        <li>Description: <xsl:value-of select="bpws:documentation"/></li>
                        <li>Activity Timeout (seconds):
                            <xsl:choose>
                                <xsl:when test="./@tibex:timeout">
                                    <xsl:call-template name="getValueFromLiteralModuleIfExists">
                                        <xsl:with-param name="valueLiteral" select="./@tibex:timeout"/>
                                        <xsl:with-param name="valueModuleProp" select="./@tibex:timeout"/>
                                        <xsl:with-param name="defaultValue" select="''"/>
                                    </xsl:call-template>
                                </xsl:when>
                                <xsl:otherwise>Default Timeout</xsl:otherwise>
                            </xsl:choose>
                        </li>

                        <li><i>Input bindings:</i>
                            <xsl:apply-templates select="./tibex:inputBindings/tibex:inputBinding"/>
                            <xsl:apply-templates select="./tibex:inputBindings/tibex:partBinding"/>
                        </li>
                        <xsl:apply-templates select="./bwext:BWActivity"/>
                    </ul>
                </p>
            </conbody>
        </concept>
    </xsl:template>

    <!-- Throw Activity -->
    <xsl:template match="bpws:throw">
        <concept>
            <xsl:attribute name="id">
                <xsl:value-of select="ncname:transformToNCName(@name)"/>
            </xsl:attribute>
            <title>Name:
                <xsl:call-template name="getBoldItalicValue">
                    <xsl:with-param name="value" select="@name"/>
                </xsl:call-template>
            </title>
            <conbody>
                <p>
                    <ul>
                        <li>Description: <xsl:value-of select="bpws:documentation"/></li>
                        <li>Fault Variable: <xsl:value-of select="@faultVariable"/></li>
                        <li><i>Input bindings:</i>
                            <xsl:apply-templates select="./tibex:inputBindings/tibex:inputBinding"/>
                            <xsl:apply-templates select="./tibex:inputBindings/tibex:partBinding"/>
                        </li>
                    </ul>
                </p>
            </conbody>
        </concept>
    </xsl:template>

    <!-- 	STARTER Activity template -->
    <xsl:template match="bpws:receive | tibex:*[@createInstance='yes']">
        <xsl:variable name="var" select="@variable"/>
        <concept>
            <xsl:attribute name="id">
                <xsl:value-of select="ncname:transformToNCName(@name)"/>
            </xsl:attribute>
            <title>Name:
                <xsl:call-template name="getBoldItalicValue">
                    <xsl:with-param name="value" select="@name"/>
                </xsl:call-template>
            </title>
            <conbody>
                <p>
                    <ul>
                        <xsl:if test="./@operation !='' or ./@partnerLink !=''"><li>Service: <xsl:value-of select="./@partnerLink"/><xsl:text> / Operation: </xsl:text><xsl:value-of select="./@operation"/></li></xsl:if>
                        <!--TIMER-->
                        <xsl:if test="./tibex:eventSource/bwext:BWActivity/@activityTypeID='bw.generalactivities.timer'">
                            <li>Start Time:
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'startTime'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                            </li>
                            <xsl:choose><xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@runOnce ='true'">
                                <li>Run once: true</li></xsl:when>
                                <xsl:otherwise>
                                    <li>Run Once:false</li>
                                    <li>Time Interval:
                                        <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'timeInterval'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                    </li>
                                    <li>Interval Unit:
                                        <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'intervalUnit'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                    </li>
                                    <!--End After-->
                                    <xsl:choose>
                                        <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@endPolicy=''">
                                            <li>End After: Occurences</li>
                                            <!--Occurences-->
                                            <xsl:choose>
                                                <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@occurrences !='' or ./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='occurrences']/@processProperty !=''">
                                                    <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='occurrences']/@processProperty"/>

                                                    <li>Occurrences:
                                                        <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'occurrences'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                                    </li>
                                                </xsl:when>
                                            </xsl:choose>
                                        </xsl:when>
                                        <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@endPolicy='END_TIME'">
                                            <li>End After: End Time</li>
                                            <xsl:choose>
                                                <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@endTime !='' or ./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='endTime']/@processProperty !=''">
                                                    <li>End Time:
                                                        <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'endTime'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                                    </li>
                                                </xsl:when>
                                            </xsl:choose>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <li>End After: Never</li>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:if>
                        <!--FILEPOLLER-->
                        <xsl:if test="./tibex:eventSource/bwext:BWActivity/@activityTypeID='bw.file.poller'">
                            <li>File Name:
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'fileName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                <!-- <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='fileName']/@processProperty"/>

				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@fileName"/>
					<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> -->
                            </li>
                            <li>Polling Interval(sec):
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'pollInterval'"/><xsl:with-param name="defaultValue" select="'5'"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                <!-- <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='pollInterval']/@processProperty"/>

				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@pollInterval"/>
					<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
					<xsl:with-param name="defaultValue" select="'5'"/>
				</xsl:call-template> -->
                            </li>
                            <!--Checkboxes-->

                            <xsl:choose>
                                <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@includeCurrent"><li>Include Existing Files: true</li></xsl:when>
                                <xsl:otherwise>
                                    <li>Include Existing Files: false</li>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:choose>
                                <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@excludeContent"><li>Exclude File Content: true</li></xsl:when>
                                <xsl:otherwise>
                                    <li>Exclude File Content: false</li>
                                    <!--Content as-->
                                    <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@contentAs"><li>Content as: <xsl:value-of select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@contentAs"/></li></xsl:if>
                                    <!--Encoding-->
                                    <xsl:choose>
                                        <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@encodingUsed !='' or ./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='encodingUsed']/@processProperty !=''">
                                            <li>Encoding:
                                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'encodingUsed'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                                <!-- <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='encodingUsed']/@processProperty"/>

								<xsl:call-template name="getValueFromLiteralModule">
									<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@encodingUsed"/>
									<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
									<xsl:with-param name="defaultValue" select="''"/>
								</xsl:call-template> -->
                                            </li>
                                        </xsl:when>
                                    </xsl:choose>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:choose>
                                <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@createEvent"><li>Poll for Create Events: true</li></xsl:when>
                                <xsl:otherwise>	<li>Poll for Create Events:false</li>	</xsl:otherwise>
                            </xsl:choose>
                            <xsl:choose>
                                <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@modifyEvent"><li>Poll for Modify Event: true</li></xsl:when>
                                <xsl:otherwise>	<li>Poll for Modify Event: false</li>	</xsl:otherwise>
                            </xsl:choose>
                            <xsl:choose>
                                <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@deleteEvent"><li>Poll for Delete Events: true</li></xsl:when>
                                <xsl:otherwise>	<li>Poll for Delete Events: false</li>	</xsl:otherwise>
                            </xsl:choose>
                            <xsl:choose>
                                <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@includeSubDirectories"><li>Poll for Include SubDirectories: true</li></xsl:when>
                                <xsl:otherwise>	<li>Poll for Include SubDirectories: false</li>	</xsl:otherwise>
                            </xsl:choose>
                            <li>Mode:
                                <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@mode='only-files'">Only Files</xsl:if>
                                <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@mode='only-directories'">Only Directories</xsl:if>
                                <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@mode='files-and-directories'">Files and Directories</xsl:if>
                            </li>
                            <li>Sort By: <xsl:value-of select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@sortby"/></li>
                            <li>Sort Order: <xsl:value-of select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@sortorder"/></li>

                        </xsl:if>
                        <!-- ************************************************************************************************************************** -->
                        <!-- FTL SUBSCRIBER-->
                        <xsl:if test="./tibex:eventSource/bwext:BWActivity/@activityTypeID='bw.ftl.subscriber'">
                            <!-- <xsl:apply-templates select="./tibex:eventSource/bwext:BWActivity" mode="main"><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates> -->
                            <!--ftl realm server connection-->
                            <li>FTL Realm Server Connection:
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'ftlRealmServerConnection'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                            </li>
                            <li>Endpoint:
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'endpoint'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                <!-- <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='endpoint']/@processProperty"/>

					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@endpoint"/>
						<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template> -->
                            </li>
                            <li>Content Matcher:
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'contentMatcher'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                <!-- <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='contentMatcher']/@processProperty"/>

						<xsl:call-template name="getValueFromLiteralModule">
							<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@contentMatcher"/>
							<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
							<xsl:with-param name="defaultValue" select="''"/>
						</xsl:call-template> -->
                            </li>
                            <!--Format-->
                            <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@format">
                                <li>Format:
                                    <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@format='custom'">Custom</xsl:if>
                                    <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@format='keyed_opaque'">Keyed Opaque</xsl:if>
                                    <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@format='opaque'">Opaque</xsl:if>
                                    <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@format='predefined'">Predefined</xsl:if>
                                </li>
                            </xsl:if>

                            <li>Subscriber Name:
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'subscribeName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                <!-- <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='subscriberName']/@processProperty"/>

					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@subscriberName"/>
						<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template> -->
                            </li>
                            <li>Durable Name:
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'durableName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                <!-- <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='durableName']/@processProperty"/>

					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@durableName"/>
						<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template> -->
                            </li>
                            <!--ack mode-->
                            <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@acknowledgementMode">
                                <li>Acknowledgement Mode:
                                    <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@acknowledgementMode='auto'">Auto</xsl:if>
                                    <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@acknowledgementMode='explicit'">Explicit</xsl:if>
                                </li>
                            </xsl:if>

                            <li>FTL Queue Dispatcher Threads:
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'queueDispatcherThreads'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                <!-- <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='queueDispatcherThreads']/@processProperty"/>

					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@queueDispatcherThreads"/>
						<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template> -->
                            </li>
                            <li>FTL Queue Size:
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'queueSize'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                <!-- <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='queueSize']/@processProperty"/>
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@queueSize"/>
						<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template> -->
                            </li>
                            <!--ftl queue overflow policy-->
                            <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@queueOverflowDiscardPolicy and ./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@queueSize !='-1'">
                                <li>FTL Queue Overflow Policy:
                                    <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@queueOverflowDiscardPolicy='none'">Discard None</xsl:if>
                                    <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@queueOverflowDiscardPolicy='new'">Discard New</xsl:if>
                                    <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@queueOverflowDiscardPolicy='old'">Discard Old</xsl:if>
                                </li>
                            </xsl:if>

                            <li>Activity Worker Threads:
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'threadPoolMinSize'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                <!-- <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='threadPoolMinSize']/@processProperty"/>

					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="concat('Create equivalent of ',(./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@threadPoolMinSize),' of BW Engine Threads')"/>
						<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template> -->
                            </li>
                        </xsl:if>
                        <!--HTTP RECEIVER-->
                        <xsl:if test="./tibex:eventSource/bwext:BWActivity/@activityTypeID='bw.http.HTTPReceiver'">
                            <li>HTTP Connection:
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'httpConnection'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                            </li>
                            <li>Context Path:
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'contextPath'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                <!-- <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='contextPath']/@processProperty"/>

					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@contextPath"/>
						<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template> -->
                            </li>
                            <li>Path Spec:
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'endpointUri'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                <!-- <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='endpointUri']/@processProperty"/>

					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@endpointUri"/>
						<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template> -->
                            </li>
                            <!--Output Style-->
                            <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@outputStyle"><li>Output Style: <xsl:value-of select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@outputStyle"/></li></xsl:if>
                            <!-- Parse Post Method -->
                            <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@outputStyle='String'">
                                <li>Parse Post Method Data:
                                    <xsl:call-template name="getItalicValue">
                                        <xsl:with-param name="value" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@parsePostData"/>
                                        <xsl:with-param name="defaultValue" select="'false'"/>
                                    </xsl:call-template>
                                </li>
                            </xsl:if>
                            <!--Parameters-->
                            <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/httpParameters">
                                <li>Parameters:
                                    <ul>
                                        <xsl:for-each select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/httpParameters">
                                            <li>
                                                <xsl:value-of select="./@parameterName"/>
                                            </li>
                                        </xsl:for-each>
                                    </ul>
                                </li>
                            </xsl:if>
                            <!--Expose Security Context-->
                            <xsl:choose>
                                <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@exposeSecurityContext"><li>Expose Security Context: true</li></xsl:when>
                                <xsl:otherwise><li>Expose Security Context: false</li></xsl:otherwise>
                            </xsl:choose>
                            <!--Default Encoding-->
                            <xsl:choose>
                                <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@defaultEncoding !='' or ./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='defaultEncoding']/@processProperty !=''">
                                    <li>Default Encoding:
                                        <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'defaultEncoding'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                        <!-- <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='defaultEncoding']/@processProperty"/>

							<xsl:call-template name="getValueFromLiteralModule">
								<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@defaultEncoding"/>
								<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
								<xsl:with-param name="defaultValue" select="''"/>
							</xsl:call-template> -->
                                    </li>
                                </xsl:when>
                            </xsl:choose>
                            <!--Write To File-->
                            <xsl:choose>
                                <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@writeToFile">
                                    <li>Write To File: true</li>
                                    <!--Directory-->
                                    <xsl:choose>
                                        <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@defaultEncoding !='' or ./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='defaultEncoding']/@processProperty !=''">
                                            <li>Directory:
                                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'directory'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                                <!-- <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/writeToFilePolicy/modulePropertyBindings[@eAttributeName='directory']/@configProperty"/>

									<xsl:call-template name="getValueFromLiteralModule">
										<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/writeToFilePolicy/@directory"/>
										<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param> select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/writeToFilePolicy/@directory"/>
										<xsl:with-param name="defaultValue" select="''"/>
									</xsl:call-template> -->
                                            </li>
                                        </xsl:when>
                                    </xsl:choose>
                                    <!--Create Non-Existing Directories-->
                                    <xsl:choose>
                                        <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/writeToFilePolicy/@createNonExistingDirectories"><li>Create Non-Existing Directories: <xsl:value-of select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/writeToFilePolicy/@createNonExistingDirectories"/></li></xsl:when>
                                        <xsl:otherwise>Create Non-Existing Directories: false</xsl:otherwise>
                                    </xsl:choose>
                                    <!--Threadshold Data Size(bytes)-->
                                    <xsl:choose>
                                        <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@defaultEncoding !='' or ./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='defaultEncoding']/@processProperty !=''">
                                            <li>Threadshold Data Size(bytes):
                                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'thresholdDataSize'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                                <!-- <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/writeToFilePolicy/modulePropertyBindings[@eAttributeName='directory']/@configProperty"/>
									<xsl:call-template name="getValueFromLiteralModule">
										<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/writeToFilePolicy/@thresholdDataSize"/>
										<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>  select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/writeToFilePolicy/modulePropertyBindings[@eAttributeName='thresholdDataSize']/@configProperty"/>
										<xsl:with-param name="defaultValue" select="''"/>
									</xsl:call-template> -->
                                            </li>
                                        </xsl:when>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:otherwise>	<li>Write To File: false</li> </xsl:otherwise>
                            </xsl:choose>
                        </xsl:if>
                        <!-- ************************************************************************************************************************** -->
                        <!--JAVA PROCESS STARTER-->
                        <xsl:if test="./tibex:eventSource/bwext:BWActivity/@activityTypeID='bw.java.javaeventsource'">
                            <!--Clas name-->
                            <li>Class Name: <xsl:value-of select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@className"/></li>
                            <!--initiaize-->
                            <xsl:choose>
                                <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@enableInitParam">
                                    <li>Initialize with Parameters: <xsl:value-of select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@enableInitParam"/></li>
                                </xsl:when>
                                <xsl:otherwise>
                                    <li>Initialize with Parameters: false </li>
                                </xsl:otherwise>
                            </xsl:choose>
                            <!--java global instance-->
                            <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@javaGlobalInstance"><li>Java Global Instance: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'javaGlobalInstance'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates><!-- <xsl:value-of select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@javaGlobalInstance"/> --></li></xsl:if>
                        </xsl:if>
                        <!--JMS RECEIVE MESSAGE-->
                        <xsl:if test="./tibex:eventSource/bwext:BWActivity/@activityTypeID='bw.jms.receive'">
                            <!--Messaging Style-->
                            <xsl:choose>
                                <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@messagingStyle='Queue'">
                                    <li>Messaging Style: Queue</li>
                                </xsl:when>
                                <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@messagingStyle='Topic'">
                                    <li>Messaging Style: Topic</li>
                                    <li>Durable Subscriber:
                                        <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'durableSubscriber'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>

                                        <!-- <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/attributeBindings[@eAttributeName='durableSubscriber']/@processProperty"/>
						<xsl:call-template name="getValueFromLiteralModule">
							<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@durableSubscriber"/>
							<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param> select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/attributeBindings[@eAttributeName='durableSubscriber']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="'false'"/>
						</xsl:call-template> -->
                                    </li>
                                </xsl:when>
                                <xsl:when test="not(./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@messagingStyle)">
                                    <li>Messaging Style: Generic</li>
                                </xsl:when>
                            </xsl:choose>
                            <!--JMS Connection-->
                            <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@connectionReference"><li>JMS Connection:
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'connectionReference'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                <!-- <xsl:value-of select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@connectionReference"/> --></li></xsl:if>

                            <li>Destination:
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'destinationName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                <!-- 	<xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/attributeBindings[@eAttributeName='destinationName']/@processProperty"/>
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@destinationName"/>
						<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template> -->
                            </li>
                            <!--Message Type-->
                            <xsl:choose>
                                <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@messageType">
                                    <li>Message Type: <xsl:value-of select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@messageType"/></li>
                                </xsl:when>
                                <xsl:otherwise>
                                    <li>Message Type: Text</li>
                                </xsl:otherwise>
                            </xsl:choose>
                            <!--Subscription Name*-->
                            <li>Subscription Name:
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'subscriptionName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                <!-- <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='subscriptionName']/@processProperty"/>

					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@subscriptionName"/>
						<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template> -->
                            </li>
                            <!--Supress local Messages*-->
                            <li>Supress local Messages:
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'isNoLocal'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='isNoLocal']/@processProperty"/>

                                <xsl:call-template name="getValueFromLiteralModule">
                                    <xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@isNoLocal"/>
                                    <xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
                                    <xsl:with-param name="defaultValue" select="'false'"/>
                                </xsl:call-template>
                            </li>
                            <!--Acknowledge Mode-->
                            <li>Acknowledge Mode:
                                <xsl:if test="not(./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@ackMode)">Auto</xsl:if>
                                <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@ackMode='Client'">Client</xsl:if>
                                <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@ackMode='Dups Ok'">Dups Ok</xsl:if>
                                <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@ackMode='TIBCO EMS Explicit Client'">TIBCO EMS Explicit Client</xsl:if>
                                <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@ackMode='TIBCO EMS EXPLICIT Client DupsOk'">TIBCO EMS EXPLICIT Client DupsOk</xsl:if>
                                <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@ackMode='TIBCO EMS No Acknowledge'">TIBCO EMS No Acknowledge</xsl:if>
                            </li>
                            <!--client: Max Sessions-->
                            <!---Message Selector: *-->
                            <li>Message Selector:
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'messageSelector'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                <!-- 	<xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='messageSelector']/@processProperty"/>
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@messageSelector"/>
						<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template> -->
                            </li>
                            <!--Application Properties Type: -->
                            <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@appPropsReference"><li>Application Properties Type: <xsl:value-of select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@appPropsReference"/></li></xsl:if>
                            <!--Polling Interval(sec) -->
                            <li>Polling Interval(sec):
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'receiveTimeout'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                <!-- <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='receiveTimeout']/@processProperty"/>
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@receiveTimeout"/>
						<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
						<xsl:with-param name="defaultValue" select="'2'"/>
					</xsl:call-template> -->
                            </li>
                        </xsl:if>

                        <!-- ON TIMEOUT -->
                        <xsl:if test="./tibex:eventSource/tibex:OnNotificationTimeout">
                            <xsl:if test="not(./tibex:eventSource/tibex:OnNotificationTimeout/@anyNotifyConfig)">
                                <li>Shared Configuration:
                                    <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'sharedResourceName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                    <!-- <xsl:variable name="variableName" select="./tibex:eventSource/tibex:OnNotificationTimeout/@sharedResourceName"/>
								<xsl:call-template name="getValueFromLiteralModule">
								<xsl:with-param name="valueLiteral" select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/bpws:from/bpws:literal"/>
								<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
								<xsl:with-param name="defaultValue" select="''"/>
							</xsl:call-template> -->
                                    <!-- <xsl:value-of select="./tibex:eventSource/tibex:OnNotificationTimeout/@sharedResourceName"/> -->
                                </li>
                            </xsl:if>
                            <li>Any Notify Config:
                                <xsl:choose>
                                    <xsl:when test="./tibex:eventSource/tibex:OnNotificationTimeout/@anyNotifyConfig">
                                        true
                                    </xsl:when>
                                    <xsl:otherwise>false</xsl:otherwise>
                                </xsl:choose>
                            </li>
                        </xsl:if>

                        <!--JMS RECEIVE MESSAGE-->
                        <xsl:if test="./tibex:eventSource/bwext:BWActivity/@activityTypeID='bw.mail.receive'">
                            <li>Host:
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'host'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                <!-- <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='host']/@processProperty"/>
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@host"/>
						<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template> -->
                            </li>
                            <li>Port:
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'port'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                <!-- <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='port']/@processProperty"/>
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@port"/>
						<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
						<xsl:with-param name="defaultValue" select="'110'"/>
					</xsl:call-template> -->
                            </li>
                            <li>User Name:
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'userName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                <!-- <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='userName']/@processProperty"/>
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@userName"/>
						<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template> -->
                            </li>
                            <li>Password:
                                <xsl:choose>
                                    <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@password"> **** </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'password'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                        <!-- 	<xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='password']/@processProperty"/>
							<xsl:call-template name="getValueFromLiteralModule">
								<xsl:with-param name="valueLiteral" select="''"/>
								<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
								<xsl:with-param name="defaultValue" select="''"/>
							</xsl:call-template> -->
                                    </xsl:otherwise>
                                </xsl:choose>
                            </li>
                            <li>Polling Interval(sec):
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'pollingInterval'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                <!-- <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='pollingInterval']/@processProperty"/>
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@pollingInterval"/>
						<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
						<xsl:with-param name="defaultValue" select="'5'"/>
					</xsl:call-template> -->
                            </li>
                            <!--Delete Mail-->
                            <xsl:choose>
                                <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@deleteMail">
                                    <li>Delete Mail: true</li>
                                </xsl:when>
                                <xsl:otherwise>
                                    <li>Delete Mail: false</li>
                                </xsl:otherwise>
                            </xsl:choose>
                            <!--Enable confidentiality-->
                            <xsl:choose>
                                <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@requiresConfidentiality">
                                    <li>Enable confidentiality: true</li>
                                    <!--SSL Client-->
                                    <xsl:if test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@sslClientProperty">
                                        <li>SSL Client:
                                            <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'sslClientProperty'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                            <!--  <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@sslClientProperty"/>
								<xsl:call-template name="getValueFromLiteralModule">
								<xsl:with-param name="valueLiteral" select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/bpws:from/bpws:literal"/>
								<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
								<xsl:with-param name="defaultValue" select="''"/>
							</xsl:call-template> -->
                                            <!-- <xsl:value-of select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@sslClientProperty"/>--></li>
                                    </xsl:if>
                                </xsl:when>
                                <xsl:otherwise>
                                    <li>Enable confidentiality: false</li>
                                </xsl:otherwise>
                            </xsl:choose>
                            <!--Provide Raw Message-->
                            <xsl:choose>
                                <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@provideRawMessage">
                                    <li>Provide Raw Message: true</li>
                                </xsl:when>
                                <xsl:otherwise>
                                    <li>Provide Raw Message: false</li>
                                </xsl:otherwise>
                            </xsl:choose>
                            <!--Write to File-->
                            <xsl:choose>
                                <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@writeToFile">
                                    <li>Write to File: true</li>
                                    <li>Directory:
                                        <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'directory'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                        <!-- <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/writeToFilePolicy/modulePropertyBindings[@eAttributeName='directory']/@configProperty"/>
							<xsl:call-template name="getValueFromLiteralModule">
								<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/writeToFilePolicy/@directory"/>
								<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
								<xsl:with-param name="defaultValue" select="''"/>
							</xsl:call-template> -->
                                    </li>
                                    <xsl:choose>
                                        <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/writeToFilePolicy/@createNonExistingDirectories">
                                            <li>Create Non-Existing Directories: true</li>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <li>Create Non-Existing Directories: false</li>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                        <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/writeToFilePolicy/@thresholdDataSize">
                                            <li>Treshold Data Size(bytes): <xsl:value-of select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/writeToFilePolicy/@thresholdDataSize"/></li>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <li>Treshold Data Size(bytes): 0</li>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:otherwise>
                                    <li>Write to File: false</li>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:if>

                        <!--RENDEZVOUS SUBSCRIBER-->
                        <xsl:if test="./tibex:eventSource/bwext:BWActivity/@activityTypeID='bw.rv.rvSubscriber'">
                            <li>Subject:
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'subject'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                <!-- <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='subject']/@processProperty"/>
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@subject"/>
						<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template> -->
                            </li>
                            <li>Transport:
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'transport'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                <!-- <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='transport']/@processProperty"/>
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@transport"/>
						<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template> -->
                            </li>
                            <!--Raw-RV-Object Mode-->
                            <xsl:choose>
                                <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@rawRVObjectMode='true'">
                                    <li>Raw-RV-Object Mode: true</li>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:choose>
                                        <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@needXMLFormat">
                                            <li>XML Format: true</li>
                                            <li>Need Output Filteration: false</li>
                                        </xsl:when>
                                        <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@needOutputFiltration">
                                            <li>XML Format: false</li>
                                            <li>Need utput Filteration: true</li>
                                        </xsl:when>
                                        <xsl:when test="not(./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@needXMLFormat) and not(./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@needOutputFiltration)">
                                            <li>XML Format: false</li>
                                            <li>Need utput Filteration: false</li>
                                        </xsl:when>
                                    </xsl:choose>
                                    <!--XML Compliant Field Names-->
                                    <xsl:choose>
                                        <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@needXMLCompliantFieldNames">
                                            <li>XML Compliant Field Names: true</li>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <li>XML Compliant Field Names: false</li>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <li>Raw-RV-Object Mode: false</li>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:if>

                        <!-- RECEIVE NOTIFICATION -->
                        <xsl:if test="./tibex:eventSource/tibex:ReceiveNotification">
                            <li>Shared Configuration:
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'sharedResourceName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                <!-- <xsl:variable name="variableName" select="./tibex:eventSource/tibex:ReceiveNotification/@sharedResourceName"/>
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/bpws:from/bpws:literal"/>
						<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template> -->
                                <!-- <xsl:value-of select="./tibex:eventSource/tibex:ReceiveNotification/@sharedResourceName"/> -->
                            </li>
                        </xsl:if>

                        <!--TCP RECEIVER-->
                        <xsl:if test="./tibex:eventSource/bwext:BWActivity/@activityTypeID='bw.tcp.receive'">
                            <li>Host:
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'host'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                <!-- <xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='host']/@processProperty"/>
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@host"/>
						<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template> -->
                            </li>
                            <li>Port:
                                <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'port'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                                <!-- 				<xsl:variable name="variableName" select="./tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='port']/@processProperty"/>
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@port"/>
						<xsl:with-param name="valueModuleProp"><xsl:choose><xsl:when test="string-length(/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource)>0"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$variableName]/@tibex:propertySource"/></xsl:when><xsl:otherwise><xsl:value-of select="$variableName"/></xsl:otherwise></xsl:choose></xsl:with-param>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template> -->
                            </li>
                            <!--Enable DNS Lookup-->
                            <xsl:choose>
                                <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@enableDNSLookup">
                                    <li>Enable DNS Lookup: true</li>
                                </xsl:when>
                                <xsl:otherwise>
                                    <li>Enable DNS Lookup: false</li>
                                </xsl:otherwise>
                            </xsl:choose>

                            <!--Keep Alive-->
                            <xsl:choose>
                                <xsl:when test="./tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@keepAlive">
                                    <li>Keep Alive: true</li>
                                </xsl:when>
                                <xsl:otherwise>
                                    <li>Keep Alive: false</li>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:if>

                        <!--li>ReplyWith: <xsl:choose><xsl:when test="@faultName"><xsl:if test="@faultName='Fault'">Fault: <xsl:value-of select="//bpws:variable[@name=$var]/@messageType"/></xsl:if><xsl:if test="@faultName='UndeclaredFault'">Undeclared Fault</xsl:if></xsl:when><xsl:otherwise>Output Message</xsl:otherwise></xsl:choose></li-->

                        <xsl:if test="@createInstance"><li>Create Instance: <xsl:value-of select="@createInstance"/></li></xsl:if>
                        <xsl:if test="./tibex:inputBindings/tibex:inputBinding"><li><i>Input bindings:</i> <xsl:apply-templates select="./tibex:inputBindings/tibex:inputBinding"/>	</li></xsl:if>
                        <xsl:if test="sequenceKey/@expression"><li>Sequence Key: <xsl:value-of select="sequenceKey/@expression"/></li></xsl:if>
                        <xsl:if test="customId/@expression"><li>Custom Job Id: <xsl:value-of select="customId/@expression"/></li></xsl:if>
                        <xsl:apply-templates select="./bwext:BWActivity" mode="main"><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                        <xsl:if test="bpws:correlations/bpws:correlation">	<xsl:apply-templates select="bpws:correlations"/>	</xsl:if>
                        <li>Description: <xsl:value-of select="bpws:documentation"/></li>
                    </ul>
                </p>
            </conbody>
        </concept>
    </xsl:template>

    <xsl:template name="timer">
        <xsl:for-each select="//bpws:scope/bpws:flow/bpws:extensionActivity/tibex:receiveEvent/tibex:eventSource/bwext:BWActivity[@activityTypeID='bw.generalactivities.timer']/../..">
            <xsl:variable name="var" select="@variable"/>
            <concept>
                <xsl:attribute name="id">
                    <xsl:value-of select="ncname:transformToNCName(@name)"/>
                </xsl:attribute>
                <title>Name:
                    <xsl:call-template name="getBoldItalicValue">
                        <xsl:with-param name="value" select="@name"/>
                    </xsl:call-template>
                </title>
                <conbody>
                    <p>
                        <ul>
                            <xsl:choose>
                                <xsl:when test="string-length(bpws:documentation)=0"><li>Description: No description</li></xsl:when>
                                <xsl:otherwise><li>Description: <xsl:value-of select="bpws:documentation"/></li></xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="./@partnerLink">	<li>Service: <xsl:value-of select="./@partnerLink"/></li> </xsl:if>
                            <xsl:if test="./@operation"> <li>Operation: <xsl:value-of select="./@operation"/></li> </xsl:if>
                            <!--li>ReplyWith: <xsl:choose><xsl:when test="@faultName"><xsl:if test="@faultName='Fault'">Fault: <xsl:value-of select="//bpws:variable[@name=$var]/@messageType"/></xsl:if><xsl:if test="@faultName='UndeclaredFault'">Undeclared Fault</xsl:if></xsl:when><xsl:otherwise>Output Message</xsl:otherwise></xsl:choose></li-->
                            <li>Start Time:
                                <xsl:choose>
                                    <xsl:when test="../tibex:receiveEvent[@variable=$var]/*[local-name()='eventSource']/*[local-name()='BWActivity']/activityConfig/properties/value/@startTime">
                                        <xsl:value-of select="../tibex:receiveEvent[@variable=$var]/*[local-name()='eventSource']/*[local-name()='BWActivity']/activityConfig/properties/value/@startTime"/>
                                    </xsl:when>
                                    <xsl:when test="//tibex:receiveEvent[@variable=$var]/tibex:eventSource/*[local-name()='BWActivity']/attributeBindings[@eAttributeName='startTime']/@processProperty!=''">
                                        <xsl:variable name="profileInfo" select="CustomFunctionsEagle:getModulePropertyProfileInfo(//bpws:process/bpws:variables/bpws:variable[@name=//tibex:receiveEvent[@variable=$var]/tibex:eventSource/*[local-name()='BWActivity']/attributeBindings[@eAttributeName='startTime']/@processProperty]/@name,$applicationName)"/>
                                        <xref outputclass="popup" format="html" href="#{$profileInfo}"><xsl:value-of select="//bpws:process/bpws:variables/bpws:variable[@name=//tibex:receiveEvent[@variable=$var]/tibex:eventSource/*[local-name()='BWActivity']/attributeBindings[@eAttributeName='startTime']/@processProperty]/@name"/></xref>
                                    </xsl:when>
                                    <xsl:otherwise><xsl:value-of select="'not found'"/></xsl:otherwise>

                                    <!--xsl:when test="tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='startTime']">
						<xsl:value-of select="tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='startTime']/@processProperty"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@startTime"/>
					</xsl:otherwise-->
                                </xsl:choose>
                            </li>
                            <xsl:choose>
                                <xsl:when test="tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@runOnce"><li>Run Once: <xsl:value-of select="tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@runOnce"/></li></xsl:when>
                                <xsl:otherwise>
                                    <li>Run Once: <xsl:value-of select="'false'"/></li>
                                    <li>Time Interval:
                                        <xsl:choose>
                                            <xsl:when test="../*[local-name()='receiveEvent'][@variable=$var]/*[local-name()='eventSource']/*[local-name()='BWActivity']/activityConfig/properties/value/@timeInterval">
                                                <xsl:value-of select="../*[local-name()='receiveEvent'][@variable=$var]/*[local-name()='eventSource']/*[local-name()='BWActivity']/activityConfig/properties/value/@timeInterval"/>
                                            </xsl:when>
                                            <xsl:when test="//tibex:receiveEvent[@variable=$var]/tibex:eventSource/*[local-name()='BWActivity']/attributeBindings[@eAttributeName='timeInterval']/@processProperty!=''">
                                                <xsl:variable name="varProfile" select="tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='timeInterval']/@processProperty"/>
                                                <xsl:value-of select="$varProfile"/>

                                                <xsl:variable name="profileInfo" select="CustomFunctionsEagle:getModulePropertyProfileInfo(//bpws:process/bpws:variables/bpws:variable[@name=$varProfile]/@name,$applicationName)"/>
                                                <xsl:value-of select="$profileInfo"/>
                                                <xref outputclass="popup" format="html" href="#{$profileInfo}"><xsl:value-of select="//bpws:process/bpws:variables/bpws:variable[@name=//tibex:receiveEvent[@variable=$var]/tibex:eventSource/*[local-name()='BWActivity']/attributeBindings[@eAttributeName='timeInterval']/@processProperty]/@name"/></xref>
                                            </xsl:when>
                                            <xsl:otherwise><xsl:value-of select="'Not found'"/></xsl:otherwise>

                                            <!--xsl:when test="tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='timeInterval']">
									<xsl:value-of select="tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='timeInterval']/@processProperty"/>
									</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@timeInterval"/>
							</xsl:otherwise-->
                                        </xsl:choose>

                                    </li>
                                    <li>Interval Unit: <xsl:value-of select="tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@intervalUnit"/></li>
                                    <xsl:if test="tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@endPolicy='END_TIME'">
                                        <li>End After: End Time</li>
                                        <li>End Time:
                                            <xsl:choose>
                                                <xsl:when test="../*[local-name()='receiveEvent'][@variable=$var]/*[local-name()='eventSource']/*[local-name()='BWActivity']/activityConfig/properties/value/@endTime">
                                                    <xsl:value-of select="../*[local-name()='receiveEvent'][@variable=$var]/*[local-name()='eventSource']/*[local-name()='BWActivity']/activityConfig/properties/value/@endTime"/>
                                                </xsl:when>
                                                <xsl:when test="//tibex:receiveEvent[@variable=$var]/tibex:eventSource/*[local-name()='BWActivity']/attributeBindings[@eAttributeName='endTime']/@processProperty!=''">
                                                    <xsl:variable name="profileInfo" select="CustomFunctionsEagle:getModulePropertyProfileInfo(//bpws:process/bpws:variables/bpws:variable[@name=//tibex:receiveEvent[@variable=$var]/tibex:eventSource/*[local-name()='BWActivity']/attributeBindings[@eAttributeName='endTime']/@processProperty]/@name,$applicationName)"/>
                                                    <xref outputclass="popup" format="html" href="#{$profileInfo}"><xsl:value-of select="//bpws:process/bpws:variables/bpws:variable[@name=//tibex:receiveEvent[@variable=$var]/tibex:eventSource/*[local-name()='BWActivity']/attributeBindings[@eAttributeName='endTime']/@processProperty]/@name"/></xref>
                                                </xsl:when>
                                                <xsl:otherwise><xsl:value-of select="'Not found'"/></xsl:otherwise>



                                                <!--xsl:when test="tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='endTime']">
										<xsl:value-of select="tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='endTime']/@processProperty"/>
									</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@endTime"/>
								</xsl:otherwise-->
                                            </xsl:choose>
                                        </li>
                                    </xsl:if>
                                    <xsl:if test="tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@endPolicy=''">
                                        <li>End After: Occurrences</li>
                                        <li>Occurrences:
                                            <xsl:choose>
                                                <xsl:when test="../*[local-name()='receiveEvent'][@variable=$var]/*[local-name()='eventSource']/*[local-name()='BWActivity']/activityConfig/properties/value/@occurrences">
                                                    <xsl:value-of select="../*[local-name()='receiveEvent'][@variable=$var]/*[local-name()='eventSource']/*[local-name()='BWActivity']/activityConfig/properties/value/@occurrences"/>
                                                </xsl:when>
                                                <xsl:when test="//tibex:receiveEvent[@variable=$var]/tibex:eventSource/*[local-name()='BWActivity']/attributeBindings[@eAttributeName='occurrences']/@processProperty!=''">
                                                    <xsl:variable name="profileInfo" select="CustomFunctionsEagle:getModulePropertyProfileInfo(//bpws:process/bpws:variables/bpws:variable[@name=//tibex:receiveEvent[@variable=$var]/tibex:eventSource/*[local-name()='BWActivity']/attributeBindings[@eAttributeName='occurrences']/@processProperty]/@name,$applicationName)"/>
                                                    <xref outputclass="popup" format="html" href="#{$profileInfo}"><xsl:value-of select="//bpws:process/bpws:variables/bpws:variable[@name=//tibex:receiveEvent[@variable=$var]/tibex:eventSource/*[local-name()='BWActivity']/attributeBindings[@eAttributeName='occurrences']/@processProperty]/@name"/></xref>
                                                </xsl:when>
                                                <xsl:otherwise><xsl:value-of select="'0'"/></xsl:otherwise>



                                                <!--xsl:when test="tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='occurrences']">
									<xsl:value-of select="tibex:eventSource/bwext:BWActivity/attributeBindings[@eAttributeName='occurrences']/@processProperty"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@occurrences">
											<xsl:value-of select="tibex:eventSource/bwext:BWActivity/activityConfig/properties/value/@occurrences"/>
										</xsl:when>
										<xsl:otherwise>0</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise-->
                                            </xsl:choose>
                                        </li>
                                    </xsl:if>
                                    <xsl:if test="tibex:eventSource/bwext:BWActivity/activityConfig/properties/value[not(@endPolicy)]">
                                        <li>End After: Never</li>
                                    </xsl:if>
                                </xsl:otherwise>
                            </xsl:choose>

                            <xsl:if test="sequenceKey/@expression"><li>Sequence Key: <xsl:value-of select="sequenceKey/@expression"/></li></xsl:if>
                            <xsl:if test="customId/@expression"><li>Custom Job Id: <xsl:value-of select="customId/@expression"/></li></xsl:if>
                            <xsl:apply-templates select="./bwext:BWActivity" mode="main"><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                            <xsl:if test="bpws:correlations/bpws:correlation">
                                <xsl:apply-templates select="bpws:correlations"/>
                            </xsl:if>
                        </ul>
                    </p>
                </conbody>
            </concept>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="bpws:empty">
        <concept>
            <xsl:attribute name="id">
                <xsl:value-of select="ncname:transformToNCName(@name)"/>
            </xsl:attribute>
            <title>Name:
                <xsl:call-template name="getBoldItalicValue">
                    <xsl:with-param name="value" select="@name"/>
                </xsl:call-template>
            </title>
            <conbody>
                <p>
                    <ul>
                        <li>Constructor: <xsl:value-of select="@tibex:constructor"/></li>
                        <li>xpdlId: <xsl:value-of select="@tibex:xpdlId"/></li>
                        <!--xsl:if test="./@partnerLink">	<li>Service: <xsl:value-of select="./@partnerLink"/></li> </xsl:if-->
                    </ul>
                </p>
            </conbody>
        </concept>
    </xsl:template>
    <!-- Transition common template-->
    <xsl:template match="bpws:link">

    </xsl:template>
    <!-- BWActivity -->
    <xsl:template match="bwext:BWActivity" mode="main">
        <xsl:param name="idFrom"/>
        <li>Type: <xsl:value-of select="@activityTypeID"/></li>
        <!-- xsl:for-each select="attributeBindings">
			<li><xsl:value-of select="bw6:map/entry[@key=./@eAttributeName]"/>: <i><xsl:value-of select="./@processProperty"/></i></li>
		</xsl:for-each>
		<xsl:for-each select="./activityConfig/properties/value/@*">
			<li><xsl:value-of select="name()"/>: <i><xsl:value-of select="."/></i></li>
		</xsl:for-each-->
        <xsl:choose>
            <xsl:when test="@activityTypeID='bw.ftl.subscriber'">
                <li>FTL Realm Server Connection: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'ftlRealmServerConnection'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="

					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@ftlRealmServerConnection"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='ftlRealmServerConnection' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='ftlRealmServerConnection' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Format: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@format"/></xsl:call-template></li>
                <li>Acknowledgement mode: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@acknowledgementMode"/></xsl:call-template></li>
                <li>FTL Queue Dispatcher Threads: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'queueDispatcherThreads'"/><xsl:with-param name="defaultValue" select="1"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@queueDispatcherThreads"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='queueDispatcherThreads' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='queueDispatcherThreads' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="1"/>
				</xsl:call-template> --></li>
                <li>Queue Overflow Discard Policy: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@queueOverflowDiscardPolicy"/></xsl:call-template></li>
                <li>Subscriber Name: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'subscriberName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@subscriberName"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='subscriberName' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='subscriberName' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Activity Worker Threads: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'thredPoolMinSize'"/><xsl:with-param name="defaultValue" select="'50%'"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@threadPoolMinSize"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='threadPoolMinSize' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='threadPoolMinSize' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="'50%'"/>
				</xsl:call-template> --></li>
                <li>FTL Queue Size: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'queueSize'"/><xsl:with-param name="defaultValue" select="-1"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@queueSize"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='queueSize' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='queueSize' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="-1"/>
				</xsl:call-template> --></li>
                <li>Endpoint: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'endpoint'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@endpoint"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='endpoint' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='endpoint' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Content Matcher: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'contentMatcher'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@contentMatcher"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='contentMatcher' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='contentMatcher' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.ftl.publisher'">
                <li>FTL Realm Server Connection: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'ftlRealmServerConnection'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@ftlRealmServerConnection"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='ftlRealmServerConnection' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='ftlRealmServerConnection' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Format: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@format"/></xsl:call-template></li>
                <li>Endpoint: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'endpoint'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@endpoint"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='endpoint' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='endpoint' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.ftl.reply'">
                <li>Reply for: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@replyFor"/></xsl:call-template></li>
                <li>Format: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@format"/></xsl:call-template></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.ftl.requestreply'">
                <li>FTL Realm Server Connection: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'ftlRealmServerConnection'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@ftlRealmServerConnection"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='ftlRealmServerConnection' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='ftlRealmServerConnection' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Reply Format: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@replyFormat"/></xsl:call-template></li>
                <li>Activity Worker Threads: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@threadPoolMinSize"/></xsl:call-template></li>
                <li>Endpoint: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'endpoint'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@endpoint"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='endpoint' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='endpoint' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Request Format: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@requestFormat"/></xsl:call-template></li>
                <li>Request Format Name: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'requestFormatName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@requestFormatName"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='requestFormatName' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='requestFormatName' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Activity Timeout: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'activityTimeout'"/><xsl:with-param name="defaultValue" select="30000"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@activityTimeout"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='activityTimeout' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='activityTimeout' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="30000"/>
				</xsl:call-template> --></li>
            </xsl:when>
            <!-- FILE ACTIVITIES -->
            <xsl:when test="@activityTypeID='bw.file.read'">
                <li>File name: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'fileName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@fileName"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='fileName' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='fileName' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Exclude file content:
                    <xsl:call-template name="getItalicValue">
                        <xsl:with-param name="value" select="activityConfig/properties/value/@excludeContent"/>
                        <xsl:with-param name="defaultValue" select="'false'"/>
                    </xsl:call-template>
                </li>
                <xsl:if test="not(activityConfig/properties/value/@excludeContent)">
                    <li>Read As: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@readAs"/></xsl:call-template></li>
                </xsl:if>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.file.poller'">
                <li>File name: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'fileName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@fileName"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='fileName' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='fileName' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Content As: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@contentAS"/></xsl:call-template></li>
                <li>Exclude file content: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@excludeContent"/></xsl:call-template></li>
                <li>Polling interval (sec): <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'pollInterval'"/><xsl:with-param name="defaultValue" select="5"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@pollInterval"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='pollInterval' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='pollInterval' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="5"/>
				</xsl:call-template> --></li>
                <li>Include Existing Files: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@includeCurrent"/></xsl:call-template></li>
                <li>Encoding: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'encoding'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@encoding"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='encoding' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='encoding' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Poll for Create Events: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@createEvent"/></xsl:call-template></li>
                <li>Poll for Modify Events: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@modifyEvent"/></xsl:call-template></li>
                <li>Poll for Delete Events: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@deleteEvent"/></xsl:call-template></li>
                <li>Include Sub-Directories: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@includeSubDirectories"/></xsl:call-template></li>
                <li>Mode: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@mode"/></xsl:call-template></li>
                <li>Sort By: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@sortby"/></xsl:call-template></li>
                <li>Sort Order: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@sortorder"/></xsl:call-template></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.file.create'">
                <li>File name: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'fileName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@fileName"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='fileName' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='fileName' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Create Non-existing directories:
                    <xsl:call-template name="getItalicValue">
                        <xsl:with-param name="value" select="activityConfig/properties/value/@createMissingDirectories"/>
                        <xsl:with-param name="defaultValue" select="'false'"/>
                    </xsl:call-template>
                </li>
                <li>Overwrite:
                    <xsl:call-template name="getItalicValue">
                        <xsl:with-param name="path" select="activityConfig/properties/value/@overwrite"/>
                        <xsl:with-param name="defaultValue" select="'false'"/>
                    </xsl:call-template>
                </li>
                <li>Is Directory:
                    <xsl:call-template name="getItalicValue">
                        <xsl:with-param name="path" select="activityConfig/properties/value/@createDirectory"/>
                        <xsl:with-param name="defaultValue" select="'false'"/>
                    </xsl:call-template>
                </li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.file.remove'">
                <li>File name: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'fileName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@fileName"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='fileName' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='fileName' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.file.wait'">
                <li>File name: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'fileName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                </li>
                <li>Content As: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@contentAs"/></xsl:call-template></li>
                <li>Encoding: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@encoding"/></xsl:call-template></li>
                <li>Polling interval (sec): <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'pollInterval'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                </li>
                <li>Include Existing Files: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@includeCurrent"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
                <li>Exclude File Content: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@excludeContent"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
                <li>Event Timeout(seconds): <xsl:value-of select="./../../@eventTimeout"/></li>
                <li>Activity Timeout(msec): <xsl:value-of select="./../../activityTimeoutDesign/@expression"/></li>
                <li>Poll for Create Events: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@createEvent"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
                <li>Poll for Modify Events: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@modifyEvent"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
                <li>Poll for Delete Events: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@deleteEvent"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
                <li>Mode: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@mode"/></xsl:call-template></li>
                <li>Sort By: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@sortby"/></xsl:call-template></li>
                <li>Sort Order: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@sortorder"/></xsl:call-template></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.file.write'">
                <li>File name:
                    <xsl:choose>
                        <xsl:when test="activityConfig/properties/value/@fileName">
                            <xsl:value-of select="activityConfig/properties/value/@fileName"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'fileName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                        </xsl:otherwise>
                    </xsl:choose>

                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@fileName"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='fileName' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='fileName' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <!--li>Create Non-existing directories: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@createMissingDirectories"/></xsl:call-template></li-->
                <xsl:choose>
                    <xsl:when test="activityConfig/properties/value/@createMissingDirectories"><li>Create Non-existing directories: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@createMissingDirectories"/></xsl:call-template></li></xsl:when>
                    <xsl:otherwise>
                        <li>Create Non-existing directories: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="'false'"/></xsl:call-template></li>
                    </xsl:otherwise>
                </xsl:choose>
                <!--li>Append: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@append"/></xsl:call-template></li-->
                <xsl:choose>
                    <xsl:when test="activityConfig/properties/value/@append"><li>Append: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@append"/></xsl:call-template></li></xsl:when>
                    <xsl:otherwise>
                        <li>Append: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="'false'"/></xsl:call-template></li>
                    </xsl:otherwise>
                </xsl:choose>
                <li>Compress: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@compressFile"/></xsl:call-template></li>
                <li>Encoding: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@encoding"/></xsl:call-template></li>
                <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@encoding"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='encoding' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='encoding' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> </li>-->
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.file.rename'">
                <li>From File name: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'fromFileName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@fromFileName"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='fromFileName' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='fromFileName' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>To File name: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'toFileName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@toFileName"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='toFileName' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='toFileName' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Create Non-existing directories:
                    <xsl:call-template name="getItalicValue">
                        <xsl:with-param name="value" select="activityConfig/properties/value/@createDestinationDirectories"/>
                        <xsl:with-param name="defaultValue" select="'false'"/>
                    </xsl:call-template>
                </li>
                <li>Overwrite:
                    <xsl:call-template name="getItalicValue">
                        <xsl:with-param name="value" select="activityConfig/properties/value/@overwrite"/>
                        <xsl:with-param name="defaultValue" select="'false'"/>
                    </xsl:call-template>
                </li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.file.list'">
                <li>File name: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'fileName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@fileName"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='fileName' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='fileName' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Mode: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@mode"/></xsl:call-template></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.file.copy'">
                <li>From File name: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'fromFileName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@fromFileName"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='fromFileName' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='fromFileName' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>To File name: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'toFileName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@toFileName"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='toFileName' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='toFileName' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Create Non-existing directories:
                    <xsl:call-template name="getItalicValueOfCheckbox">
                        <xsl:with-param name="path" select="activityConfig/properties/value/@createDestinationDirectories"/>
                    </xsl:call-template>
                </li>
                <li>Overwrite:
                    <xsl:call-template name="getItalicValueOfCheckbox">
                        <xsl:with-param name="path" select="activityConfig/properties/value/@overwrite"/>
                    </xsl:call-template>
                </li>
                <li>Include Sub-Directories:
                    <xsl:call-template name="getItalicValueOfCheckbox">
                        <xsl:with-param name="path" select="activityConfig/properties/value/@includeSubDirectories"/>
                    </xsl:call-template>
                </li>
            </xsl:when>
            <!-- INTERNAL ACTIVITIES -->
            <xsl:when test="@activityTypeID='bw.internal.getContext' or @activityTypeID='bw.internal.setContext'">
                <li>Service: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@partnerName"/></xsl:call-template></li>
                <li>Operation: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@operationName"/></xsl:call-template></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.internal.setEPR'">
                <li>Dynamic reference: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@referenceName"/></xsl:call-template></li>
            </xsl:when>
            <!-- FTP ACTIVITIES -->
            <xsl:when test="contains(@activityTypeID,'bw.ftp.')">
                <li>FTP Connection: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'ftpConnection'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@ftpConnection"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='ftpConnection' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='ftpConnection' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Quit (post-command):
                    <xsl:call-template name="getItalicValueOfCheckbox">
                        <xsl:with-param name="path" select="activityConfig/properties/value/@quitPostCommand"/>
                    </xsl:call-template>
                </li>
                <xsl:if test="@activityTypeID='bw.ftp.quote'">
                    <li>Has Socket Data:
                        <xsl:call-template name="getItalicValueOfCheckbox">
                            <xsl:with-param name="path" select="activityConfig/properties/value/@hasSocketData"/>
                        </xsl:call-template>
                    </li>
                </xsl:if>
                <xsl:if test="@activityTypeID='bw.ftp.dir'">
                    <li>NLST:
                        <xsl:call-template name="getItalicValueOfCheckbox">
                            <xsl:with-param name="path" select="activityConfig/properties/value/@nlst"/>
                        </xsl:call-template>
                    </li>
                </xsl:if>
                <xsl:if test="@activityTypeID='bw.ftp.put' or @activityTypeID='bw.ftp.get'">
                    <li>Use Process Data:
                        <xsl:call-template name="getItalicValueOfCheckbox">
                            <xsl:with-param name="path" select="activityConfig/properties/value/@useProcessData"/>
                        </xsl:call-template>
                    </li>
                    <li>Binary:
                        <xsl:call-template name="getItalicValueOfCheckbox">
                            <xsl:with-param name="path" select="activityConfig/properties/value/@binary"/>
                        </xsl:call-template>
                    </li>
                    <li>Overwrite Existing File:
                        <xsl:call-template name="getItalicValueOfCheckbox">
                            <xsl:with-param name="path" select="activityConfig/properties/value/@overwriteExistingFile"/>
                        </xsl:call-template>
                    </li>
                </xsl:if>
                <xsl:if test="@activityTypeID='bw.ftp.put'">
                    <li>Append:
                        <xsl:call-template name="getItalicValueOfCheckbox">
                            <xsl:with-param name="path" select="activityConfig/properties/value/@append"/>
                        </xsl:call-template>
                    </li>
                    <li>Timeout (msec): <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'timeout'"/><xsl:with-param name="defaultValue" select="120000"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                        <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@timeout"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='timeout' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='timeout' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="120000"/>
				</xsl:call-template> --></li>
                </xsl:if>
            </xsl:when>
            <!-- GENERAL ACTIVITIES -->
            <xsl:when test="@activityTypeID='bw.generalactivities.log'">
                <li>Logger Name: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'loggerName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@loggerName"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='loggerName' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='loggerName' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Log level: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@role"/></xsl:call-template></li>
                <li>Suppress Job Info:
                    <xsl:call-template name="getItalicValueOfCheckbox">
                        <xsl:with-param name="path" select="activityConfig/properties/value/@suppressJobInfo"/>
                    </xsl:call-template>
                </li>
            </xsl:when>

            <xsl:when test="@activityTypeID='bw.generalactivities.timer'">
                <li>Start Time: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'startTime'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@startTime"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='startTime' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='startTime' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Run Once: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@runOnce"/></xsl:call-template></li>
                <xsl:if test="activityConfig/properties/value/@runOnce">
                    <li>Time Interval: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'timeInterval'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                        <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@timeInterval"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='timeInterval' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='timeInterval' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                    <li>Interval Unit: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@intervalUnit"/></xsl:call-template></li>
                    <xsl:choose>
                        <xsl:when test="activityConfig/properties/value/@occurrences">
                            <li>End After: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="'Occurrences'"/></xsl:call-template></li>
                            <li>Occurrences: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'occurrences'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                                <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@occurrences"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='occurrences' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='occurrences' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                        </xsl:when>
                        <xsl:when test="activityConfig/properties/value/@endPolicy='END_TIME'">
                            <li>End After: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="'End Time'"/></xsl:call-template></li>
                            <li>End Time: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'endTime'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                                <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@endTime"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='endTime' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='endTime' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
							</xsl:call-template> --></li>
                        </xsl:when>
                        <xsl:otherwise>
                            <li>End After: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="'Never'"/></xsl:call-template></li>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.generalactivities.bwassign'">
                <li>Process Variable to Set: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@processVariable"/></xsl:call-template></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.generalactivities.confirm'">
                <li>Confirm Event: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@confirmEvent"/></xsl:call-template></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.generalactivities.externalcommand'">
                <li>Command to execute: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'command'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@command"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='command' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='command' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
							</xsl:call-template> --></li>
                <li>Provide Command output:
                    <xsl:call-template name="getItalicValueOfCheckbox">
                        <xsl:with-param name="path" select="activityConfig/properties/value/@outputCommandOutput"/>
                    </xsl:call-template>
                </li>
                <li>Remove parameter quotes:
                    <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
                        <xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@removeParameterQuotes"/>
                        <xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='removeParameterQuotes' and @bindingType='moduleProperty']/@processProperty"/>
                        <xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='removeParameterQuotes' and @bindingType='scaProperty']/@processProperty"/>
                        <xsl:with-param name="defaultValue" select="'false'"/>
                    </xsl:call-template> </li>
                <li>Output filename: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'outputFileName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@outputFilename"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='outputFilename' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='outputFilename' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
							</xsl:call-template> --></li>
                <li>Output line splitting: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@outputLineSplittingMode"/></xsl:call-template></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.generalactivities.inspector' or @activityTypeID='bw.internal.inspector'">
                <li>Inspect: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@inspect"/></xsl:call-template></li>
                <li>Stdout:
                    <xsl:call-template name="getItalicValueOfCheckbox">
                        <xsl:with-param name="path" select="activityConfig/properties/value/@stdOut"/>
                    </xsl:call-template>
                </li>
                <li>Append to file:
                    <xsl:call-template name="getItalicValueOfCheckbox">
                        <xsl:with-param name="path" select="activityConfig/properties/value/@appendFile"/>
                    </xsl:call-template>
                </li>
                <li>Suppress Header:
                    <xsl:call-template name="getItalicValueOfCheckbox">
                        <xsl:with-param name="path" select="activityConfig/properties/value/@supressHeader"/>
                    </xsl:call-template>
                </li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.generalactivities.mapper'">
                <li>Input Qname: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@inputQName"/></xsl:call-template></li>
            </xsl:when>
            <!-- HTTP ACTIVITIES -->
            <xsl:when test="@activityTypeID='bw.http.HTTPReceiver' or @activityTypeID='bw.http.waitForHTTPRequest'">
                <li>HTTP Connection: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'httpConnection'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@httpConnection"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='httpConnection' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='httpConnection' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
							</xsl:call-template> --></li>
                <li>Context Path: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'contextPath'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@contextPath"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='contextPath' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='contextPath' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
							</xsl:call-template> --><xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@contextPath"/></xsl:call-template></li>
                <li>Path spec: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'endpointUri'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@endpointUri"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='endpointUri' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='endpointUri' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
							</xsl:call-template> --></li>
                <li>Output style: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@outputStyle"/></xsl:call-template></li>
                <li>Parse Post Method Data: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@parsePostData"/></xsl:call-template></li>
                <li>Parameters:
                    <xsl:choose>
                        <xsl:when test="count(activityConfig/properties/value/httpParameters)!=0">
                            <ul>
                                <xsl:for-each select="activityConfig/properties/value/httpParameters">
                                    <li><xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="@parameterName"/></xsl:call-template></li>
                                </xsl:for-each>
                            </ul>
                        </xsl:when>
                        <xsl:otherwise><p>No Parameters</p></xsl:otherwise>
                    </xsl:choose>
                </li>
                <li>Expose security context: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@exposeSecurityContext"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
                <li>Default Encoding: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'defaultEncoding'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@defaultEncoding"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='defaultEncoding' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='defaultEncoding' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
							</xsl:call-template> --></li>
                <li>Event Timeout(seconds): <xsl:value-of select="./../../@eventTimeout"/></li>
                <li>Activity Timeout(msec): <xsl:value-of select="./../../activityTimeoutDesign/@expression"/></li>
                <li>Write To File: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@writeToFile"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
                <li>Directory: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'directory'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@directory"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='directory' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='directory' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
							</xsl:call-template> --></li>
                <li>Create Non-Existing Directories: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/writeToFilePolicy/@createNonExistingDirectories"/></xsl:call-template></li>
                <li>Threshold Data Size(bytes): <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'tresholdDataSize'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/writeToFilePolicy/@thresholdDataSize"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='thresholdDataSize' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='thresholdDataSize' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
							</xsl:call-template> --></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.http.sendHTTPResponse'">
                <li>Reply For: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@replyFor"/></xsl:call-template></li>
                <li>Flush Response:
                    <xsl:call-template name="getItalicValueOfCheckbox">
                        <xsl:with-param name="path" select="activityConfig/properties/value/@flushResponse"/>
                    </xsl:call-template>
                </li>
                <li>Close connection:
                    <xsl:call-template name="getItalicValueOfCheckbox">
                        <xsl:with-param name="path" select="activityConfig/properties/value/@closeConnection"/>
                    </xsl:call-template>
                </li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.http.sendHTTPRequest'">
                <li>HTTP Client: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'httpClientResource'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@httpClientResource"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='httpClientResource' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='httpClientResource' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
							</xsl:call-template> -->
                    <!-- <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@httpClientResource"/></xsl:call-template>--></li>
                <li>Parameters:
                    <xsl:choose>
                        <xsl:when test="count(activityConfig/properties/value/httpParameters)!=0">
                            <ul>
                                <xsl:for-each select="activityConfig/properties/value/httpParameters">
                                    <li><xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="@parameterName"/></xsl:call-template></li>
                                </xsl:for-each>
                            </ul>
                        </xsl:when>
                        <xsl:otherwise><p>No Parameters</p></xsl:otherwise>
                    </xsl:choose>
                </li>
                <li>Write To File: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@writeToFile"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
                <li>Directory: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'directory'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@directory"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='directory' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='directory' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
							</xsl:call-template> --></li>
                <li>Create Non-Existing Directories: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/writeToFilePolicy/@createNonExistingDirectories"/></xsl:call-template></li>
                <li>Threshold Data Size(bytes): <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'tresholdDataSize'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/writeToFilePolicy/@thresholdDataSize"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='thresholdDataSize' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='thresholdDataSize' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
							</xsl:call-template> --></li>
            </xsl:when>
            <!-- XML ACTIVITIES -->
            <xsl:when test="@activityTypeID='bw.xml.transformxml'">
                <li>Stylesheet: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'stylesheet'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@stylesheet"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='stylesheet' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='stylesheet' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
							</xsl:call-template> --></li>
                <li>Input and Output Style: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@inputOutputStyle"/></xsl:call-template></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.xml.renderxml'">
                <li>Output style: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@outputStyle"/></xsl:call-template></li>
                <li>Format using default namespace prefix: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@formatUsingDefaultNSPrefix"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
                <li>Validate Input: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@validateInput"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
                <li>Encoding: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'encoding'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>

                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@encoding"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='encoding' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='encoding' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
							</xsl:call-template> --></li>
                <li>CDATA:
                    <xsl:if test="activityConfig/properties/value/cdata">
                        <ul>
                            <xsl:for-each select="activityConfig/properties/value/cdata">
                                <li><xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="."/></xsl:call-template></li>
                            </xsl:for-each>
                        </ul>
                    </xsl:if>
                </li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.xml.parsexml'">
                <li>Input Style: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@inputStyle"/></xsl:call-template></li>
            </xsl:when>
            <!-- TCP ACTIVITIES -->
            <xsl:when test="@activityTypeID='bw.tcp.receive' or @activityTypeID='bw.tcp.waitfortcp'">
                <li>Host: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'HOST'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@host"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='HOST' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='HOST' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
							</xsl:call-template> --></li>

                <li>Port: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'port'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@port"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='port' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='port' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="0"/>
							</xsl:call-template> --></li>
                <li>Enable DNS Lookup: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@enableDNSLookup"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
                <li>Keep Alive: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@keepAlive"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
                <xsl:if test="@activityTypeID='bw.tcp.waitfortcp'">
                    <li>Event Timeout: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@eventTimeout"/></xsl:call-template></li>
                </xsl:if>
                <li>Event Timeout(seconds): <xsl:value-of select="./../../@eventTimeout"/></li>
                <li>Activity Timeout(msec): <xsl:value-of select="./../../activityTimeoutDesign/@expression"/></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.tcp.read' or @activityTypeID='bw.tcp.write'">
                <li>Type: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@type"/></xsl:call-template></li>
                <li>Separator: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'separator'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@separator"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='separator' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='separator' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="'No separator'"/>
				</xsl:call-template> --></li>
                <li>User Defined Separator: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'userDefinedSeparator'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@userDefinedSeparator"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='userDefinedSeparator' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='userDefinedSeparator' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Encoding: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'encoding'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@encoding"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='encoding' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='encoding' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <xsl:if test="@activityTypeID='bw.tcp.read'">
                    <li>Bytes To Read: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'bytesToRead'"/><xsl:with-param name="defaultValue" select="0"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                        <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@bytesToRead"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='bytesToRead' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='bytesToRead' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="0"/>
				</xsl:call-template> --></li>
                    <li>Timeout (msec): <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'timeout'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                        <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@timeout"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='timeout' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='timeout' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                </xsl:if>
            </xsl:when>
            <!-- REST JSON ACTIVITIES -->
            <xsl:when test="@activityTypeID='bw.restjson.Rest'">
                <li>HTTP Client: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'httpClientSR'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@httpClientSR"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='httpClientSR' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='httpClientSR' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Resource Path: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'resourcePath'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@resourcePath"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='resourcePath' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='resourcePath' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>HTTP Method: <xsl:choose><xsl:when test="activityConfig/properties/value/@httpMethod"><i><xsl:value-of select="activityConfig/properties/value/@httpMethod"/></i></xsl:when><xsl:otherwise><i>GET</i></xsl:otherwise></xsl:choose></li>
                <li>Request Type: <i><xsl:value-of select="activityConfig/properties/value/@requestContentType"/></i></li>
                <li>Response Type: <i><xsl:value-of select="activityConfig/properties/value/@responseAcceptType"/></i></li>
                <li>Output HTTP Response Headers: <i><xsl:choose><xsl:when test="activityConfig/properties/value/@enableHTTPResponseHeaders"><xsl:value-of select="activityConfig/properties/value/@enableHTTPResponseHeaders"/></xsl:when> <xsl:otherwise>false</xsl:otherwise></xsl:choose></i></li>
                <li>Request Entity Processing: <i><xsl:choose><xsl:when test="activityConfig/properties/value/@transferEncoding"><xsl:value-of select="activityConfig/properties/value/@transferEncoding"/></xsl:when><xsl:otherwise>Chunked</xsl:otherwise></xsl:choose></i></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.restjson.JsonParser'">
                <li>Schema Type: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'schemaType'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@schemaType"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='schemaType' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='schemaType' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Badgerfish: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'bagerfish'"/><xsl:with-param name="defaultValue" select="'false'"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@bagerfish"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='bagerfish' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='bagerfish' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="'false'"/>
				</xsl:call-template> --></li>
                <li>Input Json Style: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'jsonInputStyle'"/><xsl:with-param name="defaultValue" select="'false'"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates></li>
                <li>Use Null Values For Empty Values: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'nullForEmpty'"/><xsl:with-param name="defaultValue" select="'false'"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.restjson.JsonRender'">
                <li>Schema Type: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'schemaType'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@schemaType"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='schemaType' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='schemaType' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Badgerfish: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'bagerfish'"/><xsl:with-param name="defaultValue" select="'false'"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@bagerfish"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='bagerfish' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='bagerfish' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="'false'"/>
				</xsl:call-template> --></li>
                <li>Output Json Style: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'jsonOutputStyle'"/><xsl:with-param name="defaultValue" select="'false'"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates></li>
                <li>Use Null Values For Empty Values: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'emptyForNull'"/><xsl:with-param name="defaultValue" select="'false'"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates></li>
            </xsl:when>
            <!-- RV ACTIVITIES -->
            <xsl:when test="@activityTypeID='bw.rv.publishRVMessage'">
                <li>Subject: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'subject'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@subject"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='subject' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='subject' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Pre Register Listener: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'preRegisterListener'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@preRegisterListener"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='preRegisterListener' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='preRegisterListener' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Transport: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'transport'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@transport"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='transport' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='transport' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>XML Format:
                    <xsl:call-template name="getItalicValueOfCheckbox">
                        <xsl:with-param name="path" select="activityConfig/properties/value/@xmlFormat"/>
                    </xsl:call-template>
                </li>
                <li>XML Compliant Field Names:
                    <xsl:call-template name="getItalicValueOfCheckbox">
                        <xsl:with-param name="path" select="activityConfig/properties/value/@xmlCompliantFieldNames"/>
                    </xsl:call-template>
                </li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.rv.publishRVMessage' or @activityTypeID='bw.rv.replytoRVRequest'">
                <li>Reply To: <i><xsl:value-of select="activityConfig/properties/value/@replyFor"/></i></li>
                <li>Reply Subject: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'replySubject'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@replySubject"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='replySubject' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='replySubject' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>XML Compliant Field Names:
                    <xsl:call-template name="getItalicValue">
                        <xsl:with-param name="value" select="activityConfig/properties/value/@needXMLCompliantFieldNames"/>
                        <xsl:with-param name="defaultValue" select="'false'"/>
                    </xsl:call-template>
                </li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.rv.sendRVRequest'">
                <li>Subject: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'subject'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@subject"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='subject' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='subject' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Request Timeout (msec): <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'requestTimeout'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@requestTimeout"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='requestTimeout' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='requestTimeout' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="0"/>
				</xsl:call-template> --></li>
                <li>Pre Register Listener: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'preRegisterListener'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@preRegisterListener"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='preRegisterListener' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='preRegisterListener' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Transport: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'transport'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@transport"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='transport' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='transport' and @bindingType='scaProperty']/@processProperty"/>
				</xsl:call-template> --></li>
                <li>XML Format:
                    <xsl:call-template name="getItalicValueOfCheckbox">
                        <xsl:with-param name="path" select="activityConfig/properties/value/@xmlFormat"/>
                    </xsl:call-template>
                </li>
                <li>Need Output Filteration: <xsl:call-template name="getItalicValueOfCheckbox">
                    <xsl:with-param name="path" select="activityConfig/properties/value/@needOutputFilter"/>
                </xsl:call-template>
                </li>
                <li>XML Compliant Field Name for Input: <xsl:call-template name="getItalicValueOfCheckbox">
                    <xsl:with-param name="path" select="activityConfig/properties/value/@needXMLCompliantFieldNameInput"/>
                </xsl:call-template>
                </li>
                <li>XML Compliant Field Name for Output:
                    <xsl:call-template name="getItalicValueOfCheckbox">
                        <xsl:with-param name="path" select="activityConfig/properties/value/@needXMLCompliantFieldNameOutput"/>
                    </xsl:call-template>
                </li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.rv.waitforRVMessage' or @activityTypeID='bw.rv.rvSubscriber'">
                <li>Subject: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'subject'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@subject"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='subject' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='subject' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Transport: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'transport'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@transport"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='transport' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='transport' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>XML Format:
                    <xsl:call-template name="getItalicValue">
                        <xsl:with-param name="value" select="activityConfig/properties/value/@xmlFormat"/>
                        <xsl:with-param name="defaultValue" select="'false'"/>
                    </xsl:call-template>
                </li>
                <li>Need Output Filteration:
                    <xsl:call-template name="getItalicValue">
                        <xsl:with-param name="value" select="activityConfig/properties/value/@needOutputFiltration"/>
                        <xsl:with-param name="defaultValue" select="'false'"/>
                    </xsl:call-template>
                </li>
                <li>XML Compliant Field Names:
                    <xsl:call-template name="getItalicValue">
                        <xsl:with-param name="value" select="activityConfig/properties/value/@xmlCompliantFieldNames"/>
                        <xsl:with-param name="defaultValue" select="'false'"/>
                    </xsl:call-template>
                </li>
                <xsl:if test="@activityTypeID='bw.rv.rvSubscriber'"><li>Raw-RV-Object Mode: <i><xsl:value-of select="activityConfig/properties/value/@rawRVObjectMode"/></i></li></xsl:if>
                <li>Event Timeout(seconds): <xsl:value-of select="./../../@eventTimeout"/></li>
                <li>Activity Timeout(msec): <xsl:value-of select="./../../activityTimeoutDesign/@expression"/></li>
            </xsl:when>
            <!-- PARSE ACTIVITIES -->
            <xsl:when test="@activityTypeID='bw.parse.mimeparser'">
                <li>Input Style: <i><xsl:value-of select="activityConfig/properties/value/@inputStyle"/></i></li>
                <li>Output Style: <i><xsl:value-of select="activityConfig/properties/value/@outputStyle"/></i></li>
                <li>Generate Strict Parsing Errors:
                    <xsl:call-template name="getItalicValueOfCheckbox">
                        <xsl:with-param name="path" select="activityConfig/properties/value/@generateStrictParsingErrors"/>
                    </xsl:call-template>
                </li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.parse.renderdata'">
                <li>Data Format: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'dataFormat'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@dataFormat"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='dataFormat' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='dataFormat' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.parse.parsedata'">
                <li>Data Format: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'dataFormat'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@dataFormat"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='dataFormat' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='dataFormat' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Continue On Error: <xsl:call-template name="getItalicValueOfCheckbox">
                    <xsl:with-param name="path" select="activityConfig/properties/value/@continueOnError"/>
                </xsl:call-template>
                </li>
                <li>Encoding: <i><xsl:value-of select="activityConfig/properties/value/@encoding"/></i></li>
                <li>Input Type: <i><xsl:value-of select="activityConfig/properties/value/@inputType"/></i></li>
                <li>Manually Specified Start Record:
                    <xsl:call-template name="getItalicValueOfCheckbox">
                        <xsl:with-param name="path" select="activityConfig/properties/value/@manuallySpecifiedStartRecord"/>
                    </xsl:call-template>
                </li>
                <li>Skip Blank Spaces:
                    <xsl:call-template name="getItalicValueOfCheckbox">
                        <xsl:with-param name="path" select="activityConfig/properties/value/@skipBlankSpaces"/>
                    </xsl:call-template>
                </li>
                <li>Strict Validation:
                    <xsl:call-template name="getItalicValueOfCheckbox">
                        <xsl:with-param name="path" select="activityConfig/properties/value/@strictValidation"/>
                    </xsl:call-template>
                </li>
            </xsl:when>
            <!-- MAIL ACTIVITIES -->
            <xsl:when test="@activityTypeID='bw.mail.send'">
                <li>SMTP Property: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'smtpProperty'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@smtpProperty"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='smtpProperty' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='smtpProperty' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Allow Non-standard Email IDs:
                    <i>
                        <xsl:choose>
                            <xsl:when test="activityConfig/properties/value/@allowNonRFC822EmailIDs">
                                <xsl:value-of select="activityConfig/properties/value/@allowNonRFC822EmailIDs"/>
                            </xsl:when>
                            <xsl:otherwise>false</xsl:otherwise>
                        </xsl:choose>
                    </i></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.mail.receive'">
                <li>Host: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'HOST'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@host"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='HOST' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='HOST' and @bindingType='scaProperty']/@processProperty"/>
							</xsl:call-template> --></li>
                <li>Port: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'port'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@port"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='port' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='port' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="110"/>
							</xsl:call-template> --></li>
                <li>User Name: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'userName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@port"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='port' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='port' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
							</xsl:call-template> --></li>
                <li>Password: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'password'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@password"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='password' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='password' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
							</xsl:call-template> --></li>
                <li>Polling Interval (sec): <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'pollingInterval'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@pollingInterval"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='pollingInterval' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='pollingInterval' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="5"/>
							</xsl:call-template> --></li>
                <li>Delete Email: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@deleteMail"/></xsl:call-template></li>
                <li>Enable confidentiality: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@requiresConfidentiality"/></xsl:call-template></li>
                <li>SSL Client: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'sslClientProperty'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@sslClientProperty"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='sslClientProperty' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='sslClientProperty' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
							</xsl:call-template> --></li>
                <li>Provide Raw Message: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@provideRawMessage"/></xsl:call-template></li>
                <li>Write To File: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@writeToFile"/></xsl:call-template></li>
                <li>Directory: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'directory'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@directory"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='directory' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='directory' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
							</xsl:call-template> --></li>
                <li>Create Non-Existing Directories: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/writeToFilePolicy/@createNonExistingDirectories"/></xsl:call-template></li>
                <li>Threshold Data Size(bytes): <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'thresholdDataSize'"/><xsl:with-param name="defaultValue" select="0"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/writeToFilePolicy/@thresholdDataSize"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='thresholdDataSize' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='thresholdDataSize' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="0"/>
							</xsl:call-template> --></li>
            </xsl:when>
            <!-- JMS ACTIVITIES -->
            <xsl:when test="@activityTypeID='bw.jms.getmsg'">
                <li>JMS Connection: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'connectionReference'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@connectionReference"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='connectionReference' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='connectionReference' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Destination: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'destinationName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@destinationName"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='destinationName' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='destinationName' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Message Type: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@messageType"/><xsl:with-param name="defaultValue" select="'Text'"/></xsl:call-template></li>
                <li>Acknowledge Mode: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@ackMode"/><xsl:with-param name="defaultValue" select="'Auto'"/></xsl:call-template></li>
                <li>Message Selector: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'messageSelector'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@messageSelector"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='messageSelector' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='messageSelector' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
							</xsl:call-template> --></li>
                <li>Application Properties Type: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@appPropsReference"/><xsl:with-param name="defaultValue" select="''"/></xsl:call-template></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.jms.signalin'">
                <li>JMS Connection: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'connectionReference'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@connectionReference"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='connectionReference' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='connectionReference' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Messaging Style: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@messagingStyle"/><xsl:with-param name="defaultValue" select="'Generic'"/></xsl:call-template></li>
                <li>Destination: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'destinationName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@destinationName"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='destinationName' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='destinationName' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Message Type: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@messageType"/><xsl:with-param name="defaultValue" select="'Text'"/></xsl:call-template></li>
                <li>Durable Subscriber: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'durableSubscriber'"/><xsl:with-param name="defaultValue" select="'false'"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@durableSubscriber"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='durableSubscriber' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='durableSubscriber' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="'false'"/>
				</xsl:call-template> --></li>
                <li>Subscription Name: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'subscriptionName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@subscriptionName"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='subscriptionName' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='subscriptionName' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Suppress Local Messages: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'isNoLocal'"/><xsl:with-param name="defaultValue" select="'false'"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@isNoLocal"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='isNoLocal' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='isNoLocal' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="'false'"/>
							</xsl:call-template> --></li>
                <li>Acknowledge Mode: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@ackMode"/><xsl:with-param name="defaultValue" select="'Auto'"/></xsl:call-template></li>
                <li>Event Timeout(seconds): <xsl:value-of select="./../../@eventTimeout"/></li>
                <li>Activity Timeout(msec): <xsl:value-of select="./../../activityTimeoutDesign/@expression"/></li>
                <li>Message Selector: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'messageSelector'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@messageSelector"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='messageSelector' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='messageSelector' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
							</xsl:call-template> --></li>
                <li>Application Properties Type: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@appPropsReference"/><xsl:with-param name="defaultValue" select="''"/></xsl:call-template></li>
                <li>Polling Interval (sec): <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'receiveTimeout'"/><xsl:with-param name="defaultValue" select="'0'"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@receiveTimeout"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='receiveTimeout' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='receiveTimeout' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="'0'"/>
				</xsl:call-template> --></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.jms.requestreply' or @activityTypeID='bw.jms.send'">
                <li>JMS Connection: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'connectionReference'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@connectionReference"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='connectionReference' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='connectionReference' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Messaging Style: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@messagingStyle"/><xsl:with-param name="defaultValue" select="'Generic'"/></xsl:call-template></li>
                <li>Destination: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'destinationName'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@destinationName"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='destinationName' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='destinationName' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Message Type: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@messageType"/><xsl:with-param name="defaultValue" select="'Text'"/></xsl:call-template></li>
                <li>Reply To Destination: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'replyToDestination'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@replyToDestination"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='replyToDestination' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='replyToDestination' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Deliver Mode: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@deliveryMode"/><xsl:with-param name="defaultValue" select="''"/></xsl:call-template></li>
                <li>JMS Expiration (msec): <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@jmsExpiration"/><xsl:with-param name="defaultValue" select="'0'"/></xsl:call-template></li>
                <li>Priority: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@priority"/><xsl:with-param name="defaultValue" select="'4'"/></xsl:call-template></li>
                <li>Type: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@type"/><xsl:with-param name="defaultValue" select="''"/></xsl:call-template></li>
                <li>Application Properties Type: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@appProps"/><xsl:with-param name="defaultValue" select="''"/></xsl:call-template></li>
                <xsl:if test=" @activityTypeID='bw.jms.send'"><li>Override Transaction Behavior: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@overrideTx"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li></xsl:if>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.jms.reply'">
                <li>Reply For Event: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@replyFor"/><xsl:with-param name="defaultValue" select="''"/></xsl:call-template></li>
                <li>Message Type: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@messageType"/><xsl:with-param name="defaultValue" select="'Text'"/></xsl:call-template></li>
                <li>Deliver Mode: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@deliveryMode"/><xsl:with-param name="defaultValue" select="'Persistent'"/></xsl:call-template></li>
                <li>JMS Expiration (msec): <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@jmsExpiration"/><xsl:with-param name="defaultValue" select="'0'"/></xsl:call-template></li>
                <li>Priority: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@priority"/><xsl:with-param name="defaultValue" select="'4'"/></xsl:call-template></li>
                <li>JMS Type: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@type"/><xsl:with-param name="defaultValue" select="''"/></xsl:call-template></li>
                <li>Application Properties Type: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@appProps"/><xsl:with-param name="defaultValue" select="''"/></xsl:call-template></li>
            </xsl:when>
            <!-- JDBC ACTIVITIES -->
            <xsl:when test="@activityTypeID='bw.jdbc.JDBCCallProcedure'">
                <li>JDBC Shared Resource: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'sharedResourceProperty'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@sharedResourceProperty"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='sharedResourceProperty' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='sharedResourceProperty' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>

                <li>Timeout (sec): <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'timeout'"/><xsl:with-param name="defaultValue" select="'10'"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@timeout"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='timeout' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='timeout' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="'10'"/>
				</xsl:call-template> --></li>

                <li>Maximum rows: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'maxRows'"/><xsl:with-param name="defaultValue" select="'100'"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@maxRows"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='maxRows' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='maxRows' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="'100'"/>
				</xsl:call-template> --></li>
                <li>Schema: <i><xsl:value-of select="activityConfig/properties/value/@schema"/></i></li>
                <li>Catalog or Package: <i><xsl:value-of select="activityConfig/properties/value/@catalogOrPackage"/></i></li>
                <li>Procedure / Function: <i><xsl:value-of select="activityConfig/properties/value/@procedureOrFunctionName"/></i></li>
                <xsl:if test="count(activityConfig/properties/value/preparedParamters)!=0"><li>Parameters:
                    <table>
                        <tgroup cols="3">
                            <colspec colname="name" colwidth="175*"/>
                            <colspec colname="type" colwidth="175*"/>
                            <colspec colname="direction" colwidth="50*"/>
                            <thead>
                                <row>
                                    <entry colname="name" valign="top">Name</entry>
                                    <entry colname="type" valign="top">Type</entry>
                                    <entry colname="direction" valign="top">Direction</entry>
                                </row>
                            </thead>
                            <tbody>
                                <xsl:for-each select="activityConfig/properties/value/preparedParamters">
                                    <row><entry><xsl:value-of select="./@ParameterName"/></entry><entry><xsl:value-of select="./@DataTypeDisplayValue"/></entry><entry><xsl:value-of select="./@ProcedureParamterType"/></entry></row>
                                </xsl:for-each>
                            </tbody>
                        </tgroup>
                    </table>
                </li></xsl:if>
                <li>Thread Pool Shared Resource: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'threadPool'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@threadPool"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='threadPool' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='threadPool' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Override Transaction Behavior: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@overrideTx"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
                <li>Override JDBC Connection: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@overrideSR"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
                <li>Interpret Empty String As Null: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@interpretEmptyStringAsNull"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
                <li>Results Use Schema: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@resultSetuseSchemas"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
                <li>Interpret Invalid XML Chars: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@allowInvalidChars"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.jdbc.update'">
                <li>JDBC Shared Resource: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'sharedResourceProperty'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@sharedResourceProperty"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='sharedResourceProperty' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='sharedResourceProperty' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Timeout (sec): <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'timeout'"/><xsl:with-param name="defaultValue" select="'10'"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@timeout"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='timeout' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='timeout' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="'10'"/>
				</xsl:call-template> --></li>

                <li>Statement: <i><xsl:value-of select="activityConfig/properties/value/@sqlStatement"/></i></li>
                <li>Parameters:
                    <xsl:choose>
                        <xsl:when test="count(activityConfig/properties/value/PreparedParamters)!=0">
                            <table>
                                <tgroup cols="2">
                                    <colspec colname="name" colwidth="175*"/>
                                    <colspec colname="type" colwidth="175*"/>
                                    <thead>
                                        <row>
                                            <entry colname="name" valign="top">Parameter Name</entry>
                                            <entry colname="type" valign="top">Data Type</entry>
                                        </row>
                                    </thead>
                                    <tbody>
                                        <xsl:for-each select="activityConfig/properties/value/PreparedParamters">
                                            <row><entry><xsl:value-of select="./@ParameterName"/></entry><entry><xsl:value-of select="./@DataTypeDisplayValue"/></entry></row>
                                        </xsl:for-each>
                                    </tbody>
                                </tgroup>
                            </table>
                        </xsl:when>
                        <xsl:otherwise><p>No parameters</p></xsl:otherwise>
                    </xsl:choose>
                </li>
                <li>Thread Pool Shared Resource: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'threadPool'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@threadPool"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='threadPool' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='threadPool' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Insert if record doesn't exist: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@upsert"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
                <li>Override Transaction Behavior: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@overrideTx"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
                <li>Interpret Empty String As Null: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@interpretEmptyStringAsNull"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
                <li>Results Use Schema: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@resultSetuseSchemas"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
                <li>Batch Update: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@batchUpdate"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.jdbc.JDBCQuery'">
                <li>JDBC Shared Resource: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'sharedResourceProperty'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@sharedResourceProperty"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='sharedResourceProperty' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='sharedResourceProperty' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Timeout (sec): <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'timeout'"/><xsl:with-param name="defaultValue" select="'10'"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@timeout"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='timeout' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='timeout' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="'10'"/>
				</xsl:call-template> --></li>
                <li>Maximum rows: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'maxRows'"/><xsl:with-param name="defaultValue" select="'100'"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@maxRows"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='maxRows' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='maxRows' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="'100'"/>
				</xsl:call-template> --></li>
                <li>Statement: <i><xsl:value-of select="activityConfig/properties/value/@sqlStatement"/></i></li>
                <li>Parameters:
                    <xsl:choose>
                        <xsl:when test="count(activityConfig/properties/value/PreparedParamters)!=0">
                            <table>
                                <tgroup cols="2">
                                    <colspec colname="name" colwidth="175*"/>
                                    <colspec colname="type" colwidth="175*"/>
                                    <thead>
                                        <row>
                                            <entry colname="name" valign="top">Parameter Name</entry>
                                            <entry colname="type" valign="top">Data Type</entry>
                                        </row>
                                    </thead>
                                    <tbody>
                                        <xsl:for-each select="activityConfig/properties/value/PreparedParamters">
                                            <row><entry><xsl:value-of select="./@ParameterName"/></entry><entry><xsl:value-of select="./@DataTypeDisplayValue"/></entry></row>
                                        </xsl:for-each>
                                    </tbody>
                                </tgroup>
                            </table>
                        </xsl:when>
                        <xsl:otherwise><p>No parameters</p></xsl:otherwise>
                    </xsl:choose>
                </li>
                <li>Thread Pool Shared Resource: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'threadPool'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@threadPool"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='threadPool' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='threadPool' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Override Transaction Behavior: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@overrideTx"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
                <li>Override JDBC Connection: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@overrideSR"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
                <li>Use Nil: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@useNil"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
                <li>Interpret Empty String As Null: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@interpretEmptyStringAsNull"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
                <li>Process In Subsets: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@processInSubsets"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.jdbc.SQLDirect'">
                <li>JDBC Shared Resource: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'sharedResourceProperty'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@sharedResourceProperty"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='sharedResourceProperty' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='sharedResourceProperty' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Timeout (sec): <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'timeout'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@timeout"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='timeout' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='timeout' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="'10'"/>
				</xsl:call-template> --></li>
                <li>Maximum rows: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'maxRows'"/><xsl:with-param name="defaultValue" select="'100'"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
							<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@maxRows"/>
							<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='maxRows' and @bindingType='moduleProperty']/@processProperty"/>
							<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='maxRows' and @bindingType='scaProperty']/@processProperty"/>
							<xsl:with-param name="defaultValue" select="'100'"/>
				</xsl:call-template> --></li>
                <li>Thread Pool Shared Resource: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'threadPool'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
					<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@threadPool"/>
					<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='threadPool' and @bindingType='moduleProperty']/@processProperty"/>
					<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='threadPool' and @bindingType='scaProperty']/@processProperty"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template> --></li>
                <li>Override Transaction Behavior: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@overrideTx"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
                <li>Override JDBC Connection: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@overrideSR"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:call-template></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.java.javamethod'">
                <li>Multiple Output:
                    <xsl:call-template name="getItalicValueOfCheckbox">
                        <xsl:with-param name="path" select="activityConfig/properties/value/@isMultipleOutput"/>
                    </xsl:call-template>
                </li>
                <li>Class Name: <i><xsl:value-of select="activityConfig/properties/value/@className"/></i></li>
                <li>Method: <i><xsl:value-of select="activityConfig/properties/value/@methodName"/></i></li>
                <li>Method Return Type: <i><xsl:value-of select="activityConfig/properties/value/@methodReturn"/></i></li>
                <li>Exception Types: <i><xsl:value-of select="activityConfig/properties/value/exceptionTypes"/></i></li>
                <li>Parameters:
                    <xsl:choose>
                        <xsl:when test="count(activityConfig/properties/value/javaActivityParameter)!=0">
                            <table>
                                <tgroup cols="4">
                                    <colspec colname="fieldType" colwidth="75*"/>
                                    <colspec colname="fieldName" colwidth="175*"/>
                                    <colspec colname="type" colwidth="175*"/>
                                    <colspec colname="occurrence" colwidth="175*"/>
                                    <thead>
                                        <row>
                                            <entry colname="fieldType" valign="top">Field Type</entry>
                                            <entry colname="fieldName" valign="top">Field Name</entry>
                                            <entry colname="type" valign="top">Type</entry>
                                            <entry colname="occurrence" valign="top">Occurrence</entry>
                                        </row>
                                    </thead>
                                    <tbody>
                                        <xsl:for-each select="activityConfig/properties/value/javaActivityParameter">
                                            <row><entry><xsl:value-of select="./@parameterType"/></entry><entry><xsl:value-of select="./@parameterName"/></entry><entry><xsl:value-of select="./@parameterDataType"/></entry><entry><xsl:value-of select="./@parameterCardinality"/></entry></row>
                                        </xsl:for-each>
                                    </tbody>
                                </tgroup>
                            </table>
                        </xsl:when>
                        <xsl:otherwise><p>No Parameters</p></xsl:otherwise>
                    </xsl:choose>
                </li>
                <xsl:if test="not(activityConfig/properties/value/@isMultipleOutput)">
                    <li>Instantiate the referenced class:
                        <xsl:call-template name="getItalicValue">
                            <xsl:with-param name="value" select="activityConfig/properties/value/@constructDeclaredClass"/>
                            <xsl:with-param name="defaultValue" select="'false'"/>
                        </xsl:call-template>
                    </li>
                    <xsl:if test="activityConfig/properties/value/@constructDeclaredClass">
                        <li>Cache the object:
                            <xsl:call-template name="getItalicValue">
                                <xsl:with-param name="value" select="activityConfig/properties/value/@cacheDeclaredClass"/>
                                <xsl:with-param name="defaultValue" select="'false'"/>
                            </xsl:call-template>
                        </li>
                        <xsl:if test="activityConfig/properties/value/@cacheDeclaredClass">
                            <li>Invoke cleanup Method:
                                <xsl:call-template name="getItalicValue">
                                    <xsl:with-param name="value" select="activityConfig/properties/value/@invokeCleanupMethod"/>
                                    <xsl:with-param name="defaultValue" select="'false'"/>
                                </xsl:call-template>
                            </li>
                        </xsl:if>
                    </xsl:if>
                </xsl:if>



            </xsl:when>
            <xsl:when test="@activityTypeID='bw.java.javatoxml'">
                <li>Class Name: <i><xsl:value-of select="activityConfig/properties/value/@className"/></i></li>
                <li>Instantiate the referenced class:
                    <xsl:call-template name="getItalicValueOfCheckbox">
                        <xsl:with-param name="path" select="activityConfig/properties/value/@constructDeclaredClass"/>
                    </xsl:call-template>
                </li>
                <li>Cache the object:
                    <xsl:call-template name="getItalicValueOfCheckbox">
                        <xsl:with-param name="path" select="activityConfig/properties/value/@cacheDeclaredClass"/>
                    </xsl:call-template>
                </li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.java.xmltojava'">
                <li>Class Name: <i><xsl:value-of select="activityConfig/properties/value/@className"/></i></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.java.javaeventsource'">
                <li>Class Name: <i><xsl:value-of select="activityConfig/properties/value/@className"/></i></li>
                <li>Initialize with Parameters:
                    <xsl:call-template name="getItalicValueOfCheckbox">
                        <xsl:with-param name="path" select="activityConfig/properties/value/@enableInitParam"/>
                    </xsl:call-template>
                </li>
                <li>Method: <i><xsl:value-of select="activityConfig/properties/value/@methodName"/></i></li>
                <li>Init Parameters:
                    <xsl:choose>
                        <xsl:when test="count(activityConfig/properties/value/javaActivityParameter)!=0">
                            <table>
                                <tgroup cols="3">
                                    <colspec colname="name" colwidth="175*"/>
                                    <colspec colname="type" colwidth="175*"/>
                                    <colspec colname="value" colwidth="175*"/>
                                    <thead>
                                        <row>
                                            <entry colname="name" valign="top">Parameter</entry>
                                            <entry colname="type" valign="top">Type</entry>
                                            <entry colname="value" valign="top">Value</entry>
                                        </row>
                                    </thead>
                                    <tbody>
                                        <xsl:for-each select="activityConfig/properties/value/javaActivityParameter">
                                            <row><entry><xsl:value-of select="./@parameterName"/></entry><entry><xsl:value-of select="./@parameterType"/></entry><entry><xsl:value-of select="./@parameterValue"/></entry></row>
                                        </xsl:for-each>
                                    </tbody>
                                </tgroup>
                            </table>
                        </xsl:when>
                        <xsl:otherwise><p>No Init Parameters</p></xsl:otherwise>
                    </xsl:choose>
                </li>
                <li>Java Global Instance: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'javaGlobalInstance'"/><xsl:with-param name="defaultValue" select="''"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates>
                    <!-- <xsl:call-template name="getItalicValueFromLiteralModuleProcess">
						<xsl:with-param name="valueLiteral" select="activityConfig/properties/value/@javaGlobalInstance"/>
						<xsl:with-param name="valueModuleProp" select="attributeBindings[@eAttributeName='javaGlobalInstance' and @bindingType='moduleProperty']/@processProperty"/>
						<xsl:with-param name="valueProcessProp" select="attributeBindings[@eAttributeName='javaGlobalInstance' and @bindingType='scaProperty']/@processProperty"/>
						<xsl:with-param name="defaultValue" select="''"/>
			</xsl:call-template> --></li>
            </xsl:when>
            <!-- DataConversion ACTIVITIES-->
            <xsl:when test="@activityTypeID='bw.dataconversion.parse'">
                <li>Copybook Resource: <xsl:value-of select="activityConfig/properties/value/@copybookReference"/></li>
                <li>Big Endian: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'bigEndian'"/><xsl:with-param name="defaultValue" select="'false'"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates></li>
                <!-- xsl:value-of select="if(activityConfig/properties/value/@bigEndian) then activityConfig/properties/value/@bigEndian else 'false'"/-->
                <li>Character Set: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'encoding'"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates></li>
                <li>Character Set for DISPLAY-1 Items: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'encodingDisp1'"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates><xsl:value-of select="activityConfig/properties/value/@cencodingDisp1"/></li>
                <li>Multiple records: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'multipleRecords'"/><xsl:with-param name="defaultValue" select="'false'"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates></li>
                <li>Record delimiter: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'delimiter'"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates></li>
                <li>Trim whitespaces from String Values: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'trimStrings'"/><xsl:with-param name="defaultValue" select="'false'"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates></li>
                <li>Empty Nodes: <xsl:apply-templates select="." mode="property"><xsl:with-param name="propertyName" select="'emptyNodes'"/><xsl:with-param name="defaultValue" select="'false'"/><xsl:with-param name="idFrom" select="$idFrom"/></xsl:apply-templates></li>
                <li>Input type: <xsl:value-of select="activityConfig/properties/value/@inputType"/></li>
                <li>Return Remaining Bytes: <xsl:value-of select="activityConfig/properties/value/@returnRemaniningBytes"/></li>
                <li>Allow Incomplete Records: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'allowIncompleteRead'"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:apply-templates></li>
                <li>Allow Incomplete Text Items: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'allowIncompleteText'"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:apply-templates></li>
                <li>Ignore Invalid Items: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'ignoreInvalid'"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:apply-templates></li>
                <li>Fail on Invalid XML Characters: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'validateXmlChars'"/><xsl:with-param name="defaultValue" select="'true'"/></xsl:apply-templates></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.dataconversion.render'">
                <li>Copybook Resource: <xsl:value-of select="activityConfig/properties/value/@copybookReference"/></li>
                <li>Big Endian: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'bigEndian'"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:apply-templates></li>
                <li>Character Set: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'encoding'"/></xsl:apply-templates></li>
                <li>Multiple records: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'multipleRecords'"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:apply-templates></li>
                <li>Record delimiter: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'delimiter'"/></xsl:apply-templates></li>
                <li>Truncate Multi-Byte Strings: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'truncate'"/><xsl:with-param name="defaultValue" select="'false'"/></xsl:apply-templates></li>
                <li>Filler Character: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'encoding'"/></xsl:apply-templates></li>
                <li>ASCII Zoned Format: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'asciiZoned'"/><xsl:with-param name="defaultValue" select="'Strict'"/></xsl:apply-templates></li>
                <li>Render Data as: <xsl:value-of select="activityConfig/properties/value/@renderAs"/></li>
                <li>Fail on Invalid XML Characters: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'validateXmlChars'"/><xsl:with-param name="defaultValue" select="'true'"/></xsl:apply-templates></li>
            </xsl:when>
            <!-- Dynamic CRM -->
            <xsl:when test="@activityTypeID='bw.dynamicscrm.AssociateEntities'">
                <li>Dynamics CRM Connection: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'dynamicscrmConnection'"/></xsl:apply-templates></li>
                <li>Disassociate Entities:
                    <xsl:choose>
                        <xsl:when test="activityConfig/properties/value/@disassociate">
                            <xsl:value-of select="activityConfig/properties/value/@disassociate"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'false'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.dynamicscrm.ExecuteRequest'">
                <li>Dynamics CRM Connection: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'dynamicscrmConnection'"/></xsl:apply-templates></li>
                <li>Parse Result:
                    <xsl:choose>
                        <xsl:when test="activityConfig/properties/value/@parseResult">
                            <xsl:value-of select="activityConfig/properties/value/@parseResult"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'false'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.dynamicscrm.CreateEntity' or @activityTypeID='bw.dynamicscrm.DeleteEntity' or @activityTypeID='bw.dynamicscrm.RetrieveEntity' or @activityTypeID='bw.dynamicscrm.UpdateEntity' or @activityTypeID='bw.dynamicscrm.RetrieveMultipleEntity'">
                <li>Dynamics CRM Connection: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'dynamicscrmConnection'"/></xsl:apply-templates></li>
                <li>Dynamics CRM Entity: <xsl:value-of select="activityConfig/properties/value/@dynamicscrmEntityOption"/></li>
                <xsl:if test="@activityTypeID='bw.dynamicscrm.RetrieveMultipleEntity'"><li>Retrieve Mode: <xsl:value-of select="activityConfig/properties/value/@retrieveType"/></li></xsl:if>
                <li>Entity Metadata:
                    <xsl:for-each select="activityConfig/properties/value/entitymetadatatamap">
                        <p>Key: <xsl:value-of select="@key"/>
                            <ul>
                                <xsl:for-each select="./value/@*">
                                    <li><xsl:value-of select="name()"/>: <i><xsl:value-of select="."/></i></li>
                                </xsl:for-each>
                            </ul>
                        </p>
                    </xsl:for-each>
                </li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.dynamicscrm.EntityEventSource'">
                <li>Dynamics CRM Connection: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'dynamicscrmConnection'"/></xsl:apply-templates></li>
                <li>Dynamics CRM Entity: <xsl:value-of select="activityConfig/properties/value/@dynamicscrmEntityOption"/></li>
                <li>Event On: Create
                    <xsl:choose>
                        <xsl:when test="activityConfig/properties/value/@creation">
                            <xsl:value-of select="activityConfig/properties/value/@creation"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'false'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    Update
                    <xsl:choose>
                        <xsl:when test="activityConfig/properties/value/@updating">
                            <xsl:value-of select="activityConfig/properties/value/@updating"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'false'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    Delete
                    <xsl:choose>
                        <xsl:when test="activityConfig/properties/value/@deletion">
                            <xsl:value-of select="activityConfig/properties/value/@deletion"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'false'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </li>
                <li>Http Connection: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'HttpSharedResource'"/></xsl:apply-templates></li>
                <li>Relative Path: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'httpRelativePath'"/></xsl:apply-templates></li>
                <li>User: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'httpBasicUserName'"/></xsl:apply-templates></li>
                <li>Password: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'httpBasicPassword'"/></xsl:apply-templates></li>
                <li>Entity Metadata:
                    <xsl:for-each select="activityConfig/properties/value/entitymetadatatamap">
                        <p>Key: <xsl:value-of select="@key"/>
                            <ul>
                                <xsl:for-each select="./value/@*">
                                    <li><xsl:value-of select="name()"/>: <i><xsl:value-of select="."/></i></li>
                                </xsl:for-each>
                            </ul>
                        </p>
                    </xsl:for-each>
                </li>
            </xsl:when>
            <!-- Excel -->
            <xsl:when test="@activityTypeID='bw.excel.ExcelData'">
                <xsl:variable name="action" select="activityConfig/properties/value/@operationType"/>
                <li>Actions: <xsl:value-of select="$action"/></li>
                <xsl:if test="contains($action,'Create_')"><li>Create New File: <xsl:value-of select="activityConfig/properties/value/@isCreateNewFile"/></li></xsl:if>
                <li>Output directory: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'fileDirectory'"/></xsl:apply-templates>
                </li>
                <li>Output File Name: <xsl:apply-templates select="." mode="property">
                    <xsl:with-param name="propertyName" select="'fileName'"/>
                    <xsl:with-param name="idFrom" select="$idFrom"/>
                </xsl:apply-templates>
                </li>
                <xsl:if test="($action='Create_Rows') or ($action='Read_Rows') or ($action='Update_Rows')"><li>Modes:
                    <xsl:choose>
                        <xsl:when test="activityConfig/properties/value/@chooseMode">
                            <xsl:value-of select="activityConfig/properties/value/@chooseMode"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'Basic'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </li></xsl:if>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.excel.ExcelMetaData'">
                <xsl:variable name="action" select="activityConfig/properties/value/@Action"/>
                <li>Actions: <xsl:value-of select="$action"/></li>
            </xsl:when>
            <!-- LargeXML -->
            <xsl:when test="@activityTypeID='bw.bwlx.getfragment'">
                <xsl:variable name="inputXmlSource" select="activityConfig/properties/value/@inputXmlSource"/>
                <li>Input XML Source: <xsl:value-of select="$inputXmlSource"/></li>
                <xsl:choose>
                    <xsl:when test="$inputXmlSource='tcp stream'">
                        <li>Timeout(msec): <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'timeout'"/></xsl:apply-templates></li>
                    </xsl:when>
                    <xsl:when test="$inputXmlSource='file name'">
                        <li>Dynamic Input Source:
                            <xsl:choose>
                                <xsl:when test="activityConfig/properties/value/@dynamicInputSource">
                                    <xsl:value-of select="activityConfig/properties/value/@dynamicInputSource"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="'false'"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </li>
                        <li>Read Timeout fo Dynamic Source(msec): <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'readTimeout'"/></xsl:apply-templates></li>
                        <li>Retry Count: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'retryCount'"/></xsl:apply-templates></li>
                    </xsl:when>
                    <xsl:when test="$inputXmlSource='file name' or $inputXmlSource='input stream'">
                        <li>Dynamic Input Source:
                            <xsl:choose>
                                <xsl:when test="activityConfig/properties/value/@dynamicInputSource">
                                    <xsl:value-of select="activityConfig/properties/value/@dynamicInputSource"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="'false'"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </li>
                        <li>Read Timeout fo Dynamic Source(msec): <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'readTimeout'"/></xsl:apply-templates></li>
                        <li>Retry Count: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'retryCount'"/></xsl:apply-templates></li>
                    </xsl:when>
                </xsl:choose>
                <li>Output Source: <xsl:value-of select="activityConfig/properties/value/@outputSource"/></li>
                <li>Fragment Criteria: <xsl:value-of select="activityConfig/properties/value/@fragmentCriteria"/></li>
                <li>Fragment Criteria Value: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'fragmentCriteriaValue'"/></xsl:apply-templates></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.bwlx.streamtofile'">
                <li>Create Non-Existing Directories:
                    <xsl:choose>
                        <xsl:when test="activityConfig/properties/value/@createNonExistingDirectories">
                            <xsl:value-of select="activityConfig/properties/value/@createNonExistingDirectories"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'false'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.bwlx.xmltransform'">
                <xsl:variable name="inputXmlSource" select="activityConfig/properties/value/@inputXmlSource"/>
                <li>Input XML Source: <xsl:value-of select="$inputXmlSource"/></li>
                <li>Output Source: <xsl:value-of select="activityConfig/properties/value/@outputSource"/></li>
                <li>Stylesheet: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'stylesheet'"/></xsl:apply-templates></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.bwlx.xmlvalidation'">
                <xsl:variable name="inputXmlSource" select="activityConfig/properties/value/@inputXmlSource"/>
                <li>Input XML Source: <xsl:value-of select="$inputXmlSource"/></li>
                <li>Schema: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'schema'"/></xsl:apply-templates></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.bwlx.xmlsplitter'">
                <xsl:variable name="inputXmlSource" select="activityConfig/properties/value/@inputXmlSource"/>
                <li>Input XML Source: <xsl:value-of select="$inputXmlSource"/></li>
                <li>Fragment Criteria: <xsl:value-of select="activityConfig/properties/value/@fragmentCriteria"/></li>
                <li>Fragment Criteria Value: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'fragmentCriteriaValue'"/></xsl:apply-templates></li>
                <li>Create Non-Existing Directories:
                    <xsl:choose>
                        <xsl:when test="activityConfig/properties/value/@createNonExistingDirectories">
                            <xsl:value-of select="activityConfig/properties/value/@createNonExistingDirectories"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'false'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </li>
            </xsl:when>
            <!-- PDF -->
            <xsl:when test="@activityTypeID='bw.pdf.PDFReader'">
                <li>Input File: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'inputPDFFile'"/></xsl:apply-templates></li>
                <li>Input File Password: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'inputPDFPassword'"/></xsl:apply-templates></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.pdf.PDFWriter'">
                <li>Input File: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'inputPDFFile'"/></xsl:apply-templates></li>
                <li>Input File Password: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'inputPDFPassword'"/></xsl:apply-templates></li>
                <li>Output File directory:  <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'outputPDFDir'"/></xsl:apply-templates></li>
                <li>Output File Name Prefix: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'outputPDFNamePrefix'"/></xsl:apply-templates></li>
                <li>Is Output File Encrypted:
                    <xsl:choose>
                        <xsl:when test="activityConfig/properties/value/@outputPDFEncrypted">
                            <xsl:value-of select="activityConfig/properties/value/@outputPDFEncrypted"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'false'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </li>
                <li>Restrict Printing:
                    <xsl:choose>
                        <xsl:when test="activityConfig/properties/value/@restrictPrinting">
                            <xsl:value-of select="activityConfig/properties/value/@restrictPrinting"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'false'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </li>
            </xsl:when>
            <!-- SAP -->
            <xsl:when test="@activityTypeID='bw.sap.IDocReader'">
                <li>SAP Connection: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'sapConnection'"/></xsl:apply-templates></li>
                <li>IDoc Name: <xsl:value-of select="activityConfig/properties/value/@iDocSchemaName"/></li>
                <li>JMS Connection: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'jmsConnection'"/></xsl:apply-templates></li>
                <li>Max Session: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'maxSession'"/></xsl:apply-templates></li>

                <li>Post IDoc Destination: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'postIDocDestination'"/></xsl:apply-templates></li>
                <li>IDoc Error Destination: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'errorDestination'"/></xsl:apply-templates></li>
                <li>IDoc Input Mode:
                    <xsl:choose>
                        <xsl:when test="activityConfig/properties/value/@iDocMode">
                            <xsl:value-of select="activityConfig/properties/value/@iDocMode"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'tRFC'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </li>
                <li>SAP Queue Name: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'sapQueueName'"/></xsl:apply-templates></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.sap.IDocParser'">
                <li>SAP Connection: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'sapConnection'"/></xsl:apply-templates></li>
                <li>IDoc Name: <xsl:value-of select="activityConfig/properties/value/@iDocSchemaName"/></li>
                <li>JMS Connection: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'jmsConnection'"/></xsl:apply-templates></li>
                <li>Max Session: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'maxSession'"/></xsl:apply-templates></li>
                <li>Receive IDoc Destination: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'destination'"/></xsl:apply-templates></li>
                <li>Message Selector: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'messageSelector'"/></xsl:apply-templates></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.sap.IDocListener'">
                <li>SAP Connection: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'sapConnection'"/></xsl:apply-templates></li>
                <li>SAP TIDManager: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'tidManager'"/></xsl:apply-templates></li>
                <li>JMS Connection: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'jmsConnection'"/></xsl:apply-templates></li>
                <li>IDoc Destination: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'destination'"/></xsl:apply-templates></li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.sap.InvokeRequestResponse'">
                <li>SAP Connection: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'sapConnection'"/></xsl:apply-templates></li>
                <li>RFC/BAPI: <xsl:value-of select="activityConfig/properties/value/@operation"/></li>
                <li>Transactional:
                    <xsl:choose>
                        <xsl:when test="activityConfig/properties/value/internalConfig/@bTransactional">
                            <xsl:value-of select="activityConfig/properties/value/internalConfig/@bTransactional"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'false'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </li>
                <li>Context End:
                    <xsl:choose>
                        <xsl:when test="activityConfig/properties/value/internalConfig/@bContextEnd">
                            <xsl:value-of select="activityConfig/properties/value/internalConfig/@bContextEnd"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'false'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </li>
                <li>Auto Commit:
                    <xsl:choose>
                        <xsl:when test="activityConfig/properties/value/internalConfig/@bAutoCommit">
                            <xsl:value-of select="activityConfig/properties/value/internalConfig/@bAutoCommit"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'false'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </li>
                <li>Commit Expiry(ms):
                    <xsl:choose>
                        <xsl:when test="activityConfig/properties/value/internalConfig/@commitExpiry">
                            <xsl:value-of select="activityConfig/properties/value/internalConfig/@commitExpiry"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'30000'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.sap.RequestResponseServer'">
                <li>SAP Connection: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'sapConnection'"/></xsl:apply-templates></li>
                <li>RFC/BAPI: <xsl:value-of select="activityConfig/properties/value/@operation"/></li>
                <li>Response Timeout(ms): <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'responseTimeout'"/></xsl:apply-templates>
                    <xsl:choose>
                        <!-- doubled value??? -->
                        <xsl:when test="activityConfig/properties/value/internalConfig/@commitExpiry">
                            <xsl:value-of select="activityConfig/properties/value/internalConfig/@commitExpiry"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'30000'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </li>
            </xsl:when>
            <xsl:when test="@activityTypeID='bw.sap.Respond2Request'">
                <li>Reply For: <xsl:value-of select="activityConfig/properties/value/@replyFor"/></li>
            </xsl:when>
            <!-- SFTP ACTIVITIES -->
            <xsl:when test="contains(@activityTypeID,'bw.sftp.')">
                <li>SFTP Connection: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'sftpConnection'"/></xsl:apply-templates></li>
                <li>Quit (post-command): <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@quitPostCommand"/></xsl:call-template></li>
                <xsl:if test="@activityTypeID='bw.sftp.removeDir'">
                    <li>Remove recursively:
                        <xsl:choose>
                            <xsl:when test="activityConfig/properties/value/@includesubfolders">
                                <xsl:value-of select="activityConfig/properties/value/@includesubfolders"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="'false'"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </li>
                </xsl:if>
                <xsl:if test="@activityTypeID='bw.sftp.dir'">
                    <li>Show Short File Names:
                        <xsl:choose>
                            <xsl:when test="activityConfig/properties/value/@nlst">
                                <xsl:value-of select="activityConfig/properties/value/@nlst"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="'false'"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </li>
                </xsl:if>
                <xsl:if test="@activityTypeID='bw.sftp.put' or @activityTypeID='bw.sftp.get'">
                    <li>Use Process Data:
                        <xsl:call-template name="getItalicValueOfCheckbox">
                            <xsl:with-param name="path" select="activityConfig/properties/value/@useProcessData"/>
                        </xsl:call-template>
                    </li>
                    <li>Binary:
                        <xsl:call-template name="getItalicValueOfCheckbox">
                            <xsl:with-param name="path" select="activityConfig/properties/value/@binary"/>
                        </xsl:call-template>
                    </li>
                    <li>Overwrite Existing File:
                        <xsl:call-template name="getItalicValueOfCheckbox">
                            <xsl:with-param name="path" select="activityConfig/properties/value/@overwriteExistingFile"/>
                        </xsl:call-template>
                    </li>
                    <li>Persist Timestamp while Copy File:
                        <xsl:choose>
                            <xsl:when test="activityConfig/properties/value/@persistTimestamp">
                                <xsl:value-of select="activityConfig/properties/value/@persistTimestamp"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="'false'"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </li>
                </xsl:if>
                <xsl:if test="@activityTypeID='bw.sftp.put'">
                    <li>Append:
                        <xsl:choose>
                            <xsl:when test="activityConfig/properties/value/@append">
                                <xsl:value-of select="activityConfig/properties/value/@append"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="'false'"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </li>
                    <li>Timeout (msec): <xsl:apply-templates  select="." mode="property">
                        <xsl:with-param name="idFrom" select="$idFrom"/>
                        <xsl:with-param name="propertyName" select="'timeout'"/>
                        <xsl:with-param name="defaultValue" select="120000"/>
                    </xsl:apply-templates></li>
                </xsl:if>
            </xsl:when>
            <!-- SHAREPOINT -->
            <xsl:when test="contains(@activityTypeID,'bw.sharepoint.')">
                <li>Sharepoint Connection: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'sharedConnection'"/></xsl:apply-templates></li>
                <li>Web Name: <xsl:value-of select="activityConfig/properties/value/@webName"/></li>
                <xsl:if test="@activityTypeID!='bw.sharepoint.SharePointQuery'"><li>List Name: <xsl:value-of select="activityConfig/properties/value/@listNames"/></li></xsl:if>
                <xsl:if test="@activityTypeID='bw.sharepoint.AddListItem' or @activityTypeID='bw.sharepoint.UpdateListItem'"><li>Content Type: <xsl:value-of select="activityConfig/properties/value/@contentType"/></li></xsl:if>
                <xsl:if test="@activityTypeID!='bw.sharepoint.NotificationListener'"><li>Timeout(sec): <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'timeout'"/></xsl:apply-templates></li></xsl:if>
                <xsl:if test="@activityTypeID='bw.sharepoint.UpdateListItem'"><li>Upload Document:
                    <xsl:choose>
                        <xsl:when test="activityConfig/properties/value/@uploadDocument">
                            <xsl:value-of select="activityConfig/properties/value/@uploadDocument"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'false'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </li></xsl:if>
                <xsl:if test="@activityTypeID='bw.sharepoint.SharePointQuery'">
                    <li>List Template: <xsl:value-of select="activityConfig/properties/value/@listTemplate"/></li>
                    <li>Query Scope: <xsl:value-of select="activityConfig/properties/value/@listNames"/></li>
                    <li>Max Size: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'maxSize'"/></xsl:apply-templates></li>
                </xsl:if>
                <xsl:if test="@activityTypeID='bw.sharepoint.SelectListItem' or @activityTypeID='bw.sharepoint.SharePointQuery'">
                    <li>CAML Source: <xsl:value-of select="activityConfig/properties/value/@CAMLSource"/></li>
                    <li>Page Size: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'pageSize'"/></xsl:apply-templates></li>
                </xsl:if>
                <xsl:if test="@activityTypeID='bw.sharepoint.NotificationListener'">
                    <li>Notification Type: <xsl:value-of select="activityConfig/properties/value/@notificationType"/></li>
                    <li>Sharepoint Event: <xsl:value-of select="activityConfig/properties/value/@ItemDeleting"/></li>
                    <li>Destination Name: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'destinationName'"/></xsl:apply-templates></li>
                    <li>Connection Factory Type: <xsl:value-of select="activityConfig/properties/value/@connectionFactoryType"/></li>
                    <li>Durable Subscription:
                        <xsl:choose>
                            <xsl:when test="activityConfig/properties/value/@durableSubscription">
                                <xsl:value-of select="activityConfig/properties/value/@durableSubscription"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="'false'"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </li>
                    <xsl:if test="activityConfig/properties/value/@durableSubscription"><li>Durable Name: <xsl:apply-templates select="." mode="property"><xsl:with-param name="idFrom" select="$idFrom"/><xsl:with-param name="propertyName" select="'durableName'"/></xsl:apply-templates></li></xsl:if>
                </xsl:if>
            </xsl:when>
        </xsl:choose>
        <!-- xsl:if test="activityConfig/properties/value/@ftlRealmServerConnection"><li>FTL Realm Server Connection: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@ftlRealmServerConnection"/></xsl:call-template></li></xsl:if>
		<xsl:if test="activityConfig/properties/value/@replyFor"><li>Reply for: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@replyFor"/></xsl:call-template></li></xsl:if>
		<xsl:if test="activityConfig/properties/value/@format"><li>Format: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@format"/></xsl:call-template></li></xsl:if>
		<xsl:if test="activityConfig/properties/value/@acknowledgementMode"><li>Acknowledgement mode: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@acknowledgementMode"/></xsl:call-template></li></xsl:if>
		<xsl:if test="activityConfig/properties/value/@queueDispatcherThreads"><li>FTL Queue Dispatcher Threads: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@queueDispatcherThreads"/></xsl:call-template></li></xsl:if>
		<xsl:if test="activityConfig/properties/value/@queueOverflowDiscardPolicy"><li>Queue Overflow Discard Policy: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@queueOverflowDiscardPolicy"/></xsl:call-template></li></xsl:if>
		<xsl:if test="activityConfig/properties/value/@subscriberName"><li>Subscriber Name: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@subscriberName"/></xsl:call-template></li></xsl:if>
		<xsl:if test="activityConfig/properties/value/@threadPoolMinSize"><li>Activity Worker Threads: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@threadPoolMinSize"/></xsl:call-template></li></xsl:if>
		<xsl:if test="activityConfig/properties/value/@queueSize"><li>FTL Queue Size: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="activityConfig/properties/value/@queueSize"/></xsl:call-template></li></xsl:if>
		<xsl:if test="attributeBindings[@eAttributeName='endpoint']/@processProperty"><li>Endpoint: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="attributeBindings[@eAttributeName='endpoint']/@processProperty"/></xsl:call-template></li></xsl:if>
		<xsl:if test="attributeBindings[@eAttributeName='contentMatcher']/@processProperty"><li>Content Matcher: <xsl:call-template name="getItalicValue"><xsl:with-param name="value" select="attributeBindings[@eAttributeName='contentMatcher']/@processProperty"/></xsl:call-template></li></xsl:if -->
    </xsl:template>
    <!-- ACTIVITY common template-->
    <xsl:template match="tibex:activityExtension | tibex:receiveEvent | tibex:extActivity | bpws:throw | bpws:rethrow">
        <concept>
            <xsl:attribute name="id">
                <xsl:value-of select="ncname:transformToNCName(@name)"/>
            </xsl:attribute>
            <xsl:variable name="NameActivity" select="@name"/>
            <title>Name:
                <xsl:call-template name="getBoldItalicValue">
                    <xsl:with-param name="value" select="@name"/>
                </xsl:call-template>
            </title>
            <conbody>
                <section>
                    <indexterm>
                        <xsl:value-of select="@name"/>
                    </indexterm>
                    <ul>
                        <xsl:variable name="activityDescription">
                            <xsl:choose>
                                <xsl:when test="bpws:documentation"><xsl:value-of select="bpws:documentation"/></xsl:when>
                                <xsl:otherwise>No description</xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:value-of select="CustomFunctions:checkNoDescription(string($inputFileName),string(@name),string($activityDescription),'process/activity')" />
                        <li>Description:
                            <xsl:call-template name="getItalicValue">
                                <xsl:with-param name="value" select="$activityDescription"/>
                            </xsl:call-template>
                        </li>
                        <xsl:apply-templates select="./tibex:config/bwext:BWActivity" mode="main"><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                        <xsl:apply-templates select="./tibex:eventSource/bwext:BWActivity" mode="main"><xsl:with-param name="idFrom" select="@name"/></xsl:apply-templates>
                        <xsl:if test="@inputVariable !='' ">
                            <li>Input Variable:
                                <xsl:call-template name="getItalicValue">
                                    <xsl:with-param name="value" select="@inputVariable"/>
                                </xsl:call-template>
                            </li>
                        </xsl:if>
                        <xsl:if test="@outputVariable !='' ">
                            <li>Output Variable:
                                <xsl:call-template name="getItalicValue">
                                    <xsl:with-param name="value" select="@outputVariable"/>
                                </xsl:call-template>
                            </li>
                        </xsl:if>
                        <!--xsl:if test="tibex:config/bwext:BWActivity/attributeBindings">
										<li>Attribute Bindings:
											<ul>
												<xsl:apply-templates select="tibex:config/bwext:BWActivity/attributeBindings"/>
											</ul>
										</li>
									</xsl:if-->
                        <!-- 									<xsl:if test="*[local-name()='config'] != ''"> -->
                        <!-- 										<li> -->
                        <!-- 											<i>Configuration:</i> -->
                        <!-- 											<xsl:apply-templates select="*[local-name()='config']"> -->
                        <!-- 												<xsl:with-param name="NameAct" select="$NameActivity"/> -->
                        <!-- 											</xsl:apply-templates> -->
                        <!-- 										</li> -->
                        <!-- 									</xsl:if> -->
                        <li><i>Input bindings:</i>
                            <xsl:choose>
                                <xsl:when test="boolean(./tibex:inputBindings/tibex:inputBinding/@expression) and ./tibex:inputBindings/tibex:inputBinding/@expression=''">
                                    Missing or incorrect mapping
                                </xsl:when>
                                <xsl:when test="not(./tibex:inputBindings/tibex:inputBinding)">
                                    No mapping
                                </xsl:when>
                                <xsl:when test="not(contains(./tibex:inputBindings/tibex:inputBinding/@expression, '&lt;xsl:value-of select=&quot;'))">
                                    Incomplete mapping
                                </xsl:when>
                                <xsl:when test="./tibex:inputBindings/tibex:inputBinding">
                                    <xsl:apply-templates select="./tibex:inputBindings/tibex:inputBinding"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    No mapping
                                </xsl:otherwise>
                            </xsl:choose>
                        </li>

                        <!-- 									<xsl:if test="CustomFunctions:shallGeneratePart('process/activity/mapper')"> -->
                        <!-- if mapper activity then document input bindings -->
                        <xsl:variable name="activityType" select="*[local-name()='type']"/>
                        <xsl:if
                                test="$activityType = 'com.tibco.plugin.mapper.MapperActivity' and *[local-name()='inputBindings'] != ''">
                            <xsl:variable name="vIsElementInputBindingEmpty">
                                <xsl:call-template name="isElementInputBindingsEmpty">
                                    <xsl:with-param name="nameActivity" select="$NameActivity"/>
                                </xsl:call-template>
                            </xsl:variable>
                            <xsl:if test="$vIsElementInputBindingEmpty = 'false'">
                                <li><i>Input bindings:</i>
                                    <xsl:apply-templates select="./tibex:inputBindings/tibex:inputBinding"/>
                                </li>
                            </xsl:if>
                        </xsl:if>
                        <!-- mapper activity -->
                        <!-- 									</xsl:if> -->
                        <!-- 									<xsl:if	test="CustomFunctions:shallGeneratePart('process/activity/inputbindings')"> -->
                        <!-- else mapper activity then document input bindings -->
                        <xsl:variable name="activityType" select="*[local-name()='type']"/>
                        <xsl:if test="$activityType != 'com.tibco.plugin.mapper.MapperActivity' and *[local-name()='inputBindings'] != ''">
                            <xsl:variable name="vIsElementInputBindingEmpty">
                                <xsl:call-template name="isElementInputBindingsEmpty">
                                    <xsl:with-param name="nameActivity" select="$NameActivity"/>
                                </xsl:call-template>
                            </xsl:variable>
                            <xsl:if	test="$vIsElementInputBindingEmpty = 'false'">
                                <li><i>Input bindings:</i>
                                    <xsl:apply-templates select="./tibex:inputBindings/tibex:inputBinding"/>
                                </li>
                            </xsl:if>
                        </xsl:if>
                        <!-- mapper activity -->
                        <!-- 									</xsl:if> -->

                        <!-- POLICY tab -->
                        <xsl:if test="@policyRefs">
                            <li>
                                <i>Policy:</i>
                                <ul>
                                    <xsl:for-each select="@policyRefs">
                                        <li>
                                            <xsl:variable name="policy" select="."/>
                                            <xsl:variable name="policyFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $policiesFolder, translate($policy, '.','/'), '.policy.dita')"/>
                                            <xsl:if test="$policyFile != '' ">
                                                <xsl:element name="xref">
                                                    <xsl:attribute name="href"><xsl:value-of select="$policyFile"/></xsl:attribute>
                                                    <xsl:value-of select="."/>
                                                </xsl:element>
                                            </xsl:if>
                                        </li>
                                    </xsl:for-each>
                                </ul>
                            </li>
                        </xsl:if>

                        <xsl:if test="./tibex:CallProcess">
                            <li>Spawn:
                                <xsl:call-template name="getItalicValue">
                                    <xsl:with-param name="value" select="./tibex:CallProcess/@spawn"/>
                                    <xsl:with-param name="defaultValue" select="'false'"/>
                                </xsl:call-template>
                            </li>
                        </xsl:if>
                        <xsl:if test="boolean(./tibex:CallProcess)">
                            <li>Subprocess:
                                <xsl:variable name="refModule">
                                    <xsl:choose>
                                        <xsl:when test="boolean(./tibex:CallProcess/@moduleRef)">
                                            <xsl:value-of select="concat(./tibex:CallProcess/@moduleRef,'/')"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="concat($projectName,'/')"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:variable>
                                <xsl:variable name="relativePathPartCount" select="string-length(/bpws:process/@name) - string-length(translate(/bpws:process/@name,'.',''))+2"/>
                                <xsl:variable name="relativePathFinal">
                                    <xsl:call-template name="duplicate">
                                        <xsl:with-param name="input" select="'../'"/>
                                        <xsl:with-param name="count" select="number($relativePathPartCount)"/>
                                    </xsl:call-template>
                                </xsl:variable>


                                <xsl:element name="xref">
                                    <xsl:variable name="path" select="concat($relativePathFinal,$refModule,'Processes/',translate(./tibex:CallProcess/@subProcessName,'.','/'),'.bwp.dita')"/>
                                    <xsl:if test="$path != ''">
                                        <xsl:attribute name="href"><xsl:value-of select="$path"/></xsl:attribute>
                                    </xsl:if>
                                    <xsl:value-of select="concat($refModule,'Processes/',translate(./tibex:CallProcess/@subProcessName,'.','/'),'.bwp')"/>
                                </xsl:element>



                            </li>
                        </xsl:if>
                    </ul>
                </section>
            </conbody>
        </concept>
    </xsl:template>
    <!-- PROCESS VARIABLES -->
    <xsl:template match="bpws:variables">
        <xsl:if test="count(//bpws:variable[not(@internal)]/@property)>0">
                    <table>
                        <tgroup cols="2">
                            <colspec colname="folder" colwidth="75*"/>
                            <colspec colname="hotUpdate" colwidth="45*"/>
                            <colspec colname="privateProperty" colwidth="45*"/>
                            <colspec colname="sharedResourceType" colwidth="85*"/>
                            <colspec colname="type" colwidth="75*"/>
                            <colspec colname="propertySource" colwidth="165*"/>
                            <!--  colspec colname="defaultValue" colwidth="125*"/-->
                            <thead>
                                <row>
                                    <entry colname="name" valign="top">Name</entry>
                                    <entry colname="hotUpdate" valign="top">Hot Update</entry>
                                    <entry colname="privateProperty" valign="top">Private Property</entry>
                                    <entry colname="sharedResourceType" valign="top">Shared Resource Type</entry>
                                    <entry colname="type" valign="top">Type</entry>
                                    <entry colname="propertySource" valign="top">Property Source</entry>
                                </row>
                            </thead>
                            <tbody>
                                <xsl:for-each select="./bpws:variable[not(@internal)]">
                                    <xsl:if test="@property='yes'">
                                        <row>
                                            <entry><xsl:value-of select="@name"/></entry>
                                            <entry><xsl:value-of select="@hotUpdate"/></entry>
                                            <entry><xsl:value-of select="@privateProperty"/></entry>
                                            <entry><xsl:value-of select="@sharedResourceType"/></entry>
                                            <entry>
                                                <xsl:choose>
                                                    <xsl:when test="@sharedResourceType">
                                                        <!--<xsl:value-of select="substring-after(./@sharedResourceType, '}')"/>-->
                                                        <xsl:value-of select="@sharedResourceType"/>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:value-of select="@type"/>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </entry>
                                            <entry><xsl:choose>
                                                <xsl:when test="string-length(@tibex:propertySource)!=0">
                                                    <xsl:variable name="moduleProp" select="@tibex:propertySource"/>
                                                    <xsl:variable name="profileInfo" select="CustomFunctionsEagle:getModulePropertyProfileInfo($moduleProp,$applicationName)"/>
                                                    <xref outputclass="popup" format="html" href="#{$profileInfo}"><xsl:value-of select="$moduleProp"/></xref>
                                                </xsl:when>
                                                <xsl:otherwise><xsl:value-of select="@tibex:propertySource"/></xsl:otherwise>
                                            </xsl:choose></entry>
                                        </row>
                                    </xsl:if>
                                </xsl:for-each>
                            </tbody>
                        </tgroup>
                    </table>
        </xsl:if>
        <xsl:if test="count(//bpws:variable[not(@internal)]|//bpws:variable[not(@property)])>0">
	        <table>
	            <tgroup cols="2">
	                <colspec colname="folder" colwidth="75*"/>
	                <colspec colname="type" colwidth="75*"/>
	                <colspec colname="propertySource" colwidth="165*"/>
	                <colspec colname="defaultValue" colwidth="125*"/>
	                <thead>
	                    <row>
	                        <entry colname="name" valign="top">Name</entry>
	                        <entry colname="type" valign="top">Type</entry>
	                        <entry colname="propertySource" valign="top">Property Source</entry>
	                        <entry colname="defaultValue" valign="top">Default Value</entry>
	                    </row>
	                </thead>
	
	                <tbody>
	                    <xsl:if test="count(not(./bpws:variable[not(@internal)]/@property='yes')) = 0">
	                        <row><entry/><entry/><entry/><entry/></row>
	                    </xsl:if>
	                    <xsl:for-each select="./bpws:variable[not(@internal)]">
	                        <xsl:if test="not(@property='yes')">
	                            <row>
	                                <entry><xsl:value-of select="@name"/></entry>
	                                <entry>
	                                    <xsl:choose>
	                                        <xsl:when test="@sharedResourceType">
	                                            <!--<xsl:value-of select="substring-after(./@sca-bpel:sharedResourceType, '}')"/>-->
	                                            <xsl:value-of select="./@sharedResourceType"/>
	                                        </xsl:when>
	                                        <xsl:otherwise>
	                                            <xsl:value-of select="@type"/>
	                                        </xsl:otherwise>
	                                    </xsl:choose>
	                                </entry>
	                                <entry><xsl:value-of select="@tibex:propertySource"/></entry>
	                                <entry>
	                                    <xsl:if test="./bpws:from/bpws:literal">
	                                        <xsl:value-of select="./bpws:from/bpws:literal"/>
	                                    </xsl:if>
	                                </entry>
	                            </row>
	                        </xsl:if>
	                    </xsl:for-each>
	                </tbody>
	            </tgroup>
	        </table>
        </xsl:if>
    </xsl:template>
    <!-- INPUT Bindings -->
    <xsl:template match="tibex:inputBindings">
        <codeblock><xsl:value-of select="tibex:inputBinding/@expression"/></codeblock>
    </xsl:template>
    <!-- 	Attribute Bindings -->
    <!-- TODO add variable references -->
    <xsl:template match="attributeBindings">
        <li><xsl:value-of select="@eAttributeName"/>: <xsl:value-of select="@processProperty"/></li>
    </xsl:template>

    <!-- References -->
    <xsl:template match="bpws:partnerLink">
        <concept>
            <xsl:attribute name="id">
                <xsl:value-of select="ncname:transformToNCName(@name)"/>
            </xsl:attribute>
            <title>Name:
                <xsl:call-template name="getBoldItalicValue">
                    <xsl:with-param name="value" select="@name"/>
                </xsl:call-template>
            </title>
            <conbody>
                <p>
                    <ul>
                        <li>partnerLinkType: <xsl:value-of select="@partnerLinkType"/></li>
                        <li>partnerRole: <xsl:value-of select="@partnerRole"/></li>
                        <li>sca-bpel:ignore: <xsl:value-of select="@sca-bpel:ignore"/></li>
                        <li>sca-bpel:reference: <xsl:value-of select="@sca-bpel:reference"/></li>
                        <li>sca-bpel:wiredByImpl: <xsl:value-of select="@sca-bpel:wiredByImpl"/></li>
                        <li>dynamic: <xsl:value-of select="./tibex:ReferenceWire/@dynamic"/></li>
                        <li>inline: <xsl:value-of select="./tibex:ReferenceWire/@inline"/></li>
                        <li>processName: <xsl:value-of select="./tibex:ReferenceWire/@processName"/></li>
                        <li>serviceName: <xsl:value-of select="./tibex:ReferenceWire/@serviceName"/></li>
                    </ul>
                </p>
            </conbody>
        </concept>
    </xsl:template>


    <!-- Correlations -->
    <xsl:template match="bpws:correlations">
        <li>Conversations:
            <xsl:for-each select="./bpws:correlation">
                <ul>
                    <li>Conversation: <xsl:call-template name="getItalicValue">
                        <xsl:with-param name="value" select="@set"/>
                    </xsl:call-template>
                    </li>
                    <li>Action: <xsl:call-template name="getItalicValue">
                        <xsl:with-param name="value" select="local-name(./tibex:*)"/></xsl:call-template></li>
                    <!--li>Mapping: <xsl:choose><xsl:when test="./tibex:*/tibex:query/@expression"><codeblock><xsl:value-of select="./tibex:*/tibex:query/@expression"/></codeblock></xsl:when><xsl:otherwise>No Mapping</xsl:otherwise></xsl:choose></li-->

                    <li outputclass="raw">
                        <lines outputclass="caption">Mapping</lines>
                        <table outputclass="data">
                            <tgroup cols="1">
                                <thead>
                                    <row>
                                        <entry>Expression</entry>
                                    </row>
                                </thead>
                                <tbody>
                                    <row>
                                        <entry>
                                            <codeblock><xsl:choose><xsl:when test="./tibex:*/tibex:query/@expression"><codeblock><xsl:value-of select="./tibex:*/tibex:query/@expression"/></codeblock></xsl:when><xsl:otherwise>No Mapping</xsl:otherwise></xsl:choose></codeblock>
                                        </entry>
                                    </row>
                                </tbody>
                            </tgroup>
                        </table>
                    </li>

                </ul>
            </xsl:for-each>
        </li>
    </xsl:template>
    <xsl:template name="substring-before-last">
        <xsl:param name="string1" select="''"/>
        <xsl:param name="string2" select="''"/>

        <xsl:if test="$string1 != '' and $string2 != ''">
            <xsl:variable name="head" select="substring-before($string1, $string2)"/>
            <xsl:variable name="tail" select="substring-after($string1, $string2)"/>
            <xsl:value-of select="$head"/>
            <xsl:if test="contains($tail, $string2)">
                <xsl:value-of select="$string2"/>
                <xsl:call-template name="substring-before-last">
                    <xsl:with-param name="string1" select="$tail"/>
                    <xsl:with-param name="string2" select="$string2"/>
                </xsl:call-template>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    <xsl:template name="getBoldItalicValue">
        <xsl:param name="value"/>
        <xsl:if test="$value">
            <b>
                <i>
                    <xsl:value-of select="$value"/>
                </i>
            </b>
        </xsl:if>
    </xsl:template>
    <xsl:template name="getItalicValue">
        <xsl:param name="value"/>
        <xsl:param name="defaultValue"/>
        <xsl:choose>
            <xsl:when test="$value">
                <i>
                    <xsl:value-of select="$value"/>
                </i>
            </xsl:when>
            <xsl:otherwise>
                <i>
                    <xsl:value-of select="$defaultValue"/>
                </i>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="getValueFromLiteralModuleProcess" match="bwext:BWActivity" mode="property">
        <xsl:param name="propertyName"/>
        <xsl:param name="defaultValue"/>
        <xsl:param name="idFrom"/>
        <xsl:variable name="propertyValue"><xsl:choose>
            <xsl:when test="./attributeBindings[@eAttributeName=$propertyName and @bindingType='moduleProperty']/@processProperty"><xsl:value-of select="attributeBindings[@eAttributeName=$propertyName and @bindingType='moduleProperty']/@processProperty"/></xsl:when>
            <xsl:when test="./attributeBindings[@eAttributeName=$propertyName and @bindingType='scaProperty']/@processProperty"><xsl:value-of select="attributeBindings[@eAttributeName=$propertyName and @bindingType='scaProperty']/@processProperty"/></xsl:when>
            <xsl:when test="activityConfig/properties/value/@*[local-name()=$propertyName]"><xsl:value-of select="activityConfig/properties/value/@*[local-name()=$propertyName]"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="$defaultValue"/></xsl:otherwise>
        </xsl:choose></xsl:variable>
        <xsl:choose>
            <xsl:when test="/bpws:process/bpws:variables/bpws:variable[@name=$propertyValue]/bpws:from/bpws:literal"><xsl:variable name="idTo" select="/bpws:process/bpws:variables/bpws:variable[@name=$propertyValue]/bpws:from/bpws:literal"/>
                <xsl:element name="xref">
                    <xsl:if test="CustomFunctionsEagle:getRelativePathToObject($level, $projectRoot, $idTo, $idFrom, $inputFileName, $outputFileName) != ''">
                        <xsl:attribute name="href">
                            <xsl:value-of select="CustomFunctionsEagle:getRelativePathToObject($level, $projectRoot, $idTo, $idFrom, $inputFileName, $outputFileName)"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:value-of select="$propertyValue"/>
                </xsl:element></xsl:when>

            <xsl:when test="./attributeBindings[@eAttributeName=$propertyName and @bindingType='moduleProperty']/@processProperty">
                <!-- TODO: vytvoreni elementu s volanim JS v soucasne chvili se vola metoda custom fci pro ziskani lokace pro dane ID -->
                <xsl:variable name="moduleProp" select="/bpws:process/bpws:variables/bpws:variable[@name=$propertyValue]/@tibex:propertySource"/>
                <xsl:variable name="profileInfo" select="CustomFunctionsEagle:getModulePropertyProfileInfo($moduleProp,$applicationName)"/>
                <xref outputclass="popup" format="html" href="#{$profileInfo}"><xsl:value-of select="$moduleProp"/></xref>

                <!--<xsl:value-of select="concat($projectName,'.',$moduleProp)"/>-->

            </xsl:when>
            <!--
				<xsl:when test="/bpws:process/bpws:variables/bpws:variable[@name=$propertyValue]/@tibex:propertySource"><xsl:value-of select="/bpws:process/bpws:variables/bpws:variable[@name=$propertyValue]/@tibex:propertySource"/></xsl:when>
				-->
            <xsl:when test="/bpws:process/bpws:variables/bpws:variable[@name=$propertyValue]/@tibex:propertySource">
                <xsl:variable name="moduleProp" select="/bpws:process/bpws:variables/bpws:variable[@name=$propertyValue]/@tibex:propertySource"/>
                <xsl:variable name="profileInfo" select="CustomFunctionsEagle:getModulePropertyProfileInfo($moduleProp,$applicationName)"/>
                <xref outputclass="popup" format="html" href="#{$profileInfo}"><xsl:value-of select="$moduleProp"/></xref></xsl:when>
            <xsl:otherwise><xsl:value-of select="$propertyValue"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="getItalicValueFromLiteralModuleProcess">
        <xsl:param name="valueLiteral"/>
        <xsl:param name="valueProcessProp"/>
        <xsl:param name="valueModuleProp"/>
        <xsl:param name="defaultValue"/>
        <xsl:choose>
            <xsl:when test="$valueLiteral!=''">
                <i>
                    <xsl:value-of select="$valueLiteral"/>
                </i>
            </xsl:when>
            <xsl:when test="$valueModuleProp!=''">
                <xsl:variable name="moduleProp" select="/bpws:process/bpws:variables/bpws:variable[@name=$valueModuleProp]/@tibex:propertySource"/>
                <xsl:variable name="profileInfo" select="CustomFunctionsEagle:getModulePropertyProfileInfo($moduleProp,$applicationName)"/>
                <xref outputclass="popup" format="html" href="#{$profileInfo}"><xsl:value-of select="$moduleProp"/></xref>
                <!-- <i>
				<xref>
				<xsl:if test="CustomFunctions:getRelativeLinkToModuleProperties($projectRoot,$inputFileName,$level,$valueModuleProp) != '' ">
					<xsl:attribute name="href"><xsl:value-of select="CustomFunctions:getRelativeLinkToModuleProperties($projectRoot,$inputFileName,$level,$valueModuleProp)"/></xsl:attribute>
				</xsl:if>
				<xsl:value-of select="$valueModuleProp"/>
				</xref>
			</i> -->
            </xsl:when>
            <xsl:when test="$valueProcessProp!=''">
                <i>
                    <xref>
                        <xsl:attribute name="href">#ProcessVariables__<xsl:value-of select="$valueProcessProp"/></xsl:attribute>
                        <xsl:value-of select="$valueProcessProp"/>
                    </xref>
                </i>
            </xsl:when>
            <xsl:otherwise><i><xsl:value-of select="$defaultValue"/></i></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="isValueInInputBindings">
        <xsl:param name="nameElement"/>
        <xsl:param name="nameActivity"/>
        <xsl:variable name="value" select="(//tibex:activityExtension[@name=$nameActivity]/*[translate(name(.),$smallcase,$uppercase)='tibex:inputbindings']//*[contains(translate(name(.),$smallcase,$uppercase),translate($nameElement,$smallcase,$uppercase)) or contains(translate($nameElement,$smallcase,$uppercase),translate(name(.),$smallcase,$uppercase))]/xsl:value-of)[1]/@select"/>
        <xsl:if test="string-length($value)&gt;0">
            <xsl:value-of select="$value"/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="isElementInputBindingsEmpty">
        <xsl:param name="nameActivity"/>
        <xsl:variable name="values" select="//tibex:activityExtension[@name=$nameActivity]/*[translate(name(.),$smallcase,$uppercase)='tibex:inputbindings']//*/@select"/>
        <xsl:variable name="joinValues" select="str:concat($values)"/>
        <xsl:choose>
            <xsl:when test="string-length($values)=0">
                <xsl:value-of select="'true'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="'false'"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tibex:inputBindings/tibex:inputBinding|tibex:inputBindings/tibex:partBinding">
        <xsl:choose>
            <xsl:when test="$mappingType='raw'">
                <xsl:variable name="ibTableBody">
                    <xsl:apply-templates select="node()" mode="MT3_AsIs">
                        <xsl:with-param name="sep" select="''"/>
                    </xsl:apply-templates>
                </xsl:variable>
                <xsl:if test="$ibTableBody != ''">
                    <table>
                        <tgroup cols="1">
                            <thead>
                                <row>
                                    <entry>Mapping</entry>
                                </row>
                            </thead>
                            <tbody>
                                <row>
                                    <entry>
                                        <codeblock><xsl:value-of select="./@expression"/></codeblock>
                                    </entry>
                                </row>
                            </tbody>
                        </tgroup>
                    </table>
                </xsl:if>
            </xsl:when>
            <xsl:when test="$mappingType='tree'">
                <table>
                    <tgroup cols="1">
                        <thead>
                            <row>
                                <entry>Mapping</entry>
                            </row>
                        </thead>
                        <tbody>
                            <row>
                                <entry>
                                    <codeblock>
                                        <xsl:choose>
                                            <xsl:when test="./../../@expression">
                                                <xsl:variable name="replacedChars">
                                                    <xsl:call-template name="string-replace">
                                                        <xsl:with-param name="string" select="./../../@expression" />
                                                        <xsl:with-param name="replace" select="'&lt;'" />
                                                        <xsl:with-param name="with" select="'&#xa;&lt;'" />
                                                    </xsl:call-template>
                                                </xsl:variable>
                                                <xsl:call-template name="MT-MappingTree">
                                                    <xsl:with-param name="string" select="substring-after(substring-after($replacedChars,'&lt;xsl:template'),'>')"/>
                                                    <!--<xsl:with-param name="string" select="substring-after(substring-after(replace(./../../@expression,'&lt;','&#xa;&lt;'),'&lt;xsl:template'),'>')"/>-->
                                                </xsl:call-template>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:call-template name="MT-MappingTree">
                                                    <xsl:with-param name="string" select="substring-after(substring-after(./@expression,'&lt;xsl:template'),'>')"/>
                                                </xsl:call-template>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </codeblock>
                                </entry>
                            </row>
                        </tbody>
                    </tgroup>
                </table>
            </xsl:when>
            <xsl:when test="$mappingType='all'">
                <ul outputclass="mappings">
                    <li outputclass="table">
                        <lines outputclass="caption">Mapping table</lines>
                        <table outputclass="data">
                            <tgroup cols="2">
                                <thead>
                                    <row>
                                        <entry>Target</entry>
                                        <entry>Source</entry>
                                    </row>
                                </thead>
                                <tbody>
                                    <xsl:choose>
                                        <xsl:when test="./../../@expression">
                                            <xsl:variable name="path"><node><xslValue-of select="concat('/',substring-before(substring-after(substring-after(./../../@expression,'&lt;xsl:template'),'name=&quot;'),'&quot;'))"/></node></xsl:variable>
                                            <xsl:variable name="replacedChars">
                                                <xsl:call-template name="string-replace">
                                                    <xsl:with-param name="string" select="./../../@expression" />
                                                    <xsl:with-param name="replace" select="'&lt;'" />
                                                    <xsl:with-param name="with" select="'&#xa;&lt;'" />
                                                </xsl:call-template>
                                            </xsl:variable>
                                            <xsl:call-template name="MT-MappingTable">
                                                <xsl:with-param name="string" select="substring-after(substring-after($replacedChars,'&lt;xsl:template'),'>')"/>
                                                <xsl:with-param name="path" select="$path"/>
                                            </xsl:call-template>
                                        </xsl:when>
                                        <xsl:when test="./../../tibex:inputBinding">
                                            <xsl:variable name="path"><node><xslValue-of select="concat('/',substring-before(substring-after(substring-after(./../../tibex:inputBinding,'&lt;xsl:template'),'name=&quot;'),'&quot;'))"/></node></xsl:variable>
                                            <xsl:call-template name="MT-MappingTable">
                                                <xsl:with-param name="string" select="substring-after(substring-after(./../../tibex:inputBinding,'&lt;xsl:template'),'>')"/>
                                                <xsl:with-param name="path" select="$path"/>
                                            </xsl:call-template>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:variable name="path"><node><xslValue-of select="concat('/',substring-before(substring-after(substring-after(./@expression,'&lt;xsl:template'),'name=&quot;'),'&quot;'))"/></node></xsl:variable>
                                            <xsl:call-template name="MT-MappingTable">
                                                <xsl:with-param name="string" select="substring-after(substring-after(./@expression,'&lt;xsl:template'),'>')"/>
                                                <xsl:with-param name="path" select="$path"/>
                                            </xsl:call-template>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </tbody>
                            </tgroup>
                        </table>
                        <!--/xsl:if-->
                    </li>
                    <li outputclass="tree">
                        <lines outputclass="caption">Mapping tree</lines>
                        <table outputclass="data">
                            <tgroup cols="1">
                                <thead>
                                    <row>
                                        <entry>Mapping</entry>
                                    </row>
                                </thead>
                                <tbody>
                                    <row>
                                        <entry>
                                            <codeblock>
                                                <xsl:choose>
                                                    <xsl:when test="./../../@expression">
                                                        <xsl:variable name="replacedChars">
                                                            <xsl:call-template name="string-replace">
                                                                <xsl:with-param name="string" select="CustomFunctions:prettyFormat(./../../@expression)" />
                                                                <xsl:with-param name="replace" select="'    '" />
                                                                <xsl:with-param name="with" select="'&#x9;'" />
                                                            </xsl:call-template>
                                                        </xsl:variable>
                                                        <xsl:call-template name="MT-MappingTree">
                                                            <xsl:with-param name="string" select="substring-after(substring-after($replacedChars,'&lt;xsl:template'),'>')"/>
                                                        </xsl:call-template>
                                                    </xsl:when>
                                                    <xsl:when test="./../../tibex:inputBinding">
                                                        <xsl:variable name="replacedChars">
                                                            <xsl:call-template name="string-replace">
                                                                <xsl:with-param name="string" select="CustomFunctions:prettyFormat(./../../tibex:inputBinding/text())" />
                                                                <xsl:with-param name="replace" select="'    '" />
                                                                <xsl:with-param name="with" select="'&#x9;'" />
                                                            </xsl:call-template>
                                                        </xsl:variable>
                                                        <xsl:call-template name="MT-MappingTree">
                                                            <xsl:with-param name="string" select="substring-after(substring-after($replacedChars,'&lt;xsl:template'),'>')"/>
                                                        </xsl:call-template>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:call-template name="MT-MappingTree">
                                                            <xsl:with-param name="string" select="substring-after(substring-after(./@expression,'&lt;xsl:template'),'>')"/>
                                                        </xsl:call-template>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </codeblock>
                                        </entry>
                                    </row>
                                </tbody>
                            </tgroup>
                        </table>
                        <!-- /xsl:if-->
                    </li>
                    <li outputclass="raw">
                        <lines outputclass="caption">Source code</lines>
                        <!-- xsl:variable name="ibTableBody_raw">
              <xsl:apply-templates select="node()" mode="MT3_AsIs">
                <xsl:with-param name="sep" select="''"/>
              </xsl:apply-templates>
            </xsl:variable>
            <xsl:if test="$ibTableBody_raw != ''"-->
                        <table outputclass="data">
                            <tgroup cols="1">
                                <thead>
                                    <row>
                                        <entry>Mapping</entry>
                                    </row>
                                </thead>
                                <tbody>
                                    <row>
                                        <entry>
                                            <codeblock>
                                                <xsl:choose>
                                                    <xsl:when test="./../../@expression">
                                                        <xsl:value-of select="CustomFunctions:prettyFormat(./../../@expression)"/>
                                                    </xsl:when>
                                                    <xsl:when test="./../../tibex:inputBinding">
                                                        <xsl:value-of select="CustomFunctions:prettyFormat(./../../tibex:inputBinding/text())"/>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:value-of select="./@expression"/>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </codeblock>
                                        </entry>
                                    </row>
                                </tbody>
                            </tgroup>
                        </table>
                        <!-- /xsl:if-->
                    </li>
                </ul>
            </xsl:when>
            <xsl:otherwise> <!-- Default is mapping table ~ mapping type 1 ~ MT1 -->
                <table>
                    <tgroup cols="2">
                        <thead>
                            <row>
                                <entry>Target</entry>
                                <entry>Source</entry>
                            </row>
                        </thead>
                        <tbody>
                            <xsl:call-template name="MT-MappingTable">
                                <xsl:with-param name="string" select="substring-after(substring-after(./@expression,'&lt;xsl:template'),'>')"/>
                            </xsl:call-template>
                        </tbody>
                    </tgroup>
                </table>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="MT-MappingTable">
        <xsl:param name="string"/>
        <xsl:param name="path"/>
        <xsl:variable name="restOfString" select="substring-after($string,'/>')"/>
        <xsl:variable name="prefix" select="substring-before($string,'/>')"/>
        <xsl:variable name="currentNodeWithPath">
            <xsl:call-template name="getPath">
                <xsl:with-param name="nodes" select="$prefix"/>
                <xsl:with-param name="path" select="$path"/>
                <xsl:with-param name="source" select="substring-after($prefix,'xsl:value-of select=&quot;')"/>
            </xsl:call-template></xsl:variable>

        <row><entry>
            <xsl:value-of select="common:node-set($currentNodeWithPath)/row/entry[1]" disable-output-escaping="yes"/>
        </entry><entry><xsl:value-of select="common:node-set($currentNodeWithPath)/row/entry[2]" disable-output-escaping="yes"/></entry></row>
        <!--xsl:value-of select="dyn:evaluate($currentNodeWithPath)/row/entry[1]" disable-output-escaping="yes"/>
  	</entry><entry><xsl:value-of select="dyn:evaluate($currentNodeWithPath)/row/entry[2]" disable-output-escaping="yes"/></entry></row-->

        <xsl:choose>
            <xsl:when test="contains($restOfString,'/>')"><xsl:call-template name="MT-MappingTable">
                <xsl:with-param name="string" select="$restOfString"/>
                <xsl:with-param name="path" select="common:node-set($currentNodeWithPath)/row/entry[1]"/>
                <!--xsl:with-param name="path" select="dyn:evaluate($currentNodeWithPath)/row/entry[1]"/-->
            </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="getPath">
        <xsl:param name="nodes"/>
        <xsl:param name="path"/>
        <xsl:param name="source"/>
        <xsl:variable name="node" select="substring-before(substring-after($nodes,'&lt;'),'>')"/>
        <xsl:variable name="nodePath">
            <xsl:choose>
                <xsl:when test="substring($node,1,1)!='/' and string-length($node)!=0"><xsl:variable name="nodeName">
                    <xsl:call-template name="getNodeName">
                        <xsl:with-param name="node" select="$node"/>
                    </xsl:call-template>
                </xsl:variable>
                    <xsl:value-of select="concat($path,$nodeName)" disable-output-escaping="yes"/></xsl:when>
                <xsl:when test="substring($node,1,5)='/xsl:'"><xsl:call-template name="substring-before-last">
                    <xsl:with-param name="string1" select="$path"/>
                    <xsl:with-param name="string2" select="'&lt;i&gt;/['"/>
                </xsl:call-template></xsl:when>
                <xsl:when test="substring($node,1,1)='/' and substring($node,1,5)!='/xsl:'"><xsl:call-template name="substring-before-last">
                    <xsl:with-param name="string1" select="$path"/>
                    <xsl:with-param name="string2" select="'&lt;b&gt;/'"/>
                </xsl:call-template></xsl:when>
                <xsl:otherwise><xsl:value-of select="$path" disable-output-escaping="yes"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="string-length($nodes)!=0 and contains($nodes,'>') ">
                <xsl:call-template name="getPath">
                    <xsl:with-param name="nodes" select="substring-after(substring-after($nodes,'&lt;'),'>')"/>
                    <xsl:with-param name="path" select="$nodePath"/>
                    <xsl:with-param name="source" select="$source"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <row><entry><xsl:value-of select="$nodePath" disable-output-escaping="yes"/></entry><entry><xsl:call-template name="getNodeName"><xsl:with-param name="source" select="$source"/><xsl:with-param name="node" select="substring-after($nodes,'&lt;')"/></xsl:call-template></entry></row></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="getNodeName">
        <xsl:param name="node"/>
        <xsl:param name="source"/>
        <xsl:choose>
            <xsl:when test="substring($node,1,12)='xsl:value-of'">
                <xsl:value-of select="substring-before(substring-after($node,'=&quot;'),'&quot;')"/>
            </xsl:when>
            <!-- <xsl:when test="substring($node,1,4)='xsl:' and not(contains(substring-before($node,'&gt;'),'select') or contains(substring-before($node,'&gt;'),'test'))">&lt;i&gt;/[<xsl:value-of select="translate(substring-before(substring-after($node,'xsl:'),'&gt;'), $smallcase, $uppercase)"/>]-&lt;i&gt;</xsl:when> -->
            <xsl:when test="substring($node,1,10)='xsl:choose'">&lt;i&gt;/[CHOOSE]&lt;/i&gt;</xsl:when>
            <xsl:when test="substring($node,1,13)='xsl:otherwise'">&lt;i&gt;/[OTHERWISE]&lt;/i&gt;</xsl:when>
            <xsl:when test="substring($node,1,4)='xsl:'">&lt;i&gt;/[<xsl:value-of select="translate(substring-before(substring-after($node,'xsl:'),' '), $smallcase, $uppercase)"/>] <!-- &lt; --> <xsl:value-of select="substring-before(substring-after($node,'=&quot;'),'&quot;')"/> <!-- &gt; -->&lt;/i&gt;</xsl:when>
            <xsl:when test="string-length($node)=0"><xsl:value-of select="$source"/></xsl:when>
            <xsl:otherwise>&lt;b&gt;/<xsl:value-of select="$node"/>&lt;/b&gt;</xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="MT-MappingTree">
        <xsl:param name="string"/>
        <xsl:variable name="restOfString" select="substring-after($string,'xsl:value-of select=&quot;')"/>
        <xsl:variable name="prefix" select="substring-before($string,'&lt;xsl:value-of select=&quot;')"/>
        <xsl:variable name="currentNodePath">
            <xsl:call-template name="previousNodes">
                <xsl:with-param name="preText" select="$prefix"/>
            </xsl:call-template></xsl:variable>
        <b><xsl:value-of select="$currentNodePath"/></b><xsl:value-of select="substring-before($restOfString,'&quot;')"/>
        <xsl:if test="contains($restOfString,'xsl:value-of select=&quot;')"><xsl:call-template name="MT-MappingTree">
            <xsl:with-param name="string" select="substring-after($restOfString,'/>')"/>
        </xsl:call-template>
        </xsl:if>
    </xsl:template>
    <xsl:template name="previousNodes">
        <xsl:param name="preText"/>
        <xsl:if test="substring(substring-after($preText,'&lt;'),1,1)!='/'">
            <xsl:value-of select="substring-before($preText,'&lt;')"/><xsl:value-of select="substring-before(substring-after($preText,'&lt;'),'>')"/>
        </xsl:if>
        <xsl:choose>
            <xsl:when test="string-length($preText)!=0">
                <xsl:call-template name="previousNodes">
                    <xsl:with-param name="preText" select="substring-after(substring-after($preText,'&lt;'),'>')"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text> = </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Helper templates -->
    <xsl:template name="getValueFromLiteralModule">
        <xsl:param name="valueLiteral"/>
        <xsl:param name="valueModuleProp"/>
        <xsl:param name="defaultValue"/>
        <xsl:choose>
            <!-- <xsl:when test="$defaultValue!=''">
				<xsl:variable name="profileInfo" select="CustomFunctionsEagle:getModulePropertyProfileInfo($defaultValue,$applicationName)"/>
				<xref outputclass="popup" format="html" href="#{$profileInfo}"><xsl:value-of select="$defaultValue"/></xref>
			</xsl:when> -->
            <xsl:when test="$valueLiteral!=''">
                <xsl:value-of select="$valueLiteral"/>
            </xsl:when>
            <xsl:when test="$valueModuleProp!=''">
                <xsl:variable name="profileInfo" select="CustomFunctionsEagle:getModulePropertyProfileInfo($valueModuleProp,$applicationName)"/>
                <xref outputclass="popup" format="html" href="#{$profileInfo}"><xsl:value-of select="$valueModuleProp"/></xref>
            </xsl:when>
            <xsl:otherwise><xsl:value-of select="$defaultValue"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="getValueFromLiteralModuleIfExists">
        <xsl:param name="valueLiteral"/>
        <xsl:param name="valueModuleProp"/>
        <xsl:param name="defaultValue"/>
        <xsl:variable name="isModuleProperty" select="//bpws:variable[not(@sca-bpel:internal)]/@name = $valueModuleProp" />

        <xsl:choose>
            <xsl:when test="$valueLiteral!='' and $isModuleProperty">
                <xsl:variable name="profileInfo" select="CustomFunctionsEagle:getModulePropertyProfileInfo($valueModuleProp,$applicationName)"/>
                <xref outputclass="popup" format="html" href="#{$profileInfo}"><xsl:value-of select="$valueModuleProp"/></xref>
            </xsl:when>
            <xsl:when test="$valueLiteral!=''">
                <xsl:value-of select="$valueLiteral"/>
            </xsl:when>
            <xsl:otherwise><xsl:value-of select="$defaultValue"/></xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template name="getItalicValueOfCheckbox">
        <xsl:param name="path"/>
        <xsl:choose>
            <xsl:when test="$path">
                <xsl:call-template name="getItalicValue">
                    <xsl:with-param name="value" select="$path"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="getItalicValue">
                    <xsl:with-param name="value" select="'false'"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="string-replace">
        <xsl:param name="string" />
        <xsl:param name="replace" />
        <xsl:param name="with" />

        <xsl:choose>
            <xsl:when test="contains($string, $replace)">
                <xsl:value-of select="substring-before($string, $replace)" />
                <xsl:value-of select="$with" />
                <xsl:call-template name="string-replace">
                    <xsl:with-param name="string" select="substring-after($string,$replace)" />
                    <xsl:with-param name="replace" select="$replace" />
                    <xsl:with-param name="with" select="$with" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$string" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="duplicate">
        <xsl:param name="input"/>
        <xsl:param name="count" select="1"/>
        <xsl:choose>
            <xsl:when test="not($count) or not($input)"/>
            <xsl:when test="$count = 1">
                <xsl:value-of select="$input"/>
            </xsl:when>
            <xsl:otherwise>
                <!-- If $count is odd append an extra copy of input -->
                <xsl:if test="$count mod 2">
                    <xsl:value-of select="$input"/>
                </xsl:if>
                <!-- Recursively apply template after doubling input and
               halving count -->
                <xsl:call-template name="duplicate">
                    <xsl:with-param name="input"
                                    select="concat($input,$input)"/>
                    <xsl:with-param name="count"
                                    select="floor($count div 2)"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
        <!-- ============================== END OF FILE ================================= -->
