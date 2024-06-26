<?xml version="1.0" encoding="utf-8"?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             BEHAIM IT Solutions                              -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : ftpConnection.xsl                                          -->
<!-- originator      : lsatin                                                     -->
<!-- creation date   : 2015/09/01                                                 -->
<!-- description     : XSL template transfers BW XML file of type                 -->
<!--                   .dataFormatResource into DITA format.                      -->
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

		<concept id="FTPConnectionsMain" xml:lang="en-us">
			<xsl:variable name="processName" select="substring-before($heading,'.ftpResource')"/>
		<title>
			<xsl:value-of select="$processName"/>
		</title>
		<titlealts>
			<navtitle>
				<xsl:choose>
					<xsl:when test="$displayPathInTopicName">
              			<xsl:value-of select="substring-before($relativePath,'.ftpResource')"/>
            		</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$processName"/>
					</xsl:otherwise>
				</xsl:choose>
			</navtitle>
		</titlealts>
					<conbody>
						<p>
							<xsl:value-of select="CustomFunctions:initializeTemplate('ftpConnection.xsl')"/>
						</p>
						<p>
							Section contains description of FTP Connections "
							<xsl:value-of select="$heading"/>
							" .
						</p>
						<p>
							Name:
							<xsl:value-of select="@name"/>
						</p>
						<xsl:if test="jndi:description != ''">
							<p>
								Description:
								<xsl:value-of select="jndi:description"/>
							</p>
						</xsl:if>
					</conbody>
		
		<concept id="FTPConnections">
		<title>FTP Connections</title>
			<conbody>
				<ul>
					<xsl:apply-templates select="jndi:configuration"></xsl:apply-templates>
					<xsl:apply-templates select="/" mode="SSL"></xsl:apply-templates>
				</ul>
			</conbody>
		</concept>
		</concept>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="jndi:configuration">
		
			<li>
				Host:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@host"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='host']/@propName"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template>
			</li>
		
			<li>
				Port:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@port"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='port']/@propName"/>
					<xsl:with-param name="defaultValue" select="'21'"/>
				</xsl:call-template>
			</li>
		
			<li>
				User Name:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@userName"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='userName']/@propName"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template>
			</li>
		
			<li>
				Password:
				<xsl:choose>
					<xsl:when test="@password !=''"> **** </xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="getValueFromLiteralModule">
							<xsl:with-param name="valueLiteral" select="''"/>
							<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='password']/@propName"/>
							<xsl:with-param name="defaultValue" select="''"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</li>
		
			<li>
				Mode:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@mode"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='mode']/@propName"/>
					<xsl:with-param name="defaultValue" select="'Active'"/>
				</xsl:call-template>
			</li>
		
			<li>
				Connection Timeout (msec):
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@timeout"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='timeout']/@propName"/>
					<xsl:with-param name="defaultValue" select="'60000'"/>
				</xsl:call-template>
			</li>
		
			<li>
				Remote Filename Encoding:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@remoteFileNameEncoding"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='remoteFileNameEncoding']/@propName"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template>
			</li>
		
		<xsl:choose>
			<xsl:when test="@firewall!='' or substitutionBindings[@template='firewall']/@propName!=''">
			<li>
				Firewall:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@firewall"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='firewall']/@propName"/>
					<xsl:with-param name="defaultValue" select="'false'"/>
				</xsl:call-template>
			</li>
			<!--/xsl:when>
			<xsl:otherwise>
				<li>Firewall: false</li>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="@firewall!=''"-->
			<li>
				Proxy Host:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@proxyHost"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='proxyHost']/@propName"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template>
			</li>
		
			<li>
				Proxy Port:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@proxyPort"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='proxyPort']/@propName"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template>
			</li>
		
			<li>
				Proxy User Name:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@proxyUserName"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='proxyUserName']/@propName"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template>
			</li>
		
			<li>
				Proxy User Password:
				<xsl:choose>
					<xsl:when test="@proxyPassword !=''"> **** </xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="getValueFromLiteralModule">
							<xsl:with-param name="valueLiteral" select="''"/>
							<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='proxyPassword']/@propName"/>
							<xsl:with-param name="defaultValue" select="''"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</li>
			</xsl:when>
			<xsl:otherwise>
				<li>Firewall: false</li>
				<!--li>Proxy Host:</li>
				<li>Proxy Port:</li>
				<li>Proxy User Name:</li>
				<li>Proxy User Password:</li-->				
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="/" mode="SSL">
	<xsl:choose>
		<xsl:when test="/jndi:namedResource/identitySet/sca_ext:intentMap/sca_ext:qualifier/id:IdentityReference/@URI!=''">
			<li>Confidentiality: true</li>
			<li>
				SSL Client:				
				<xsl:if test="/jndi:namedResource/identitySet/sca_ext:intentMap/sca_ext:qualifier/id:IdentityReference/@URI!=''">
					<xsl:variable name="sslClient" select="/jndi:namedResource/identitySet/sca_ext:intentMap/sca_ext:qualifier/id:IdentityReference/@URI"/>
					<xsl:variable name="sslClientFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($sslClient, '.','/'), '.sslClientResource.dita')"/>
					<xsl:variable name="sslClientRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($sslClientFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
					<xsl:element name="xref">
						<xsl:attribute name="href"><xsl:value-of select="$sslClientRef"/></xsl:attribute>
						<xsl:value-of select="$sslClient"/>
					</xsl:element>
				</xsl:if>
			</li>
		</xsl:when>
		<xsl:otherwise>
				<li>Confidentiality: false</li>
			</xsl:otherwise>
		</xsl:choose>
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



