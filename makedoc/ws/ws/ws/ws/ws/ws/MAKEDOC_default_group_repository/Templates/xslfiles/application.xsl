<?xml version="1.0" encoding="UTF-8"?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             BEHAIM IT Solutions                              -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : application.xsl                                            -->
<!-- originator      : jkaspar                                                    -->
<!-- creation date   : 2016/02/09                                                 -->
<!-- description     : XSL template transfers BW XML file of type                 -->
<!--                   TIBCO.xml into DITA format.                      		  -->
<!-- ============================================================================ -->
<xsl:stylesheet version="1.0" 
	xmlns:java="http://xml.apache.org/xalan/java"
	xmlns:manifest="CustomFunctions:java.util.jar.Manifest" 
	xmlns:set="xalan://java.util.Set" 
	xmlns:common="http://exslt.org/common" 
	xmlns:xalan="http://xml.apache.org/xalan" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:msv="http://tns.tibco.com/bw/model/core/moduleSV" 
	xmlns:jsv="http://tns.tibco.com/bw/model/core/jobSV" 
	xmlns:CustomFunctions="com.behaim.commons.xsl.CustomFunctions" 
	xmlns:CustomFunctionsEagle="com.behaim.commons.eagle.CustomFunctions" 
	xmlns:jndi="http://xsd.tns.tibco.com/amf/models/sharedresource/jndi" 
	xmlns:ncname="com.pikeelectronic.xsl.NCName"  
	xmlns:compositeext="http://schemas.tibco.com/amx/3.0/compositeext" 
	xmlns:sca="http://www.osoa.org/xmlns/sca/1.0" 
	xmlns:scaext="http://xsd.tns.tibco.com/amf/models/sca/extensions" 
	xmlns:packaging="http://schemas.tibco.com/tra/model/core/PackagingModel" 
	xmlns:map="xalan://java.util.Map" 
	extension-element-prefixes="map set" 
	exclude-result-prefixes="ncname java CustomFunctions CustomFunctionsEagle jndi sca scaext compositeext jsv msv xalan common manifest packaging">

	<xsl:output encoding="utf-8" method="xml" indent="no"/>
	<!-- <xsl:param name="moduleJSV"/>
	<xsl:param name="moduleMSV"/>
	<xsl:param name="docJSV" select="document($moduleJSV)"/>
	<xsl:param name="docMSV" select="document($moduleMSV)"/> -->
	<xsl:param name="mdcfg"/>
	<xsl:param name="heading"/>
	<xsl:param name="level"/>
	<xsl:param name="designLib"/>
	<xsl:param name="isUseInputBindings"/>
	<xsl:param name="inputFileName"/>
	<xsl:param name="ImageMapFolder"/>
	<xsl:param name="outputFileName"/>
	<xsl:param name="projectRoot"/>
	<xsl:param name="applicationName"/>
	<xsl:param name="relativePath"/>
	<xsl:param name="displayPathInTopicName" select="false()"/>
	<xsl:param name="ModificationTime"/>
	<xsl:param name="moduleMF" />
	<xsl:param name="textManifest" />
	<!--  type odf mapping - table, tree, raw >
    <xsl:param name="mappingType" select="'table'"/-->
	<!-- Special folder names -->
    <xsl:param name="wsdlFolder"/>
    <xsl:param name="processesFolder"/>
    <xsl:param name="schemasFolder"/>
    <xsl:param name="policiesFolder"/>
    <xsl:param name="resourcesFolder"/>
	<xsl:template match="/">
	<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE concept PUBLIC "-//OASIS//DTD DITA Concept//EN" "]]></xsl:text><xsl:value-of select="concat($mdcfg,'/dtd','/concept.dtd')"/><xsl:text disable-output-escaping="yes">"></xsl:text>  

		<concept id="ApplicationMain" xml:lang="en-us">
			<title>
				<xsl:value-of select="'Application'"/>
			</title>
			<titlealts>
				<navtitle>				
					<xsl:value-of select="'Application'"/>
				</navtitle>
			</titlealts>
			<conbody>
				<p>
					<xsl:value-of select="CustomFunctions:initializeTemplate('application.xsl')"/>
				</p>
				<p>
					Section contains description of Application "
					<xsl:value-of select="$heading"/>
					" .
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
			   			<li>Description: <xsl:value-of select="/packaging:packageUnit/packaging:description"/> </li>
			   		</ul>		   		
				</conbody>
			</concept>
			
			<concept id="ModuleProfile">
				<title>Module Profiles</title>
				<conbody>					
					<xsl:apply-templates select="/" mode="profiles"></xsl:apply-templates>
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
					<colspec colname="constraint" colwidth="75*"/>
					<thead>
						<row>
							<entry colname="name" valign="top">Name</entry>
							<entry colname="type" valign="top">Type</entry>
							<entry colname="publicAccess" valign="top">Public Access</entry>
							<entry colname="scalable" valign="top">Scalable</entry>
							<entry colname="override" valign="top">Override</entry>
						</row>
					</thead>
					
					<tbody>
						<xsl:for-each select="/packaging:packageUnit/packaging:properties/packaging:property">
							<row>
								<entry><xsl:value-of select="packaging:name"/></entry>
								<entry><xsl:value-of select="packaging:type"/></entry>
								<entry><xsl:value-of select="packaging:visibility"/></entry>
								<entry><xsl:value-of select="packaging:scalable"/></entry>
								<entry><xsl:value-of select="packaging:overrideValue"/></entry>
							</row>
						</xsl:for-each>
					</tbody>
				</tgroup>
			</table>
		</conbody>
		</concept>
			
		<concept id="ModuleIncludes">
			
			<title>Module Includes</title>
			<conbody>
				<table>
					<tgroup cols="3">
						<colspec colname="name" colwidth="175*"/>
						<colspec colname="type" colwidth="75*"/>
						<colspec colname="version" colwidth="75*"/>
						<thead>
							<row>
								<entry colname="name" valign="top">Name</entry>
								<entry colname="type" valign="top">Type</entry>
								<entry colname="version" valign="top">Version</entry>
							</row>
						</thead>
						<tbody>
							<xsl:for-each select="/packaging:packageUnit/packaging:modules/packaging:module">
								<row>
									<entry><xsl:value-of select="packaging:symbolicName"/></entry>
									<entry><xsl:value-of select="packaging:technologyType"/></entry>
									<entry><xsl:value-of select="packaging:technologyVersion"/></entry>
								</row>
							</xsl:for-each>
						</tbody>
					</tgroup>
				</table>
			</conbody>
		</concept>
			<!-- <concept id="ModuleMSV">
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
			</concept> -->
		</concept>
		
	</xsl:template>
	
	<xsl:template match='/' mode="profiles">	

		<xsl:variable name="profilesTable" select="CustomFunctionsEagle:getAllProfileInfo($applicationName)"/>
		<xsl:variable name="profilesList" select="CustomFunctionsEagle:getProfileList($applicationName)"/>
		<xsl:variable name="profilesListDocument" select="CustomFunctionsEagle:getProfileListAsDocument($applicationName)"/>
		<xsl:variable name="loopInc" select="0"/>
		<xsl:variable name="profileSize" select="set:size($profilesList)"/>
		<xsl:if test="map:size($profilesTable) > 0">
			<table>
				<tgroup cols="{$profileSize}">
					<colspec colnum="propertyName" colname="propertyName" colwidth="1*"/>
					<xsl:for-each select="$profilesListDocument/Profiles/profile">
						<xsl:variable name="loopInc" select="$loopInc + 1" />
						<colspec colnum="{$loopInc}" colname="col{$loopInc}" colwidth="1*"/>
					</xsl:for-each>
					<thead>
						<row>
							<entry valign="top">Module Property Name</entry>
							<xsl:for-each select="$profilesListDocument/Profiles/profile">
								<entry valign="top"><xsl:value-of select="."/></entry>
							</xsl:for-each>
						</row>
					</thead>
					<tbody>
						<xsl:for-each select="/packaging:packageUnit/packaging:properties/packaging:property">
							<xsl:variable name="propertyName" select="packaging:name"/>
							<row>
								<entry id="{ncname:transformToNCName($propertyName)}" namest="col1" nameend="col{$profileSize}" align="left"><b><xsl:value-of select="$propertyName"/></b></entry>
								<xsl:for-each select="$profilesListDocument/Profiles/profile">
									<xsl:variable name="currentProfile" select="."/>
									<entry>										
										<xsl:value-of select="CustomFunctionsEagle:getModulePropertyValueForProfile($propertyName,$currentProfile,$applicationName)"/>	
									</entry>	
								</xsl:for-each>
							</row>
						</xsl:for-each>
					</tbody>
				</tgroup>
			</table>
		</xsl:if>
	</xsl:template>
	
	<!--<xsl:template match='/' mode="mf">	
		<xsl:variable name="moduleDependencies" select="CustomFunctions:getModuleDependencies($moduleMF)"/>
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
						<xsl:for-each select="common:node-set(map:keySet($moduleDependencies))">
							<row>
								<xsl:variable name="key" select="."/>
								<entry><xsl:value-of select="map:get($moduleDependencies, string($key))"/></entry>
								<entry><xsl:value-of select="."/></entry>
							</row>
						</xsl:for-each>
					</tbody>
				</tgroup>
			</table>
		</xsl:if>
	</xsl:template>-->
</xsl:stylesheet>
