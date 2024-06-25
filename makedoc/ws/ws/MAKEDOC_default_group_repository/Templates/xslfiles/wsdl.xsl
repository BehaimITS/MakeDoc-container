<?xml version='1.0' encoding='utf-8' ?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                            BEHAIM IT SOLUTIONS                               -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : wsdl.xsl                                                   -->
<!-- originator      : Kaspar, lmajer 								              -->
<!-- creation date   : 2015/03/05                                                 -->
<!-- description     : XSL template transfers BW XML file of type .wsdl into      -->
<!--                   DITA format.                                               -->
<!-- ============================================================================ -->

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ncname="com.pikeelectronic.xsl.NCName"
                xmlns:a="http://schemas.xmlsoap.org/wsdl/" xmlns:b="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="a b soap java ncname"
                xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"
                xmlns:java="com.behaim.commons.xsl.CustomFunctions"
                xmlns:CustomFunctions="com.behaim.commons.xsl.CustomFunctions"
                xmlns:str="http://exslt.org/strings"
                xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/"
                extension-element-prefixes="str">
    <xsl:output encoding="utf-8" method="xml" />
    <xsl:param name="mdcfg"/>
    <xsl:param name="heading" />
    <xsl:param name="level"/>
    <xsl:param name="designLib" />
    <xsl:param name="inputFileName" />
    <xsl:param name="outputFileName" />
    <xsl:param name="relativePath" /><!-- added by jsalomoun - relative
		path of the file in project directory -->
    <xsl:param name="displayPathInTopicName" select="false" /><!--
		added by jsalomoun - for displaying whole relative path - default value:
		'false' -->
    <xsl:param name="imageNotExist" select="false" />

    <!-- added by mrozsypal - for displaying last modification time of object
        (system time) -->
    <xsl:param name="ModificationTime" />
    <xsl:param name="folderDescription"/>
    <!-- =================================== NOTES: =====================================
        STRUCTURE: - main concept Wsdl contains concept Definitions - concept Definitions
        contains concepts Diagram, Namespaces, Types, PortConfig, Operations and
        Messages - concept Types may contain concept with id=<httpNamespaceAddress>
        TODO: - vyresit xmlns:soap v html hlavicce, mode="operationMessage" se nepouziva?,
        concept Types ma obsahovat PortConfig? - v Messages a Types kotvy v bunkach
        nahrazeny kotvami na celou tabulku, asi predelat z tabulky na seznam conceptu
        - do Messages:Part element a mode="schemaTypeDetailTemplate" pridana podminka
        if, aby se negeneroval odkaz, kdyz je prazdny - u mode="schemaTypeDetailTemplate"
        se odkazuje na typ, ktery neni na strance definovany - xs:string atd. - Namespace
        id je napr. id="www.tibco.com_schemas_GrantingCredit_SharedConnections_Schema.xsd"
        ================================================================================ -->

    <!-- Match document root tag -->
    <xsl:template match="/">
        <xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE concept PUBLIC "-//OASIS//DTD DITA Concept//EN" "]]></xsl:text><xsl:value-of select="concat($mdcfg,'/dtd','/concept.dtd')"/><xsl:text disable-output-escaping="yes">"></xsl:text>
        <xsl:variable name="wsdlName" select="substring-before($heading, '.wsdl')" />
        <!--xsl:variable name="imageName" select="concat($wsdlName, '.wsdl.png')"/ -->
        <xsl:variable name="imageName"
                      select="java:getDitaFileName(concat($heading,'.svg'))" />
        <!--html xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" -->

        <concept id="Wsdl" xml:lang="en-us">
            <!--title><xsl:value-of select="$wsdlName"/> - BusinessWorks WSDL</title -->
            <title>
                <xsl:value-of select="$wsdlName" />
            </title>
            <titlealts>
                <navtitle>
                    <xsl:choose>
                        <xsl:when test="$displayPathInTopicName">
                            <xsl:value-of select="substring-before($relativePath, '.wsdl')" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$wsdlName" />
                        </xsl:otherwise>
                    </xsl:choose>
                </navtitle>
            </titlealts>
            <conbody>
                <xsl:choose>
                    <xsl:when test="$designLib != ''">
                        <p>
                            Section contains description of WSDL Schema "
                            <xsl:value-of select="$heading"/> "
                            <q>
                                <xsl:choose>
                                    <xsl:when test="java:shallGeneratePart('wsdl/includeWSDL')">
                                        <xsl:if
                                                test="java:setUsedAEandXSDschemaInDocumentation($inputFileName,$outputFileName )">
                                            <xsl:element name="xref">
                                                <xsl:attribute name="href">
                                                    <xsl:value-of select="ncname:transformPathToNCName($heading)" />
                                                </xsl:attribute>
                                                <xsl:attribute name="type">fig</xsl:attribute>
                                                <xsl:attribute name="format">wsdl</xsl:attribute>
                                                <xsl:attribute name="scope">external</xsl:attribute>
                                                <xsl:value-of select="$heading" />
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="$heading" />
                                    </xsl:otherwise>
                                </xsl:choose>
                            </q>
                        </p>
                        <xsl:if test="java:shallGeneratePart('wsdl/modificationTime')">
                            <p>
                                Modification time:
                                <xsl:value-of select="$ModificationTime" />
                            </p>
                        </xsl:if>
                        <p>
                            Source Library: "
                            <xsl:value-of select="$designLib" />
                            "
                        </p>
                    </xsl:when>
                    <xsl:otherwise>
                        <p>
                            <xsl:value-of select="java:initializeTemplate('wsdl.xsl')"/>
                        </p>
                        <p>
                            Section contains description of WSDL Schema
                            <q>
                                <xsl:choose>
                                    <xsl:when test="java:shallGeneratePart('wsdl/includeWSDL')">
                                        <xsl:if
                                                test="java:setUsedAEandXSDschemaInDocumentation($inputFileName,$outputFileName )">
                                            <xsl:element name="xref">
                                                <xsl:attribute name="href">
                                                    <xsl:value-of select="ncname:transformPathToNCName($heading)" />
                                                </xsl:attribute>
                                                <xsl:attribute name="type">fig</xsl:attribute>
                                                <xsl:attribute name="format">wsdl</xsl:attribute>
                                                <xsl:attribute name="scope">external</xsl:attribute>
                                                <xsl:value-of select="$heading" />
                                            </xsl:element>
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="$heading" />
                                    </xsl:otherwise>
                                </xsl:choose>
                            </q>
                        </p>
                        <xsl:if test="java:shallGeneratePart('wsdl/modificationTime')">
                            <p>
                                Modification time:
                                <xsl:value-of select="$ModificationTime" />
                            </p>
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
                <p>
                    Service:
                    <xsl:value-of select="a:definitions/a:service/@name" />
                </p>
                <p>
                    Documentation:
                    <xsl:value-of select="a:definitions/a:service/a:documentation" />
                </p>
            </conbody>
            <xsl:if test="java:shallGeneratePart('wsdl/folderDescription')">
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
                                            <row><entry/><entry>No description</entry></row>
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
            <!-- if there is <service> i.e. it is CONCRETE WSDL then show its diagram -->




            <xsl:if
                    test="count(a:definitions)>0 and java:shallGeneratePart('wsdl/diagram')">
                <concept id="Diagram" xml:lang="en-us">
                    <title>Diagram:</title>
                    <conbody>
                        <xsl:choose>
                            <xsl:when test="$imageNotExist">
                                <p>
                                    Unable to generate diagram from wsdl.
                                </p>
                            </xsl:when>
                            <xsl:otherwise>
                                <p>Diagram
                                    <xsl:element name="xref">
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="$imageName" />
                                        </xsl:attribute>
                                        <xsl:attribute name="type">fig</xsl:attribute>
                                        <xsl:attribute name="format">svg</xsl:attribute>
                                        <xsl:attribute name="scope">external</xsl:attribute>
                                        <xsl:value-of select="$imageName" />
                                    </xsl:element>
                                </p>
                                <!-- MaxHeight -->
                                <xsl:variable name="IOFElements" select="./a:definitions/a:portType/a:operation/*[self::a:input or self::a:output or self::a:fault]"/>
                                <xsl:variable name="allMessages" select="./a:definitions/a:message"/>
                                <xsl:variable name="countPreviousParts" select="java:getCountOfPreviousParts($IOFElements,$allMessages)"/>
                                <xsl:variable name="maxHeight" select="(count(./wsdl:definitions/wsdl:portType)*40)+(count(./wsdl:definitions/wsdl:portType/wsdl:operation)*20)+($countPreviousParts*20)"/>
                                <!-- MaxWidth -->
                                <xsl:variable name="portNames" select="./a:definitions/a:service/a:port"/>
                                <xsl:variable name="maxPortName"><xsl:choose><xsl:when test="count(./a:definitions/a:service/a:port) &gt; 0">
                                    <xsl:for-each select="$portNames">
                                        <xsl:sort select="string-length(@name)" order="descending" data-type="number"/>
                                        <xsl:if test="position() = 1">
                                            <xsl:value-of select="string-length(@name)"/>
                                        </xsl:if>
                                    </xsl:for-each></xsl:when><xsl:otherwise>0</xsl:otherwise></xsl:choose></xsl:variable>
                                <xsl:variable name="serviceNames" select="./a:definitions/a:service"/>
                                <xsl:variable name="maxServiceName"><xsl:choose><xsl:when test="count(./a:definitions/a:service) &gt; 0">
                                    <xsl:for-each select="$serviceNames">
                                        <xsl:sort select="string-length(@name)" order="descending" data-type="number"/>
                                        <xsl:if test="position() = 1">
                                            <xsl:value-of select="string-length(@name)"/>
                                        </xsl:if>
                                    </xsl:for-each></xsl:when><xsl:otherwise>0</xsl:otherwise></xsl:choose></xsl:variable>
                                <xsl:variable name="addressLocations" select="./a:definitions/a:service/a:port/*[local-name() = 'address']"/>
                                <xsl:variable name="maxAddressLocation"><xsl:choose><xsl:when test="count(./a:definitions/a:service/a:port/*[local-name() = 'address']) &gt; 0">
                                    <xsl:for-each select="$addressLocations">
                                        <xsl:sort select="string-length(@location)" order="descending" data-type="number"/>
                                        <xsl:if test="position() = 1">
                                            <xsl:value-of select="string-length(@location)"/>
                                        </xsl:if>
                                    </xsl:for-each></xsl:when><xsl:otherwise>0</xsl:otherwise></xsl:choose></xsl:variable>
                                <xsl:variable name="maxServiceWidth" select="(160 + (CustomFunctions:max(number($maxServiceName),number($maxAddressLocation),number($maxPortName))*9))"/>
                                <xsl:variable name="portTypeNames" select="./a:definitions/a:portType"/>
                                <xsl:variable name="maxPortTypeName"><xsl:choose><xsl:when test="count(./a:definitions/a:portType) &gt; 0">
                                    <xsl:for-each select="$portTypeNames">
                                        <xsl:sort select="string-length(@name)" order="descending" data-type="number"/>
                                        <xsl:if test="position() = 1">
                                            <xsl:value-of select="string-length(@name)"/>
                                        </xsl:if>
                                    </xsl:for-each></xsl:when><xsl:otherwise>0</xsl:otherwise></xsl:choose></xsl:variable>
                                <xsl:variable name="faultNames" select="./a:definitions/a:portType/a:operation/a:fault"/>
                                <xsl:variable name="maxFaultName"><xsl:choose><xsl:when test="count(./a:definitions/a:portType/a:operation/a:fault) &gt; 0">
                                    <xsl:for-each select="$faultNames">
                                        <xsl:sort select="string-length(@name)" order="descending" data-type="number"/>
                                        <xsl:if test="position() = 1"><xsl:value-of select="string-length(@name)"/></xsl:if>
                                    </xsl:for-each></xsl:when><xsl:otherwise>6</xsl:otherwise></xsl:choose></xsl:variable>
                                <xsl:variable name="allMessageAttributesConcatenated">
                                    <xsl:for-each select="./a:definitions/a:portType/a:operation/a:*/@message">
                                        <xsl:value-of select="concat(.,' ')"/>
                                    </xsl:for-each>
                                </xsl:variable>
                                <xsl:variable name="allParts" select="./a:definitions/a:message[contains(concat($allMessageAttributesConcatenated,' '),concat(':',@name,' '))]/a:part"/>
                                <xsl:variable name="maxWidthsPart" select="java:getMaxLengthOfPart($allParts)"/>
                                <xsl:variable name="maxPartName" select="number(normalize-space(substring-before($maxWidthsPart,':')))"/>
                                <xsl:variable name="maxPartType" select="number(normalize-space(substring-after($maxWidthsPart,':')))"/>
                                <xsl:variable name="maxPartLength" select="$maxFaultName + $maxPartType + $maxPartName"/>
                                <xsl:variable name="maxWidth" select="(CustomFunctions:max(number($maxPartLength), number($maxPortTypeName))*9)"/>
                                <object>
                                    <xsl:attribute name="data"><xsl:value-of select="$imageName" /></xsl:attribute>
                                    <xsl:attribute name="width"><xsl:value-of select="($maxServiceWidth + $maxWidth) + 50"/></xsl:attribute>
                                    <xsl:attribute name="height"><xsl:value-of select="$maxHeight + 50" /></xsl:attribute>
                                    <xsl:attribute name="type">image/svg+xml</xsl:attribute>
                                    <desc>Diagram of <xsl:value-of select="$heading" />.</desc>
                                </object>
                            </xsl:otherwise>
                        </xsl:choose>

                    </conbody>
                </concept>
            </xsl:if>

            <xsl:if test="java:shallGeneratePart('wsdl/namespaces')">
                <concept id="Namespaces" xml:lang="en-us">
                    <title>Namespaces:</title>
                    <conbody>
                        <p>
                            <xsl:choose>
                                <xsl:when
                                        test="count(//*[local-name() = 'definitions']/namespace::*)>0">
                                    <ul>
                                        <xsl:for-each select="//*[local-name() = 'definitions']/namespace::*">
                                            <xsl:sort select="concat(local-name(),.)" />
                                            <li>
                                                xmlns:
                                                <xsl:value-of select="local-name()" />
                                                <xsl:text> - </xsl:text>
                                                <xsl:value-of select="." />
                                            </li>
                                        </xsl:for-each>
                                    </ul>
                                </xsl:when>
                                <xsl:otherwise>
                                    <i>Empty</i>
                                </xsl:otherwise>
                            </xsl:choose>
                        </p>
                    </conbody>
                </concept>
            </xsl:if>

            <xsl:if test="java:shallGeneratePart('wsdl/types')">
                <concept id="Types" xml:lang="en-us">
                    <title>Types:</title>
                    <xsl:choose>
                        <xsl:when
                                test="count(//*[local-name() = 'definitions']/namespace::*)=0">
                            <conbody>
                                <p>
                                    <i>Empty</i>
                                </p>
                            </conbody>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:for-each
                                    select="/*[local-name()='definitions']/*[local-name()='types']/*[local-name()='schema']">
                                <xsl:variable name="count">
                                    <xsl:value-of select="position()"/>
                                </xsl:variable>
                                <xsl:variable name="isLocal">
                                    <xsl:for-each select="./namespace::*">
                                        <xsl:if test="contains(name(.),'xsdLocal')">
                                            <xsl:if test=".=../@targetNamespace">
                                                <xsl:text>true</xsl:text>
                                            </xsl:if>
                                        </xsl:if>
                                    </xsl:for-each>
                                </xsl:variable>
                                <xsl:if test="not(contains($isLocal,'true'))">
                                    <xsl:choose>
                                        <xsl:when test="count(./*[local-name() = 'import']) > 0">
                                            <xsl:for-each select="./*[local-name()='import']">
                                                <xsl:if test="./@schemaLocation">
                                                    <xsl:element name="concept">
                                                        <xsl:attribute name="xml:lang">en-us</xsl:attribute>
                                                        <xsl:variable name="ncId"
                                                                      select="ncname:transformToNCName(translate(./@targetNamespace,'/','_'))" />
                                                        <xsl:variable name="id">
                                                            <xsl:choose>
                                                                <xsl:when test="($ncId != '') and ($count=1)">
                                                                    <xsl:value-of select="$ncId" />
                                                                </xsl:when>
                                                                <xsl:when test="($ncId != '') and ($count!=1)">
                                                                    <xsl:value-of select="concat($ncId,'_',$count)" />
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <xsl:value-of
                                                                            select="concat('unknownNamespace', java:unknownNamespaceId())" />
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </xsl:variable>
                                                        <xsl:attribute name="id">
                                                            <!-- TODO: kontrola jestli neni targetNamespace relativni URI -->
                                                            <!--<xsl:value-of select="ncname:transformToNCName(translate(substring-after(./@targetNamespace,'://'),'/','_'))"/>-->
                                                            <!--<xsl:value-of select="ncname:transformToNCName(translate(./@targetNamespace,'/','_'))"/>-->
                                                            <xsl:value-of select="$id" />
                                                        </xsl:attribute>
                                                        <xsl:variable name="schemaFile">
                                                            <xsl:if test="./@schemaLocation">
                                                                <xsl:value-of select="./@schemaLocation"/>
                                                            </xsl:if>
                                                            <xsl:if test="./@location">
                                                                <xsl:value-of select="./@location"/>
                                                            </xsl:if>
                                                        </xsl:variable>
                                                        <xsl:variable name="schemaDocumentationPath" select="java:getSchemaDocumentationLink($level, $schemaFile, $inputFileName, $relativePath)" />
                                                        <title>
                                                            Namespace:
                                                            <xsl:value-of select="./@namespace"/>
                                                        </title>
                                                        <conbody>
                                                            <p>
                                                                Imported from file:
                                                                <xsl:element name="xref">
                                                                    <xsl:attribute name="href"><xsl:value-of select="$schemaDocumentationPath"/></xsl:attribute>
                                                                    <xsl:value-of select="$schemaFile"/>
                                                                </xsl:element>
                                                            </p>
                                                        </conbody>
                                                    </xsl:element>
                                                </xsl:if>
                                            </xsl:for-each>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:element name="concept">
                                                <xsl:attribute name="xml:lang">en-us</xsl:attribute>
                                                <xsl:variable name="ncId"
                                                              select="ncname:transformToNCName(translate(./@targetNamespace,'/','_'))" />
                                                <xsl:variable name="id">
                                                    <xsl:choose>
                                                        <xsl:when test="($ncId != '') and ($count=1)">
                                                            <xsl:value-of select="$ncId" />
                                                        </xsl:when>
                                                        <xsl:when test="($ncId != '') and ($count!=1)">
                                                            <xsl:value-of select="concat($ncId,'_',$count)" />
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of
                                                                    select="concat('unknownNamespace', java:unknownNamespaceId())" />
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:variable>
                                                <xsl:attribute name="id">
                                                    <!-- TODO: kontrola jestli neni targetNamespace relativni URI -->
                                                    <!--<xsl:value-of select="ncname:transformToNCName(translate(substring-after(./@targetNamespace,'://'),'/','_'))"/>-->
                                                    <!--<xsl:value-of select="ncname:transformToNCName(translate(./@targetNamespace,'/','_'))"/>-->
                                                    <xsl:value-of select="$id" />
                                                </xsl:attribute>
                                                <title>
                                                    Namespace:
                                                    <xsl:value-of select="./@targetNamespace" />
                                                </title>
                                                <xsl:variable name="namSpace" select="./@targetNamespace" />
                                                <xsl:variable name="namPrefix">
                                                    <xsl:choose>
                                                        <xsl:when
                                                                test="count(//*[local-name()= 'definitions']/namespace::*[.=$namSpace]) > 0">
                                                            <xsl:value-of
                                                                    select="local-name(//*[local-name()= 'definitions']/namespace::*[.=$namSpace][1])" />
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="''" />
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:variable>
                                                <conbody>
                                                    <p>
                                                        <xsl:apply-templates select="."
                                                                             mode="schemaTypeTemplate">
                                                            <xsl:with-param name="namPrefix" select="$namPrefix" />
                                                        </xsl:apply-templates>
                                                    </p>
                                                </conbody>
                                            </xsl:element>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:otherwise>
                    </xsl:choose>
                </concept>
            </xsl:if>

            <xsl:if test="java:shallGeneratePart('wsdl/portConfig')">
                <concept id="PortConfig" xml:lang="en-us">
                    <title>Port configuration:</title>
                    <conbody>
                        <p>
                            <xsl:choose>
                                <xsl:when test="count(a:definitions/a:service/a:port)>0">
                                    <ul>
                                        <li>
                                            <b>
                                                <xsl:text>Binding: </xsl:text>
                                            </b>
                                            <xsl:value-of select="a:definitions/a:service/a:port/@binding" />
                                        </li>
                                        <li>
                                            <b>
                                                <xsl:text>Name: </xsl:text>
                                            </b>
                                            <xsl:value-of select="a:definitions/a:service/a:port/@name" />
                                        </li>
                                        <li>
                                            <b>
                                                <xsl:text>Soap Address: </xsl:text>
                                            </b>
                                            <xsl:value-of
                                                    select="a:definitions/a:service/a:port/soap:address/@location" />
                                        </li>
                                    </ul>
                                </xsl:when>
                                <xsl:otherwise>
                                    <i>Empty</i>
                                </xsl:otherwise>
                            </xsl:choose>
                        </p>
                    </conbody>
                </concept>
            </xsl:if>

            <xsl:if test="java:shallGeneratePart('wsdl/operations')">
                <concept id="Operations" xml:lang="en-us">
                    <title>Operations:</title>
                    <conbody>
                        <p>
                            <xsl:choose>
                                <xsl:when
                                        test="count(/*[local-name()='definitions']/*[local-name()='portType']/*[local-name()='operation'])=0">
                                    <i>Empty</i>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:for-each
                                            select="/*[local-name()='definitions']/*[local-name()='portType']/*[local-name()='operation']">
                                        <xsl:sort select="@name" />
                                        <ul>
                                            <li>
                                                <b>Name: </b>
                                                <xsl:value-of select="@name" />
                                                <ul>
                                                    <li>
                                                        <b>Parameters: </b>
                                                        <xsl:apply-templates select="." mode="oper" />
                                                    </li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </xsl:for-each>
                                </xsl:otherwise>
                            </xsl:choose>
                        </p>
                    </conbody>
                </concept>
            </xsl:if>

            <xsl:if test="java:shallGeneratePart('wsdl/messages')">
                <concept id="Messages" xml:lang="en-us">
                    <title>Messages:</title>
                    <conbody>
                        <p>
                            <xsl:choose>
                                <xsl:when
                                        test="count(/*[local-name()='definitions']/*[local-name()='message'])>0">
                                    <ul>
                                        <xsl:for-each
                                                select="/*[local-name()='definitions']/*[local-name()='message']">
                                            <xsl:sort select="@name" />
                                            <xsl:element name="li">
                                                <xsl:attribute name="id">
                                                    <xsl:value-of select="ncname:transformToNCName(@name)" />
                                                </xsl:attribute>
                                                <b>Name: </b>
                                                <xsl:value-of select="@name" />
                                                <xsl:for-each select="./*[local-name()='part']">
                                                    <ul>
                                                        <li>
                                                            <b>Part Element: </b>
                                                            <!-- if condition added, don't generate href if element is
                                                                empty -->

                                                            <xsl:variable name="elementPrefix" select="substring-before(./@element, ':')"/>
                                                            <xsl:variable name="elementNamespace" select="./../namespace::*[name()=$elementPrefix]"/>

                                                            <xsl:variable name="schemaNamespace">
                                                                <xsl:choose>
                                                                    <xsl:when test="/*[local-name()='definitions']/*[local-name()='types']/*[local-name()='schema']/*[local-name()='import'][@namespace=$elementNamespace]/@namespace">
                                                                        <xsl:value-of select="/*[local-name()='definitions']/*[local-name()='types']/*[local-name()='schema']/*[local-name()='import'][@namespace=$elementNamespace]/@namespace"/>
                                                                    </xsl:when>
                                                                    <xsl:when test="/*[local-name()='definitions']/*[local-name()='import'][@namespace=$elementNamespace]/@namespace">
                                                                        <xsl:value-of select="/*[local-name()='definitions']/*[local-name()='import'][@namespace=$elementNamespace]/@namespace"/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise><xsl:value-of select="$elementNamespace"/></xsl:otherwise>
                                                                </xsl:choose>
                                                            </xsl:variable>
                                                            <xsl:variable name="schemaFile">
                                                                <xsl:choose>
                                                                    <xsl:when test="/*[local-name()='definitions']/*[local-name()='import'][@namespace=$schemaNamespace]/@schemaLocation">
                                                                        <xsl:value-of select="/*[local-name()='definitions']/*[local-name()='import'][@namespace=$schemaNamespace]/@schemaLocation"/>
                                                                    </xsl:when>
                                                                    <xsl:when test="/*[local-name()='definitions']/*[local-name()='import'][@namespace=$schemaNamespace]/@location">
                                                                        <xsl:value-of select="/*[local-name()='definitions']/*[local-name()='import'][@namespace=$schemaNamespace]/@location"/>
                                                                    </xsl:when>
                                                                    <xsl:when test="/*[local-name()='definitions']/*[local-name()='types']/*[local-name()='schema']/*[local-name()='import'][@namespace=$schemaNamespace]/@schemaLocation">
                                                                        <xsl:value-of select="/*[local-name()='definitions']/*[local-name()='types']/*[local-name()='schema']/*[local-name()='import'][@namespace=$schemaNamespace]/@schemaLocation"/>
                                                                    </xsl:when>
                                                                    <xsl:when test="/*[local-name()='definitions']/*[local-name()='types']/*[local-name()='schema']/*[local-name()='import'][@namespace=$schemaNamespace]/@location">
                                                                        <xsl:value-of select="/*[local-name()='definitions']/*[local-name()='types']/*[local-name()='schema']/*[local-name()='import'][@namespace=$schemaNamespace]/@location"/>
                                                                    </xsl:when>
                                                                    <xsl:when test="not(/*[local-name()='definitions']/*[local-name()='import']) and not(/*[local-name()='definitions']/*[local-name()='types']/*[local-name()='schema']/*[local-name()='import'])">
                                                                        <xsl:value-of select="$inputFileName"/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise/>
                                                                </xsl:choose>
                                                            </xsl:variable>

                                                            <xsl:variable name="schemaDocumentationPath" select="java:getSchemaDocumentationLink($level, $schemaFile, $inputFileName, $relativePath)" />

                                                            <xsl:if test="./@element != ''">
                                                                <xsl:variable name="endsWithHeading">
                                                                    <xsl:call-template name="ends-with">
                                                                        <xsl:with-param name="string" select="substring-before($schemaDocumentationPath, '.dita')" />
                                                                        <xsl:with-param name="endString" select="$heading" />
                                                                    </xsl:call-template>
                                                                </xsl:variable>
                                                                <xsl:choose>
                                                                    <xsl:when test="$endsWithHeading">
                                                                        <xsl:value-of select="./@element" />
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:element name="xref">
                                                                            <xsl:attribute name="href">
                                                                                <xsl:variable name="endsWithWSDL">
                                                                                    <xsl:call-template name="ends-with">
                                                                                        <xsl:with-param name="string" select="substring-before($schemaDocumentationPath, '.dita')" />
                                                                                        <xsl:with-param name="endString" select="'.wsdl'" />
                                                                                    </xsl:call-template>
                                                                                </xsl:variable>
                                                                                <xsl:variable name="endsWithXSD">
                                                                                    <xsl:call-template name="ends-with">
                                                                                        <xsl:with-param name="string" select="substring-before($schemaDocumentationPath, '.dita')" />
                                                                                        <xsl:with-param name="endString" select="'.xsd'" />
                                                                                    </xsl:call-template>
                                                                                </xsl:variable>
                                                                                <xsl:choose>
                                                                                    <xsl:when test="$endsWithWSDL">
                                                                                        <xsl:value-of select="$schemaDocumentationPath"/>#Messages__<xsl:value-of select="substring-after(./@element, concat($elementPrefix, ':'))" />
                                                                                    </xsl:when>
                                                                                    <xsl:when test="$endsWithXSD">
                                                                                        <xsl:value-of select="$schemaDocumentationPath"/>#element_<xsl:value-of select="substring-after(./@element, concat($elementPrefix, ':'))" />
                                                                                    </xsl:when>
                                                                                    <xsl:otherwise>
                                                                                        <xsl:value-of select="$schemaDocumentationPath"/>
                                                                                    </xsl:otherwise>
                                                                                </xsl:choose>
                                                                            </xsl:attribute>

                                                                            <!--xsl:attribute name="type">entry</xsl:attribute -->
                                                                            <xsl:attribute name="type">concept</xsl:attribute>
                                                                            <xsl:value-of select="./@element" />
                                                                        </xsl:element>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </xsl:if>
                                                        </li>
                                                        <li>
                                                            <b>Part Name: </b>
                                                            <xsl:value-of select="./@name" />
                                                        </li>
                                                    </ul>
                                                </xsl:for-each>
                                            </xsl:element>
                                        </xsl:for-each>
                                    </ul>
                                </xsl:when>
                                <xsl:otherwise>
                                    <i>Empty</i>
                                </xsl:otherwise>
                            </xsl:choose>
                        </p>
                    </conbody>
                </concept>
            </xsl:if>


        </concept>
    </xsl:template>

    <xsl:template match="*" mode="oper">
        <p>
            <xsl:if test="count(./*)>0">
                <ul>
                    <xsl:for-each select="./*">
                        <xsl:choose>
                            <xsl:when test="local-name() = 'input'">
                                <li>
                                    <b>Input: </b>
                                    <xsl:element name="xref">
                                        <xsl:attribute name="href">#Messages</xsl:attribute>
                                        <xsl:attribute name="type">concept</xsl:attribute>
                                        <xsl:value-of select="./@message" />
                                    </xsl:element>
                                </li>
                            </xsl:when>
                            <xsl:when test="local-name() = 'output'">
                                <li>
                                    <b>Output: </b>
                                    <xsl:element name="xref">
                                        <xsl:attribute name="href">#Messages</xsl:attribute>
                                        <xsl:attribute name="type">concept</xsl:attribute>
                                        <xsl:value-of select="./@message" />
                                    </xsl:element>
                                </li>
                            </xsl:when>
                            <xsl:when test="local-name() = 'fault'">
                                <li>
                                    <b>Fault: </b>
                                    <xsl:element name="xref">
                                        <xsl:attribute name="href">#Messages</xsl:attribute>
                                        <xsl:attribute name="type">concept</xsl:attribute>
                                        <xsl:value-of select="./@message" />
                                    </xsl:element>
                                </li>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:for-each>
                </ul>
            </xsl:if>
        </p>
    </xsl:template>


    <xsl:template match="*" mode="operationMessage">
        <table>
            <tgroup cols="1">
                <tbody>
                    <row>
                        <entry>
                            <xsl:value-of select="./@message" />
                        </entry>
                    </row>
                </tbody>
            </tgroup>
        </table>
    </xsl:template>

    <xsl:template match="*" mode="schemaTypeTemplate">
        <xsl:param name="namPrefix" />
        <xsl:choose>
            <!-- Next recursive call when current tag has any children -->
            <xsl:when test="local-name(.)='element'">
                <xsl:apply-templates select="."
                                     mode="schemaTypeDetailTemplate">
                    <xsl:with-param name="namPrefix" select="$namPrefix" />
                </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="./*">
                <ul>

                    <xsl:choose>
                        <xsl:when test="./@name">
                            <xsl:element name="li">
                                <xsl:attribute name="id">
                                    <xsl:value-of
                                            select="ncname:transformToNCName(concat($namPrefix, ':', ./@ref))" />
                                    <xsl:value-of
                                            select="ncname:transformToNCName(concat($namPrefix, ':', ./@name))" />
                                </xsl:attribute>
                                <xsl:choose>
                                    <xsl:when test="./@name">
                                        <xsl:value-of select="$namPrefix"/>
                                        :
                                        <xsl:value-of select="./@name"/>
                                    </xsl:when>
                                    <xsl:when test="./@ref">
                                        <xsl:value-of select="./@ref"/>
                                    </xsl:when>
                                </xsl:choose>

                                <xsl:apply-templates select="*"
                                                     mode="schemaTypeTemplate">
                                    <xsl:with-param name="namPrefix" select="$namPrefix" />
                                </xsl:apply-templates>

                            </xsl:element>

                        </xsl:when>

                        <xsl:otherwise>
                            <li>
                                <xsl:value-of select="local-name(.)" />

                                <xsl:apply-templates select="*"
                                                     mode="schemaTypeTemplate">
                                    <xsl:with-param name="namPrefix" select="$namPrefix" />
                                </xsl:apply-templates>
                            </li>
                        </xsl:otherwise>
                    </xsl:choose>

                </ul>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="."
                                     mode="schemaTypeDetailTemplate">
                    <xsl:with-param name="namPrefix" select="$namPrefix" />
                </xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="*" mode="schemaTypeDetailTemplate">
        <xsl:param name="namPrefix" />
        <xsl:if test="@name or @ref">
            <ul>
                <xsl:element name="li">
                    <xsl:attribute name="id">
                        <xsl:value-of
                                select="ncname:transformToNCName(concat($namPrefix, ':', @name))" />
                    </xsl:attribute>
                    <xsl:choose>
                        <xsl:when test="./@name">
                            <xsl:value-of select="$namPrefix"/>
                            :
                            <xsl:value-of select="./@name"/>
                        </xsl:when>
                        <xsl:when test="./@ref">
                            <xsl:value-of select="./@ref"/>
                        </xsl:when>
                    </xsl:choose>
                    <!-- if condition added, don't generate href if type empty -->
                    <xsl:if test="./@type != ''">
                        <xsl:text> - </xsl:text>
                        <xsl:value-of select="./@type" />
                    </xsl:if>
                </xsl:element>
            </ul>
        </xsl:if>
    </xsl:template>
    <xsl:template name="ends-with">
        <xsl:param name="string" />
        <xsl:param name="endString" />
        <xsl:variable name="index" select="string-length($string)- string-length($endString) +1"/>
        <xsl:choose>
            <xsl:when test="substring($string,$index)=$endString"><xsl:value-of select="true()"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="false()" /></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
        <!-- =============================== END OF FILE ================================ -->