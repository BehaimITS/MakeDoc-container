<?xml version="1.0" encoding="utf-8"?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             BEHAIM IT Solutions                              -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : httpConnector.xsl                                          -->
<!-- originator      : lsatin                                                     -->
<!-- creation date   : 2016/01/21                                                 -->
<!-- description     : XSL template transfers BW XML file of type                 -->
<!--                   .httpConnResource into DITA format.                      -->
<!-- ============================================================================ -->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:java="http://xml.apache.org/xalan/java" 
	xmlns:CustomFunctions="com.behaim.commons.xsl.CustomFunctions" 
	xmlns:CustomFunctionsEagle="com.behaim.commons.eagle.CustomFunctions" 
	xmlns:id="http://www.tibco.com/ws/2013/11/identity" 
	xmlns:sca_ext="http://www.tibco.com/ns/sca/201311" 
	xmlns:jndi="http://xsd.tns.tibco.com/amf/models/sharedresource/jndi" 
	xmlns:ncname="com.pikeelectronic.xsl.NCName" 
	xmlns:xpdExt="http://www.tibco.com/XPD/xpdExtension1.0.0" 
	xmlns:xpdl2="http://www.wfmc.org/2008/XPDL2.1" 
	xmlns:PrimitiveTypeFacets="http:///schemas/PrimitiveTypeFacets/_8TmTUMtlEdy7K9XeCH7Hrw/0" 
	xmlns:map="xalan://java.util.Map" 
	extension-element-prefixes="map" 
	exclude-result-prefixes="xpdl2 ncname xpdExt java CustomFunctions CustomFunctionsEagle PrimitiveTypeFacets jndi id sca_ext">
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

		<concept id="HTTPConnectorsMain" xml:lang="en-us">
			<xsl:variable name="processName" select="substring-before($heading,'.httpConnResource')"/>
		<title>
			<xsl:value-of select="$processName"/>
		</title>
		<titlealts>
			<navtitle>
				<xsl:choose>
					<xsl:when test="$displayPathInTopicName">
              			<xsl:value-of select="substring-before($relativePath,'.httpConnResource')"/>
            		</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$processName"/>
					</xsl:otherwise>
				</xsl:choose>
			</navtitle>
		</titlealts>
					<conbody>
						<p>
							<xsl:value-of select="CustomFunctions:initializeTemplate('httpConnector.xsl')"/>
						</p>
						<p>
							Section contains description od HTTP Connectors "
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
		
			<concept id="HTTPConnectorBasic">
			<title>Basic Configuration</title>
				<conbody>
					<ul>
						<xsl:apply-templates select="jndi:configuration" mode="basic"></xsl:apply-templates>
					</ul>
				</conbody>
			</concept>
			<concept id="HTTPConnectorAdvanced">
				<title>Advanced Configuration</title>
				<conbody>
						<xsl:apply-templates select="jndi:configuration" mode="advanced"></xsl:apply-templates>
						<xsl:apply-templates select="/" mode="SSL"></xsl:apply-templates>
				</conbody>
			</concept>
		</concept>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="jndi:configuration" mode="basic">
		<li>Host:
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@host"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='host']/@propName"/>
				<xsl:with-param name="defaultValue" select="''"/>
			</xsl:call-template>
		</li>
		<li>Port:
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@port"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='port']/@propName"/>
				<xsl:with-param name="defaultValue" select="'8080'"/>
			</xsl:call-template>
		</li>
		<li>Accept Queue Size:
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@acceptQueueSize"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='acceptQueueSize']/@propName"/>
				<xsl:with-param name="defaultValue" select="'-1'"/>
			</xsl:call-template>
		</li>
		<li>Acceptor Threads:
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@acceptors"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='acceptors']/@propName"/>
				<xsl:with-param name="defaultValue" select="'1'"/>
			</xsl:call-template>
		</li>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="jndi:configuration" mode="advanced">
		<ul>
			<li>
				Head Buffer Size (B):
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@headerBufferSize"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='headerBufferSize']/@propName"/>
					<xsl:with-param name="defaultValue" select="'4096'"/>
				</xsl:call-template>
			</li>
			<li>
				Request Buffer Size (B):
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@requestBufferSize"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='requestBufferSize']/@propName"/>
					<xsl:with-param name="defaultValue" select="'8192'"/>
				</xsl:call-template>
			</li>
			<li>
				Response Buffer Size (B):
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@responseBufferSize"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='responseBufferSize']/@propName"/>
					<xsl:with-param name="defaultValue" select="'24576'"/>
				</xsl:call-template>
			</li>
			<li>
				Max Idle Time (ms):
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@maxIdleTime"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='maxIdleTime']/@propName"/>
					<xsl:with-param name="defaultValue" select="'200000'"/>
				</xsl:call-template>
			</li>
			<li>
				Low Resource Max Idle Time (ms):
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@lowResourceMaxIdleTime"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='lowResourceMaxIdleTime']/@propName"/>
					<xsl:with-param name="defaultValue" select="'0'"/>
				</xsl:call-template>
			</li>
			<li>
				Linger Time (ms):
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@lingerTime"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='lingerTime']/@propName"/>
					<xsl:with-param name="defaultValue" select="'0'"/>
				</xsl:call-template>
			</li>
			<li>
				Session timeout (ms):
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@sessionTimeout"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='sessionTimeout']/@propName"/>
					<xsl:with-param name="defaultValue" select="'1800'"/>
				</xsl:call-template>
			</li>
			<li>
				Max Post Size:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@maxPostSize"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='maxPostSize']/@propName"/>
					<xsl:with-param name="defaultValue" select="'2097152'"/>
				</xsl:call-template>
			</li>
			<li>
				Max Save Post Size:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@maxSavePostSize"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='maxSavePostSize']/@propName"/>
					<xsl:with-param name="defaultValue" select="'4096'"/>
				</xsl:call-template>
			</li>
			<li>
				Minimum QTP Threads:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@minThreads"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='minThreads']/@propName"/>
					<xsl:with-param name="defaultValue" select="'10'"/>
				</xsl:call-template>
			</li>
			
			<li>
				Maximum QTP Threads:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@maxThreads"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='maxThreads']/@propName"/>
					<xsl:with-param name="defaultValue" select="'75'"/>
				</xsl:call-template>
			</li>
			<xsl:choose>
				<xsl:when test="./disabledHttpMethods">
					<li>
							Disable HTTP Methods:
							<table>
								<tgroup cols="1">
								<thead>
									<row>
										<entry>
											HTTP Method
										</entry>
									</row>
								</thead>
								<tbody>
									<xsl:apply-templates select="./disabledHttpMethods"/>
								</tbody>
								</tgroup>
							</table>
					</li>
				</xsl:when>
				<xsl:otherwise>
					<li>
						Disable HTTP methods: no disabled methods.
					</li>
				</xsl:otherwise>
			</xsl:choose>
		</ul>
		<ul>
			<li>
				Use Non-Blocking IO Sockets:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@useNonBlockingIOSockets"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='useNonBlockingIOSockets']/@propName"/>
					<xsl:with-param name="defaultValue" select="'true'"/>
				</xsl:call-template>
			</li>
			<li>
				Use Direct Buffers:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@useDirectBuffers"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='useDirectBuffers']/@propName"/>
					<xsl:with-param name="defaultValue" select="'true'"/>
				</xsl:call-template>
			</li>
			<li>
				URI Encoding:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@uriEncoding"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='uriEncoding']/@propName"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template>
			</li>
			<li>
				Enable DNS Lookups:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@enableDNSLookup"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='enableDNSLookup']/@propName"/>
					<xsl:with-param name="defaultValue" select="'false'"/>
				</xsl:call-template>
			</li>
			<li>
				Compression:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@compression"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='compression']/@propName"/>
					<xsl:with-param name="defaultValue" select="'false'"/>
				</xsl:call-template>
			</li>
			<li>
				Compressible Mime Types
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@compressableMimeTypes"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='compressableMimeTypes']/@propName"/>
					<xsl:with-param name="defaultValue" select="'text/html,text/xml,text/plain'"/>
				</xsl:call-template>
			</li>
			<li>
				Reverse Proxy Host:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@reverseProxyHost"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='reverseProxyHost']/@propName"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template>
			</li>
			<li>
				Reverse Proxy Port:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@reverseProxyPort"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='reverseProxyPort']/@propName"/>
					<xsl:with-param name="defaultValue" select="'0'"/>
				</xsl:call-template>
			</li>
			<li>
				Enable access logs:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@enableAccessLogs"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='enableAccessLogs']/@propName"/>
					<xsl:with-param name="defaultValue" select="'false'"/>
				</xsl:call-template>
			</li>
			<li>
				Share accross application:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@shareAcrossApplication"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='shareAcrossApplication']/@propName"/>
					<xsl:with-param name="defaultValue" select="'false'"/>
				</xsl:call-template>
			</li>
		</ul>
	</xsl:template>
	
	<xsl:template match="disabledHttpMethods">
		<row>
			<entry>
				<xsl:value-of select="."/>
			</entry>		
		</row>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="/" mode="SSL">
		<ul>
			<li>
				<xsl:choose>
					<xsl:when test="/jndi:namedResource/identitySet/sca_ext:intentMap/sca_ext:qualifier/id:IdentityReference/@URI">
						SSL server configuration:
						<xsl:variable name="sslResource" select="/jndi:namedResource/identitySet/sca_ext:intentMap/sca_ext:qualifier/id:IdentityReference/@URI"/>
						<xsl:variable name="sslResourceFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($sslResource, '.','/'), '.sslServerResource.dita')"/>
						<xsl:variable name="sslResourceRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($sslResourceFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
						<xsl:element name="xref">
							<xsl:attribute name="href"><xsl:value-of select="$sslResourceRef"/></xsl:attribute>
							<xsl:value-of select="$sslResource"/>
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						No SSL server configuration chosen.
					</xsl:otherwise>
				</xsl:choose>
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
			<xsl:otherwise><xsl:value-of select="$defaultValue"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template> 
</xsl:stylesheet>



