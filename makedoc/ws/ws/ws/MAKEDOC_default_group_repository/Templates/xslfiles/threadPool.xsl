<?xml version="1.0" encoding="utf-8"?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             BEHAIM IT Solutions                              -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : threadPool.xsl                                             -->
<!-- originator      : lsatin                                                     -->
<!-- creation date   : 2015/09/02                                                 -->
<!-- description     : XSL template transfers BW XML file of type                 -->
<!--                   .threadPoolResource into DITA format.                              -->
<!-- ============================================================================ -->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:java="http://xml.apache.org/xalan/java" 
	xmlns:CustomFunctionsEagle="com.behaim.commons.eagle.CustomFunctions" 
	xmlns:CustomFunctions="com.behaim.commons.xsl.CustomFunctions" 
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
	<xsl:template match="/jndi:namedResource">
<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE concept PUBLIC "-//OASIS//DTD DITA Concept//EN" "]]></xsl:text><xsl:value-of select="concat($mdcfg,'/dtd','/concept.dtd')"/><xsl:text disable-output-escaping="yes">"></xsl:text>  

		<concept id="ThreadPoolMain" xml:lang="en-us">
			<xsl:variable name="processName" select="substring-before($heading,'.threadPoolResource')"/>
		<title>
			<xsl:value-of select="$processName"/>
		</title>
		<titlealts>
			<navtitle>
				<xsl:choose>
					<xsl:when test="$displayPathInTopicName">
              			<xsl:value-of select="substring-before($relativePath,'.threadPoolResource')"/>
            		</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$processName"/>
					</xsl:otherwise>
				</xsl:choose>
			</navtitle>
		</titlealts>
					<conbody>
						<p>
							<xsl:value-of select="CustomFunctions:initializeTemplate('threadPool.xsl')"/>
						</p>
						<p>
							Section contains description of Thread Pool "
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
		
		<concept id="ThreadPool">
		<title>Thread Pool</title>
		<conbody>
			<ul>
				<xsl:apply-templates select="jndi:configuration"></xsl:apply-templates>		
			</ul>
		</conbody>
		</concept>
		</concept>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="jndi:configuration">
		<li>
			Core Pool Size: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@coreThreadPoolSize"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='coreThreadPoolSize']/@propName"/>
				<xsl:with-param name="defaultValue" select="'5'"/>
			</xsl:call-template>
		</li>
		<li>
			Thread Pool Name Prefix: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@threadNamePrefix"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='threadNamePrefix']/@propName"/>
				<xsl:with-param name="defaultValue" select="''"/>
			</xsl:call-template>
		</li>
		<li>
			Max Pool Size: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@maxPoolSize"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='maxPoolSize']/@propName"/>
				<xsl:with-param name="defaultValue" select="'10'"/>
			</xsl:call-template>
		</li>
		<li>
			Daemon: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@daemon"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='daemon']/@propName"/>
				<xsl:with-param name="defaultValue" select="'false'"/>
			</xsl:call-template>
		</li>
		<li>
			Keep Alive Time (s): 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@keepAliveTime"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='keepAliveTime']/@propName"/>
				<xsl:with-param name="defaultValue" select="'30'"/>
			</xsl:call-template>
		</li>
		<li>
			Priority: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@priority"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='priority']/@propName"/>
				<xsl:with-param name="defaultValue" select="'5'"/>
			</xsl:call-template>
		</li>
		<li>
			Auto Start Core Threads: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@autoStartCoreThreads"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='autoStartCoreThreads']/@propName"/>
				<xsl:with-param name="defaultValue" select="'false'"/>
			</xsl:call-template>
		</li>
		<li>
			Rejection Policy: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@rejectionPolicy"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='rejectionPolicy']/@propName"/>
				<xsl:with-param name="defaultValue" select="'BLOCKING'"/>
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
			<xsl:otherwise><xsl:value-of select="$defaultValue"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template> 
</xsl:stylesheet>



