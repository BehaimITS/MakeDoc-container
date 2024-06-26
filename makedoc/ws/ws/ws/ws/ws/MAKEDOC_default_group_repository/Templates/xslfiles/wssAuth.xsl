<?xml version="1.0" encoding="utf-8"?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             BEHAIM IT Solutions                              -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : wssAuth.xsl                                             -->
<!-- originator      : lsatin                                                     -->
<!-- creation date   : 2015/09/02                                                 -->
<!-- description     : XSL template transfers BW XML file of type                 -->
<!--                   .wssAuthenticationResource into DITA format.                              -->
<!-- ============================================================================ -->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:java="http://xml.apache.org/xalan/java" 
	xmlns:CustomFunctions="com.behaim.commons.xsl.CustomFunctions" 
	xmlns:CustomFunctionsEagle="com.behaim.commons.eagle.CustomFunctions" 
	xmlns:str="http://exslt.org/strings"
	xmlns:jndi="http://xsd.tns.tibco.com/amf/models/sharedresource/jndi" 
	xmlns:ncname="com.pikeelectronic.xsl.NCName" 
	xmlns:map="xalan://java.util.Map" 
	extension-element-prefixes="map" 
	exclude-result-prefixes="ncname java CustomFunctions CustomFunctionsEagle jndi str">
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

		<concept id="WSSAuthenticationMain" xml:lang="en-us">
			<xsl:variable name="processName" select="substring-before($heading,'.wssResource')"/>
		<title>
			<xsl:value-of select="$processName"/>
		</title>
		<titlealts>
			<navtitle>
				<xsl:choose>
					<xsl:when test="$displayPathInTopicName">
              			<xsl:value-of select="substring-before($relativePath,'.wssResource')"/>
            		</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$processName"/>
					</xsl:otherwise>
				</xsl:choose>
			</navtitle>
		</titlealts>
					<conbody>
						<p>
							<xsl:value-of select="CustomFunctions:initializeTemplate('wssAuth.xsl')"/>
						</p>
						<p>
							Section contains description of WSS Authentication "
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
		
		<concept id="WSSAuth">
		<title>WSS Authentication</title>
		<conbody>
			<ul>	
				<li>
					Security Token:
					<xsl:choose>
						<xsl:when test="jndi:configuration/@securityToken">
							<xsl:value-of select="jndi:configuration/@securityToken"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'X.509'"/>
						</xsl:otherwise>
					</xsl:choose>
				</li>
				<xsl:choose>
					<xsl:when test="jndi:reference[@key='signatureValidationService']/@value != ''">
						<xsl:choose>
						
							<xsl:when test="jndi:reference[@type='trust:TrustConfiguration']">
								<li>Enable Signature Verification: true</li>
								<li>Enable Decryption: false</li>
								<li>Trust Provider:
									<xsl:variable name="trustResource" select="jndi:reference[@key='signatureValidationService']/@value"/>
									<xsl:variable name="trustResourceFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level),$resourcesFolder, translate($trustResource, '.','/'), '.trustResource.dita')"/>
									<xsl:variable name="trustResourceRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($trustResourceFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
									<xsl:element name="xref">
										<xsl:attribute name="href"><xsl:value-of select="$trustResourceRef"/></xsl:attribute>
										<xsl:value-of select="$trustResource"/>
									</xsl:element>
								</li>
							</xsl:when>
							
							<xsl:when test="jndi:reference[@type='mip:MIPConfiguration']">
								<li>Enable Decryption: true</li>
								<li>Trust Provider:
								
								<xsl:variable name="sipResource" select="jndi:reference[@key='signatureValidationService']/@value"/>
								<xsl:variable name="sipResourceFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level),$resourcesFolder, translate($sipResource, '.','/'), '.sipResource.dita')"/>
								<xsl:variable name="sipResourceRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($sipResourceFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
								<xsl:element name="xref">
									<xsl:attribute name="href"><xsl:value-of select="$sipResourceRef"/></xsl:attribute>
									<xsl:value-of select="$sipResource"/>
								</xsl:element>
								</li>
							</xsl:when>							
						</xsl:choose>								
					</xsl:when>
					<xsl:otherwise>						
					</xsl:otherwise>
				</xsl:choose>
				
				<xsl:choose>
					<xsl:when test="jndi:reference[@type='ldapauth:LDAPConfiguration']/@value != ''">
						<li>Type Of Authentication: LDAP Authentication</li>
						<li>LDAP Resource:
						
						<xsl:variable name="ldapResource" select="jndi:reference[@type='ldapauth:LDAPConfiguration']/@value"/>
						<xsl:variable name="ldapResourceFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($ldapResource, '.','/'), '.ldapResource.dita')"/>
						<xsl:variable name="ldapResourceRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($ldapResourceFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
						<xsl:element name="xref">
							<xsl:attribute name="href">
								<xsl:value-of select="$ldapResourceRef"/>
							</xsl:attribute>
							<xsl:value-of select="$ldapResource"/>
						</xsl:element>
						</li>
					</xsl:when>
					<xsl:when test="jndi:reference[@type='authxml:XMLConfiguration']/@value != ''">
						<li>Type Of Authentication: XML File Authentication</li>
						<li>XML File Resource:
							<xsl:variable name="authResource" select="jndi:reference[@type='authxml:XMLConfiguration']/@value"/>
							<xsl:variable name="authResourceFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($authResource, '.','/'), '.authxml.dita')"/>
							<xsl:element name="xref">
								<xsl:attribute name="href"><xsl:value-of select="$authResourceFile"/></xsl:attribute>
								<xsl:value-of select="$authResource"/>
							</xsl:element>
						</li>
					</xsl:when>
				</xsl:choose>	
			</ul>
		</conbody>
		</concept>
		</concept>
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



