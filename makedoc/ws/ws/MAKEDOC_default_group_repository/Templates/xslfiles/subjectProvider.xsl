<?xml version="1.0" encoding="utf-8"?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             BEHAIM IT Solutions                              -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : subjectProvider.xsl                                          -->
<!-- originator      : lsatin                                                     -->
<!-- creation date   : 2015/09/02                                                 -->
<!-- description     : XSL template transfers BW XML file of type                 -->
<!--                   .sipResource into DITA format.                      -->
<!-- ============================================================================ -->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:java="http://xml.apache.org/xalan/java" 
	xmlns:jndi="http://xsd.tns.tibco.com/amf/models/sharedresource/jndi" 
	xmlns:CustomFunctions="com.behaim.commons.xsl.CustomFunctions" 
	xmlns:CustomFunctionsEagle="com.behaim.commons.eagle.CustomFunctions" 
	xmlns:ncname="com.pikeelectronic.xsl.NCName" 
	xmlns:map="xalan://java.util.Map" 
	extension-element-prefixes="map" 
	exclude-result-prefixes="ncname java CustomFunctions CustomFunctionsEagle jndi">
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
	<xsl:template match="/jndi:namedResource">
<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE concept PUBLIC "-//OASIS//DTD DITA Concept//EN" "]]></xsl:text><xsl:value-of select="concat($mdcfg,'/dtd','/concept.dtd')"/><xsl:text disable-output-escaping="yes">"></xsl:text>  

		<concept id="SubjectProvidersMain" xml:lang="en-us">
			<xsl:variable name="processName" select="substring-before($heading,'.sipResource')"/>
		<title>
			<xsl:value-of select="$processName"/>
		</title>
		<titlealts>
			<navtitle>
				<xsl:choose>
					<xsl:when test="$displayPathInTopicName">
              			<xsl:value-of select="substring-before($relativePath,'.sipResource')"/>
            		</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$processName"/>
					</xsl:otherwise>
				</xsl:choose>
			</navtitle>
		</titlealts>
					<conbody>
						<p>
							<xsl:value-of select="CustomFunctions:initializeTemplate('subjectProvider.xsl')"/>
						</p>
						<p>
							Section contains description of Subject Providers "
							<xsl:value-of select="$heading"/>
							" .
						</p>
						<xsl:if test="jndi:description != ''">
							<p>
								Description:
								<xsl:value-of select="jndi:description"/>
							</p>
						</xsl:if>
					</conbody>
		
		<concept id="SubjectProviders">
			<title>Subject Providers</title>
		<conbody>
			<ul>
				<xsl:apply-templates select="/jndi:namedResource" mode="SSL"></xsl:apply-templates>
				<xsl:apply-templates select="jndi:configuration"></xsl:apply-templates>
			</ul>
		</conbody>
		</concept>
		</concept>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="/jndi:namedResource" mode="SSL">
		<li>Credential Provider for Identity Store:
		
		<xsl:choose>
			<xsl:when test="jndi:reference[@key='identityStoreServiceProvider']/@value != ''">
				<xsl:variable name="identityStoreProvider" select="jndi:reference[@key='identityStoreServiceProvider']/@value"/>
				<xsl:variable name="identityStoreProviderFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($identityStoreProvider, '.','/'), '.keystoreProviderResource.dita')"/>
				<xsl:variable name="identityStoreProviderRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($identityStoreProviderFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
				<xsl:element name="xref">
					<xsl:attribute name="href"><xsl:value-of select="$identityStoreProviderRef"/></xsl:attribute>
					<xsl:value-of select="$identityStoreProvider"/>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>No credential provider for identity store chosen.</xsl:otherwise>
		</xsl:choose>
		
		</li>
		
		<li>Credential Provider for Trust Store:
		
		<xsl:choose>
			<xsl:when test="jndi:reference[@key='trustStoreServiceProvider']/@value != ''">
				<xsl:variable name="trustStoreProvider" select="jndi:reference[@key='identityStoreServiceProvider']/@value"/>
				<xsl:variable name="trustStoreProviderFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($trustStoreProvider, '.','/'), '.keystoreProviderResource.dita')"/>
				<xsl:variable name="trustStoreProviderRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($trustStoreProviderFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
				<xsl:element name="xref">
					<xsl:attribute name="href"><xsl:value-of select="$trustStoreProviderRef"/></xsl:attribute>
					<xsl:value-of select="$trustStoreProvider"/>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>No credential provider for trust store chosen.</xsl:otherwise>
		</xsl:choose>
		</li>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="jndi:configuration/configuration">
		<li>Key Alias Name:
			<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@keyAlias"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='keyAlias']/@propName"/>
					<xsl:with-param name="defaultValue" select="''"/>
			</xsl:call-template>
		</li>
		
		<li>Key Alias Password:
		<xsl:choose>
			<xsl:when test="@keyPassword !=''"> **** </xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="''"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='keyPassword']/@propName"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>		
		</li>
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
			<xsl:otherwise><xsl:value-of select="$defaultValue"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template> 
</xsl:stylesheet>



