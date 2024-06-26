<?xml version="1.0" encoding="utf-8"?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             BEHAIM IT Solutions                              -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : dynamicsCRMConnection.xsl                                  -->
<!-- originator      : lsatin                                                     -->
<!-- creation date   : 2016/02/03                                                 -->
<!-- description     : XSL template transfers BW XML file of type                 -->
<!--                   .sslClientResource into DITA format.                       -->
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
	exclude-result-prefixes="xpdl2 ncname xpdExt java CustomFunctions CustomFunctionsEagle PrimitiveTypeFacets id sca_ext jndi">
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

	<concept id="DynamicsCRMMain" xml:lang="en-us">
	<xsl:variable name="processName" select="substring-before($heading,'.dynamicscrmResource')"/>
		<title>
			<xsl:value-of select="$processName"/>
		</title>
		<titlealts>
			<navtitle>
				<xsl:choose>
					<xsl:when test="$displayPathInTopicName">
              			<xsl:value-of select="substring-before($relativePath,'.dynamicscrmResource')"/>
            		</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$processName"/>
					</xsl:otherwise>
				</xsl:choose>
			</navtitle>
		</titlealts>
					<conbody>
						<p>
							<xsl:value-of select="CustomFunctions:initializeTemplate('dynamicsCRMConnection.xsl')"/>
						</p>
						<p>
							Section contains description of Dynamics CRM Configuration "
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
		
			<concept id="OSIsoft">
				<title>Dynamics CRM Configuration</title>
				<conbody>
					<ul>
						<xsl:apply-templates select="jndi:configuration" mode="ConnectionConfiguration"></xsl:apply-templates>		
					</ul>
				</conbody>
		</concept>
		</concept>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="jndi:configuration" mode="ConnectionConfiguration">
		<li>
			Deployment Type: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@serverType"/>
				<xsl:with-param name="defaultValue" select="'Online'"/>
			</xsl:call-template>
		</li>		
		<li>
			Authentication Type: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@authType"/>
				<xsl:with-param name="defaultValue" select="'OnlineFederation'"/>
			</xsl:call-template>
		</li>
		<xsl:if test="@authType = 'Kerberos'">
			<li>
				LoginModule File:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@loginModuleFilePath"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template>
			</li>
			<li>
				Kerberos File:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@krb5FilePath"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template>
			</li>
			<li>
				Server SPN:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@krb5SPN"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template>
			</li>
		</xsl:if>
		<li>
			User Name: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@username"/>
				<xsl:with-param name="defaultValue" select="''"/>
			</xsl:call-template>
		</li>
		<li>
			Password: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@password"/>
				<xsl:with-param name="defaultValue" select="''"/>
			</xsl:call-template>
		</li>
		<li>
			Organization Service: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@organizationService"/>
				<xsl:with-param name="defaultValue" select="''"/>
			</xsl:call-template>
		</li>
		<li>
			Timeout (sec): 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@timeout"/>
				<xsl:with-param name="defaultValue" select="'1800'"/>
			</xsl:call-template>
		</li>
		<xsl:if test="@useproxy">
			<li>
				Proxy Server:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@proxyserver"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='proxyserver']/@propName"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template>
			</li>
			<li>
				Proxy Port:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@proxyport"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='proxyport']/@propName"/>
					<xsl:with-param name="defaultValue" select="'0'"/>
				</xsl:call-template>
			</li>
			<li>
				Proxy Username:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@proxyusername"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='proxyusername']/@propName"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template>
			</li>
			<li>
				Proxy Password:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@proxypassword"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='proxypassword']/@propName"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template>
			</li>
		</xsl:if>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="/" mode="IdentityProvider">
		<xsl:if test="/jndi:namedResource/jndi:reference[@type='subject:SubjectConfiguration']/@value">
			<li>
				Identity Provider:
				<xsl:value-of select="/jndi:namedResource/jndi:reference[@type='subject:SubjectConfiguration']/@value"/>
			</li>
		</xsl:if>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="/" mode="SSL">
		<xsl:if test="/jndi:namedResource/jndi:reference[@type='sslclient:SSLClientConfiguration']/@value">
			<li>
				SSL Client:
				<xsl:value-of select="/jndi:namedResource/jndi:reference[@type='sslclient:SSLClientConfiguration']/@value"/>
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
				<xsl:variable name="profileInfo" select="javaEagle:getModulePropertyProfileInfo($valueModuleProp,$applicationName)"/>
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



