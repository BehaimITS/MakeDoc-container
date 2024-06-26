<?xml version="1.0" encoding="utf-8"?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             BEHAIM IT Solutions                              -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : httpClientConfiguration.xsl                                -->
<!-- originator      : lsatin                                                     -->
<!-- creation date   : 2015/01/21                                                 -->
<!-- description     : XSL template transfers BW XML file of type                 -->
<!--                   .httpClientResource into DITA format.                      -->
<!-- ============================================================================ -->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:java="http://xml.apache.org/xalan/java"
	xmlns:CustomFunctions="com.behaim.commons.xsl.CustomFunctions" 
	xmlns:CustomFunctionsEagle="com.behaim.commons.eagle.CustomFunctions" 
	xmlns:jndi="http://xsd.tns.tibco.com/amf/models/sharedresource/jndi" 
	xmlns:sca_ext="http://www.tibco.com/ns/sca/201311" 
	xmlns:id="http://www.tibco.com/ws/2013/11/identity" 
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

		<concept id="HTTPClientConfigurationsMain" xml:lang="en-us">
			<xsl:variable name="processName" select="substring-before($heading,'.httpClientResource')"/>
		<title>
			<xsl:value-of select="$processName"/>
		</title>
		<titlealts>
			<navtitle>
				<xsl:choose>
					<xsl:when test="$displayPathInTopicName">
              			<xsl:value-of select="substring-before($relativePath,'.httpClientResource')"/>
            		</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$processName"/>
					</xsl:otherwise>
				</xsl:choose>
			</navtitle>
		</titlealts>
					<conbody>
						<p>
							<xsl:value-of select="CustomFunctions:initializeTemplate('httpClientConfiguration.xsl')"/>
						</p>
						<p>
							Section contains description HTTP Client Configurations "
							<xsl:value-of select="$heading"/>
							" .
						</p>
						<p>
							Name:
							<xsl:value-of select="@name"/>
						</p>
						<p>
							Description:
							<xsl:value-of select="jndi:description"/>
						</p>
					</conbody>
		
			<concept id="HTTPClientConfigurations">
			<title>Configuration</title>
				<conbody>
					<ul>
						<xsl:apply-templates select="jndi:configuration"></xsl:apply-templates>
					<li>
						Thread Pool:		
						<xsl:if test="jndi:reference[@type='tp:ThreadPoolConfiguration']/@value!=''">						
						<xsl:variable name="threadPoolResource" select="jndi:reference[@type='tp:ThreadPoolConfiguration']/@value"/>
						<xsl:variable name="threadPoolResourceFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($threadPoolResource, '.','/'), '.threadPoolResource.dita')"/>
						<xsl:variable name="threadPoolResourceRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($threadPoolResourceFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
						<xsl:element name="xref">
							<xsl:attribute name="href"><xsl:value-of select="$threadPoolResourceRef"/></xsl:attribute>
							<xsl:value-of select="$threadPoolResource"/>
						</xsl:element>	
						</xsl:if>
					</li>
					</ul>
				</conbody>
			</concept>
			<concept id="HTTPClientAdvanced">
				<title>Advanced</title>
				<conbody>
					<ul>
						<xsl:apply-templates select="jndi:configuration/tcpDetails"></xsl:apply-templates>
						<xsl:apply-templates select="jndi:configuration" mode="Advanced"></xsl:apply-templates>
						<li>
							HTTP Proxy: 
							<xsl:if test="jndi:reference[@type='httpproxy:ProxyConfiguration']/@value!=''">						
							<xsl:variable name="httpProxyResource" select="jndi:reference[@type='httpproxy:ProxyConfiguration']/@value"/>
							<xsl:variable name="httpProxyResourceFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($httpProxyResource, '.','/'), '.httpProxyResource.dita')"/>
							<xsl:variable name="httpProxyResourceRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($httpProxyResourceFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
							<xsl:element name="xref">
								<xsl:attribute name="href"><xsl:value-of select="$httpProxyResourceRef"/></xsl:attribute>
								<xsl:value-of select="$httpProxyResource"/>
							</xsl:element>					
							</xsl:if>						
						</li>
					</ul>
				</conbody>
			</concept>
			<xsl:if test="identitySet/sca_ext:intentMap/sca_ext:qualifier/id:IdentityReference[@type='subject:SubjectConfiguration']/@URI != '' or jndi:configuration/@useKerberosAuthentication='true' or identitySet/sca_ext:intentMap/sca_ext:qualifier/id:IdentityReference[@type='sslclient:SSLClientConfiguration']/@URI != '' or identitySet/sca_ext:intentMap/sca_ext:qualifier/id:IdentityReference[@type='subject:SSLClientConfiguration']/@URI != ''">
			<concept id="HTTPClientSecurity">
				<title>Security</title>
				<conbody>
					<ul>
						<xsl:if test="identitySet/sca_ext:intentMap/sca_ext:qualifier/id:IdentityReference[@type='subject:SubjectConfiguration']/@URI != ''">
							<li>
								Identity Provider: 	
								<xsl:if test="identitySet/sca_ext:intentMap/sca_ext:qualifier/id:IdentityReference[@type='subject:SubjectConfiguration']/@URI!=''">	
								<xsl:variable name="identityProvider" select="identitySet/sca_ext:intentMap/sca_ext:qualifier/id:IdentityReference[@type='subject:SubjectConfiguration']/@URI"/>
								<xsl:variable name="identityProviderFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($identityProvider, '.','/'), '.userIdResource.dita')"/>
								<xsl:variable name="identityProviderRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($identityProviderFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
								<xsl:element name="xref">
									<xsl:attribute name="href"><xsl:value-of select="$identityProviderRef"/></xsl:attribute>
									<xsl:value-of select="$identityProvider"/>
								</xsl:element>
								</xsl:if>
							</li>
						</xsl:if>
						
						<xsl:if test="jndi:configuration/@useKerberosAuthentication='true'">
							<li>
							Kerberos Authentication: true
							
							<ul><li> Username: 
							
							<xsl:choose>
								<xsl:when test="jndi:configuration/@username">
									<xsl:call-template name="getValueFromLiteralModule">
										<xsl:with-param name="valueLiteral" select="jndi:configuration/@username"/>
										<xsl:with-param name="valueModuleProp" select="jndi:configuration/substitutionBindings[@template='username']/@propName"/>
										<xsl:with-param name="defaultValue" select="''"/>
									</xsl:call-template>
								</xsl:when>

								<xsl:otherwise>
									<xsl:call-template name="getValueFromLiteralModule">
										<xsl:with-param name="valueLiteral" select="''"/>
										<xsl:with-param name="valueModuleProp" select="jndi:configuration/substitutionBindings[@template='username']/@propName"/>
										<xsl:with-param name="defaultValue" select="''"/>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
							
					
							</li>
							<li> Password: 
							
							<xsl:choose>
								<xsl:when test="jndi:configuration/@userpassword">
									****
								</xsl:when>

								<xsl:otherwise>
									<xsl:call-template name="getValueFromLiteralModule">								
										<xsl:with-param name="valueLiteral" select="'****'"/>
										<xsl:with-param name="valueModuleProp" select="jndi:configuration/substitutionBindings[@template='userpassword']/@propName"/>
										<xsl:with-param name="defaultValue" select="''"/>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
							
							</li></ul></li>
						</xsl:if>
						
						
						<xsl:if test="identitySet/sca_ext:intentMap/sca_ext:qualifier/id:IdentityReference[@type='sslclient:SSLClientConfiguration']/@URI != ''">
							<li>
							SSL Client Configuration: 
							<xsl:if test="identitySet/sca_ext:intentMap/sca_ext:qualifier/id:IdentityReference[@type='sslclient:SSLClientConfiguration']/@URI!=''">	
							<xsl:variable name="sslClient" select="identitySet/sca_ext:intentMap/sca_ext:qualifier/id:IdentityReference[@type='sslclient:SSLClientConfiguration']/@URI"/>
							<xsl:variable name="sslClientFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($sslClient, '.','/'), '.sslClientResource.dita')"/>
							<xsl:variable name="sslClientRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($sslClientFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
							<xsl:element name="xref">
								<xsl:attribute name="href"><xsl:value-of select="$sslClientRef"/></xsl:attribute>
								<xsl:value-of select="$sslClient"/>
							</xsl:element>
							</xsl:if>
							</li>
						</xsl:if>
					</ul>
				</conbody>
			</concept>
			</xsl:if>
		</concept>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="jndi:configuration" mode="Advanced">
		<li>
			Accept Redirect: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@acceptRedirect"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='acceptRedirect']/@propName"/>
				<xsl:with-param name="defaultValue" select="'false'"/>
			</xsl:call-template>
		</li>
		<li>
			Retry Count: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@retryCount"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='retryCount']/@propName"/>
				<xsl:with-param name="defaultValue" select="'0'"/>
			</xsl:call-template>
		</li>
		<li>
			Use Single Cookie Header: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@useSingleCookieHeader"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='useSingleCookieHeader']/@propName"/>
				<xsl:with-param name="defaultValue" select="'false'"/>
			</xsl:call-template>
		</li>
		<li>
			Use Non-Preemptive Authentication: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@useNonPreemptiveAuth"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='useNonPreemptiveAuth']/@propName"/>
				<xsl:with-param name="defaultValue" select="'false'"/>
			</xsl:call-template>
		</li>
		<li>
			Log Reqest/Response Time: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@logReqRespTime"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='logReqRespTime']/@propName"/>
				<xsl:with-param name="defaultValue" select="'false'"/>
			</xsl:call-template>
		</li>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="jndi:configuration/tcpDetails">
		<li>
			Socket Timeout (ms): 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@soTimeout"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='soTimeout']/@propName"/>
				<xsl:with-param name="defaultValue" select="'0'"/>
			</xsl:call-template>
		</li>
		<li>
			Connection Timeout (ms): 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@connectionTimeout"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='connectionTimeout']/@propName"/>
				<xsl:with-param name="defaultValue" select="'0'"/>
			</xsl:call-template>
		</li>

		
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="jndi:configuration">
			<li>Implementation Library:
				<xsl:choose>
					<xsl:when test="@httpClientVersion='commons'">
						<xsl:value-of select="'Apache Commons(Supported by HTTP and SOAP)'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'Apache HttpComponents(Supported by HTTP and REST)'"/>
					</xsl:otherwise>
				</xsl:choose> 		
			</li>
			<li>Disable Connection Pooling:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@useSingleThreadConnectionManager"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='useSingleThreadConnectionManager']/@propName"/>
					<xsl:with-param name="defaultValue" select="'false'"/>
				</xsl:call-template>
			</li>
			<li>
				Maximum Total Connections:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@maxTotalConnections"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='maxTotalConnections']/@propName"/>
					<xsl:with-param name="defaultValue" select="'200'"/>
				</xsl:call-template>
			</li>
			<li>
				Maximum Total Connections Per Host:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@maxTotalConnectionsPerHost"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='maxTotalConnectionsPerHost']/@propName"/>
					<xsl:with-param name="defaultValue" select="'20'"/>
				</xsl:call-template>
			</li>
			<li>
				Idle Connection Timeout:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@idleConnectionTimeout"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='idleConnectionTimeout']/@propName"/>
					<xsl:with-param name="defaultValue" select="'0'"/>
				</xsl:call-template>
			</li>
			<li>
				Stale Check:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="tcpDetails/@staleCheck"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='staleCheck']/@propName"/>
					<xsl:with-param name="defaultValue" select="'false'"/>
				</xsl:call-template>
			</li>
			<li>
				Default Host:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@host"/>
					<xsl:with-param name="valueModuleProp" select="tcpDetails/substitutionBindings[@template='host']/@propName"/>
					<xsl:with-param name="defaultValue" select="'localhost'"/>
				</xsl:call-template>
			</li>
			<li>
				Default Port:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="tcpDetails/@port"/>
					<xsl:with-param name="valueModuleProp" select="tcpDetails/substitutionBindings[@template='port']/@propName"/>
					<xsl:with-param name="defaultValue" select="'80'"/>
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
			<xsl:when test="$valueModuleProp!=''">
					<xsl:variable name="profileInfo" select="CustomFunctionsEagle:getModulePropertyProfileInfo($valueModuleProp)"/>
					<xref outputclass="popup" format="html" href="#{$profileInfo}"><xsl:value-of select="$valueModuleProp"/></xref>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="$defaultValue"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template> 
</xsl:stylesheet>



