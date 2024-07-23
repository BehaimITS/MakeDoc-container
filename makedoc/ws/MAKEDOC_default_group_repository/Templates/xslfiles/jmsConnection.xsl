<?xml version="1.0" encoding="utf-8"?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             BEHAIM IT Solutions                              -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : jmsConnection.xsl                                          -->
<!-- originator      : lsatin                                                     -->
<!-- creation date   : 2016/01/22                                                 -->
<!-- description     : XSL template transfers BW XML file of type                 -->
<!--                   .jmsConnResource into DITA format.                      -->
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

	<concept id="JMSConnectionsMain" xml:lang="en-us">
		<xsl:variable name="processName" select="substring-before($heading,'.jmsConnResource')"/>
		<title>
			<xsl:value-of select="$processName"/>
		</title>
		<titlealts>
			<navtitle>
				<xsl:choose>
					<xsl:when test="$displayPathInTopicName">
						<xsl:value-of select="substring-before($relativePath,'.jmsConnResource')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$processName"/>
					</xsl:otherwise>
				</xsl:choose>
			</navtitle>
		</titlealts>
		<conbody>
			<p>
				<xsl:value-of select="CustomFunctions:initializeTemplate('jmsConnection.xsl')"/>
			</p>
			<p>
				Section contains description of JMS connection "
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
		<concept id="JMSConnectionsBasic">
			<title>Basic Configuration</title>
			<conbody>
				<ul>
					<xsl:choose>
						<xsl:when test="jndi:configuration/@*[local-name()='type'] = 'jms:JNDIConnectionFactory'">
							<xsl:apply-templates select="jndi:configuration" mode="jndi"></xsl:apply-templates>
						</xsl:when>
						<xsl:when test="jndi:configuration/@*[local-name()='type'] = 'jms:DirectConnectionFactory'">
							<xsl:apply-templates select="jndi:configuration" mode="direct"></xsl:apply-templates>
						</xsl:when>
					</xsl:choose>				
				</ul>
			</conbody>
		</concept>
		<xsl:if test="jndi:configuration/userCredentials">
		<concept id="JMSConnectionsSecurity">
			<title>Security</title>
			<conbody>
					<xsl:apply-templates select="jndi:configuration/userCredentials"></xsl:apply-templates>
			</conbody>
		</concept>
		</xsl:if>		
		<concept id="JMSConnectionsSSL">
			<title>SSL</title>
			<conbody>
				<ul>
				<xsl:choose>
					<xsl:when test="jndi:configuration/userCredentials">
						<li>
							Login credentials
							<xsl:apply-templates select="jndi:configuration/userCredentials"/>
						</li>
					</xsl:when>
					<xsl:otherwise>
						<li>Login credentials: None</li>
					</xsl:otherwise>
				</xsl:choose>
				</ul>
			</conbody>
		</concept>	
		<concept id="JMSConnectionsAdvanced">
			<title>Advanced Configuration</title>
                <conbody>
                    <ul>
                        <li>
                            Auto-generate Client ID:
                            <xsl:choose>
								<xsl:when test="@autoGenerateClientID">
									<xsl:value-of select="@autoGenerateClientID"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="'true'"/>
								</xsl:otherwise>
							</xsl:choose>
                        </li>
                        <xsl:if test="jndi:configuration/@autoGenerateClientID = 'false'">
                            <li>
                                Client ID:
                                <xsl:value-of select="jndi:configuration/@clientID"/>
                            </li>
                        </xsl:if>
                    </ul>
                </conbody>
		</concept>
	</concept>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="jndi:configuration/userCredentials">
		<ul>
			<li>
				Username: 
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@username"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='username']/@propName"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template>
			</li>
			<li>
				Password: 
				<xsl:choose>
					<xsl:when test="@password !=''"> ****</xsl:when>
					<xsl:otherwise>
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="''"/>
						<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='password']/@propName"/>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</li>
		</ul>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="jndi:configuration" mode="jndi">
		<xsl:choose>
			<xsl:when test="@factoryType='Queue/Topic'">
				<li>
					Connection Factory Type: JNDI
				</li>
				<li>
					Messaging style: Queue/Topic
				</li>
				<li>
					Queue Connection Factory:
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="@jndiName"/>
						<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='jndiName']/@propName"/>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template>
				</li>
				<li>
					Topic Connection Factory:
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="@topicFactoryJNDIName"/>
						<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='topicFactoryJNDIName']/@propName"/>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template>
				</li>
				<li>
					JNDI Configuration:
					<xsl:choose>
						<xsl:when test="../jndi:reference[@type='jms:JNDIConnection']/@value != ''">
							<xsl:variable name="jndiConfig" select="../jndi:reference[@type='jms:JNDIConnection']/@value"/>
							<xsl:variable name="jndiConfigFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($jndiConfig, '.','/'), '.jndiConfigResource.dita')"/>
							<xsl:variable name="jndiConfigRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($jndiConfigFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
							<xsl:element name="xref">
								<xsl:attribute name="href"><xsl:value-of select="$jndiConfigRef"/></xsl:attribute>
								<xsl:value-of select="$jndiConfig"/>
							</xsl:element>
						</xsl:when>
						<xsl:otherwise>
							No JNDI configuration chosen.
						</xsl:otherwise>	
					</xsl:choose>
				</li>
			</xsl:when>
			<xsl:otherwise>
				<li>
					Connection Factory Type: JNDI
				</li>
				<li>
					Messaging style: Generic
				</li>
				<li>
					<xsl:variable name="connFactory">
						<xsl:call-template name="getValueFromLiteralModule">
							<xsl:with-param name="valueLiteral" select="@jndiName"/>
							<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='jndiName']/@propName"/>
							<xsl:with-param name="defaultValue" select="''"/>
						</xsl:call-template>
					</xsl:variable>
					
					Connection Factory JNDI Name:
					
					<xsl:choose>
						<xsl:when test="$connFactory != ''">
							<xsl:value-of select="$connFactory"/>
						</xsl:when>
						<xsl:otherwise>
							GenericConnectionFactory
						</xsl:otherwise>
					</xsl:choose>
				</li>
				<li>
					JNDI Configuration:
					<xsl:choose>
						<xsl:when test="../jndi:reference[@type='jms:JNDIConnection']/@value != ''">
							<xsl:variable name="jndiConfig" select="../jndi:reference[@type='jms:JNDIConnection']/@value"/>
							<xsl:variable name="jndiConfigFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $resourcesFolder, translate($jndiConfig, '.','/'), '.jndiConfigResource.dita')"/>
							<xsl:variable name="jndiConfigRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($jndiConfigFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
							<xsl:element name="xref">
								<xsl:attribute name="href"><xsl:value-of select="$jndiConfigRef"/></xsl:attribute>
								<xsl:value-of select="$jndiConfig"/>
							</xsl:element>
						</xsl:when>
						<xsl:otherwise>
							No JNDI configuration chosen.
						</xsl:otherwise>	
					</xsl:choose>
				</li>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="jndi:configuration" mode="direct">
		<li>
			Connection Factory Type: Direct
		</li>
		<li>
			Messaging Style:
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@factoryType"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='factoryType']/@propName"/>
				<xsl:with-param name="defaultValue" select="'Generic'"/>
			</xsl:call-template>
		</li>
		<li>
			Provider URL:						
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@providerURL"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='providerURL']/@propName"/>
				<xsl:with-param name="defaultValue" select="'tcp://&lt;host&gt;:&lt;port&gt;'"/>
			</xsl:call-template>
		</li>
		<li>
			Use UFO Connection Factory:						
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@ufo"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='ufo']/@propName"/>
				<xsl:with-param name="defaultValue" select="'false'"/>
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



