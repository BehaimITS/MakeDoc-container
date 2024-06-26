<?xml version="1.0" encoding="utf-8"?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             BEHAIM IT Solutions                              -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : tcpConnection.xsl                                             -->
<!-- originator      : jkaspar                                                    -->
<!-- creation date   : 2015/09/01                                                 -->
<!-- description     : XSL template transfers BW XML file of type                 -->
<!--                   .tcpResource into DITA format.                      -->
<!-- ============================================================================ -->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:java="http://xml.apache.org/xalan/java" 
	xmlns:CustomFunctionsEagle="com.behaim.commons.eagle.CustomFunctions" 
	xmlns:jndi="http://xsd.tns.tibco.com/amf/models/sharedresource/jndi" 
	xmlns:CustomFunctions="com.behaim.commons.xsl.CustomFunctions" 
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

		<concept id="TCPConnectionsMain" xml:lang="en-us">
		<xsl:variable name="processName" select="substring-before($heading,'.tcpResource')"/>
		<title>
			<xsl:value-of select="$processName"/>
		</title>
		<titlealts>
			<navtitle>
				<xsl:choose>
					<xsl:when test="$displayPathInTopicName">
              			<xsl:value-of select="substring-before($relativePath,'.tcpResource')"/>
            		</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$processName"/>
					</xsl:otherwise>
				</xsl:choose>
			</navtitle>
		</titlealts>
					<conbody>
						<p>
							<xsl:value-of select="CustomFunctions:initializeTemplate('tcpConnection.xsl')"/>
						</p>
						<p>
							Section contains description of TCP Connections "
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
		
		<concept id="TCPConnections">
		<title>TCP Connections</title>
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
			Host:
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@host"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='host']/@propName"/>
				<xsl:with-param name="defaultValue" select="''"/>
			</xsl:call-template>
		</li>
		<li>
			Port:
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@port"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='port']/@propName"/>
				<xsl:with-param name="defaultValue" select="'0'"/>
			</xsl:call-template>
		</li>
		
		<xsl:variable name="enableConnPool">
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@enableConnectionPool"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='enableConnectionPool']/@propName"/>
				<xsl:with-param name="defaultValue" select="'false'"/>
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:choose>
		<xsl:when test="$enableConnPool != 'false'">
			
			<xsl:variable name="whenExhausted">
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@whenExhaustedAction"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='whenExhaustedAction']/@propName"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template>
			</xsl:variable>
			
			<li>
				Enable connection pool:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@enableConnectionPool"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='enableConnectionPool']/@propName"/>
					<xsl:with-param name="defaultValue" select="'false'"/>
				</xsl:call-template>
			</li>
			<xsl:if test="$enableConnPool != 'false'">
			<ul>
				<li>
				When Exhausted Connection: <xsl:value-of select="$whenExhausted"/>
				</li>
				<xsl:choose>
					<xsl:when test="$whenExhausted = 'Block'">
						<ul>
							<li>
									Maximum Connections:
									<xsl:call-template name="getValueFromLiteralModule">
										<xsl:with-param name="valueLiteral" select="@maxConnections"/>
										<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='maxConnections']/@propName"/>
										<xsl:with-param name="defaultValue" select="'10'"/>
									</xsl:call-template>
								</li>
								<li>
									Maximum Wait Time (ms):
									<xsl:call-template name="getValueFromLiteralModule">
										<xsl:with-param name="valueLiteral" select="@maxWaitTime"/>
										<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='maxWaitTime']/@propName"/>
										<xsl:with-param name="defaultValue" select="'10000'"/>
								</xsl:call-template>
							</li>
						</ul>
					</xsl:when>
					<xsl:when test="$whenExhausted = 'Fail'">
						<ul>
							<li>
								Maximum Connections:
								<xsl:call-template name="getValueFromLiteralModule">
									<xsl:with-param name="valueLiteral" select="@maxConnections"/>
									<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='maxConnections']/@propName"/>
									<xsl:with-param name="defaultValue" select="'10'"/>
								</xsl:call-template>
							</li>
						</ul>
					</xsl:when>		
					</xsl:choose>
					
					<li>
						Idle Timeout (ms):
						<xsl:call-template name="getValueFromLiteralModule">
							<xsl:with-param name="valueLiteral" select="@idleTimeout"/>
							<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='idleTimeout']/@propName"/>
							<xsl:with-param name="defaultValue" select="'-1'"/>
						</xsl:call-template>
					</li>
				</ul>		
				</xsl:if>
			
		</xsl:when>
			<xsl:otherwise>
				<li>Enable connection pool: false </li>
			</xsl:otherwise>
		</xsl:choose>
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



