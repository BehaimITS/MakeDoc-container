<?xml version="1.0" encoding="UTF-8" ?>
<!--============================================================================-->
<!--                                                                            -->
<!--                             PIKE ELECTRONIC                                -->
<!--                                                                            -->
<!--                            All Rights Reserved                             -->
<!--                                                                            -->
<!--                                                                            -->
<!-- project         : MakeDoc for TIBCO                                                  -->
<!-- filename        : Projects.xsl                                             -->
<!-- originator      : jpospisil                                                -->
<!-- creation date   : 2006-09-28                                               -->
<!-- description     : This header was automatically created                    -->
<!--                                                                            -->
<!--============================================================================-->

<xsl:transform version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:java="java:com.pike.falcon.xsl.CustomFunctions" 
	exclude-result-prefixes="java">
	
<xsl:output encoding="utf-8" method="html"/>

<xsl:param name="mdcfg"/>
<xsl:param name="destinationsDocumentName" />
<xsl:param name="author" />
<xsl:param name="owner" />
<xsl:param name="version" />
<xsl:param name="generated" />

<!-- Match document root tag -->
<xsl:template match="TibcoDoc">  
    <!-- ditamap heading -->
    <xsl:text disable-output-escaping="yes"><![CDATA[<?xml version="1.0" encoding="UTF-8"?>]]></xsl:text>
    <xsl:text disable-output-escaping="yes">&#xA;<![CDATA[<!DOCTYPE map PUBLIC "-//OASIS//DTD DITA Map//EN" "]]></xsl:text><xsl:value-of select="concat($mdcfg,'/dtd','/map.dtd')"/><xsl:text disable-output-escaping="yes">"></xsl:text>
    <xsl:text disable-output-escaping="yes">&#xA;<![CDATA[  <map title="Project documentation">]]></xsl:text> 
    
    <xsl:element name="topicmeta">
      <xsl:element name="author"><xsl:value-of select="$author"/></xsl:element>
      <xsl:element name="source"><xsl:value-of select="$version"/></xsl:element>
      <xsl:element name="publisher"><xsl:value-of select="$owner"/></xsl:element>
      <xsl:element name="critdates">
        <xsl:element name="created"><xsl:attribute name="date"><xsl:value-of select="$generated"/></xsl:attribute></xsl:element>     
      </xsl:element>
    </xsl:element>
	  
      <xsl:for-each select="Project">
	      <xsl:sort select="@name"/>
	      <xsl:call-template name="ProjectLine"/> 
	    </xsl:for-each>
    <xsl:text disable-output-escaping="yes">&#xA;<![CDATA[  </map>]]></xsl:text>
</xsl:template>

<xsl:template match="Project" name="ProjectLine">
  <xsl:variable name="projectName" select="translate(@name,' ', '_')"></xsl:variable>
  <xsl:text disable-output-escaping="yes">&#xA;<![CDATA[  <topicref href="]]></xsl:text>
  <xsl:value-of select="$projectName"/>
    <xsl:text disable-output-escaping="yes"><![CDATA[/]]></xsl:text>
    <xsl:value-of select="$projectName"/>
    <xsl:text disable-output-escaping="yes"><![CDATA[.dita">]]></xsl:text>
  <xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref format="ditamap" href="]]></xsl:text>
  <xsl:value-of select="$projectName"/>
	<xsl:text disable-output-escaping="yes"><![CDATA[/content_DITA.ditamap"/>]]></xsl:text>
	<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[</topicref>]]></xsl:text>
</xsl:template>
  

</xsl:transform>

<!-- ================================= END OF FILE ============================== -->