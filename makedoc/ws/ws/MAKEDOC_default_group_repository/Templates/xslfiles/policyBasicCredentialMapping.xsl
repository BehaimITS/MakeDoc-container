<?xml version="1.0" encoding="utf-8"?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             BEHAIM IT Solutions                              -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : policyBasicCredentialMapping.xsl                           -->
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
	xmlns:jndi="http://xsd.tns.tibco.com/amf/models/sharedresource/jndi" 
	xmlns:CustomFunctions="com.behaim.commons.xsl.CustomFunctions" 
	xmlns:ncname="com.pikeelectronic.xsl.NCName" 
	xmlns:xpdExt="http://www.tibco.com/XPD/xpdExtension1.0.0" 
	xmlns:xpdl2="http://www.wfmc.org/2008/XPDL2.1" 
	xmlns:PrimitiveTypeFacets="http:///schemas/PrimitiveTypeFacets/_8TmTUMtlEdy7K9XeCH7Hrw/0" 
	xmlns:map="xalan://java.util.Map" 
	extension-element-prefixes="map" 
	exclude-result-prefixes="xpdl2 ncname xpdExt java CustomFunctions CustomFunctionsEagle PrimitiveTypeFacets jndi policy">
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

		<concept id="BasicCredentialMappingMain" xml:lang="en-us">
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
							<xsl:value-of select="CustomFunctions:initializeTemplate('policyBasicCredentialMapping.xsl')"/>
						</p>
						<p>
							Section contains description of Policy Basic Credential Mapping "
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

			<concept id="PolicyBasicCredentialMapping">
				<title>Policy Basic Credential Mapping</title>
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
		<li>
			Credential Mapping Type:
			<xsl:value-of select="/policy:Policy/configuration/groups[@paramGroupName='CredentialMapping']/paramSettings[@paramName = 'CredentialMappingType']/@value"/>
		</li>
			<xsl:choose>
				<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='CredentialMapping']/paramSettings[@paramName = 'FixedTypeSelected']/@value">
					<li>Credential Mechanism: Fixed
						<ul>
							<li>
								Identity Provider:
								<xsl:choose>
									<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='IdentityProviderCredentialMapping']/paramSettings[@paramName='IspCredentialMappingDefault']/properties[@propertyName='IdentityProvider']/value/@value">
										<xsl:variable name="identityProvider" select="/policy:Policy/configuration/groups[@paramGroupName='IdentityProviderCredentialMapping']/paramSettings[@paramName='IspCredentialMappingDefault']/properties[@propertyName='IdentityProvider']/value/@value"/>
										<xsl:variable name="identityProviderFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($identityProvider, '.','/'), '.userIdResource.dita')"/>
										<xsl:variable name="identityProviderRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($identityProviderFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
										<xsl:element name="xref">
											<xsl:attribute name="href"><xsl:value-of select="$identityProviderRef"/></xsl:attribute>
											<xsl:value-of select="$identityProvider"/>
										</xsl:element>
									</xsl:when>
									<xsl:otherwise>
										No identity provider chosen.
									</xsl:otherwise>
								</xsl:choose>
							</li>
						</ul>
					</li>
				</xsl:when>
				<xsl:otherwise>
						Credential Mechanism: Conditional	
						<table>
							<tgroup cols="2">
								<thead>
									<row>
										<entry>Role</entry>
										<entry>Identity Provider</entry>
									</row>
								</thead>
								<tbody>
									<xsl:apply-templates select="/policy:Policy/configuration/groups[@paramGroupName='IdentityProviderCredentialMapping']/paramSettings[@paramName='IspCredentialMappingForRoles']/values"/>
								</tbody>
							</tgroup>
						</table>
						<p>
							Authenticated Users ID Provider:
							<xsl:variable name="authProvider" select="/policy:Policy/configuration/groups[@paramGroupName='IdentityProviderCredentialMapping']/paramSettings[@paramName='IspCredentialMappingForAuthenticatedUsers']/properties[@propertyName='IdentityProvider']/value/@value"/>
							<xsl:choose>
								<xsl:when test="$authProvider">
									<xsl:variable name="authProviderFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($authProvider, '.','/'), '.userIdResource.dita')"/>
									<xsl:variable name="authProviderRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($authProviderFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
									<xsl:element name="xref">
										<xsl:attribute name="href"><xsl:value-of select="$authProviderRef"/></xsl:attribute>
										<xsl:value-of select="$authProvider"/>
									</xsl:element>
								</xsl:when>
								<xsl:otherwise>
										No identity provider chosen.
									</xsl:otherwise>
							</xsl:choose>
						</p>
						<p>
							<xsl:variable name="anonProvider" select="/policy:Policy/configuration/groups[@paramGroupName='IdentityProviderCredentialMapping']/paramSettings[@paramName='IspCredentialMappingForAnonymousUsers']/properties[@propertyName='IdentityProvider']/value/@value"/>
							Anonymous Users ID Provider:				
							<xsl:choose>
								<xsl:when test="$anonProvider">
									<xsl:variable name="anonProviderFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($anonProvider, '.','/'), '.userIdResource.dita')"/>
									<xsl:variable name="anonProviderRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($anonProviderFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
									<xsl:element name="xref">
										<xsl:attribute name="href"><xsl:value-of select="$anonProviderRef"/></xsl:attribute>
										<xsl:value-of select="$anonProvider"/>
									</xsl:element>
								</xsl:when>
								<xsl:otherwise>
									No identity provider chosen.
								</xsl:otherwise>
							</xsl:choose>
						</p>
				</xsl:otherwise>
			</xsl:choose>
		<li>
			Credential Mapping By Roles:
			<xsl:choose>
				<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='IdentityProviderCredentialMapping']/paramSettings[@paramName='IspCredentialMappingByRolesSelected']/@value = 'true'">
					<xsl:value-of select="'true'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'false'"/>
				</xsl:otherwise>
			</xsl:choose>
		</li>
	</xsl:template>
	
	<xsl:template match="paramSettings/values">
		<row>
			<entry>
				<xsl:value-of select="./properties[@propertyName='Role']/value/@value"/>
			</entry>		
			<entry>
				<xsl:choose>
					<xsl:when test="./properties[@propertyName='IdentityProvider']/value/@value != ''">
						<xsl:variable name="identityProvider" select="./properties[@propertyName='IdentityProvider']/value/@value"/>
						<xsl:variable name="identityProviderFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($identityProvider, '.','/'), '.userIdResource.dita')"/>
						<xsl:variable name="identityProviderRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($identityProviderFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
						<xsl:element name="xref">
							<xsl:attribute name="href"><xsl:value-of select="$identityProviderRef"/></xsl:attribute>
							<xsl:value-of select="$identityProvider"/>
						</xsl:element>
					</xsl:when>
				</xsl:choose>
			</entry>
		</row>
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



