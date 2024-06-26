<?xml version="1.0" encoding="utf-8"?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             BEHAIM IT Solutions                              -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : rendezvous.xsl                                             -->
<!-- originator      : lsatin                                                     -->
<!-- creation date   : 2016/01/25                                                 -->
<!-- description     : XSL template transfers BW XML file of type                 -->
<!--                   .rvResource into DITA format.                              -->
<!-- ============================================================================ -->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:java="http://xml.apache.org/xalan/java"
	xmlns:CustomFunctionsEagle="com.behaim.commons.eagle.CustomFunctions" 
	xmlns:CustomFunctions="com.behaim.commons.xsl.CustomFunctions" 
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

		<concept id="RendezVousMain" xml:lang="en-us">
			<xsl:variable name="processName" select="substring-before($heading,'.rvResource')"/>
		<title>
			<xsl:value-of select="$processName"/>
		</title>
		<titlealts>
			<navtitle>
				<xsl:choose>
					<xsl:when test="$displayPathInTopicName">
              			<xsl:value-of select="substring-before($relativePath,'.rvResource')"/>
            		</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$processName"/>
					</xsl:otherwise>
				</xsl:choose>
			</navtitle>
		</titlealts>
					<conbody>
						<p>
							<xsl:value-of select="CustomFunctions:initializeTemplate('rendezvous.xsl')"/>
						</p>
						<p>
							Section contains description of Rendezous "
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
		
			<concept id="Rendezvous">
			<title>Rendezvous</title>
				<conbody>
					<ul>
						<xsl:apply-templates select="jndi:configuration" mode="basic"></xsl:apply-templates>
						<xsl:apply-templates select="/" mode="SSL"></xsl:apply-templates>
					</ul>
				</conbody>
			</concept>
			<concept id="RendezVousAdvanced">
				<title>Rendezvous Advanced</title>
				<conbody>
					<ul>
						<xsl:apply-templates select="jndi:configuration" mode="advanced"></xsl:apply-templates>
					</ul>
				</conbody>
			</concept>
		</concept>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="jndi:configuration" mode="advanced">
		<li>
			RV Type: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@rvType"/>
				<xsl:with-param name="defaultValue" select="'Reliable'"/>
			</xsl:call-template>
		</li>
		<xsl:choose>
			<xsl:when test="@rvType = 'Certified'">
				<li>
					CM Name:
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="@cmName"/>
						<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='cmName']/@propName"/>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template>
				</li>
				<li>
					Ledger File:
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="@ledgerFile"/>
						<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='ledgerFile']/@propName"/>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template>
				</li>
				<li>
					Sync Ledger File:
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="@syncLedgerFile"/>
						<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='syncLedgerFile']/@propName"/>
						<xsl:with-param name="defaultValue" select="'false'"/>
					</xsl:call-template>
				</li>
				<li>
					Relay Agent:
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="@relayAgent"/>
						<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='relayAgent']/@propName"/>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template>
				</li>
				<li>
					Require Old Message:
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="@requireOldMsg"/>
						<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='requireOldMsg']/@propName"/>
						<xsl:with-param name="defaultValue" select="'false'"/>
					</xsl:call-template>
				</li>
				<li>
					Message Timeout (sec):
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="@msgTimeout"/>
						<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='msgTimeout']/@propName"/>
						<xsl:with-param name="defaultValue" select="'0'"/>
					</xsl:call-template>
				</li>
			</xsl:when>
			<xsl:when test="@rvType = 'Distributed Queue'">
				<li>
					CMQ Name:
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="@cmqName"/>
						<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='cmqName']/@propName"/>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template>
				</li>
				<li>
					Worker Weight:
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="@workerWeight"/>
						<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='workerWeight']/@propName"/>
						<xsl:with-param name="defaultValue" select="'1'"/>
					</xsl:call-template>
				</li>
				<li>
					Worker Tasks:
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="@workerTasks"/>
						<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='workerTasks']/@propName"/>
						<xsl:with-param name="defaultValue" select="'10'"/>
					</xsl:call-template>
				</li>
				<li>
					Worker Complete Time:
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="@workerCompleteTime"/>
						<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='workerCompleteTime']/@propName"/>
						<xsl:with-param name="defaultValue" select="'0.0'"/>
					</xsl:call-template>
				</li>
				<li>
					Scheduler Weight:
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="@schedulerWeight"/>
						<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='schedulerWeight']/@propName"/>
						<xsl:with-param name="defaultValue" select="'1'"/>
					</xsl:call-template>
				</li>
				<li>
					Scheduler Heartbeat:
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="@schedulerHeartbeat"/>
						<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='schedulerHeartbeat']/@propName"/>
						<xsl:with-param name="defaultValue" select="'1.0'"/>
					</xsl:call-template>
				</li>
				<li>
					Scheduler Activation:
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="@schedulerActivation"/>
						<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='schedulerActivation']/@propName"/>
						<xsl:with-param name="defaultValue" select="'3.5'"/>
					</xsl:call-template>
				</li>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
		
	<!-- Sub template -->
	<xsl:template match="jndi:configuration" mode="basic">
		<li>Daemon:
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@daemon"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='daemon']/@propName"/>
				<xsl:with-param name="defaultValue" select="''"/>
			</xsl:call-template>
		</li>
		<li>Network:
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@network"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='network']/@propName"/>
				<xsl:with-param name="defaultValue" select="''"/>
			</xsl:call-template>
		</li>
		<li>Service:
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@service"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='service']/@propName"/>
				<xsl:with-param name="defaultValue" select="''"/>
			</xsl:call-template>
		</li>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="/" mode="SSL">
	
	    <xsl:choose>
			<xsl:when test="/jndi:namedResource/identitySet/sca_ext:intentMap/sca_ext:qualifier/id:IdentityReference[@type='sslclient:SSLClientConfiguration']/@URI!=''">
				<li>Confidentiality: True </li>
			</xsl:when>
			<xsl:otherwise>
			  <li> Confidentiality: False </li>
			</xsl:otherwise>
		</xsl:choose>
		
		<xsl:if test="/jndi:namedResource/identitySet/sca_ext:intentMap/sca_ext:qualifier/id:IdentityReference[@type='sslclient:SSLClientConfiguration']/@URI!=''">
			<li>
				SSL Client:		
				<xsl:if test="/jndi:namedResource/identitySet/sca_ext:intentMap/sca_ext:qualifier/id:IdentityReference[@type='sslclient:SSLClientConfiguration']/@URI!=''">	
				<xsl:variable name="sslClient" select="/jndi:namedResource/identitySet/sca_ext:intentMap/sca_ext:qualifier/id:IdentityReference[@type='sslclient:SSLClientConfiguration']/@URI"/>
						<xsl:variable name="sslClientFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($sslClient, '.','/'), '.sslClientResource.dita')"/>
						<xsl:variable name="sslResourceRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($sslClientFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
						<xsl:element name="xref">
							<xsl:attribute name="href"><xsl:value-of select="$sslResourceRef"/></xsl:attribute>
							<xsl:value-of select="$sslClient"/>
						</xsl:element>	
				</xsl:if>		
			</li>
		</xsl:if>
		
		<xsl:choose>
			<xsl:when test="/jndi:namedResource/identitySet/sca_ext:intentMap/sca_ext:qualifier/id:IdentityReference[@type='subject:SubjectConfiguration']/@URI!=''">
				<li>Authentication: True </li>
			</xsl:when>
			<xsl:otherwise>
			  <li> Authentication: False </li>
			</xsl:otherwise>
		</xsl:choose>
		
		<xsl:if test="/jndi:namedResource/identitySet/sca_ext:intentMap/sca_ext:qualifier/id:IdentityReference[@type='subject:SubjectConfiguration']/@URI!=''">
			<li>
				Identity Provider:	
				<xsl:if test="/jndi:namedResource/identitySet/sca_ext:intentMap/sca_ext:qualifier/id:IdentityReference[@type='subject:SubjectConfiguration']/@URI!=''">
				<xsl:variable name="identityProvider" select="/jndi:namedResource/identitySet/sca_ext:intentMap/sca_ext:qualifier/id:IdentityReference[@type='subject:SubjectConfiguration']/@URI"/>
						<xsl:variable name="identityProviderFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($identityProvider, '.','/'), '.userIdResource.dita')"/>
						<xsl:variable name="identityProviderRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($identityProviderFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
						<xsl:element name="xref">
							<xsl:attribute name="href"><xsl:value-of select="$identityProviderRef"/></xsl:attribute>
							<xsl:value-of select="$identityProvider"/>
						</xsl:element>
				</xsl:if>
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



