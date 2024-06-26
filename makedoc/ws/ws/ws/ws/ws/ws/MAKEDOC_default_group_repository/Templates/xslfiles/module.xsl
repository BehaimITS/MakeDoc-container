<?xml version="1.0" encoding="UTF-8"?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             BEHAIM IT Solutions                              -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : module.xsl                                                 -->
<!-- originator      : lsatin                                                     -->
<!-- edited by       : jkaspar                                                    -->
<!-- creation date   : 2016/02/09                                                 -->
<!-- description     : XSL template transfers BW XML file of type                 -->
<!--                   .bwm into DITA format.                      				  -->
<!-- ============================================================================ -->
<xsl:stylesheet version="1.0" 
	xmlns:java="http://xml.apache.org/xalan/java"
	xmlns:crproperty="com.behaim.commons.eagle.crossreference.project.CRProperty" 
	xmlns:manifest="CustomFunctions:java.util.jar.Manifest" 
	xmlns:set="CustomFunctions:java.util.HashSet" 
	xmlns:common="http://exslt.org/common" 
	xmlns:xalan="http://xml.apache.org/xalan" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:msv="http://tns.tibco.com/bw/model/core/moduleSV" 
	xmlns:jsv="http://tns.tibco.com/bw/model/core/jobSV" 
	xmlns:CustomFunctions="com.behaim.commons.xsl.CustomFunctions" 
	xmlns:CustomFunctionsEagle="com.behaim.commons.eagle.CustomFunctions" 
	xmlns:jndi="http://xsd.tns.tibco.com/amf/models/sharedresource/jndi" 
	xmlns:ncname="com.pikeelectronic.xsl.NCName" 
	xmlns:xpdExt="http://www.tibco.com/XPD/xpdExtension1.0.0" 
	xmlns:xpdl2="http://www.wfmc.org/2008/XPDL2.1" 
	xmlns:compositeext="http://schemas.tibco.com/amx/3.0/compositeext" 
	xmlns:sca="http://www.osoa.org/xmlns/sca/1.0" 
	xmlns:scaext="http://xsd.tns.tibco.com/amf/models/sca/extensions" 
	xmlns:map="xalan://java.util.Map" 
	extension-element-prefixes="map" 
	exclude-result-prefixes="xpdl2 ncname xpdExt java CustomFunctions CustomFunctionsEagle jndi sca scaext compositeext jsv msv xalan common manifest set crproperty">
