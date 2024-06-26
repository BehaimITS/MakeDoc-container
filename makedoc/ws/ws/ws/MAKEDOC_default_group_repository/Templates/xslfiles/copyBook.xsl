<?xml version="1.0" encoding="utf-8"?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             BEHAIM IT Solutions                              -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : copyBook.xsl                                               -->
<!-- originator      : lsatin                                                     -->
<!-- creation date   : 2015/09/01                                                 -->
<!-- description     : XSL template transfers BW XML file of type                 -->
<!--                   .ldapResource into DITA format.                      -->
<!-- ============================================================================ -->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:java="http://xml.apache.org/xalan/java"
	xmlns:id="http://www.tibco.com/ws/2013/11/identity" 
	xmlns:CustomFunctionsEagle="com.behaim.commons.eagle.CustomFunctions" 
	xmlns:sca_ext="http://www.tibco.com/ns/sca/201311" 
	xmlns:CustomFunctions="com.behaim.commons.xsl.CustomFunctions" 
	xmlns:jndi="http://xsd.tns.tibco.com/amf/models/sharedresource/jndi" 
	xmlns:ncname="com.pikeelectronic.xsl.NCName" 
	xmlns:xpdExt="http://www.tibco.com/XPD/xpdExtension1.0.0" 
	xmlns:xpdl2="http://www.wfmc.org/2008/XPDL2.1" 
	xmlns:PrimitiveTypeFacets="http:///schemas/PrimitiveTypeFacets/_8TmTUMtlEdy7K9XeCH7Hrw/0" 
	xmlns:map="xalan://java.util.Map" 
	extension-element-prefixes="map" 
	exclude-result-prefixes="xpdl2 ncname xpdExt java CustomFunctions CustomFunctionsEagle PrimitiveTypeFacets jndi sca_ext id">
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

		<concept id="CopybookMain" xml:lang="en-us">
		<xsl:variable name="processName" select="substring-before($heading,'.copybook')"/>
		<title>
			<xsl:value-of select="$processName"/>
		</title>
		<titlealts>
			<navtitle>
				<xsl:choose>
					<xsl:when test="$displayPathInTopicName">
              			<xsl:value-of select="substring-before($relativePath,'.copybook')"/>
            		</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$processName"/>
					</xsl:otherwise>
				</xsl:choose>
			</navtitle>
		</titlealts>
					<conbody>						
						<p>
							<xsl:value-of select="CustomFunctions:initializeTemplate('copyBook.xsl')"/>
						</p>						
						<p>
							Section contains description of Copy Book "
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
		
			<concept id="Copybook">
				<title>Copybook</title>
			<conbody>
				<ul>
					<xsl:apply-templates select="jndi:configuration" mode="Settings"></xsl:apply-templates>		
				</ul>
			</conbody>
		</concept>
			<xsl:if test="jndi:configuration/@copybook != ''">
				<concept id="CopybookAdvanced">
					<title>Copybook</title>
					<conbody>
						<ul>
							<xsl:apply-templates select="jndi:configuration" mode="Copybook"></xsl:apply-templates>		
						</ul>
					</conbody>
				</concept>
			</xsl:if>
			<xsl:if test="jndi:configuration/binaryOverrides != ''">
				<concept id="CopybookFieldConfiguration">
					<title>Field Configuration</title>
					<conbody>
						<ul>
							<xsl:apply-templates select="jndi:configuration" mode="FieldConfiguration"></xsl:apply-templates>		
						</ul>
					</conbody>
				</concept>
			</xsl:if>
		</concept>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="jndi:configuration" mode="Copybook">
		<li>
			Copybook:
			<xsl:value-of select="@copybook"/>
		</li>
		<xsl:if test="@origCopybook != ''">
			<li>
				Original Copybook:
				<xsl:value-of select="@origCopybook"/>
			</li>
		</xsl:if>
	</xsl:template>	
	
	<!-- Sub template -->
	<xsl:template match="jndi:configuration" mode="FieldConfiguration">
		<li>
			Binary Overrides:
		</li>
			<xsl:for-each select="binaryOverrides">
				<li>
					<xsl:value-of select="."/>
				</li>
			</xsl:for-each>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="jndi:configuration" mode="Advanced">
		<li>
			Follow Referrals:
			<xsl:choose>
				<xsl:when test="followReferals = 'false'">
					false
				</xsl:when>
				<xsl:otherwise>
					true
				</xsl:otherwise>
			</xsl:choose>
		</li>		
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="jndi:configuration" mode="Settings">
		<li>
			Copybook Type: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@copybookType"/>
				<xsl:with-param name="defaultValue" select="'COBOL'"/>
			</xsl:call-template>
		</li>		
		<li>
			File Encoding: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@encoding"/>
				<xsl:with-param name="defaultValue" select="'ASCII'"/>
			</xsl:call-template>
		</li>
			<xsl:if test="@copybookType != 'RPG' or not(@copybookType)">
			<li>
				Floating Point: 
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@float"/>
					<xsl:with-param name="defaultValue" select="'Hexadecimal'"/>
				</xsl:call-template>
			</li>
			<xsl:if test="@copybookType = 'COBOL' or not(@copybookType)">
				<li>
					Day/Month Order: 
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="@dayMonth"/>
						<xsl:with-param name="defaultValue" select="'Day/month'"/>
					</xsl:call-template>
				</li>	
				<li>
					Default Date Format: 
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="@dateFormat"/>
						<xsl:with-param name="defaultValue" select="'YYYYXXXX'"/>
					</xsl:call-template>
				</li>
				<li>
					TRUNC(BIN):
					<xsl:choose>
						<xsl:when test="@truncBin = 'true'">true</xsl:when>
						<xsl:otherwise>false</xsl:otherwise>
					</xsl:choose>					
				</li>
				<li>
					Aligment Processing, use v4.1 and earlier:
					<xsl:choose>
						<xsl:when test="@legacyAlign = 'false'">false</xsl:when>
						<xsl:otherwise>true</xsl:otherwise>
					</xsl:choose>					
				</li>
			</xsl:if>
		</xsl:if>
		
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="/" mode="Admin">
		<xsl:if test="/jndi:namedResource/jndi:reference[@type='sp:CredentialSecurityProvider']/@value">
			<li>
				Credentials Provider:
				<xsl:value-of select="/jndi:namedResource/jndi:reference[@type='sp:CredentialSecurityProvider']/@value"/>
			</li>
		</xsl:if>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="/" mode="SSL">
		<xsl:if test="/jndi:namedResource/jndi:reference[@type='sp:IdentitySecurityProvider']/@value">
			<li>
				SSL Client:
				<xsl:value-of select="/jndi:namedResource/jndi:reference[@type='sp:IdentitySecurityProvider']/@value"/>
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



