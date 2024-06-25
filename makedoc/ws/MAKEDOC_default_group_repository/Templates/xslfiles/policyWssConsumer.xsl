<?xml version="1.0" encoding="utf-8"?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             BEHAIM IT Solutions                              -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : policyWssConsumer.xsl                                      -->
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

		<concept id="WssConsumerMain" xml:lang="en-us">
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
					<xsl:value-of select="CustomFunctions:initializeTemplate('policyWssConsumer.xsl')"/>
				</p>
				<p>
					Section contains description of Policy Wss Consumer "
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
		
			<concept id="PolicyWssConsumer">
				<title>Wss Consumer Policy</title>
				<conbody>
					<ul>
						<xsl:apply-templates select="configuration" mode="basic"></xsl:apply-templates>
					</ul>
				</conbody>
			</concept>
			<concept id="PolicyWssConsumerConfidentality">
				<title>Confidentality</title>
				<conbody>
					<ul>
						<xsl:apply-templates select="configuration" mode="confidentality"></xsl:apply-templates>
					</ul>
				</conbody>
			</concept>
			<concept id="PolicyWssConsumerIntegrity">
				<title>Integrity</title>
				<conbody>
					<ul>
						<xsl:apply-templates select="configuration" mode="integrity"></xsl:apply-templates>
					</ul>
				</conbody>
			</concept>
			<concept id="PolicyWssConsumerTimestamp">
				<title>Timestamp</title>
				<conbody>
					<ul>
						<xsl:apply-templates select="configuration" mode="timestamp"></xsl:apply-templates>
					</ul>
				</conbody>
			</concept>
			<concept id="PolicyWssConsumerCredentials">
				<title>Credential Mapping</title>
				<conbody>
					<ul>
						<xsl:apply-templates select="configuration" mode="credentials"></xsl:apply-templates>
					</ul>
				</conbody>
			</concept>
		</concept>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="configuration" mode="basic">
		<li>
			The shared resource facilitating processing of WS-Security header from the request message:
			<xsl:choose>
				<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='WssProcessor']">
					<xsl:variable name="wssAuthProvider" select="/policy:Policy/configuration/groups[@paramGroupName='WssProcessor']/paramSettings[@paramName='WssAsp']/@value"/>
					<xsl:variable name="wssAuthProviderFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($wssAuthProvider, '.','/'), '.wssResource.dita')"/>
					<xsl:variable name="wssAuthProviderRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($wssAuthProviderFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
					<xsl:element name="xref">
						<xsl:attribute name="href"><xsl:value-of select="$wssAuthProviderRef"/></xsl:attribute>
						<xsl:value-of select="$wssAuthProvider"/>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise>
					No WSS authentication chosen.
				</xsl:otherwise>	
			</xsl:choose>
		</li>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="configuration" mode="credentials">
		<li>
			Settings to attach credentials to the onbound request.
		<ul>
			<xsl:choose>
				<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='CredentialMapping']">					
					<xsl:choose>
						<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='CredentialMapping']/paramSettings[@paramName = 'CredentialMappingType']/@value = 'IdentityProvider'">
							<li>Username token based Credential Mapping
							<xsl:choose>
								<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='CredentialMapping']/paramSettings[@paramName = 'FixedTypeSelected']/@value = 'true'">
									<ul>
										<li>
											Credential mechanism: Fixed. Identity Provider:
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
												<xsl:otherwise>No identity provider chosen.</xsl:otherwise>
											</xsl:choose>
										</li>
									</ul>
								</xsl:when>
								<xsl:otherwise>
									<ul>
										<li>
											Credential mechanism: Conditional
											<table>
												<tgroup cols="2">
												<thead>
													<row>
														<entry>
															Role
														</entry>
														<entry>
															Identity Provider
														</entry>
													</row>
												</thead>
												<tbody>
													<xsl:apply-templates select="/policy:Policy/configuration/groups[@paramGroupName='IdentityProviderCredentialMapping']/paramSettings/values" mode="credential_mapping"></xsl:apply-templates>
												</tbody>
												</tgroup>
											</table>
											
											<p>
												
												Authenticated Identity Provider: 
												
												<xsl:choose>
													<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='IdentityProviderCredentialMapping']/paramSettings[@paramName='IspCredentialMappingForAuthenticatedUsers']/properties/value/@value">
														<xsl:variable name="identityProvider" select="/policy:Policy/configuration/groups[@paramGroupName='IdentityProviderCredentialMapping']/paramSettings[@paramName='IspCredentialMappingForAuthenticatedUsers']/properties/value/@value"/>
														<xsl:variable name="identityProviderFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($identityProvider, '.','/'), '.userIdResource.dita')"/>
														<xsl:variable name="identityProviderRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($identityProviderFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
														<xsl:element name="xref">
															<xsl:attribute name="href"><xsl:value-of select="$identityProviderRef"/></xsl:attribute>
															<xsl:value-of select="$identityProvider"/>
														</xsl:element>
													</xsl:when>
													<xsl:otherwise>No authenticated identity provider chosen.</xsl:otherwise>
												</xsl:choose>
												
											</p>
											<p>
												
												Anonymous Identity Provider: 
												
												<xsl:choose>
													<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='IdentityProviderCredentialMapping']/paramSettings[@paramName='IspCredentialMappingForAnonymousUsers']/properties/value/@value">
														<xsl:variable name="identityProvider" select="/policy:Policy/configuration/groups[@paramGroupName='IdentityProviderCredentialMapping']/paramSettings[@paramName='IspCredentialMappingForAnonymousUsers']/properties/value/@value"/>
														<xsl:variable name="identityProviderFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($identityProvider, '.','/'), '.userIdResource.dita')"/>
														<xsl:variable name="identityProviderRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($identityProviderFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
														<xsl:element name="xref">
															<xsl:attribute name="href"><xsl:value-of select="$identityProviderRef"/></xsl:attribute>
															<xsl:value-of select="$identityProvider"/>
														</xsl:element>
													</xsl:when>
													<xsl:otherwise>No anonymous identity provider chosen.</xsl:otherwise>
												</xsl:choose>
												
											</p>											
										</li>
									</ul>
								</xsl:otherwise>						
							</xsl:choose>
						</li>
						</xsl:when>
						<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='CredentialMapping']/paramSettings[@paramName='CredentialMappingType']/@value = 'SAML'">
							<li>
								Saml Token Profile:
								<xsl:value-of select="/policy:Policy/configuration/groups[@paramGroupName='SAMLTokenCredentialMapping']/paramSettings[@paramName='SamlTokenProfile']/@value"/>
							</li>
							<li>
								<xsl:choose>
									<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='SAMLTokenCredentialMapping']/paramSettings[@paramName='SignAssertionSelected']/@value">
										Sign SAML Assertion: true
										<ul>	
											<li>
												Subject Provider:
												<xsl:choose>
													<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='SAMLTokenCredentialMapping']/paramSettings[@paramName='IdentityProvider']/@value">
														<xsl:variable name="subjectProvider" select="/policy:Policy/configuration/groups[@paramGroupName='SAMLTokenCredentialMapping']/paramSettings[@paramName='IdentityProvider']/@value"/>
															<xsl:variable name="subjectProviderFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($subjectProvider, '.','/'), '.sipResource.dita')"/>
															<xsl:variable name="subjectProviderRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($subjectProviderFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
															<xsl:element name="xref">
																<xsl:attribute name="href"><xsl:value-of select="$subjectProviderRef"/></xsl:attribute>
																<xsl:value-of select="$subjectProvider"/>
														</xsl:element>
													</xsl:when>
													<xsl:otherwise>
														No subject provider chosen.
													</xsl:otherwise>
												</xsl:choose>
											</li>
											<li>
												Sign Algorithm Suite:
												<xsl:value-of select="/policy:Policy/configuration/groups[@paramGroupName='SAMLTokenCredentialMapping']/paramSettings[@paramName='SignAlgorithmSuite']/@value"/>
											</li>
											<li>
												Digest Algorithm:
												<xsl:value-of select="/policy:Policy/configuration/groups[@paramGroupName='SAMLTokenCredentialMapping']/paramSettings[@paramName='DigestAlgorithm']/@value"/>
											</li>											
										</ul>									
									</xsl:when>
									<xsl:otherwise>
										Sign SAML Assertion: false
									</xsl:otherwise>
								</xsl:choose>
							</li>
							<li>
								SAML Issuer Name:
								<xsl:call-template name="getValueFromLiteralModule">
									<xsl:with-param name="valueLiteral" select="/policy:Policy/configuration/groups[@paramGroupName='SAMLTokenCredentialMapping']/paramSettings[@paramName='IssuerName']/@value"/>
									<xsl:with-param name="valueModuleProp" select="/policy:Policy/configuration/groups[@paramGroupName='SAMLTokenCredentialMapping']/paramSettings[@paramName='IssuerName']/subVarRefs/@name"/>
									<xsl:with-param name="defaultValue" select="''"/>
								</xsl:call-template>
							</li>
							<li>
								SAML Assertion Validity:
								<xsl:call-template name="getValueFromLiteralModule">
									<xsl:with-param name="valueLiteral" select="/policy:Policy/configuration/groups[@paramGroupName='SAMLTokenCredentialMapping']/paramSettings[@paramName='ValidPeriod']/@value"/>
									<xsl:with-param name="valueModuleProp" select="/policy:Policy/configuration/groups[@paramGroupName='SAMLTokenCredentialMapping']/paramSettings[@paramName='ValidPeriod']/subVarRefs/@name"/>
									<xsl:with-param name="defaultValue" select="'SAML Assertion validity (forever)'"/>
								</xsl:call-template>
							</li>						
						</xsl:when>	
					</xsl:choose>
				</xsl:when>				
				<xsl:otherwise>
					<li>No credentials</li>
				</xsl:otherwise>
			</xsl:choose>
			</ul>
		</li>
		<xsl:if test="/policy:Policy/configuration/groups[@paramGroupName='CredentialMapping']/paramSettings[@paramName = 'CredentialMappingType']/@value = 'IdentityProvider'">
		<xsl:choose>
			<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='CredentialMapping']/paramSettings[@paramName = 'FixedTypeSelected']/@value">
				<li>
					Credential Mechanism: Fixed
				</li>
				<li>
					ISP Refresh Interval:
					<xsl:value-of select="/policy:Policy/configuration/groups[@paramGroupName='IdentityProviderCredentialMapping']/paramSettings[@paramName='IspCredentialMappingDefault']/properties[@propertyName='IspRefreshInterval']/value/@value"/>
				</li>
				<li>
					Identity Provider:
					<xsl:value-of select="/policy:Policy/configuration/groups[@paramGroupName='IdentityProviderCredentialMapping']/paramSettings[@paramName='IspCredentialMappingDefault']/properties[@propertyName='IdentityProvider']/value/@value"/>
				</li>
			</xsl:when>
			<xsl:otherwise>
				<li>
					Credential Mechanism: Conditional
				</li>
				<li>		
					<table>
						<tgroup cols="2">
							<colspec colname="role" colwidth="175*"/>
							<colspec colname="isp" colwidth="75*"/>
							<thead>
								<row>
									<entry colname="role" valign="top">Role</entry>
									<entry colname="isp" valign="top">Identity Provider</entry>
								</row>
							</thead>
							
							<tbody>
								<xsl:for-each select="/policy:Policy/configuration/groups[@paramGroupName='IdentityProviderCredentialMapping']/paramSettings[@paramName='IspCredentialMappingForRoles']/values">
									<row>
										<entry><xsl:value-of select="./properties[@propertyName='Role']/value/@value"/></entry>
										<entry><xsl:value-of select="./properties[@propertyName='IdentityProvider']/value/@value"/></entry>
									</row>
								</xsl:for-each>
							</tbody>
						</tgroup>
					</table>
				</li>
				<li>
					Authenticated Users ID Provider:
					<xsl:value-of select="/policy:Policy/configuration/groups[@paramGroupName='IdentityProviderCredentialMapping']/paramSettings[@paramName='IspCredentialMappingForAuthenticatedUsers']/properties[@propertyName='IdentityProvider']/value/@value"/>
				</li>
				<li>
					Anonymous Users ID Provider:
					<xsl:value-of select="/policy:Policy/configuration/groups[@paramGroupName='IdentityProviderCredentialMapping']/paramSettings[@paramName='IspCredentialMappingForAnonymousUsers']/properties[@propertyName='IdentityProvider']/value/@value"/>
				</li>
			</xsl:otherwise>
		</xsl:choose>
		</xsl:if>
		<xsl:if test="/policy:Policy/configuration/groups[@paramGroupName='CredentialMapping']/paramSettings[@paramName = 'CredentialMappingType']/@value = 'SAML'">
			<li>
				Saml Token Profile:
				<xsl:value-of select="/policy:Policy/configuration/groups[@paramGroupName='SAMLTokenCredentialMapping']/paramSettings[@paramName='SamlTokenProfile']/@value"/>
			</li>
			<li>
				Assertion Validity:
				<xsl:value-of select="/policy:Policy/configuration/groups[@paramGroupName='SAMLTokenCredentialMapping']/paramSettings[@paramName='AssertionValidity']/@value"/>
			</li>
			<li>
				Issuer Name:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="/policy:Policy/configuration/groups[@paramGroupName='SAMLTokenCredentialMapping']/paramSettings[@paramName='IssuerName']/@value"/>
					<xsl:with-param name="valueModuleProp" select="/policy:Policy/configuration/groups[@paramGroupName='SAMLTokenCredentialMapping']/paramSettings[@paramName='IssuerName']/subVarRefs/@name"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template>
			</li>
			<li>
				Valid Period:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="/policy:Policy/configuration/groups[@paramGroupName='SAMLTokenCredentialMapping']/paramSettings[@paramName='ValidPeriod']/@value"/>
					<xsl:with-param name="valueModuleProp" select="/policy:Policy/configuration/groups[@paramGroupName='SAMLTokenCredentialMapping']/paramSettings[@paramName='ValidPeriod']/subVarRefs/@name"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template>
			</li>
			<li>
				Subject Provider:
				<xsl:value-of select="/policy:Policy/configuration/groups[@paramGroupName='SAMLTokenCredentialMapping']/paramSettings[@paramName='IdentityProvider']/@value"/>
			</li>
			<li>
				Sign Algorithm Suite:
				<xsl:value-of select="/policy:Policy/configuration/groups[@paramGroupName='SAMLTokenCredentialMapping']/paramSettings[@paramName='SignAlgorithmSuite']/@value"/>
			</li>
			<li>
				Digest Algorithm:
				<xsl:value-of select="/policy:Policy/configuration/groups[@paramGroupName='SAMLTokenCredentialMapping']/paramSettings[@paramName='DigestAlgorithm']/@value"/>
			</li>
		</xsl:if>
	
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="configuration" mode="timestamp">
		<li>
			Set Request Timestamp:
			<xsl:choose>
				<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='Timestamp']/paramSettings[@paramName='SetRequestTimestampSelected']/@value = 'true'">
					<xsl:value-of select="'true'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'false'"/>
				</xsl:otherwise>
			</xsl:choose>
		</li>
		<li>
			Time To Live:
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="/policy:Policy/configuration/groups[@paramGroupName='Timestamp']/paramSettings[@paramName='TimeToLive']/@value"/>
				<xsl:with-param name="valueModuleProp" select="/policy:Policy/configuration/groups[@paramGroupName='Timestamp']/paramSettings[@paramName='TimeToLive']/subVarRefs/@name"/>
				<xsl:with-param name="defaultValue" select="''"/>
			</xsl:call-template>
		</li>
		<li>
			Verify Timestamp:
			<xsl:choose>
				<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='Timestamp']/paramSettings[@paramName='VerifyTimestamp']/@value = 'true'">
					<xsl:value-of select="'true'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'false'"/>
				</xsl:otherwise>
			</xsl:choose>
		</li>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="configuration" mode="integrity">
		<li>
		Integrity settings which verifies signature on response and sign setting
		<ul>
			<li>
				Sign Request:
			<xsl:choose>
				<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='Integrity']/paramSettings[@paramName='SignRequestSelected']/@value = 'true'">
					<xsl:value-of select="'true'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'false'"/>
				</xsl:otherwise>
			</xsl:choose>
		</li>
		<li>
			Sign Header:
			<xsl:choose>
				<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='Integrity']/paramSettings[@paramName='SignHeaderSelected']/@value = 'true'">
					<xsl:value-of select="'true'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'false'"/>
				</xsl:otherwise>
			</xsl:choose>
		</li>
		<li>
			Sign Body:
			<xsl:choose>
				<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='Integrity']/paramSettings[@paramName='SignBodySelected']/@value = 'true'">
					<xsl:value-of select="'true'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'false'"/>
				</xsl:otherwise>
			</xsl:choose>
			</li>
					<li>
						Subject Provider:
						<xsl:choose>
							<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='Integrity']/paramSettings[@paramName='SubjectIsp']/@value">
								<xsl:variable name="subjectProvider" select="/policy:Policy/configuration/groups[@paramGroupName='Integrity']/paramSettings[@paramName='SubjectIsp']/@value"/>
								<xsl:variable name="subjectProviderFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($subjectProvider, '.','/'), '.sipResource.dita')"/>
								<xsl:variable name="subjectProviderRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($subjectProviderFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
								<xsl:element name="xref">
									<xsl:attribute name="href"><xsl:value-of select="$subjectProviderRef"/></xsl:attribute>
									<xsl:value-of select="$subjectProvider"/>
								</xsl:element>
							</xsl:when>
							<xsl:otherwise>
								No subject provider chosen.
							</xsl:otherwise>
						</xsl:choose>
					</li>
					<li>
						Sign Algorithm Suite:
						<xsl:value-of select="/policy:Policy/configuration/groups[@paramGroupName='Integrity']/paramSettings[@paramName='SignAlgorithmSuite']/@value"/>
					</li>
					<li>
						Digest Algorithm:
						<xsl:value-of select="/policy:Policy/configuration/groups[@paramGroupName='Integrity']/paramSettings[@paramName='DigestAlgorithm']/@value"/>
					</li>
					<li>
						<xsl:if test="/policy:Policy/configuration/groups[@paramGroupName='Integrity']/paramSettings[@paramName='SignSetting']/@value = 'SignParts'">
							Sign parts: 
							<ul>
								<xsl:if test="/policy:Policy/configuration/groups[@paramGroupName='Integrity']/paramSettings[@paramName='SignHeaderSelected']/@value = 'true'">
									<li>Header</li>
								</xsl:if>
								<xsl:if test="/policy:Policy/configuration/groups[@paramGroupName='Integrity']/paramSettings[@paramName='SignBodySelected']/@value = 'true'">
									<li>Body</li>
								</xsl:if>
							</ul>
						</xsl:if>
						<xsl:if test="/policy:Policy/configuration/groups[@paramGroupName='Integrity']/paramSettings[@paramName='SignSetting']/@value = 'SignElements'">
							Sign Elements:
							<table>
							<tgroup cols="2">
							<thead>
								<row>
									<entry>
										Namespace
									</entry>
									<entry>
										Prefix
									</entry>
									<entry>
										Element name
									</entry>
								</row>
							</thead>
							<tbody>
								<xsl:apply-templates select="/policy:Policy/configuration/groups[@paramGroupName='Integrity']/paramSettings/values" mode="integrity_confidentiality"/>
							</tbody>
							</tgroup>
						</table>
						</xsl:if>
					</li>
					</ul>
			</li>
			<li>
				<xsl:choose>
					<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='Integrity']/paramSettings[@paramName='VerifySignatureSelected']/@value">
						Verify signature on response: true
						<ul>
							<li>Verify parts that are signed: 
							
							<xsl:choose>
								<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='Integrity']/paramSettings[@paramName='VerifySignatureScope']/@value = 'Envelope'">
									Entire message
								</xsl:when>	
								<xsl:otherwise>
									Message <xsl:value-of select="/policy:Policy/configuration/groups[@paramGroupName='Integrity']/paramSettings[@paramName='VerifySignatureScope']/@value" />
								</xsl:otherwise>						
							</xsl:choose>
							</li>
						</ul>
					</xsl:when>
					<xsl:otherwise>
						Verify signature on response: false
					</xsl:otherwise>
				</xsl:choose>
			</li>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="configuration" mode="confidentality">
		<li>
		Confidentiality settings which sets up decryption on request and encryption on response
		<ul>
		<xsl:choose>
			<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='Confidentiality']/paramSettings[@paramName='EncryptRequestSelected']/@value">
						<li>
							Encrypt request: true
						<ul>
							<li>
								Trust Provider:
								<xsl:choose>
									<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='Confidentiality']/paramSettings[@paramName='TrustIsp']/@value">
										<xsl:variable name="trustProvider" select="/policy:Policy/configuration/groups[@paramGroupName='Confidentiality']/paramSettings[@paramName='TrustIsp']/@value"/>
										<xsl:variable name="trustProviderFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($trustProvider, '.','/'), '.trustResource.dita')"/>
										<xsl:variable name="trustProviderRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($trustProviderFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
										<xsl:element name="xref">
											<xsl:attribute name="href"><xsl:value-of select="$trustProviderRef"/></xsl:attribute>
											<xsl:value-of select="$trustProvider"/>
										</xsl:element>
									</xsl:when>
									<xsl:otherwise>
										No trust provider chosen.
									</xsl:otherwise>
								</xsl:choose>
							</li>
							<li>
								Key Alias:
								<xsl:call-template name="getValueFromLiteralModule">
									<xsl:with-param name="valueLiteral" select="/policy:Policy/configuration/groups[@paramGroupName='Confidentiality']/paramSettings[@paramName='KeyAlias']/@value"/>
									<xsl:with-param name="valueModuleProp" select="/policy:Policy/configuration/groups[@paramGroupName='Confidentiality']/paramSettings[@paramName='KeyAlias']/subVarRefs/@name"/>
									<xsl:with-param name="defaultValue" select="''"/>
								</xsl:call-template>
							</li>
							<li>
								Encrypt Algorithm Suite:
								<xsl:value-of select="/policy:Policy/configuration/groups[@paramGroupName='Confidentiality']/paramSettings[@paramName='EncryptAlgorithmSuite']/@value"/>
							</li>

							<li>
								Encrypt Request Selected:
								<xsl:choose>
									<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='Confidentiality']/paramSettings[@paramName='EncryptRequestSelected']/@value = 'true'">
										<xsl:value-of select="'true'"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="'false'"/>
									</xsl:otherwise>
								</xsl:choose>
							</li>
							<li>
								Encryption Algorithm:

							</li>
		<li>
			Encrypt Header:
			<xsl:choose>
				<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='Confidentiality']/paramSettings[@paramName='EncryptHeaderSelected']/@value = 'true'">
					<xsl:value-of select="'true'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'false'"/>
				</xsl:otherwise>
			</xsl:choose>
		</li>
							<li>
								<xsl:if test="/policy:Policy/configuration/groups[@paramGroupName='Confidentiality']/paramSettings[@paramName='EncryptSetting']/@value = 'EncryptParts'">
									Encrypt parts: 
									<ul>
										<xsl:if test="/policy:Policy/configuration/groups[@paramGroupName='Confidentiality']/paramSettings[@paramName='EncryptHeaderSelected']/@value = 'true'">
											<li>Header</li>
										</xsl:if>
										<xsl:if test="/policy:Policy/configuration/groups[@paramGroupName='Confidentiality']/paramSettings[@paramName='EncryptBodySelected']/@value = 'true'">
											<li>Body</li>
										</xsl:if>
									</ul>
								</xsl:if>
								<xsl:if test="/policy:Policy/configuration/groups[@paramGroupName='Confidentiality']/paramSettings[@paramName='EncryptSetting']/@value = 'EncryptElements'">
									Encrypt Elements:
									<table>
										<tgroup cols="2">
										<thead>
											<row>
												<entry>
													Namespace
												</entry>
												<entry>
													Prefix
												</entry>
												<entry>
													Element name
												</entry>
											</row>
										</thead>
										<tbody>
											<xsl:apply-templates select="/policy:Policy/configuration/groups[@paramGroupName='Confidentiality']/paramSettings/values" mode="integrity_confidentiality"/>
										</tbody>
										</tgroup>
									</table>
								</xsl:if>
							</li>			
						</ul>
					</li>					
			</xsl:when>
			<xsl:otherwise>
				<li>Encrypt request: false</li>
			</xsl:otherwise>
			</xsl:choose>
		<li>
			Encrypt Body:
			<xsl:choose>
				<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='Confidentiality']/paramSettings[@paramName='EncryptBodySelected']/@value = 'true'">
					<xsl:value-of select="'true'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'false'"/>
				</xsl:otherwise>
			</xsl:choose>
		</li>
		<li>
			Verify Decryption (Decrypt Response):
			<xsl:choose>
				<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='Confidentiality']/paramSettings[@paramName='VerifyDecryption']/@value = 'true'">
					<xsl:value-of select="'true'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'false'"/>
				</xsl:otherwise>
			</xsl:choose>
		</li>
		</ul>
		</li>
	</xsl:template>
	
	<xsl:template match="paramSettings/values" mode="integrity_confidentiality">
		<row>
			<entry>
				<xsl:value-of select="./properties[@propertyName='NamespaceUri']/value/@value"/>
			</entry>		
			<entry>
				<xsl:value-of select="./properties[@propertyName='NamespacePrefix']/value/@value"/>
			</entry>
			<entry>
				<xsl:value-of select="./properties[@propertyName='ElementName']/value/@value"/>
			</entry>
		</row>
	</xsl:template>
	
	<xsl:template match="paramSettings/values" mode="credential_mapping">
		<row>
			<entry>
				<xsl:value-of select="./properties[@propertyName='Role']/value/@value"/>
			</entry>		
			<entry>
				<xsl:choose>
					<xsl:when test="./properties[@propertyName='IdentityProvider']/value/@value">
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



