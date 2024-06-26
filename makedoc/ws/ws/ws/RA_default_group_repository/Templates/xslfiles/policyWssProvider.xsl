<?xml version="1.0" encoding="utf-8"?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             BEHAIM IT Solutions                              -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : policyWssProvider.xsl                                      -->
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

		<concept id="WssProviderMain" xml:lang="en-us">
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
							<xsl:value-of select="CustomFunctions:initializeTemplate('policyWssProvider.xsl')"/>
						</p>
						<p>
							Section contains description of Policy Wss Provider "
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
		
			<concept id="PolicyWssProvider">
				<title>Wss Provider Policy</title>
				<conbody>
					<ul>
						<xsl:apply-templates select="configuration" mode="basic"></xsl:apply-templates>
					</ul>
				</conbody>
			</concept>
			
			<concept id="PolicyWssAuthentication">
				<title>Authentication</title>
				<conbody>
					<ul>
						<xsl:apply-templates select="configuration" mode="confidentality"></xsl:apply-templates>
					</ul>
				</conbody>
			</concept>
			<concept id="PolicyWssProviderIntegrity">
				<title>Integrity</title>
				<conbody>
					<ul>
						<xsl:apply-templates select="configuration" mode="integrity"></xsl:apply-templates>
					</ul>
				</conbody>
			</concept>
			<concept id="PolicyWssProviderTimestamp">
				<title>Timestamp</title>
				<conbody>
					<ul>
						<xsl:apply-templates select="configuration" mode="timestamp"></xsl:apply-templates>
					</ul>
				</conbody>
			</concept>
				
			<xsl:if test="/policy:Policy/configuration/groups[@paramGroupName='Confidentiality']">
				<concept id="PolicyWssProviderConfidentality">
						<title>Confidentiality</title>
						<conbody>
							<ul>
								<xsl:apply-templates select="configuration" mode="confidentiality"></xsl:apply-templates>
							</ul>
						</conbody>
				</concept>
				</xsl:if>
			<xsl:if test="/policy:Policy/configuration/groups[@paramGroupName='Integrity']">
				<concept id="PolicyWssProviderIntegrity">
					<title>Integrity</title>
					<conbody>
						<ul>
							<xsl:apply-templates select="configuration" mode="integrity"></xsl:apply-templates>
						</ul>
					</conbody>
				</concept>
			</xsl:if>
			<xsl:if test="/policy:Policy/configuration/groups[@paramGroupName='Timestamp']">
				<concept id="PolicyWssProviderTimestamp">
					<title>Timestamp</title>
					<conbody>
						<ul>
							<xsl:apply-templates select="configuration" mode="timestamp"></xsl:apply-templates>
						</ul>
					</conbody>
				</concept>
			</xsl:if>
		</concept>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="configuration" mode="basic">
		<li>
			Shared resource for WSS processing:
			
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
	
	<xsl:template match="configuration" mode="authentication">
		<li>
		Setup to enforce authentication on request
		<ul>
		<xsl:choose>
			<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='Authentication']">
				<xsl:choose>
					<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='Authentication']/paramSettings[@paramName='AuthenticationSetting']/values = 'UsernameToken'">
						<li>Verify Username Token</li>
					</xsl:when>
					<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='Authentication']/paramSettings[@paramName='AuthenticationSetting']/values = 'SamlToken'">
						<li>Verify Saml token
							<ul>
								<li>Confirmation method: <xsl:value-of select="/policy:Policy/configuration/groups[@paramGroupName='Authentication']/paramSettings[@paramName='SamlConfirmation']/@value"/></li>
								<li>Security Token Type: <xsl:value-of select="/policy:Policy/configuration/groups[@paramGroupName='Authentication']/paramSettings[@paramName='SamlTokenType']/@value"/></li>
								<li>Issuer Name:
								<xsl:call-template name="getValueFromLiteralModule">
									<xsl:with-param name="valueLiteral" select="/policy:Policy/configuration/groups[@paramGroupName='Authentication']/paramSettings[@paramName='SamlIssuerName']/@value"/>
									<xsl:with-param name="valueModuleProp" select="/policy:Policy/configuration/groups[@paramGroupName='Authentication']/paramSettings[@paramName='SamlIssuerName']/subVarRefs/@name"/>
									<xsl:with-param name="defaultValue" select="''"/>
								</xsl:call-template>
								</li>
							</ul>
						</li>			
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<li>No verifications</li>
			</xsl:otherwise>
		</xsl:choose>
		</ul>
		</li>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="configuration" mode="timestamp">
		<li>Settings to verify timestamp on request and/or set timestamp on response
		<ul>
		<li>
			Verify Timestamp:
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
			Set Response Timestamp:
			<xsl:choose>
				<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='Timestamp']/paramSettings[@paramName='SetResponseTimestampSelected']/@value">
					<xsl:value-of select="'true'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'false'"/>
				</xsl:otherwise>
			</xsl:choose>
			<ul>				
				<li>
					Time To Live:
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="/policy:Policy/configuration/groups[@paramGroupName='Timestamp']/paramSettings[@paramName='TimeToLive']/@value"/>
						<xsl:with-param name="valueModuleProp" select="/policy:Policy/configuration/groups[@paramGroupName='Timestamp']/paramSettings[@paramName='TimeToLive']/subVarRefs/@name"/>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template>
				</li>			
			</ul>
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
		</ul>
		</li>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="configuration" mode="integrity">
		<li>
		Integrity settings to set up signature verification on request and signing on response
		<ul>
			<li>
				Verify Signature on request
				<xsl:choose>
					<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='Integrity']/paramSettings[@paramName='VerifySignatureScope']/@value = 'Envelope'">
						<ul><li>Verify parts that are signed: Entire Message</li></ul>
					</xsl:when>
					<xsl:otherwise>
						<ul><li>Verify parts that are signed: Message <xsl:value-of select="/policy:Policy/configuration/groups[@paramGroupName='Integrity']/paramSettings[@paramName='VerifySignatureScope']/@value"/></li></ul>
					</xsl:otherwise>
				</xsl:choose>
			</li>
			<li>
				Sign Response:
				<xsl:choose>
					<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='Integrity']/paramSettings[@paramName='SignResponseSelected']/@value = 'true'">
						<xsl:value-of select="'true'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'false'"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="/policy:Policy/configuration/groups[@paramGroupName='Integrity']/paramSettings[@paramName='SignResponseSelected']/@value">
					<ul>
					<li>
						Subject Provider:
						<xsl:if test="/policy:Policy/configuration/groups[@paramGroupName='Integrity']/paramSettings[@paramName='SubjectIsp']/@value">
							<xsl:variable name="subjectProvider" select="/policy:Policy/configuration/groups[@paramGroupName='Integrity']/paramSettings[@paramName='SubjectIsp']/@value"/>
							<xsl:variable name="subjectProviderFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($subjectProvider, '.','/'), '.sipResource.dita')"/>
							<xsl:variable name="subjectProviderRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($subjectProviderFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
							<xsl:element name="xref">
								<xsl:attribute name="href"><xsl:value-of select="$subjectProviderRef"/></xsl:attribute>
								<xsl:value-of select="$subjectProvider"/>
							</xsl:element>
						</xsl:if>
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
								<xsl:if test="/policy:Policy/configuration/groups[@paramGroupName='Integrity']/paramSettings[@paramName='SignHeaderSelected']/@value = 'true'">
									<ul><li>Header</li></ul>
								</xsl:if>
								<xsl:if test="/policy:Policy/configuration/groups[@paramGroupName='Integrity']/paramSettings[@paramName='SignBodySelected']/@value = 'true'">
									<ul><li>Body</li></ul>
								</xsl:if>
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
								<xsl:apply-templates select="/policy:Policy/configuration/groups[@paramGroupName='Integrity']/paramSettings/values"/>
							</tbody>
							</tgroup>
						</table>
						</xsl:if>
					</li>
					</ul>
				</xsl:if>
			</li>
		</ul>
		</li>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="configuration" mode="confidentiality">
		<li>
		Confidentiality settings which sets up decryption on request and encryption on response
		<ul>
			<li>
				Decrypt Request:
				<xsl:choose>
					<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='Confidentiality']/paramSettings[@paramName='VerifyDecryption']/@value = 'true'">
						<xsl:value-of select="'true'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'false'"/>
					</xsl:otherwise>
				</xsl:choose>
			</li>
			<li>
				Encrypt Response:
				<xsl:choose>
					<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='Confidentiality']/paramSettings[@paramName='EncryptResponseSelected']/@value">
						<xsl:value-of select="/policy:Policy/configuration/groups[@paramGroupName='Confidentiality']/paramSettings[@paramName='EncryptResponseSelected']/@value"/>
						<ul>
							<li>
								Trust Provider:		
								<xsl:variable name="trustProvider" select="/policy:Policy/configuration/groups[@paramGroupName='Confidentiality']/paramSettings[@paramName='TrustIsp']/@value"/>
								<xsl:choose>
									<xsl:when test="$trustProvider">
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
								Algorithm Suite:
								<xsl:choose>
									<xsl:when test="/policy:Policy/configuration/groups[@paramGroupName='Confidentiality']/paramSettings[@paramName='EncryptAlgorithmSuite']/@value">
										<xsl:value-of select="/policy:Policy/configuration/groups[@paramGroupName='Confidentiality']/paramSettings[@paramName='EncryptAlgorithmSuite']/@value"/>
									</xsl:when>
								</xsl:choose>
							</li>
							<li>Encryption algorithm:
								<xsl:value-of select="/policy:Policy/configuration/groups[@paramGroupName='Confidentiality']/paramSettings[@paramName='EncryptionAlgorithm']/@value"/>
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
											<xsl:apply-templates select="/policy:Policy/configuration/groups[@paramGroupName='Confidentiality']/paramSettings/values"/>
										</tbody>
										</tgroup>
									</table>
								</xsl:if>
							</li>
						</ul>
					</xsl:when>
				</xsl:choose>
			</li>
		</ul>
		</li>
	</xsl:template>
	
	<xsl:template match="paramSettings/values">
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



