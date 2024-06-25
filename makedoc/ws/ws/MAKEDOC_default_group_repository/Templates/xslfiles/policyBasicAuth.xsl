<?xml version="1.0" encoding="utf-8"?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             BEHAIM IT Solutions                              -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : policyBasicAuth.xsl                                        -->
<!-- originator      : lsatin                                                     -->
<!-- creation date   : 2016/03/07                                                 -->
<!-- description     : XSL template transfers BW XML file of type                 -->
<!--                   .keystoreProviderResource into DITA format.                -->
<!-- ============================================================================ -->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:java="http://xml.apache.org/xalan/java"
	xmlns:policy="http://tns.tibco.com/bw/model/core/policy" 
	xmlns:CustomFunctionsEagle="com.behaim.commons.eagle.CustomFunctions" 
	xmlns:CustomFunctions="com.behaim.commons.xsl.CustomFunctions" 
	xmlns:ncname="com.pikeelectronic.xsl.NCName" 
	xmlns:xpdExt="http://www.tibco.com/XPD/xpdExtension1.0.0" 
	xmlns:xpdl2="http://www.wfmc.org/2008/XPDL2.1" 
	xmlns:PrimitiveTypeFacets="http:///schemas/PrimitiveTypeFacets/_8TmTUMtlEdy7K9XeCH7Hrw/0" 
	xmlns:map="xalan://java.util.Map" 
	extension-element-prefixes="map" 
	exclude-result-prefixes="xpdl2 ncname xpdExt java CustomFunctions CustomFunctionsEagle PrimitiveTypeFacets policy">
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
	<xsl:template match="/policy:Policy">
<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE concept PUBLIC "-//OASIS//DTD DITA Concept//EN" "]]></xsl:text><xsl:value-of select="concat($mdcfg,'/dtd','/concept.dtd')"/><xsl:text disable-output-escaping="yes">"></xsl:text>  

		<concept id="PolicyBasicAuthenticationMain" xml:lang="en-us">
			<xsl:variable name="policyName" select="substring-before($heading,'.policy')"/>
			<title>
				<xsl:value-of select="$policyName"/>
			</title>
			<titlealts>
				<navtitle>				
					<xsl:choose>
						<xsl:when test="$displayPathInTopicName">
							<xsl:value-of select="substring-before($relativePath,'.policy')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$policyName"/>
						</xsl:otherwise>
				</xsl:choose>
				</navtitle>
			</titlealts>
					<conbody>
						<p>
							<xsl:value-of select="CustomFunctions:initializeTemplate('policyBasicAuth.xsl')"/>
						</p>
						<p>
							Section contains description of Policy Basic Authentication "
							<xsl:value-of select="$heading"/>
							" .
						</p>
						<xsl:if test="@description != ''">
							<p>
								Description:
								<xsl:value-of select="@description"/>
							</p>
						</xsl:if>
					</conbody>
		
			<concept id="PolicyBasicAuthentication">
				<title>Policy Basic Authentication</title>
		<conbody>
			<ul>
				<xsl:apply-templates select="configuration"></xsl:apply-templates>
			</ul>
		</conbody>
		</concept>
		</concept>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="configuration">
		Service provider to perform username/password authentication
		<ul>
		<li>
			Login Module Type:
			<xsl:value-of select="./groups/paramSettings[@paramName='loginModuleType']/@value"/>
		</li>
		<li>
			Security Token:
			<xsl:value-of select="./groups/paramSettings[@paramName='SecurityToken']/@value"/>
		</li>
		<li>
			Identity Provider:
			<xsl:variable name="ldapResource" select="./groups/paramSettings[@paramName='Asp' and @resourceType = 'TIBCOSecurityServerAgent:LdapAuthNResource']" />
			<xsl:variable name="xmlAuthResource" select="./groups/paramSettings[@paramName='Asp' and @resourceType = 'TIBCOSecurityServerAgent:XmlAuthNResource']" />
			<ul><li>
			<xsl:choose>
				<xsl:when test="./groups/paramSettings[@paramName='Asp' and @resourceType = 'TIBCOSecurityServerAgent:LdapAuthNResource']">
				
					LDAP Resource
					<xsl:variable name="ldapResourceValue" select="$ldapResource/@value"/>
					<xsl:variable name="ldapResourceFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($ldapResourceValue, '.','/'), '.ldapResource.dita')"/>
					<xsl:variable name="ldapResourceRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($ldapResourceFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
					<xsl:element name="xref">
						<xsl:attribute name="href"><xsl:value-of select="$ldapResourceRef"/></xsl:attribute>
						<xsl:value-of select="$ldapResourceValue"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="./groups/paramSettings[@paramName='Asp' and @resourceType = 'TIBCOSecurityServerAgent:XmlAuthNResource']">
					XML File Resource
					<xsl:variable name="xmlAuthResourceValue" select="$xmlAuthResource/@value"/>
					<xsl:variable name="xmlAuthResourceFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($xmlAuthResourceValue, '.','/'), '.authxml.dita')"/>
					<xsl:variable name="xmlAuthResourceRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($xmlAuthResourceFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
					<xsl:element name="xref">
						<xsl:attribute name="href"><xsl:value-of select="$xmlAuthResourceRef"/></xsl:attribute>
						<xsl:value-of select="$xmlAuthResourceValue"/>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise>
					No resource chosen.
				</xsl:otherwise>
			</xsl:choose>
			</li></ul>
		</li>
		</ul>
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



