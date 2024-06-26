<?xml version="1.0" encoding="utf-8"?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             BEHAIM IT Solutions                              -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : ldapConnection.xsl                                         -->
<!-- originator      : lsatin                                                     -->
<!-- creation date   : 2016/02/01                                                 -->
<!-- description     : XSL template transfers BW XML file of type                 -->
<!--                   .ldapConnection into DITA format.                              -->
<!-- ============================================================================ -->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:java="http://xml.apache.org/xalan/java"
	xmlns:id="http://www.tibco.com/ws/2013/11/identity" 
	xmlns:sca_ext="http://www.tibco.com/ns/sca/201311" 
	xmlns:CustomFunctionsEagle="com.behaim.commons.eagle.CustomFunctions" 
	xmlns:CustomFunctions="com.behaim.commons.xsl.CustomFunctions" 
	xmlns:jndi="http://xsd.tns.tibco.com/amf/models/sharedresource/jndi" 
	xmlns:ncname="com.pikeelectronic.xsl.NCName" 
	xmlns:xpdExt="http://www.tibco.com/XPD/xpdExtension1.0.0" 
	xmlns:xpdl2="http://www.wfmc.org/2008/XPDL2.1" 
	xmlns:PrimitiveTypeFacets="http:///schemas/PrimitiveTypeFacets/_8TmTUMtlEdy7K9XeCH7Hrw/0" 
	xmlns:map="xalan://java.util.Map" 
	extension-element-prefixes="map" 
	exclude-result-prefixes="xpdl2 ncname xpdExt java CustomFunctions CustomFunctionsEagle PrimitiveTypeFacets id sca_ext jndi">
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

		<concept id="LDAPConnectionMain" xml:lang="en-us">
			<title>
				<xsl:value-of select="'LDAPConnection'"/>
			</title>
			<titlealts>
				<navtitle>				
					<xsl:value-of select="'LDAP Connection'"/>
				</navtitle>
			</titlealts>
					<conbody>
						<p>
							<xsl:value-of select="CustomFunctions:initializeTemplate('ldapConnection.xsl')"/>
						</p>
						<p>
							Section contains description of LDAP Connection "
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
		
			<concept id="LDAPConnection">
				<title>LDAP Connection</title>
				<conbody>
					<ul>
						<xsl:apply-templates select="jndi:configuration" mode="ConnectionConfiguration"></xsl:apply-templates>		
					</ul>
				</conbody>
		</concept>
		</concept>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="jndi:configuration" mode="ConnectionConfiguration">
		<li>
			Server Type: <xsl:value-of select="@serverType"/>
		</li>
		<li>
			Server Name: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@serverName"/>
				<xsl:with-param name="defaultValue" select="''"/>
			</xsl:call-template>
		</li>		
		<li>
			LDAP Port: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@ldapPort"/>
				<xsl:with-param name="defaultValue" select="''"/>
			</xsl:call-template>
		</li>
		<li>
			Reconnection Times: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@reconnectionTimes"/>
				<xsl:with-param name="defaultValue" select="'3'"/>
			</xsl:call-template>
		</li>
		<li>
			Reconnection Interval: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@reconnectionInterval"/>
				<xsl:with-param name="defaultValue" select="'3000'"/>
			</xsl:call-template>
		</li>
		<xsl:choose>
			<xsl:when test="@authenticationMode = 'Simple'">
				<li>
					Authentication Mode: <xsl:value-of select="@authenticationMode"/>
				</li>
				<li>
					Authentication Enabled: <xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="@authenticationMode"/>
						<xsl:with-param name="defaultValue" select="'true'"/>
					</xsl:call-template>
				</li>				
				<xsl:apply-templates select="/" mode="IdentityProvider"></xsl:apply-templates>
			</xsl:when>
			<xsl:when test="@authenticationMode = ''">
				<li>
					Authentication Mode: Anonymous
				</li>
			</xsl:when>
			<xsl:otherwise>
				<li>
					Authentication Mode: <xsl:value-of select="@authenticationMode"/>
				</li>				
			</xsl:otherwise>
		</xsl:choose>		
		<xsl:apply-templates select="/" mode="SSL"></xsl:apply-templates>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="/" mode="IdentityProvider">
		<xsl:if test="/jndi:namedResource/jndi:reference[@type='subject:SubjectConfiguration']/@value">
			<li>
				Identity Provider:
				<xsl:value-of select="/jndi:namedResource/jndi:reference[@type='subject:SubjectConfiguration']/@value"/>
			</li>
		</xsl:if>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="/" mode="SSL">
		<xsl:if test="/jndi:namedResource/jndi:reference[@type='sslclient:SSLClientConfiguration']/@value">
			<li>
				SSL Client:
				<xsl:value-of select="/jndi:namedResource/jndi:reference[@type='sslclient:SSLClientConfiguration']/@value"/>
			</li>
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



