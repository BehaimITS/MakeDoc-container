<?xml version="1.0" encoding="utf-8"?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             BEHAIM IT Solutions                              -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : sslServer.xsl                                              -->
<!-- originator      : lsatin                                                     -->
<!-- creation date   : 2015/09/02                                                 -->
<!-- description     : XSL template transfers BW XML file of type                 -->
<!--                   .sslClientResource into DITA format.                              -->
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

		<concept id="SSLServerMain" xml:lang="en-us">
			<xsl:variable name="processName" select="substring-before($heading,'.sslServerResource')"/>
		<title>
			<xsl:value-of select="$processName"/>
		</title>
		<titlealts>
			<navtitle>
				<xsl:choose>
					<xsl:when test="$displayPathInTopicName">
              			<xsl:value-of select="substring-before($relativePath,'.sslServerResource')"/>
            		</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$processName"/>
					</xsl:otherwise>
				</xsl:choose>
			</navtitle>
		</titlealts>
					<conbody>
						<p>
							<xsl:value-of select="CustomFunctions:initializeTemplate('sslServer.xsl')"/>
						</p>
						<p>
							Section contains description of SSL Server "
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
		
			<concept id="SSLServerBasic">
			<title>Basic SSL Server configuration</title>
				<conbody>
					<ul>
						<xsl:if test="not(./jndi:reference[@key='identityStoreServiceProvider']/@value)">
							<li>Identity store provider: no identity provider chosen.</li>
							<li>Key alias:</li>
							<li>Key password:</li>
						</xsl:if>
						<xsl:apply-templates select="jndi:configuration" mode="basic"/>
					</ul>
				</conbody>
			</concept>
			<concept id="SSLServerAdvanced">
				<title>Advanced SSL Server configuration</title>
					<conbody>
						<ul>
							<xsl:apply-templates select="jndi:configuration" mode="advanced"/>
						</ul>
					</conbody>
			</concept>
		
		</concept>
	</xsl:template>
	
	<xsl:template match="jndi:configuration" mode="basic">
		<xsl:choose>
			<xsl:when test="../jndi:reference[@key='identityStoreServiceProvider']/@value != ''">
				<li>
					<xsl:choose>
						<xsl:when test="../jndi:reference[@key='identityStoreServiceProvider']/@value">
						Identity store provider:
						<xsl:variable name="identityProvider" select="../jndi:reference[@key='identityStoreServiceProvider']/@value"/>
						<xsl:variable name="identityProviderFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($identityProvider, '.','/'), '.keystoreProviderResource.dita')"/>
						<xsl:variable name="identityProviderRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($identityProviderFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
						<xsl:element name="xref">
							<xsl:attribute name="href"><xsl:value-of select="$identityProviderRef"/></xsl:attribute>
							<xsl:value-of select="$identityProvider"/>
						</xsl:element>
						</xsl:when>
						<xsl:otherwise>
							Identity store provider: No identity provider chosen.
						</xsl:otherwise>
					</xsl:choose>
				</li>
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
			</xsl:when>
		</xsl:choose>
	
		<li>Enable mutual authentication:
		
			<xsl:choose>
				<xsl:when test="@enableMutualAuthentication">
					<xsl:value-of select="@enableMutualAuthentication"/>
				</xsl:when>
				<xsl:otherwise>
					false
				</xsl:otherwise>
			</xsl:choose>
		
			<xsl:if test="@enableMutualAuthentication = 'true'">
				<ul>
					<li>
						Client Auth Type: 
						<xsl:choose>
							<xsl:when test="@clientAuthenticationMode">
								<xsl:value-of select="@clientAuthenticationMode"/>
							</xsl:when>
							<xsl:otherwise>
								None
							</xsl:otherwise>
						</xsl:choose>
					</li>
					<li>
						Keystore Provider as Trust Store:
						<xsl:choose>
							<xsl:when test="../jndi:reference[@key='trustStoreServiceProvider']/@value">
								<xsl:variable name="keystoreProvider" select="../jndi:reference[@key='trustStoreServiceProvider']/@value"/>
								<xsl:variable name="keystoreProviderFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($keystoreProvider, '.','/'), '.keystoreProviderResource.dita')"/>
								<xsl:variable name="keystoreProviderRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($keystoreProviderFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
								<xsl:element name="xref">
									<xsl:attribute name="href"><xsl:value-of select="$keystoreProviderRef"/></xsl:attribute>
									<xsl:value-of select="$keystoreProvider"/>
								</xsl:element>
							</xsl:when>
							<xsl:otherwise>
								Keystore store provider: No keystore provider chosen.
							</xsl:otherwise>	
						</xsl:choose>
					</li>
				</ul>
			</xsl:if>
		</li>	
	
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="jndi:configuration" mode="advanced">
		
		<li>SSL Security Provider:
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@sslProvider"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='sslProvider']/@propName"/>
				<xsl:with-param name="defaultValue" select="''"/>
			</xsl:call-template>
		</li>
		<li>SSL Protocol:
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@sslProtocol"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='sslProtocol']/@propName"/>
				<xsl:with-param name="defaultValue" select="'TLSv1'"/>
			</xsl:call-template>
		</li>
		<li>SSL Cipher Class:
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@sslCipherStrength"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='sslCipherStrength']/@propName"/>
				<xsl:with-param name="defaultValue" select="'At Least 128 Bit'"/>
			</xsl:call-template>
		</li>
		<li>Verify Remote Host: 
			<xsl:choose>
				<xsl:when test="@verifyRemoteHostName">
					<xsl:value-of select="@verifyRemoteHostName"/>
				</xsl:when>
				<xsl:otherwise>
					false
				</xsl:otherwise>
			</xsl:choose>
			
			<xsl:if test="@verifyRemoteHostName='true'">
				<ul>
				<li>Expected Remote Hostname:
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="@expectedRemoteHostName"/>
						<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='expectedRemoteHostName']/@propName"/>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template>
				</li>
				</ul>
			</xsl:if>
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



