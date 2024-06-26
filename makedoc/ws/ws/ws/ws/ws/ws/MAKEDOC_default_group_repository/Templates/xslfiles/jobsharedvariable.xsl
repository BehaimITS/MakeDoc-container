<?xml version="1.0" encoding="utf-8"?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             PIKE ELECTRONIC                                  -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : jobsharedvariable.xsl                                      -->
<!-- originator      : ljezek                                                     -->
<!-- creation date   : 2008/05/23                                                 -->
<!-- description     : XSL template transfers BW XML file of type                 -->
<!--                   .jobsharedvariable into DITA format.                       -->
<!-- ============================================================================ -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:java="http://xml.apache.org/xalan/java"
	xmlns:CustomFunctions="com.behaim.commons.xsl.CustomFunctions"
	xmlns:CustomFunctionsEagle="com.behaim.commons.eagle.CustomFunctions"
	exclude-result-prefixes="java CustomFunctions CustomFunctionsEagle"
	xmlns:str="http://exslt.org/strings" 
	extension-element-prefixes="str">
	<xsl:output encoding="utf-8" method="xml" />

	<!-- Parameters passed by java XSL transformer launcher -->
	<xsl:param name="mdcfg"/>
	<xsl:param name="heading" />
	<xsl:param name="designLib" />
	<xsl:param name="outputFileName" />
	<xsl:param name="inputFileName" />
	<xsl:param name="relativePath" /><!-- added by jsalomoun - relative 
		path of the file in project directory -->
	<xsl:param name="displayPathInTopicName" select="false" /><!-- 
		added by jsalomoun - for displaying whole relative path - default value: 
		'false' -->

	<!-- Global parameters -->
	<xsl:param name="saName" />

	<!-- added by mrozsypal - for displaying last modification time of object 
		(system time) -->
	<xsl:param name="ModificationTime" />
	<xsl:param name="folderDescription"/>
	<!-- Special folder names -->
    <xsl:param name="wsdlFolder"/>
    <xsl:param name="processesFolder"/>
    <xsl:param name="schemasFolder"/>
    <xsl:param name="policiesFolder"/>
    <xsl:param name="resourcesFolder"/>
	<!-- Match document root tag -->
	<xsl:template match="/">
		<xsl:param name="saName"
			select="substring-before($heading, '.jsv')" />
		<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE concept PUBLIC "-//OASIS//DTD DITA Concept//EN" "]]></xsl:text><xsl:value-of select="concat($mdcfg,'/dtd','/concept.dtd')"/><xsl:text disable-output-escaping="yes">"></xsl:text>
		<concept id="JobSharedVariable" xml:lang="en-us">
			<title>Job Shared Variables</title>
			<titlealts>
				<navtitle>
					<xsl:choose>
						<xsl:when test="$displayPathInTopicName">
							<xsl:value-of select="substring-before($relativePath, '.jsv')" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$saName" />
						</xsl:otherwise>
					</xsl:choose>
				</navtitle>
			</titlealts>
			<xsl:choose>
				<xsl:when test="$designLib != ''">
					<conbody>
						<p>
							<xsl:value-of select="CustomFunctions:initializeTemplate('jobsharedvariable.xsl')"/>
						</p>
						<p>
							Section contains description of Job Shared Variable "
							<xsl:value-of select="$heading" />
							" .
						</p>
						<xsl:if
							test="CustomFunctions:shallGeneratePart('jobSharedVariable/modificationTime')">
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
					</conbody>
				</xsl:when>
				<xsl:otherwise>
					<conbody>
						<p>
							<xsl:value-of select="CustomFunctions:initializeTemplate('jobsharedvariable.xsl')"/>
						</p>
						<p>
							Section contains description of Job Shared Variable "
							<xsl:value-of select="$heading" />
							" .
						</p>
						
						<xsl:if
							test="CustomFunctions:shallGeneratePart('jobSharedVariable/modificationTime')">
							<p>
								Modification time:
								<xsl:value-of select="$ModificationTime" />
							</p>
						</xsl:if>				
					</conbody>
		<concept id="table">
		<title>Job Shared Variables</title>
		<conbody>	
		
		<xsl:variable name="jobSharedVariables" select="./*[local-name()='DocumentRoot']/jobSharedVariables/jobSharedVariable"/>
		<xsl:if test="count($jobSharedVariables)">
			<table>
				<tgroup cols="2">
					<colspec colname="name" colwidth="95*"/>
					<colspec colname="type" colwidth="75*"/>
					<colspec colname="location" colwidth="75*"/>
					<colspec colname="initialvaluemode" colwidth="75*"/>
					<colspec colname="initialvalue" colwidth="75*"/>
					<colspec colname="description" colwidth="75*"/>
					<thead>
						<row>
							<entry colname="name" valign="top">Name</entry>
							<entry colname="type" valign="top">Type</entry>
							<entry colname="location" valign="top">Location</entry>
							<entry colname="initialvaluemode" valign="top">Initial Value Mode</entry>
							<entry colname="initialvalue" valign="top">Initial Value</entry>
							<entry colname="description" valign="top">Description</entry>
						</row>
					</thead>
					<tbody>
						<xsl:for-each select="$jobSharedVariables">
							<row>
								<entry><xsl:value-of select="@name"/></entry>
								<entry><xsl:value-of select="@type"/></entry>
								<xsl:variable name="importNamespace" select="substring-before(substring-after(@type,'{'),'}')"/>								
								<entry><xsl:call-template name="getLocation">
									<xsl:with-param name="value" select="//import[@namespace=$importNamespace]/@location"/>
								</xsl:call-template></entry>
								<entry><xsl:call-template name="getInitialValueMode">
									<xsl:with-param name="initialValueMode" select="@initialValueMode"/>
									</xsl:call-template>
								</entry>								
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
	
		</conbody>
		</concept>
				</xsl:otherwise>
			</xsl:choose>
			<!-- xsl:apply-templates select="//*[local-name()='BWSharedResource']" /-->
			
		</concept>
	</xsl:template>

	<!-- xsl:template match="*[local-name()='BWSharedResource']">
		<xsl:variable name="description" select="*[local-name()='description']" />
		<xsl:value-of
			select="CustomFunctions:checkNoDescription(string($inputFileName),string($saName),string($description),'variables/job')" />
		<xsl:if	test="CustomFunctions:shallGeneratePart('jobSharedVariable/folderDescription')">
		<concept id="FolderDescription" xml:lang="en-us">
			<title>Folder description:</title>
			<conbody>
				<table>
					<tgroup cols="2">
					<colspec colname="folder" colwidth="75*"/>
					<colspec colname="desc" colwidth="175*"/>
					<thead>
					<row>
						<entry colname="folder" valign="top">Folder</entry>
						<entry colname="desc" valign="top">Description</entry>
					</row>
					</thead>
					
						<tbody>
						<xsl:choose>
							<xsl:when test="string-length($folderDescription)=0">
								<row><entry></entry><entry>No description</entry></row>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of disable-output-escaping="yes" select="$folderDescription"/>
							</xsl:otherwise>
						</xsl:choose>
							
						</tbody>
					</tgroup>
				</table>
			</conbody>
		</concept>
		</xsl:if>
		<concept id="SharedVariableDescription" xml:lang="en-us">
			<title>Job Shared Variable description:</title>
			<conbody>
				<table>
					<tgroup cols="1">
						<tbody>
							<row>
								<entry>
									<xsl:choose>
										<xsl:when test="*[local-name()='description']">
											<xsl:value-of select="$description" />
										</xsl:when>
										<xsl:otherwise>
											No description
										</xsl:otherwise>
									</xsl:choose>
								</entry>
							</row>
						</tbody>
					</tgroup>
				</table>
			</conbody>
		</concept>
		
		<xsl:apply-templates select="//*[local-name()='config']" />
	</xsl:template>

	<xsl:template match="*[local-name()='config']">
		<concept id="SharedVariableConfiguration" xml:lang="en-us">
			<title>Job Shared Variable configuration:</title>
			<conbody>
				<p>
					<xsl:choose>
						<xsl:when test="*[local-name()='initialValue']">
							<xsl:variable name="initialvalue" select="*[local-name()='initialValue']" />
							<xsl:choose>
								<xsl:when test="$initialvalue = 'none'">
									<ul>
										<li>Initial Value: None</li>
									</ul>
								</xsl:when>
								<xsl:when test="$initialvalue = 'byRef'">
									<ul>
										<li>
											Initial Value: Select Value
											<ul>
												<li>
													<xsl:value-of select="*[local-name()='initialValueRef']" />
												</li>
											</ul>
										</li>
									</ul>
								</xsl:when>
								<xsl:when test="$initialvalue = 'byData'">
									<ul>
										<li>Initial Value: Build Value</li>
									</ul>
									<xsl:variable name="BuildValue"
										select="*[local-name()='initialValueData']" />
									<xsl:variable name="BuildValue"
										select="normalize-space(substring-after($BuildValue,'&gt;'))" />
									<table>
										<xsl:if test="$BuildValue != ''">
											<tgroup cols="2">
												<colspec colname="variable"></colspec>
												<colspec colname="value"></colspec>
												<thead>
													<row>
														<entry colname="variable">Variable</entry>
														<entry colname="value">Value</entry>
													</row>
												</thead>
												<tbody>
													<xsl:call-template name="printBuildValue">
														<xsl:with-param name="Value" select="$BuildValue" />
													</xsl:call-template>
												</tbody>
											</tgroup>
										</xsl:if>
										<xsl:if test="$BuildValue = ''">
											<tgroup cols="1">
												<tbody>
													<row>
														<entry>no value</entry>
													</row>
												</tbody>
											</tgroup>
										</xsl:if>
									</table>
								</xsl:when>
								<xsl:otherwise>
									<p>
										Initial Value:
										<xsl:value-of select="*[local-name()='initialValue']" />
									</p>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
					</xsl:choose>
				</p>
			</conbody>
		</concept>
		<xsl:if test="*[local-name()='xsdString']">
			<xsl:variable name="schema" select="*[local-name()='xsdString']" />
			<xsl:if test="$schema != ''">
				<concept id="ProcessVariables" xml:lang="en-us">
					<title>Job Shared Variable schema:</title>
					<conbody>
						<p>
							<ul-->
								<!--xsl:apply-templates select="*[local-name()='xsdString']"/ --><!-- 
								<xsl:apply-templates select="*[local-name()='xsdString']"
									mode="configNode" />
							</ul>
						</p>
					</conbody>
				</concept>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template name="printBuildValue">
		<xsl:param name="Value" />
		<xsl:for-each select="str:tokenize(string($Value),'&gt;[ ]*&lt;')">
			<xsl:if test="contains(string(.),'&lt;/')">
				<row>
					<entry>
						<xsl:value-of select="substring-before(string(.),'&gt;')" />
					</entry>
					<entry>
						<xsl:value-of
							select="substring-before(substring-after(string(.),'&gt;'),'&lt;')" />
					</entry>
				</row>
			</xsl:if>
			<xsl:if test="substring(string(.), (string-length(string(.)) - string-length('/')) + 1) = '/'">
				<row>
					<entry>
						<xsl:value-of select="substring-before(string(.),'/')" />
					</entry>
					<entry>no value</entry>
				</row>
			</xsl:if>
			<xsl:if test="substring(string(.), (string-length(string(.)) - string-length('/&gt;')) + 1) = '/&gt;'">
				<row>
					<entry>
						<xsl:value-of select="substring-before(substring-after(string(.),'&lt;'),'/&gt;')" />
					</entry>
					<entry>no value</entry>
				</row>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="*[local-name()='xsdString']">
		<xsl:apply-templates select="*" mode="configElement" />
	</xsl:template>

	<xsl:template match="*" mode="configElement">
		<xsl:choose>
			<xsl:when test="@ref != ''">
				<li>
					-
					<xsl:apply-templates select="." mode="configReference" />
				</li>
			</xsl:when>
			<xsl:when test="@type != ''">
				<li>
					-
					<xsl:call-template name="printReference">
						<xsl:with-param name="contextNode" select="." />
						<xsl:with-param name="reference" select="@type" />
						<xsl:with-param name="name" select="@name" />
						<xsl:with-param name="referenceType" select="'type'" />
					</xsl:call-template>
					<xsl:text> (</xsl:text>
					<xsl:value-of select="@type" />
					<xsl:text>, </xsl:text>
					<xsl:apply-templates select="." mode="nodeCardinality" />
					<xsl:text>)</xsl:text>
				</li>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="*" mode="configNode" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="*" mode="nodeCardinality">
		<xsl:choose>
			<xsl:when test="@minOccurs=0">
				<xsl:choose>
					<xsl:when test="@maxOccurs='unbounded'">
						<xsl:text>repeating</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>optional</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="@maxOccurs='unbounded'">
						<xsl:text>at least one</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>required</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="*" mode="configNode">
		<xsl:choose-->
			<!-- xsd:element --><!-- 
			<xsl:when test="local-name() = 'element'">
				<xsl:apply-templates select="." mode="configElement" />
			</xsl:when-->
			<!-- xsd:complex-type --><!-- 
			<xsl:when test="local-name() = 'complexType'">
				<li>
					+
					<xsl:value-of select="../@name" />
					(Complex Type,
					<xsl:apply-templates select="." mode="nodeCardinality" />
					)
					<xsl:if test="count(child::*) &gt; 0">
						<xsl:if
							test="not(count(child::*) = 1 and local-name(child::*[1]) = 'sequence' and count(child::*[1]/child::*) = 0)">
							<ul>
								<xsl:apply-templates select="*" mode="configNode" />
							</ul>
						</xsl:if>
					</xsl:if>
				</li>
			</xsl:when-->
			<!-- xsd:sequence --><!-- 
			<xsl:when test="local-name() = 'sequence'">
				<xsl:choose>
					<xsl:when test="local-name(..) != 'complexType'">
						<li>
							+(Sequence,
							<xsl:apply-templates select="." mode="nodeCardinality" />
							)
							<xsl:if test="count(child::*) &gt; 0">
								<p>
									<ul>
										<xsl:apply-templates select="*" mode="configNode" />
									</ul>
								</p>
							</xsl:if>
						</li>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="*" mode="configNode" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when-->
			<!-- xsl:choice --><!-- 
			<xsl:when test="local-name() = 'choice'">
				<li>
					+(Choice,
					<xsl:apply-templates select="." mode="nodeCardinality" />
					)
					<xsl:if test="count(child::*) &gt; 0">
						<ul>
							<xsl:apply-templates select="*" mode="configNode" />
						</ul>
					</xsl:if>
				</li>
			</xsl:when-->
			<!-- xsl:all --><!-- 
			<xsl:when test="local-name() = 'all'">
				<li>
					+(All,
					<xsl:apply-templates select="." mode="nodeCardinality" />
					)
					<xsl:if test="count(child::*) &gt; 0">
						<ul>
							<xsl:apply-templates select="*" mode="configNode" />
						</ul>
					</xsl:if>
				</li>
			</xsl:when-->
			<!-- xsl:any --><!-- 
			<xsl:when test="local-name() = 'any'">
				<li>
					-(Any Element,
					<xsl:apply-templates select="." mode="nodeCardinality" />
					)
				</li>
			</xsl:when-->
			<!-- xsl:group --><!-- 
			<xsl:when test="local-name() = 'group'">
				<li>
					-
					<xsl:apply-templates select="." mode="configReference" />
				</li>
			</xsl:when-->
			<!-- xsl:attribute --><!-- 
			<xsl:when test="local-name() = 'attribute'">
				<li>
					-
					<xsl:choose>
						<xsl:when test="@use != ''">
							<xsl:text>@</xsl:text>
							<xsl:call-template name="printReference">
								<xsl:with-param name="contextNode" select="." />
								<xsl:with-param name="reference" select="@type" />
								<xsl:with-param name="name" select="@name" />
								<xsl:with-param name="referenceType" select="'type'" />
							</xsl:call-template>
							<xsl:text> (</xsl:text>
							<xsl:value-of select="@type" />
							<xsl:text>, </xsl:text>
							<xsl:value-of select="@use" />
							<xsl:text>)</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>@</xsl:text>
							<xsl:call-template name="printReference">
								<xsl:with-param name="contextNode" select="." />
								<xsl:with-param name="reference" select="@type" />
								<xsl:with-param name="name" select="@name" />
								<xsl:with-param name="referenceType" select="'type'" />
							</xsl:call-template>
							<xsl:text> (</xsl:text>
							<xsl:value-of select="@type" />
							<xsl:text>, optional)</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</li>
			</xsl:when-->
			<!-- Do general output (shouldn't get there) --><!-- 
			<xsl:otherwise>
				<li>
					-
					<xsl:value-of select="local-name()" />
				</li>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="*" mode="configReference">
		<xsl:variable name="reference" select="@ref" />
		<xsl:variable name="localName">
			<xsl:choose>
				<xsl:when test="$reference != ''">
					<xsl:value-of select="local-name($reference)" />
				</xsl:when>
				<xsl:otherwise><xsl:text>(unknown)</xsl:text></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="referenceType">
			<xsl:choose>
				<xsl:when test="local-name(.) = 'group'">group</xsl:when>
				<xsl:otherwise>element</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="printReference">
			<xsl:with-param name="contextNode" select="." />
			<xsl:with-param name="reference" select="$reference" />
			<xsl:with-param name="name" select="$localName" />
			<xsl:with-param name="referenceType" select="$referenceType" />
		</xsl:call-template>
		<xsl:choose>
			<xsl:when test="$referenceType = 'group'">
				(XML Group Reference,
				<xsl:apply-templates select="." mode="nodeCardinality" />
				)
			</xsl:when>
			<xsl:otherwise>
				(XML Element Reference,
				<xsl:apply-templates select="." mode="nodeCardinality" />
				)
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="printReference">
		<xsl:param name="contextNode" />
		<xsl:param name="reference" />
		<xsl:param name="name" />
		<xsl:param name="referenceType" />

		<xsl:value-of select="$name" />
	</xsl:template-->
	
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
	
	
	<xsl:template name="getLocation">
		<xsl:param name="value"/>
		<xsl:choose>
			<xsl:when test="$value!=''">
								<xsl:variable name="identityProviderFile" select="concat(translate($value,' ','_'), '.html')"/>
								<xsl:element name="xref">
									<xsl:attribute name="href"><xsl:value-of select="$identityProviderFile"/></xsl:attribute>
									<xsl:value-of select="$value"/>
								</xsl:element>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="$value"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template> 
	
	<xsl:template name="getInitialValueMode">
		<xsl:param name="initialValueMode"/>
		<xsl:choose>
			<xsl:when test="$initialValueMode='none'">	
				None
			</xsl:when>
			<xsl:when test="$initialValueMode='textfile'">
				Selected Valued
			</xsl:when>
			<xsl:when test="$initialValueMode='literal'">	
				Build Value
			</xsl:when>
		</xsl:choose>
	</xsl:template> 
	

</xsl:stylesheet>
<!-- =============================== END OF FILE ================================ -->
