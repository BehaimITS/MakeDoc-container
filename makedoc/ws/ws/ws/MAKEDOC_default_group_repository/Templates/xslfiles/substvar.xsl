<?xml version="1.0" encoding="utf-8"?>
<?altova_samplexml C:\Java\Repare_IN\defaultVars\defaultVars.substvar?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             PIKE ELECTRONIC                                  -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : substvar.xsl                                               -->
<!-- originator      : Hozakova, changed Chladek                                  -->
<!-- creation date   : 2007/02/27                                                 -->
<!-- description     : XSL template transfers BW XML file of type .substvar into  -->
<!--                   DITA format.                                               -->
<!-- ============================================================================ -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:java="http://xml.apache.org/xalan/java" 
	xmlns:CustomFunctions="com.behaim.commons.xsl.CustomFunctions"
	xmlns:ncname="com.pikeelectronic.xsl.NCName"
	exclude-result-prefixes="java ncname CustomFunctions">
	<xsl:output encoding="utf-8" method="xml" />

	<!-- Parameters passed by java XSL transformer launcher -->
	<xsl:param name="mdcfg"/>
	<xsl:param name="heading" />
	<xsl:param name="designLib" />
	<xsl:param name="inputFileName" />
	<xsl:param name="outputFileName" />
	<xsl:param name="relativePath" /><!-- added by jsalomoun - relative 
		path of the file in project directory -->
	<xsl:param name="displayPathInTopicName" select="false" /><!-- 
		added by jsalomoun - for displaying whole relative path - default value: 
		'false' -->
	<!-- added by mrozsypal - for displaying last modification time of object 
		(system time) -->
	<xsl:param name="ModificationTime" />
	<!-- =================================== NOTES: ===================================== 
		STRUCTURE: - main concept Substvar contains concept GlobalVariables TODO: 
		- vyresit formatovani * u konfliktu ================================================================================ -->

	<!-- Match document root tag -->
	<xsl:template match="/">
		<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE concept PUBLIC "-//OASIS//DTD DITA Concept//EN" "]]></xsl:text><xsl:value-of select="concat($mdcfg,'/dtd','/concept.dtd')"/><xsl:text disable-output-escaping="yes">"></xsl:text>
		<concept id="Substvar" xml:lang="en-us">
			<!--title> <xsl:value-of select="$heading"/> - BusinessWorks Global Variables 
				</title -->
			<title>
				<xsl:value-of select="$inputFileName" />
			</title>
			<titlealts>
				<navtitle>
					<xsl:value-of select="concat($heading,'/',$inputFileName)" />
				</navtitle>
			</titlealts>
			<conbody>
				<xsl:choose>
					<xsl:when test="$designLib != ''">
						<p>
							<xsl:value-of select="CustomFunctions:initializeTemplate('substvar.xsl')"/>
						</p>
						<p>
							Section contains description of Global Variables "
							<xsl:value-of select="$heading" />
							"
						</p>
						<xsl:if test="CustomFunctions:shallGeneratePart('substvar/modificationTime')">
							<p>
								Modification time:
								<xsl:value-of select="$ModificationTime" />
							</p>
						</xsl:if>
						<p>
							Source Library: "
							<xsl:value-of select="$designLib" />
							"
						</p>
					</xsl:when>
					<xsl:otherwise>
						<p>
							<xsl:value-of select="CustomFunctions:initializeTemplate('substvar.xsl')"/>
						</p>
						<p>
							Section contains description of Global Variables "
							<xsl:value-of select="$inputFileName" />
							"
						</p>
						<xsl:if test="CustomFunctions:shallGeneratePart('substvar/modificationTime')">
							<p>
								Modification time:
								<xsl:value-of select="$ModificationTime" />
							</p>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:apply-templates select="//*[local-name()='repository']" />
			</conbody>
		</concept>
	</xsl:template>

	<!-- Match <globalVariables> tag, contains all other tags -->
	<xsl:template match="*[local-name()='globalVariables']">
		<xsl:variable name="designLibs">
			<xsl:choose>
				<xsl:when test="*[local-name()='globalVariable']/designLib">
					<xsl:text>true</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>false</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$designLibs = 'true'">
				<xsl:if
					test="count(*[local-name()='globalVariable'])>0 and CustomFunctions:shallGeneratePart('substvar/name')">
					<ul>
						<!-- Iterate over all <globalVariable> tags if any -->
						<xsl:for-each select="*[local-name()='globalVariable']">
							<xsl:choose>
								<xsl:when test="designLib != ''">
									<li>
										<p><xsl:attribute name="id"><xsl:value-of select="ncname:transformToNCName(./name)" /></xsl:attribute>
										<b>Name: </b>
										<xsl:if test="hasConflict='true'">
											<u>*</u>
										</xsl:if>
										<xsl:value-of select="./name" />
										<ul>
											<li>
												<b>Value: </b>
												<xsl:choose>
													<xsl:when test="(type='Password') and (starts-with(value,'#!'))">
														*****
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="*[local-name()='value']" />
													</xsl:otherwise>
												</xsl:choose>
											</li>
  										<xsl:if test="*[local-name()='type'] != ''">
   											<li>
   											 <b>Type: </b><xsl:value-of select="*[local-name()='type']" />
   											</li>
  										</xsl:if>
  										<xsl:if test="*[local-name()='description'] != ''">
  											<li>
  											 <b>Description: </b><xsl:value-of select="*[local-name()='description']" />
  											</li>
  										</xsl:if>
  										<xsl:if test="*[local-name()='deploymentSettable'] != ''">
   											<li>
   											 <b>Deployment Settable: </b><xsl:value-of select="*[local-name()='deploymentSettable']" />
   											</li>
  										</xsl:if>
  										<xsl:if test="*[local-name()='serviceSettable'] != ''">
   											<li>
   											 <b>Service Settable: </b><xsl:value-of select="*[local-name()='serviceSettable']" />
   											</li>
  										</xsl:if>
  										<xsl:if test="*[local-name()='constraint'] != ''">
  											<li>
  											 <b>Constraint: </b><xsl:value-of select="*[local-name()='constraint']" />
  											</li>
  										</xsl:if>
  										<xsl:if test="*[local-name()='modTime'] != ''">
   											<li>
   											 <b>Modification Time: </b><xsl:value-of select="*[local-name()='modTime']" />
   											</li>
  										</xsl:if>
											<li>
												<b>Design Library: </b>
												<xsl:value-of select="*[local-name()='designLib']" />
											</li>
										</ul>
										</p>
									</li>
								</xsl:when>
								<xsl:otherwise>
									<li>
										<p><xsl:attribute name="id"><xsl:value-of select="ncname:transformToNCName(./name)" /></xsl:attribute>
										<b>Name: </b>
										<xsl:if test="conflict='true'">
											<u>*</u>
										</xsl:if>
										<xsl:value-of select="./name" />
										<ul>
											<li>
												<b>Value: </b>
												<xsl:choose>
													<xsl:when test="(type='Password') and (starts-with(value,'#!'))">
														*****
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="*[local-name()='value']" />
													</xsl:otherwise>
												</xsl:choose>
											</li>
  										<xsl:if test="*[local-name()='type'] != ''">
   											<li>
   											 <b>Type: </b><xsl:value-of select="*[local-name()='type']" />
   											</li>
  										</xsl:if>
  										<xsl:if test="*[local-name()='description'] != ''">
  											<li>
  											 <b>Description: </b><xsl:value-of select="*[local-name()='description']" />
  											</li>
  										</xsl:if>
  										<xsl:if test="*[local-name()='deploymentSettable'] != ''">
   											<li>
   											 <b>Deployment Settable: </b><xsl:value-of select="*[local-name()='deploymentSettable']" />
   											</li>
  										</xsl:if>
  										<xsl:if test="*[local-name()='serviceSettable'] != ''">
   											<li>
   											 <b>Service Settable: </b><xsl:value-of select="*[local-name()='serviceSettable']" />
   											</li>
  										</xsl:if>
  										<xsl:if test="*[local-name()='constraint'] != ''">
  											<li>
  											 <b>Constraint: </b><xsl:value-of select="*[local-name()='constraint']" />
  											</li>
  										</xsl:if>
  										<xsl:if test="*[local-name()='modTime'] != ''">
   											<li>
   											 <b>Modification Time: </b><xsl:value-of select="*[local-name()='modTime']" />
   											</li>
  										</xsl:if>
											<li>
												<b>Design Library: </b>
												<xsl:value-of select="*[local-name()='designLib']" />
											</li>
										</ul>
										</p>
									</li>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</ul>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if
					test="count(*[local-name()='globalVariable'])>0 and CustomFunctions:shallGeneratePart('substvar/name')">
					<ul>
						<!-- Iterate over all <globalVariable> tags if any -->
						<xsl:for-each select="*[local-name()='globalVariable']">
							<xsl:choose>
								<xsl:when test="designLib != ''">
									<li>
									<p><xsl:attribute name="id"><xsl:value-of select="ncname:transformToNCName(./name)" /></xsl:attribute>
										<b>Name: </b>
										<xsl:if test="hasConflict='true'">
											<u>*</u>
										</xsl:if>
										<xsl:value-of select="./name" />
										<ul>
											<li>
												<b>Value: </b>
												<xsl:choose>
													<xsl:when test="(type='Password') and (starts-with(value,'#!'))">
														*****
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="*[local-name()='value']" />
													</xsl:otherwise>
												</xsl:choose>
											</li>
  										<xsl:if test="*[local-name()='type'] != ''">
   											<li>
   											 <b>Type: </b><xsl:value-of select="*[local-name()='type']" />
   											</li>
  										</xsl:if>
  										<xsl:if test="*[local-name()='description'] != ''">
  											<li>
  											 <b>Description: </b><xsl:value-of select="*[local-name()='description']" />
  											</li>
  										</xsl:if>
  										<xsl:if test="*[local-name()='deploymentSettable'] != ''">
   											<li>
   											 <b>Deployment Settable: </b><xsl:value-of select="*[local-name()='deploymentSettable']" />
   											</li>
  										</xsl:if>
  										<xsl:if test="*[local-name()='serviceSettable'] != ''">
   											<li>
   											 <b>Service Settable: </b><xsl:value-of select="*[local-name()='serviceSettable']" />
   											</li>
  										</xsl:if>
  										<xsl:if test="*[local-name()='constraint'] != ''">
  											<li>
  											 <b>Constraint: </b><xsl:value-of select="*[local-name()='constraint']" />
  											</li>
  										</xsl:if>
  										<xsl:if test="*[local-name()='modTime'] != ''">
   											<li>
   											 <b>Modification Time: </b><xsl:value-of select="*[local-name()='modTime']" />
   											</li>
  										</xsl:if>
										</ul>
										</p>
									</li>
								</xsl:when>
								<xsl:otherwise>
									<li>
									<p><xsl:attribute name="id"><xsl:value-of select="ncname:transformToNCName(./name)" /></xsl:attribute>
										<b>Name: </b>
										<xsl:if test="conflict='true'">
											<u>*</u>
										</xsl:if>
										<xsl:value-of select="./name" />
										<ul>
											<li>
												<b>Value: </b>
												<xsl:choose>
													<xsl:when test="(type='Password') and (starts-with(value,'#!'))">
														*****
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="*[local-name()='value']" />
													</xsl:otherwise>
												</xsl:choose>
											</li>
  										<xsl:if test="*[local-name()='type'] != ''">
   											<li>
   											 <b>Type: </b><xsl:value-of select="*[local-name()='type']" />
   											</li>
  										</xsl:if>
  										<xsl:if test="*[local-name()='description'] != ''">
  											<li>
  											 <b>Description: </b><xsl:value-of select="*[local-name()='description']" />
  											</li>
  										</xsl:if>
  										<xsl:if test="*[local-name()='deploymentSettable'] != ''">
   											<li>
   											 <b>Deployment Settable: </b><xsl:value-of select="*[local-name()='deploymentSettable']" />
   											</li>
  										</xsl:if>
  										<xsl:if test="*[local-name()='serviceSettable'] != ''">
   											<li>
   											 <b>Service Settable: </b><xsl:value-of select="*[local-name()='serviceSettable']" />
   											</li>
  										</xsl:if>
  										<xsl:if test="*[local-name()='constraint'] != ''">
  											<li>
  											 <b>Constraint: </b><xsl:value-of select="*[local-name()='constraint']" />
  											</li>
  										</xsl:if>
  										<xsl:if test="*[local-name()='modTime'] != ''">
   											<li>
   											 <b>Modification Time: </b><xsl:value-of select="*[local-name()='modTime']" />
   											</li>
  										</xsl:if>
										</ul>
										</p>
									</li>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</ul>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
<!-- =============================== END OF FILE ================================ -->