<xsl:output encoding="utf-8" method="xml" indent="no"/>
	<xsl:param name="moduleJSV"/>
	<xsl:param name="moduleMSV"/>
	<xsl:param name="docJSV" select="document($moduleJSV)"/>
	<xsl:param name="docMSV" select="document($moduleMSV)"/>
	<xsl:param name="moduleMF" />
	<xsl:param name="textManifest"/>
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
	<xsl:param name="displayPathInTopicName" select="false()"/>
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
	<xsl:template match="/">
		<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE concept PUBLIC "-//OASIS//DTD DITA Concept//EN" "]]></xsl:text><xsl:value-of select="concat($mdcfg,'/dtd','/concept.dtd')"/><xsl:text disable-output-escaping="yes">"></xsl:text>  

		<concept id="ModuleMain" xml:lang="en-us">
			<title>
				<xsl:value-of select="'Module'"/>
			</title>
			<titlealts>
				<navtitle>				
					<xsl:value-of select="'Module'"/>
				</navtitle>
			</titlealts>
					<conbody>
						<p>
							<xsl:value-of select="CustomFunctions:initializeTemplate('module.xsl')"/>
						</p>
						<p>
							Section contains Module properties "
							<xsl:value-of select="$inputFileName"/>
							" .
						</p>
						<p>
							Name:
							<xsl:value-of select="/sca:composite/@name"/>
						</p>
					</conbody>
					
			<concept id="Overview">
				<title>Overview</title>
				<conbody>			    
			   		<ul>
			   			<li>ID: <xsl:value-of select="substring-before(substring-after($textManifest,'Bundle-SymbolicName: '),'&#xa;')"/></li>
			   			<li>Version: <xsl:value-of select="substring-before(substring-after($textManifest,'Bundle-Version: '),'&#xa;')"/></li>
			   			<li>Name: <xsl:value-of select="substring-before(substring-after($textManifest,'Bundle-Name: '),'&#xa;')"/></li>
			   			<li>Vendor: <xsl:value-of select="substring-before(substring-after($textManifest,'Bundle-Vendor: '),'&#xa;')"/></li>
			   			<li>Description: <xsl:value-of select="/sca:composite/@compositeext:description"/> </li>
			   		</ul>
				</conbody>
			</concept>
			
			<concept id="Module">
				<title>Module Properties</title>
				<conbody>
					<table>
						<tgroup cols="5">
							<colspec colname="name" colwidth="175*"/>
							<colspec colname="type" colwidth="75*"/>
							<colspec colname="publicAccess" colwidth="75*"/>
							<colspec colname="scalable" colwidth="75*"/>
							<colspec colname="description" colwidth="75*"/>
							<thead>
								<row>
									<entry colname="name" valign="top">Name</entry>
									<entry colname="type" valign="top">Type</entry>
									<entry colname="publicAccess" valign="top">Public Access</entry>
									<entry colname="scalable" valign="top">Scalable</entry>
									<entry colname="description" valign="top">Description</entry>
								</row>
							</thead>
							<tbody>
								<xsl:for-each select="/sca:composite/sca:property">
									<row>
										<entry><xsl:value-of select="@name"/></entry>
										<entry><xsl:value-of select="@type"/></entry>
										<entry>
											<xsl:choose>
												<xsl:when test="@publicAccess">	<xsl:value-of select="@publicAccess"/></xsl:when>
												<xsl:otherwise>false</xsl:otherwise>
											</xsl:choose>
										</entry>
										<entry><xsl:value-of select="@scalable"/></entry>
										<entry><xsl:value-of select="@description"/></entry>
									</row>
								</xsl:for-each>
							</tbody>
						</tgroup>
					</table>
				</conbody>
			</concept>
			
			<concept id="ModuleComponents">			
				<title>Module Components</title>
				<conbody>
					<table>
						<tgroup cols="3">
							<colspec colname="name" colwidth="175*"/>
							<colspec colname="process" colwidth="75*"/>
							<colspec colname="version" colwidth="75*"/>
							<thead>
								<row>
									<entry colname="name" valign="top">Name</entry>
									<entry colname="process" valign="top">Process Name</entry>
									<entry colname="version" valign="top">Version</entry>
								</row>
							</thead>
							<tbody>											
								<xsl:choose>
									<xsl:when test="/sca:composite/sca:component/@name or /sca:composite/sca:component/scaext:implementation/@processName or /sca:composite/sca:component/@compositeext:version">			
										<xsl:for-each select="/sca:composite/sca:component">	
											<row>								
												<entry><xsl:value-of select="@name"/></entry>
												<entry><xsl:value-of select="./scaext:implementation/@processName"/></entry>
												<entry><xsl:value-of select="@compositeext:version"/></entry>									
											</row>
										</xsl:for-each>
									</xsl:when>
									<xsl:otherwise><row><entry/><entry/><entry/></row></xsl:otherwise>
								</xsl:choose>							
							</tbody>
						</tgroup>
					</table>
				</conbody>
			</concept>
			
			<concept id="ModuleMSV">
				<title>Module Shared Variables</title>
				<conbody>					
					<xsl:apply-templates select="/" mode="msv"></xsl:apply-templates>
				</conbody>
			</concept>
			<concept id="ModuleJSV">
				<title>Module Job Shared Variables</title>
				<conbody>
					<xsl:apply-templates select="/" mode="jsv"></xsl:apply-templates>
				</conbody>
			</concept>
			 <concept id="ModuleMF">
				<title>Module Dependencies</title>
				<conbody>
					<xsl:apply-templates select="/" mode="mf"></xsl:apply-templates>
				</conbody>
			</concept>
		</concept>
	</xsl:template>
	
	<xsl:template match='/' mode="mf">	
		<xsl:variable name="moduleDependencies" select="CustomFunctions:getModuleDependencies($moduleMF)"/>
		<xsl:variable name="moduleDependenciesAsDocument" select="CustomFunctions:getModuleDependenciesAsDocument($moduleMF)"/>

		<xsl:if test="map:size($moduleDependencies) > 0">
			<table>
				<tgroup cols="2">
					<colspec colname="module" colwidth="175*"/>
					<colspec colname="filter" colwidth="75*"/>
					<thead>
						<row>
							<entry colname="module" valign="top">Namespace</entry>
							<entry colname="filter" valign="top">Module Filter</entry>
						</row>
					</thead>
					<tbody>
						<xsl:for-each select="$moduleDependenciesAsDocument/Dependencies/dependency">
							<row>
								<entry><xsl:value-of select="./value"/></entry>
								<entry><xsl:value-of select="./key"/></entry>
							</row>
						</xsl:for-each>
					</tbody>
				</tgroup>
			</table>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match='/' mode="msv">		
		<xsl:variable name="moduleSharedVariable" select="common:node-set($docMSV)/msv:DocumentRoot/moduleSharedVariables/moduleSharedVariable"/>
		<xsl:if test="count($moduleSharedVariable)">
			<table>
				<tgroup cols="2">
					<colspec colname="name" colwidth="175*"/>
					<colspec colname="type" colwidth="75*"/>
					<colspec colname="initialvalue" colwidth="75*"/>
					<colspec colname="description" colwidth="75*"/>
					<thead>
						<row>
							<entry colname="name" valign="top">Name</entry>
							<entry colname="type" valign="top">Type</entry>
							<entry colname="initialvalue" valign="top">Initial Value</entry>
							<entry colname="description" valign="top">Description</entry>
						</row>
					</thead>
					<tbody>
						<xsl:for-each select="$moduleSharedVariable">
							<row>
								<entry><xsl:value-of select="@name"/></entry>
								<entry><xsl:value-of select="@type"/></entry>
								<entry><xsl:call-template name="getValueFromLiteralModule">
									<xsl:with-param name="initialValueMode" select="@initialValueMode"/>
									<xsl:with-param name="value" select="@initialValue"/>
									<xsl:with-param name="defaultValue" select="''"/>
								</xsl:call-template></entry>
								<entry><xsl:value-of select="@description"/></entry>
							</row>
						</xsl:for-each>
					</tbody>
				</tgroup>
			</table>
		</xsl:if>
	</xsl:template>
	<xsl:template match='/' mode="jsv">		
		<xsl:variable name="jobSharedVariables" select="common:node-set($docJSV)/jsv:DocumentRoot/jobSharedVariables/jobSharedVariable"/>
		<xsl:if test="count($jobSharedVariables)">
			<table>
				<tgroup cols="2">
					<colspec colname="name" colwidth="175*"/>
					<colspec colname="type" colwidth="75*"/>
					<colspec colname="initialvalue" colwidth="75*"/>
					<colspec colname="description" colwidth="75*"/>
					<thead>
						<row>
							<entry colname="name" valign="top">Name</entry>
							<entry colname="type" valign="top">Type</entry>
							<entry colname="initialvalue" valign="top">Initial Value</entry>
							<entry colname="description" valign="top">Description</entry>
						</row>
					</thead>
					<tbody>
						<xsl:for-each select="$jobSharedVariables">
							<row>
								<entry><xsl:value-of select="@name"/></entry>
								<entry><xsl:value-of select="@type"/></entry>
								<entry><xsl:call-template name="getValueFromLiteralModule">
									<xsl:with-param name="initialValueMode" select="@initialValueMode"/>
									<xsl:with-param name="value" select="@initialValue"/>
									<xsl:with-param name="defaultValue" select="''"/>
								</xsl:call-template></entry>
								<entry><xsl:value-of select="@description"/></entry>
							</row>
						</xsl:for-each>
					</tbody>
				</tgroup>
			</table>
		</xsl:if>
	</xsl:template>	
	<!-- Helper templates -->
	<xsl:template name="getValueFromLiteralModule">
		<xsl:param name="initialValueMode"/>
		<xsl:param name="value"/>
		<xsl:param name="defaultValue"/>
		<xsl:choose>
			<xsl:when test="$value=''"/>	
			<xsl:when test="$initialValueMode='textfile'">
								<xsl:variable name="identityProviderFile" select="concat('../', translate($value,' ','_'), '.html')"/>
								<xsl:element name="xref">
									<xsl:attribute name="href"><xsl:value-of select="$identityProviderFile"/></xsl:attribute>
									<xsl:value-of select="$value"/>
								</xsl:element>
			</xsl:when>
			<xsl:when test="$value!=''">
				<xsl:value-of select="$value"/>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="$defaultValue"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template> 
</xsl:stylesheet>
