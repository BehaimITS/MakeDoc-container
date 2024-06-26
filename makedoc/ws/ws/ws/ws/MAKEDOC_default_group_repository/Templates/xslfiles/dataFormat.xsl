<?xml version="1.0" encoding="utf-8"?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             BEHAIM IT Solutions                              -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : dataFormat.xsl                                             -->
<!-- originator      : lsatin                                                    -->
<!-- creation date   : 2016/01/19                                                 -->
<!-- description     : XSL template transfers BW XML file of type                 -->
<!--                   .dataFormatResource into DITA format.                      -->
<!-- ============================================================================ -->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:java="http://xml.apache.org/xalan/java" 
	xmlns:CustomFunctions="com.behaim.commons.xsl.CustomFunctions" 
	xmlns:CustomFunctionsEagle="com.behaim.commons.eagle.CustomFunctions" 
	xmlns:jndi="http://xsd.tns.tibco.com/amf/models/sharedresource/jndi" 
	xmlns:ncname="com.pikeelectronic.xsl.NCName" 
	xmlns:xpdExt="http://www.tibco.com/XPD/xpdExtension1.0.0" 
	xmlns:xpdl2="http://www.wfmc.org/2008/XPDL2.1" 
	xmlns:PrimitiveTypeFacets="http:///schemas/PrimitiveTypeFacets/_8TmTUMtlEdy7K9XeCH7Hrw/0" 
	xmlns:map="xalan://java.util.Map" 
	extension-element-prefixes="map" 
	exclude-result-prefixes="xpdl2 ncname xpdExt java CustomFunctions CustomFunctionsEagle PrimitiveTypeFacets jndi">
	<xsl:output encoding="utf-8" method="xml" indent="no"/>
	<xsl:param name="mdcfg"/>
	<xsl:param name="heading"/>
	<xsl:param name="level"/>
	<xsl:param name="designLib"/>
	<xsl:param name="isUseInputBindings"/>
	<xsl:param name="inputFileName"/>
	<xsl:param name="outputFileName"/>
	<xsl:param name="projectRoot"/>
	<xsl:param name="applicationName"/>
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
	<!--  type odf mapping - table, tree, raw >
    <xsl:param name="mappingType" select="'table'"/-->
    <xsl:param name="structure"/>
	<!-- Special folder names -->
    <xsl:param name="wsdlFolder"/>
    <xsl:param name="processesFolder"/>
    <xsl:param name="schemasFolder"/>
    <xsl:param name="policiesFolder"/>
    <xsl:param name="resourcesFolder"/>
	<!-- Main template -->
	<xsl:template match="/jndi:namedResource">
	<xsl:variable name="processName" select="substring-before($heading,'.dataFormatResource')"/>
		<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE concept PUBLIC "-//OASIS//DTD DITA Concept//EN" "]]></xsl:text><xsl:value-of select="concat($mdcfg,'/dtd','/concept.dtd')"/><xsl:text disable-output-escaping="yes">"></xsl:text>  
		<concept id="DataFormatsMain" xml:lang="en-us">
		<title>
			<xsl:value-of select="$processName"/>
		</title>
		<titlealts>
			<navtitle>
				<xsl:choose>
					<xsl:when test="$displayPathInTopicName">
              			<xsl:value-of select="substring-before($relativePath,'.dataFormatResource')"/>
            		</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$processName"/>
					</xsl:otherwise>
				</xsl:choose>
			</navtitle>
		</titlealts>
		<conbody>			
			<p>
				<xsl:value-of select="CustomFunctions:initializeTemplate('dataFormat.xsl')"/>
			</p>	
			<p>
				Section contains description of data formats "
				<xsl:value-of select="$heading"/>
				" .
			</p>				
			<p>
				Name:
				<xsl:value-of select="@name"/>
			</p>
			<xsl:if test="jndi:description != ''">
				<p>
					Description:
					<xsl:value-of select="jndi:description"/>
				</p>
			</xsl:if>
		</conbody>
		<concept id="DataFormatConfiguration">
			<title>Data Format Configuration</title>
			<conbody>
				<xsl:apply-templates select="jndi:configuration" mode="DataFormatConfiguration"></xsl:apply-templates>
			</conbody>
		</concept>
			<concept id="DataFormatEditor">
				<title>Data Format Editor</title>
				<conbody>
					<xsl:if test="imports/@importType != '' or imports/@namespace != '' or jndi:configuration/@schemaElementQName != ''">
					<ul>
						<xsl:if test="imports/@importType != ''">
							<li>Import Type: <xsl:value-of select="imports/@importType"/></li>
						</xsl:if>
						<xsl:if test="imports/@namespace != ''">
							<li>Namespace: <xsl:value-of select="imports/@namespace"/></li>
						</xsl:if>
						<xsl:if test="jndi:configuration/@schemaElementQName != ''">
							<li>Schema Element: <xsl:value-of select="jndi:configuration/@schemaElementQName"/></li>
						</xsl:if>
					</ul>
					</xsl:if>
				</conbody>
			</concept>
			<concept id="DataFormatFieldOffsets">
				<title>Field Offsets</title>
				<conbody>
					<xsl:apply-templates select="jndi:configuration" mode="DataFormatFieldOffsets"></xsl:apply-templates>
				</conbody>
			</concept>
	</concept>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="jndi:configuration" mode="DataFormatConfiguration">
		<ul>
			<xsl:if test="@formatType != ''">
				<li>Format Type: <xsl:value-of select="@formatType"/></li>
			</xsl:if>
			<xsl:if test="@colSeparator != ''">
				<li>Col Separator:
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="@colSeparator"/>
						<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='colSeparator']/@propName"/>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template>
				</li>
			</xsl:if>
			<xsl:if test="@colSeparatorParseRule != ''">
				<li>Col Separator Parse Rule: <xsl:value-of select="@colSeparatorParseRule"/></li>
			</xsl:if>
			<xsl:if test="@lineSeparator != ''">
				<li>Line Separator: <xsl:value-of select="@lineSeparator"/></li>
			</xsl:if>
			<xsl:if test="@fillCharacter != ''">
				<li>Fill Character: <xsl:value-of select="@fillCharacter"/></li>
			</xsl:if>
			<xsl:if test="@fillWith != ''">
				<li>Fill With: <xsl:value-of select="@fillWith"/></li>
			</xsl:if>
		</ul>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="jndi:configuration" mode="DataFormatFieldOffsets">
			<xsl:if test="@lineLength != '' or substitutionBindings[@template='lineLength']/@propName != ''">
				<ul>
					<li>Line Length:
						<xsl:call-template name="getValueFromLiteralModule">
							<xsl:with-param name="valueLiteral" select="@lineLength"/>
							<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='lineLength']/@propName"/>
							<xsl:with-param name="defaultValue" select="''"/>
						</xsl:call-template>
					</li>
				</ul>
			</xsl:if>
			<xsl:if test="@fieldOffsetsStr!=''">
			  <ul>
			  	<li><p>Field Offset Values</p>
				  <ul>
				   <li>Field Offset: <xsl:value-of select="@fieldOffsetsStr"/></li>
					<li>
					<xsl:for-each select="fieldOffsets">
						<xsl:value-of select="@name"/>
						<xsl:if test="not(position() = last())">,</xsl:if>
					</xsl:for-each>		
					</li>
				   </ul>
				  </li>
				</ul>
			</xsl:if>		
	</xsl:template>
	
	<!-- Helper templates -->
	<xsl:template name="getValueFromLiteralModule">
		<xsl:param name="valueLiteral"/>
		<xsl:param name="valueModuleProp"/>
		<xsl:param name="defaultValue"/>
		<xsl:choose>
			<xsl:when test="$valueModuleProp!=''">
				<xsl:variable name="profileInfo" select="CustomFunctionsEagle:getModulePropertyProfileInfo($valueModuleProp,$applicationName)"/>
				<xref outputclass="popup" format="html" href="#{$profileInfo}"><xsl:value-of select="$valueModuleProp"/></xref>
			</xsl:when>
			<xsl:when test="$valueLiteral!=''">
				<xsl:value-of select="$valueLiteral"/>
			</xsl:when>
			<xsl:when test="$valueModuleProp!=''">
					<xsl:variable name="profileInfo" select="CustomFunctionsEagle:getModulePropertyProfileInfo($valueModuleProp)"/>
					<xref outputclass="popup" format="html" href="#{$profileInfo}"><xsl:value-of select="$valueModuleProp"/></xref>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="$defaultValue"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template> 
</xsl:stylesheet>



