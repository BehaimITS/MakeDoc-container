<?xml version="1.0" encoding="utf-8"?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             BEHAIM IT Solutions                              -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : proxyConfiguration.xsl                                     -->
<!-- originator      : lsatin                                                     -->
<!-- creation date   : 2016/01/25                                                 -->
<!-- description     : XSL template transfers BW XML file of type                 -->
<!--                   .httpProxyResource into DITA format.                      -->
<!-- ============================================================================ -->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:java="http://xml.apache.org/xalan/java" 
	xmlns:CustomFunctionsEagle="com.behaim.commons.eagle.CustomFunctions" 
	xmlns:CustomFunctions="com.behaim.commons.xsl.CustomFunctions" 
	xmlns:id="http://www.tibco.com/ws/2013/11/identity" 
	xmlns:sca_ext="http://www.tibco.com/ns/sca/201311" 
	xmlns:jndi="http://xsd.tns.tibco.com/amf/models/sharedresource/jndi" 
	xmlns:ncname="com.pikeelectronic.xsl.NCName" 
	xmlns:xpdExt="http://www.tibco.com/XPD/xpdExtension1.0.0" 
	xmlns:xpdl2="http://www.wfmc.org/2008/XPDL2.1" 
	xmlns:PrimitiveTypeFacets="http:///schemas/PrimitiveTypeFacets/_8TmTUMtlEdy7K9XeCH7Hrw/0" 
	xmlns:map="xalan://java.util.Map" 
	extension-element-prefixes="map" 
	exclude-result-prefixes="xpdl2 ncname xpdExt java CustomFunctions CustomFunctionsEagle PrimitiveTypeFacets jndi id sca_ext">
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

		<concept id="ProxyConfigurationsMain" xml:lang="en-us">
		<xsl:variable name="processName" select="substring-before($heading,'.httpProxyResource')"/>
		<title>
			<xsl:value-of select="$processName"/>
		</title>
		<titlealts>
			<navtitle>
				<xsl:choose>
					<xsl:when test="$displayPathInTopicName">
              			<xsl:value-of select="substring-before($relativePath,'.httpProxyResource')"/>
            		</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$processName"/>
					</xsl:otherwise>
				</xsl:choose>
			</navtitle>
		</titlealts>
					<conbody>
						<p>
							<xsl:value-of select="CustomFunctions:initializeTemplate('proxyConfiguration.xsl')"/>
						</p>
						<p>
							Section contains description of Proxy Configurations "
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
		
			<concept id="ProxyConfigurations">
			<title>Proxy Configurations</title>
				<conbody>
					<ul>
						<xsl:apply-templates select="jndi:configuration"></xsl:apply-templates>
						<xsl:apply-templates select="/" mode="SSL"></xsl:apply-templates>
					</ul>
				</conbody>
			</concept>
		</concept>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="/" mode="SSL">
		<xsl:if test="/jndi:namedResource/identitySet/sca_ext:intentMap/sca_ext:qualifier/id:IdentityReference/@URI!=''">
			<li>
				SSL Client:
				<xsl:if test="/jndi:namedResource/identitySet/sca_ext:intentMap/sca_ext:qualifier/id:IdentityReference/@URI!=''">
				<xsl:variable name="identityProvider" select="/jndi:namedResource/identitySet/sca_ext:intentMap/sca_ext:qualifier/id:IdentityReference/@URI"/>
						<xsl:variable name="identityProviderFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($identityProvider, '.','/'), '.userIdResource.dita')"/>
						<xsl:variable name="identityProviderRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($identityProviderFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
						<xsl:element name="xref">
							<xsl:attribute name="href"><xsl:value-of select="$identityProviderRef"/></xsl:attribute>
							<xsl:value-of select="$identityProvider"/>
						</xsl:element>
				</xsl:if>
			</li>
		</xsl:if>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="jndi:configuration">
		<li>
			Proxy Host:
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@proxyHost"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='proxyHost']/@propName"/>
				<xsl:with-param name="defaultValue" select="''"/>
			</xsl:call-template>
		</li>
		<li>
			Proxy Port:
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@proxyPort"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='proxyPort']/@propName"/>
				<xsl:with-param name="defaultValue" select="'4480'"/>
			</xsl:call-template>
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
			<xsl:when test="$valueModuleProp!=''">
					<xsl:variable name="profileInfo" select="CustomFunctionsEagle:getModulePropertyProfileInfo($valueModuleProp)"/>
					<xref outputclass="popup" format="html" href="#{$profileInfo}"><xsl:value-of select="$valueModuleProp"/></xref>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="$defaultValue"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template> 
</xsl:stylesheet>



