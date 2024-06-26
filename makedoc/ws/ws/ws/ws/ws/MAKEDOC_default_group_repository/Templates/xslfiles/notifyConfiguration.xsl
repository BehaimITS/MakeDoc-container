<?xml version="1.0" encoding="utf-8"?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             BEHAIM IT Solutions                              -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : notifyConfiguration.xsl                                    -->
<!-- originator      : tochmann                                                   -->
<!-- creation date   : 2018/07/13                                                 -->
<!-- description     : XSL template transfers BW XML file of type                 -->
<!--                   .notifyConfigurationResource into DITA format.             -->
<!-- ============================================================================ -->
<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:java="http://xml.apache.org/xalan/java"
xmlns:id="http://www.tibco.com/ws/2013/11/identity" 
xmlns:CustomFunctions="com.behaim.commons.xsl.CustomFunctions"
xmlns:CustomFunctionsEagle="com.behaim.commons.eagle.CustomFunctions" 
xmlns:sca_ext="http://www.tibco.com/ns/sca/201311" 
xmlns:jndi="http://xsd.tns.tibco.com/amf/models/sharedresource/jndi" 
xmlns:ncname="com.pikeelectronic.xsl.NCName" 
xmlns:xpdExt="http://www.tibco.com/XPD/xpdExtension1.0.0" 
xmlns:xpdl2="http://www.wfmc.org/2008/XPDL2.1" 
xmlns:PrimitiveTypeFacets="http:///schemas/PrimitiveTypeFacets/_8TmTUMtlEdy7K9XeCH7Hrw/0" 
xmlns:map="xalan://java.util.Map" 
extension-element-prefixes="map" 
exclude-result-prefixes="xpdl2 ncname xpdExt java CustomFunctions CustomFunctionsEagle PrimitiveTypeFacets jndi id sca_ext util"
xmlns:util="com.behaim.diagram.impl.bwd635.helper.BWDiagramUtil" >
<xsl:output encoding="utf-8" method="xml" indent="no"/>
	<xsl:param name="mdcfg"/>
	<xsl:param name="heading"/>
	<xsl:param name="level"/>
	<xsl:param name="designLib"/>
	<xsl:param name="isUseInputBindings"/>
	<xsl:param name="inputFileName"/>
	<xsl:param name="outputFileName"/>
	<xsl:param name="projectRoot"/>
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
	
		<concept id="NotifyConfigurationMain" xml:lang="en-us">
			<xsl:variable name="processName" select="substring-before($heading,'.notifyConfigurationResource')"/>
			<title>
				<xsl:value-of select="$processName"/>
			</title>
			<titlealts>
				<navtitle>
					<xsl:value-of select="$processName"/>
				</navtitle>
			</titlealts>
				<conbody>
					<p>
						<xsl:value-of select="CustomFunctions:initializeTemplate('notifyConfiguration.xsl')"/>
					</p>
					<p>
						Section contains description of Notify Configuration "
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
			
			<concept id="NotifyConfigurationBasic">
				<title>Notify Configuration Root Element</title>
				<conbody>
					<xsl:choose>
						<xsl:when test="boolean(imports)">
							<xsl:for-each select="imports">
							<p>
								<xsl:choose>
									<xsl:when test="./@location">
										<xsl:variable name="schemaLocation" select="./@location"/>
										<xsl:variable name="schemaNamePath" select="substring-after($schemaLocation, $schemasFolder)"/> 
										<xsl:variable name="schemaFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level), $schemasFolder, $schemaNamePath, '.dita')"/>
										<xsl:element name="xref">
											<xsl:attribute name="href"><xsl:value-of select="$schemaFile"/></xsl:attribute>
											<xsl:value-of select="$schemaNamePath"/>
										</xsl:element>
									</xsl:when>
									<xsl:otherwise>
										<xsl:element name="xref">
											<xsl:variable name="schemaFile" select="string(util:getImportedWsdlFileByNSpace(util:createNSpace('', ./@namespace)))"/>
											<xsl:attribute name="href"><xsl:value-of select="CustomFunctions:getSchemaDocumentationLink($level, $schemaFile, $inputFileName, $relativePath)" /></xsl:attribute>
											<xsl:value-of select="CustomFunctions:getSchemaDocumentationLink($level, $schemaFile, $inputFileName, $relativePath)"/>
										</xsl:element>		
									</xsl:otherwise>
								</xsl:choose>
							</p>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise><p>No root element exists</p></xsl:otherwise>
					</xsl:choose>
				</conbody>
			</concept>
		</concept>
	</xsl:template>
	
</xsl:stylesheet>



