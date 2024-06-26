<?xml version="1.0" encoding="utf-8"?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             PIKE ELECTRONIC                                  -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : xsd.xsl                                                    -->
<!-- originator      : Hozakova, changed Chladek, changed jsalomoun,              -->
<!--                   changed bjecmen                                            -->
<!-- creation date   : 2007/03/02                                                 -->
<!-- description     : XSL template transfers BW XML file of type .xsd into       -->
<!--                   DITA format.                                               -->
<!-- ============================================================================ -->
<xsl:transform version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:util="com.behaim.diagram.impl.bwd635.helper.BWDiagramUtil" 
	xmlns:xsd="http://www.w3.org/2001/XMLSchema"
	xmlns:java="http://xml.apache.org/xalan/java"
	xmlns:str="http://exslt.org/strings"
	xmlns:CustomFunctions="com.behaim.commons.xsl.CustomFunctions"
    xmlns:ncname="com.pikeelectronic.xsl.NCName"
    extension-element-prefixes="CustomFunctions ncname str"
	exclude-result-prefixes="java ncname CustomFunctions str xsd util">
	<xsl:output encoding="utf-8" method="xml"/>
	
	<!-- Parameters passed by java XSL transformer launcher -->
	<xsl:param name="mdcfg"/>
	<xsl:param name="heading"/>
	<xsl:param name="level"/>
	<xsl:param name="inputFileName"/>
	<xsl:param name="designLib"/>
	<xsl:param name="outputFileName"/>
	<xsl:param name="relativePath"/>
	<!-- added by jsalomoun - relative path of the file in project directory -->
	<xsl:param name="displayPathInTopicName" select="false"/>
	<!-- added by jsalomoun - for displaying whole relative path - default value: 
		'false' -->

	<!-- added by mrozsypal - for displaying last modification time of object 
		(system time) -->
	<xsl:param name="ModificationTime"/>
	<xsl:param name="folderDescription"/>
	<!-- Special folder names -->
    <xsl:param name="wsdlFolder"/>
    <xsl:param name="processesFolder"/>
    <xsl:param name="schemasFolder"/>
    <xsl:param name="policiesFolder"/>
    <xsl:param name="resourcesFolder"/>
	<!-- =================================== NOTES: ===================================== 
		STRUCTURE: - main concept Xsd contains concept XsdSchema - concept XsdSchema 
		contains concept Attributes, Overview, Detail - concept Overview may contain 
		these concepts: Elements, ComplexTypes, SimpleTypes, ListAttributes, Groups, 
		AttributeGroups, Redefines, Notations - concept Detail contains concepts 
		with id=element_<element name> TODO: - dela problem xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
		z hlavicky, protoze se vklada do root conceptu a dita to nebere - zapoznamkovany 
		link na xsd.css - sekce Attributes se generuje i kdyz je prazdna - mezery 
		ve vyslednem HTML upravit pres CSS u divu .p - !!! pouziva misto table SIMPLETABLE, 
		aby nemela okraje ================================================================================ -->
	<!-- Match document root tag -->
	<xsl:template match="/">
		<xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE concept PUBLIC "-//OASIS//DTD DITA Concept//EN" "]]></xsl:text><xsl:value-of select="concat($mdcfg,'/dtd','/concept.dtd')"/><xsl:text disable-output-escaping="yes">"></xsl:text>
		<concept id="Xsd" xml:lang="en-us">
			<xsl:apply-templates select="xsd:schema"/>
		</concept>
	</xsl:template>
	<xsl:template match="xsd:schema">
		<xsl:variable name="schemaName" select="substring-before($heading, '.xsd')"/>
		<!--xsl:variable name="imageName" select="concat($schemaName, '.xsd.png')"/ -->
		<xsl:variable name="imageName"
			select="CustomFunctions:getDitaFileName(concat($heading,'.png'))" />
		<!--title><xsl:value-of select="$schemaName"/> - XSD schema</title -->
		<title>
			<xsl:value-of select="$schemaName"/>
		</title>
		<titlealts>
			<navtitle>
				<xsl:choose>
					<xsl:when test="$displayPathInTopicName">
						<xsl:value-of select="substring-before($relativePath, '.xsd')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$schemaName"/>
					</xsl:otherwise>
				</xsl:choose>
			</navtitle>
		</titlealts>
		<conbody>
			<!-- <p>Section contains description of XSD Schema " <xsl:value-of select="$heading"/>" 
				</p> <xsl:if test="CustomFunctions:shallGeneratePart('xsd/includeXSDSchema')"> <xsl:if 
				test="CustomFunctions:setUsedAEandXSDschemaInDocumentation($inputFileName,$outputFileName 
				)"> <p>Open XSD Schema: <xsl:element name="xref"> <xsl:attribute name="href"> 
				<xsl:value-of select="$heading"/> </xsl:attribute> <xsl:attribute name="type">fig</xsl:attribute> 
				<xsl:attribute name="format">xsd</xsl:attribute> <xsl:value-of select="$heading"/> 
				</xsl:element> </p> </xsl:if> </xsl:if> <section> <indexterm> <xsl:value-of 
				select="$schemaName"/> </indexterm> </section> -->
			<p>
				<xsl:value-of select="CustomFunctions:initializeTemplate('xsd.xsl')"/>
			</p>
			<p>
				Section contains description of XSD Schema <xsl:value-of select="$heading"/>
				<q>
					<xsl:choose>
						<xsl:when test="CustomFunctions:shallGeneratePart('xsd/includeXSDSchema')">
							<xsl:if
								test="CustomFunctions:setUsedAEandXSDschemaInDocumentation($inputFileName,$outputFileName )">
								<xsl:element name="xref">
									<xsl:attribute name="href"><xsl:value-of
										select="ncname:transformToNCName($heading)" /></xsl:attribute>
									<xsl:attribute name="type">fig</xsl:attribute>
									<xsl:attribute name="format">xsd</xsl:attribute>
									<xsl:attribute name="scope">external</xsl:attribute>
									<xsl:value-of select="$heading"/>
								</xsl:element>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$heading"/>
						</xsl:otherwise>
					</xsl:choose>
				</q>
			</p>
			<xsl:if test="CustomFunctions:shallGeneratePart('xsd/modificationTime')">
				<p>
					Modification time:
					<xsl:value-of select="$ModificationTime"/>
				</p>
			</xsl:if>
			<section>
				<indexterm>
					<xsl:value-of select="$schemaName"/>
				</indexterm>
			</section>
		</conbody>
		<xsl:if test="CustomFunctions:shallGeneratePart('xsd/folderDescription')">
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
		<xsl:if test="CustomFunctions:shallGeneratePart('xsd/diagram')">
			<concept id="Diagram" xml:lang="en-us">
				<title>Diagram:</title>
				<conbody>
					<xsl:element name="image">
						<xsl:attribute name="href">
              <xsl:value-of select="$imageName"/>
            </xsl:attribute>
						<xsl:attribute name="alt">Diagram
              <xsl:value-of select="$heading"/>
            </xsl:attribute>
						<!-- vyska a sirka obrazku, jrozsypalova -->
						<xsl:variable name="size">
							<xsl:value-of
								select="CustomFunctions:getImageSize(concat(substring-before($outputFileName,'.dita'),'.png'))" />
						</xsl:variable>
						<xsl:if test="$size">
							<xsl:attribute name="height">
                <xsl:value-of select="substring-before($size,';')"/>
              </xsl:attribute>
							<!--xsl:attribute name="width"><xsl:value-of select="substring-after($size,';')"/>px</xsl:attribute -->
						</xsl:if>
						<!-- / vyska a sirka obrazku -->
					</xsl:element>
				</conbody>
			</concept>
		</xsl:if>
		<xsl:if test="CustomFunctions:shallGeneratePart('xsd/attributes')">
			<concept id="Attributes" xml:lang="en-us">
				<title>Attributes</title>
				<conbody>
					<xsl:apply-templates mode="printAttributes"
						select="." />
				</conbody>
			</concept>
		</xsl:if>
		<xsl:if test="count(*[(local-name(.) = 'import')]) > 0">
			<xsl:apply-templates mode="printImports" select="."/>
		</xsl:if>
		<xsl:if test="count(*[(local-name(.) = 'include')]) > 0">
			<xsl:apply-templates mode="printIncludes" select="."/>
		</xsl:if>
		<concept id="Overview" xml:lang="en-us">
			<title>Overview</title>
			<xsl:if
				test="xsd:element and CustomFunctions:shallGeneratePart('xsd/overview/elements')">
				<concept id="Elements" xml:lang="en-us">
					<title>Elements</title>
					<xsl:choose>
						<xsl:when test="CustomFunctions:shallGeneratePart('xsd/detail')">
							<conbody>
								<ul>
									<xsl:apply-templates mode="printGenericElementHeader"
										select="xsd:element" />
								</ul>
							</conbody>
						</xsl:when>
						<xsl:otherwise>
							<conbody>
								<ul>
									<xsl:apply-templates mode="printGenericElementHeaderWithoutHref"
										select="xsd:element" />
								</ul>
							</conbody>
						</xsl:otherwise>
					</xsl:choose>
				</concept>
			</xsl:if>
			<xsl:if
				test="xsd:complexType and CustomFunctions:shallGeneratePart('xsd/overview/complexTypes')">
				<concept id="ComplexTypes" xml:lang="en-us">
					<title>Complex Types</title>
					<xsl:choose>
						<xsl:when test="CustomFunctions:shallGeneratePart('xsd/detail')">
							<conbody>
								<ul>
									<xsl:apply-templates mode="printGenericElementHeader"
										select="xsd:complexType" />
								</ul>
							</conbody>
						</xsl:when>
						<xsl:otherwise>
							<conbody>
								<ul>
									<xsl:apply-templates mode="printGenericElementHeaderWithoutHref"
										select="xsd:complexType" />
								</ul>
							</conbody>
						</xsl:otherwise>
					</xsl:choose>
				</concept>
			</xsl:if>
			<xsl:if
				test="xsd:simpleType and CustomFunctions:shallGeneratePart('xsd/overview/simpleTypes')">
				<concept id="SimpleTypes" xml:lang="en-us">
					<title>Simple Types</title>
					<xsl:choose>
						<xsl:when test="CustomFunctions:shallGeneratePart('xsd/detail')">
							<conbody>
								<ul>
									<xsl:apply-templates mode="printGenericElementHeader"
										select="xsd:simpleType" />
								</ul>
							</conbody>
						</xsl:when>
						<xsl:otherwise>
							<conbody>
								<ul>
									<xsl:apply-templates mode="printGenericElementHeaderWithoutHref"
										select="xsd:simpleType" />
								</ul>
							</conbody>
						</xsl:otherwise>
					</xsl:choose>
				</concept>
			</xsl:if>
			<xsl:if
				test="xsd:attribute and CustomFunctions:shallGeneratePart('xsd/overview/attributes')">
				<concept id="ListAttributes" xml:lang="en-us">
					<title>Attributes</title>
					<conbody>
						<ul>
							<xsl:apply-templates mode="printGenericElementHeader"
								select="xsd:attribute" />
						</ul>
					</conbody>
				</concept>
			</xsl:if>
			<xsl:if test="xsd:group and CustomFunctions:shallGeneratePart('xsd/overview/groups')">
				<concept id="Groups" xml:lang="en-us">
					<title>Groups</title>
					<conbody>
						<ul>
							<xsl:apply-templates mode="printGenericElementHeader"
								select="xsd:group" />
						</ul>
					</conbody>
				</concept>
			</xsl:if>
			<xsl:if
				test="xsd:attributeGroup and CustomFunctions:shallGeneratePart('xsd/overview/attributeGroups')">
				<concept id="AttributeGroups" xml:lang="en-us">
					<title>Attribute Groups</title>
					<conbody>
						<ul>
							<xsl:apply-templates mode="printGenericElementHeader"
								select="xsd:attributeGroup" />
						</ul>
					</conbody>
				</concept>
			</xsl:if>
			<xsl:if
				test="xsd:redefine and CustomFunctions:shallGeneratePart('xsd/overview/redefines')">
				<concept id="Redefines" xml:lang="en-us">
					<title>Redefines</title>
					<conbody>
						<ul>
							<xsl:apply-templates mode="printGenericElementHeader"
								select="xsd:redefine" />
						</ul>
					</conbody>
				</concept>
			</xsl:if>
			<xsl:if
				test="xsd:notation and CustomFunctions:shallGeneratePart('xsd/overview/notations')">
				<concept id="Notations" xml:lang="en-us">
					<title>Notations</title>
					<conbody>
						<ul>
							<xsl:apply-templates mode="printGenericElementHeader"
								select="xsd:notation" />
						</ul>
					</conbody>
				</concept>
			</xsl:if>
		</concept>
		<xsl:if test="CustomFunctions:shallGeneratePart('xsd/detail')">
			<concept id="Detail" xml:lang="en-us">
				<title>Detail</title>
				<xsl:choose>
					<xsl:when
						test="count(*[(local-name(.) != 'import') and (local-name(.) != 'include')])&gt;0">
						<xsl:apply-templates mode="printGenericElement"
							select="*[(local-name(.) != 'import') and (local-name(.) != 'include')]" />
					</xsl:when>
					<xsl:otherwise>
						<conbody>
							<p>
								<i>Empty</i>
							</p>
						</conbody>
					</xsl:otherwise>
				</xsl:choose>
			</concept>
		</xsl:if>
	</xsl:template>
	<xsl:template mode="printGenericElementHeader" match="*">
		<xsl:variable name="anchorName">
			<xsl:choose>
				<xsl:when
					test="(local-name(.)='simpleType') or (local-name(.)='complexType')">
					<xsl:value-of select="concat('type_', @name)"/>
				</xsl:when>
				<xsl:when test="(local-name(.)='key') or (local-name(.)='unique')">
					<xsl:value-of select="concat('anyKey_', @name)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(local-name(.), '_', @name)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<li>
			<xsl:element name="xref">
<!--				<xsl:attribute name="href" select="concat('#', $anchorName)"/> -->
					<xsl:attribute name="href">
						<xsl:value-of select="concat('#', $anchorName)"/>
					</xsl:attribute>
				<xsl:attribute name="type">concept</xsl:attribute>
				<xsl:value-of select="@name"/>
			</xsl:element>
		</li>
	</xsl:template>
	<xsl:template mode="printGenericElementHeaderWithoutHref"
		match="*">
		<li>
			<xsl:value-of select="@name"/>
		</li>
	</xsl:template>
	<xsl:template mode="printGenericElement" match="*">
		<xsl:variable name="isTopLevel" select="local-name(..)='schema'"/>
		<xsl:variable name="anchorName">
			<xsl:choose>
				<xsl:when
					test="(local-name(.)='simpleType') or (local-name(.)='complexType')">
					<xsl:value-of select="concat('type_', @name)"/>
				</xsl:when>
				<xsl:when test="(local-name(.)='key') or (local-name(.)='unique')">
					<xsl:value-of select="concat('anyKey_', @name)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(local-name(.), '_', @name)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!--xsl:element name="xref"> <xsl:attribute name="name" select="$anchorName" 
			/> </xsl:element -->
		<xsl:variable name="elementName">
			<xsl:choose>
				<xsl:when test="@name != ''">
					<xsl:value-of select="concat(local-name(.), ' ', @name)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if
						test="contains('annotation;documentation;appInfo', local-name(.)) != true()">
						<xsl:value-of select="local-name(.)"/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$isTopLevel = true()">
				<!--<xsl:if test="compare(local-name(.), 'annotation') != 0"> -->
				<xsl:if
					test="contains('annotation;documentation;appInfo', local-name(.)) != true()">
					<xsl:element name="concept">
						<xsl:attribute name="xml:lang">en-us</xsl:attribute>
						<xsl:attribute name="id">
              <xsl:value-of select="ncname:transformToNCName($anchorName)"/>
            </xsl:attribute>
						<title>
							<xsl:value-of select="$elementName"/>
						</title>
						<conbody>
							<!--tgroup cols="2"> <tbody -->
							<xsl:choose>
								<xsl:when
									test="(count(@*) &gt; 1) or ((count(@*)=1) and (@*[local-name(.) != 'name']))">
									<xsl:if
										test="contains('annotation;documentation;appinfo', local-name(.)) != true()">
										<xsl:apply-templates mode="printAttributes"
											select="." />
									</xsl:if>
									<xsl:if test="count(*)&gt;0">
										<xsl:apply-templates mode="printAnnotation"
											select="." />
                                     <xsl:variable name="childs">
                                      <xsl:for-each select="*">
                                       <xsl:variable name="oneChild">
                                        <xsl:apply-templates mode="printGenericElement"
														select="." />
                                       </xsl:variable>
                                       <xsl:if test="$oneChild!=''">
                                        <li>
                                         	<xsl:choose>
												<xsl:when test="@name != ''">
													<xsl:value-of select="concat(local-name(.), ' ', @name)"/>										
												</xsl:when>
												<xsl:when test="contains('annotation;documentation;appInfo', local-name(.)) != true()">													
													<xsl:value-of select="local-name(.)"/>
													<xsl:text>:</xsl:text>													
												</xsl:when>
												<xsl:otherwise>
													 Annotation of element:
												</xsl:otherwise>
											</xsl:choose>                                        
                                         <xsl:copy-of select="$oneChild"/>
                                        </li>
                                       </xsl:if>
                                     </xsl:for-each>
                                    </xsl:variable>
                                    <xsl:if test="$childs!=''">
                                     <ul>
                                      <xsl:copy-of select="$childs"/>
                                     </ul>
                                    </xsl:if>
                                  </xsl:if>
								</xsl:when>
								<xsl:otherwise>
									<xsl:for-each select="*">
										<xsl:apply-templates mode="printGenericElement"
											select="." />
										<xsl:apply-templates mode="printAnnotation"
											select="." />
									</xsl:for-each>
								</xsl:otherwise>
							</xsl:choose>
							<!--/tbody> </tgroup -->
						</conbody>
					</xsl:element>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<!--xsl:call-template name="printIdentCell"/ -->
				<xsl:choose>
					<xsl:when
						test="(count(@*) &gt; 1) or ((count(@*)=1) and (@*[local-name(.) != 'name']))">
						<xsl:if
							test="contains('annotation;documentation;appinfo', local-name(.)) != true()">
							<xsl:variable name="childs">
								<!--tgroup cols="2"> <tbody -->
								 <xsl:variable name="elementChild">
								    <xsl:value-of select="$elementName"/>
									<xsl:apply-templates mode="printAttributesOnLine"
										select="." />
								 </xsl:variable>
								 <xsl:if test="$elementChild!=''">
							    	<li>
                                      <xsl:copy-of select="$elementChild"/>
							    	</li>
								</xsl:if>
								<xsl:for-each select="*">
                                 <xsl:variable name="oneChild">
                                   <xsl:apply-templates mode="printGenericElement" select="." />
                                 </xsl:variable>
                                 <xsl:if test="$oneChild!=''">
                                  <li>
                                  	<xsl:choose>
										<xsl:when test="@name != ''">
											<xsl:value-of select="concat(local-name(.), ' ', @name)"/>
										</xsl:when>										
										<xsl:when test="contains('annotation;documentation;appInfo', local-name(.)) != true()">
											<xsl:value-of select="local-name(.)"/>
											<xsl:text>:</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											Annotation of element:
										</xsl:otherwise>
									</xsl:choose>                                  	
                                   <xsl:copy-of select="$oneChild"/>
                                  </li>
                                 </xsl:if>
								</xsl:for-each>
								<!--/tbody> </tgroup -->
							  </xsl:variable>
							  <xsl:if test="$childs!=''">
							  <ul><xsl:copy-of select="$childs"/>
							  </ul>
							</xsl:if>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:for-each select="*">
							<xsl:apply-templates mode="printGenericElement"
								select="." />
						</xsl:for-each>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- annotations added by bjecmen -->
	<xsl:template mode="printAnnotation" match="xsd:annotation">
		<xsl:if test="CustomFunctions:shallGeneratePart('xsd/documentAnnotations')">
			<xsl:element name="p">
				<xsl:element name="ul">
					<xsl:element name="li">
							Annotation of element:						
						<xsl:value-of select="concat(' ', @id)"/>
						<xsl:if test="count(xsd:documentation) &gt; 0">
							<xsl:apply-templates mode="printAnnotationDocumentation"
								select="xsd:documentation" />
						</xsl:if>
						<xsl:if test="count(xsd:appinfo) &gt; 0">
							<xsl:apply-templates mode="printAnnotationAppInfo"
								select="xsd:appinfo" />
						</xsl:if>
					</xsl:element>
				</xsl:element>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template mode="printAnnotationDocumentation" match="xsd:documentation">
		<xsl:element name="ul">
			<xsl:element name="li">
				<xsl:value-of select="concat('Documentation: ', .)"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template mode="printAnnotationAppInfo" match="xsd:appinfo">
		<xsl:element name="ul">
			<xsl:element name="li">
				Application Info:
				<xsl:element name="pre">
					<xsl:value-of select="concat(' ', .)"/>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template mode="printAttributes" match="*">
		<xsl:variable name="parentNode" select="."/>
		<xsl:if test="attribute::*[local-name(.) != 'name']">
			<ul>
				<!--group cols="2"> <body -->
				<xsl:for-each select="attribute::*[local-name(.) != 'name']">
					<xsl:call-template name="printAttribute">
						<xsl:with-param name="attrName" select="name(.)"/>
						<xsl:with-param name="attrValues" select="."/>
						<xsl:with-param name="references">
							<xsl:call-template name="getAttrReferences">
								<xsl:with-param name="parentNode" select="$parentNode"/>
								<xsl:with-param name="attrName" select="name(.)"/>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:for-each>
				<!--/body> </group -->
			</ul>
		</xsl:if>
	</xsl:template>
	<xsl:template mode="printAttributesOnLine" match="*">
		<xsl:variable name="parentNode" select="."/>
		<xsl:for-each select="attribute::*[local-name(.) != 'name']">
			<xsl:if test="position() != 1">
				,
			</xsl:if>
			<xsl:call-template name="printAttributeOnLine">
				<xsl:with-param name="attrName" select="name(.)"/>
				<xsl:with-param name="attrValues" select="."/>
				<xsl:with-param name="references">
					<xsl:call-template name="getAttrReferences">
						<xsl:with-param name="parentNode" select="$parentNode"/>
						<xsl:with-param name="attrName" select="name(.)"/>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="printIdentCell">
		<xsl:element name="stentry"/>
	</xsl:template>
	<xsl:template name="printAttribute">
		<xsl:param name="attrName"/>
		<xsl:param name="attrValues"/>
		<xsl:param name="references"/>
		<xsl:variable name="refNodes" select="str:tokenize($references)"/>
		<li>
			<i>
				<xsl:value-of select="concat(' ', $attrName)"/>
				:
			</i>
			<xsl:for-each select="str:tokenize($attrValues)">
				<xsl:variable name="attrValue" select="."/>
				<xsl:variable name="pos" select="position()"/>
				<xsl:variable name="reference">
					<xsl:if test="count($refNodes) &gt;= $pos">
						<xsl:value-of select="substring($refNodes[$pos], 2)"/>
					</xsl:if>
				</xsl:variable>
				<!-- <xsl:if test="$pos > 1"> <xsl:text> </xsl:text> </xsl:if> -->
				<xsl:choose>
					<xsl:when test="$reference = '' or $reference = '_'">
						<i>
							<xsl:value-of select="concat(' ', $attrValue)"/>
						</i>
					</xsl:when>
					<xsl:otherwise>
						<i>
							<xsl:element name="xref">
								<xsl:attribute name="href">
									<xsl:value-of select="CustomFunctions:sanitizeReference($reference)"/>
								</xsl:attribute>
								<xsl:value-of select="$attrValue"/>
							</xsl:element>
						</i>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</li>
	</xsl:template>
	<xsl:template name="printAttributeOnLine">
		<xsl:param name="attrName"/>
		<xsl:param name="attrValues"/>
		<xsl:param name="references"/>
		<xsl:variable name="refNodes" select="str:tokenize($references)"/>
		<i>
			<xsl:text/>
			<xsl:value-of select="concat(' ', $attrName, ' ')"/>
		</i>
		<xsl:for-each select="str:tokenize($attrValues)">
			<xsl:variable name="attrValue" select="."/>
			<xsl:variable name="pos" select="position()"/>
			<xsl:variable name="reference">
				<xsl:if test="count($refNodes) &gt;= $pos">
					<xsl:value-of select="substring($refNodes[$pos], 2)"/>
				</xsl:if>
			</xsl:variable>
			<xsl:if test="$pos &gt; 1">
				<xsl:text/>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="$reference = ''">
					<i>
						<xsl:value-of select="concat(' ', $attrValue)"/>
					</i>
				</xsl:when>
				<xsl:otherwise>
					<i>
						<xsl:element name="xref">
							<xsl:if test="starts-with($reference, 'http')">
								<xsl:attribute name="format">
								 <xsl:value-of select="'html'"/>
								</xsl:attribute>
							</xsl:if>
							<xsl:attribute name="href">
								<xsl:value-of select="CustomFunctions:sanitizeReference(concat($reference,$attrValue))"/>
							</xsl:attribute>
						</xsl:element>
					</i>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="getAttrReferences">
		<xsl:param name="parentNode"/>
		<xsl:param name="attrName"/>
		<xsl:variable name="parentName" select="local-name($parentNode)"/>
		<xsl:choose>
			<xsl:when
				test="($attrName = 'ref') and (($parentName = 'attribute') or ($parentName = 'attributeGroup') or ($parentName = 'element') or ($parentName = 'group'))">
				<xsl:call-template name="resolveReferences">
					<xsl:with-param name="references" select="$parentNode/@ref"/>
					<xsl:with-param name="contextNode" select="$parentNode"/>
					<xsl:with-param name="referenceType" select="local-name($parentNode)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when
				test="(($attrName = 'type') and (($parentName = 'attribute') or ($parentName = 'element'))) or (($attrName = 'base') and (($parentName = 'extension') or ($parentName = 'restriction'))) or (($attrName = 'itemType') and ($parentName = 'list'))">
				<xsl:call-template name="resolveReferences">
					<xsl:with-param name="references"
						select="$parentNode/attribute::*[local-name(.) = $attrName]" />
					<xsl:with-param name="contextNode" select="$parentNode"/>
					<xsl:with-param name="referenceType" select="'type'"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="($attrName = 'refer') and ($parentName = 'keyref')">
				<xsl:call-template name="resolveReferences">
					<xsl:with-param name="references" select="$parentNode/@refer"/>
					<xsl:with-param name="contextNode" select="$parentNode"/>
					<xsl:with-param name="referenceType" select="'anyKey'"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="($attrName = 'memberTypes') and ($parentName = 'union')">
				<xsl:call-template name="resolveReferences">
					<xsl:with-param name="references" select="$parentNode/@memberTypes"/>
					<xsl:with-param name="contextNode" select="$parentNode"/>
					<xsl:with-param name="referenceType" select="'type'"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="resolveReferences">
		<xsl:param name="contextNode"/>
		<xsl:param name="references"/>
		<xsl:param name="referenceType"/>
		<xsl:variable name="targetSchema" select="/xsd:schema/@targetNamespace"/>
		<xsl:variable name="schema" select="/xsd:schema"/>
		<xsl:for-each select="str:tokenize($references)">
			<xsl:variable name="namespace">
				<xsl:value-of select="namespace-uri($contextNode)" />
			</xsl:variable>
			<xsl:variable name="localName">
				<xsl:value-of select="local-name($contextNode)" />
			</xsl:variable>
			<xsl:if test="position() &gt; 1">
				<xsl:text/>
			</xsl:if>
			<xsl:text>_</xsl:text>
			<xsl:choose>
				<xsl:when
					test="($namespace = $targetSchema) or ((string-length($namespace) = 0) and (string-length($targetSchema) = 0))">
					<xsl:for-each select="$schema/*[@name=$localName]">
						<xsl:choose>
							<xsl:when test="$referenceType = 'type'">
								<xsl:if
									test="(local-name(.) = 'simpleType') or (local-name(.) = 'complexType')">
									<xsl:value-of select="concat('#type_', $localName)"/>
								</xsl:if>
								<xsl:if test="(local-name(.) = 'key') or (local-name(.) = 'unique')">
									<xsl:value-of select="concat('#anyKey_', $localName)"/>
								</xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="local-name(.) = $referenceType">
									<xsl:value-of select="concat('#', $referenceType, '_', $localName)"/>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="count($schema/xsd:import[@namespace = $namespace]) = 1">
						<xsl:variable name="schemaDocumentationPath"
							select="CustomFunctions:getSchemaDocumentationLink($level, $schema/xsd:import[@namespace=$namespace]/@schemaLocation, $inputFileName, $relativePath)" />
						<xsl:if test="$schemaDocumentationPath != ''">
							<xsl:value-of
								select="concat($schemaDocumentationPath, '#', $referenceType, '_', $localName)" />
						</xsl:if>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<xsl:template mode="printImports" match="*">
		<concept id="Imports" xml:lang="en-us">
			<title>Imports</title>
			<xsl:for-each select="*[(local-name(.) = 'import')]">
				<xsl:element name="concept">
					<xsl:attribute name="xml:lang">en-us</xsl:attribute>
					<xsl:variable name="ncId" select="ncname:transformToNCName(translate(./*[local-name()='import']/@namespace,'/','_'))" />
					<xsl:variable name="id">
						<xsl:choose>
							<xsl:when test="$ncId != ''">
								<xsl:value-of select="$ncId" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat('unknownNamespace', CustomFunctions:unknownNamespaceId())" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
						<xsl:attribute name="id">
	                    <xsl:value-of select="$id" />
       		        </xsl:attribute>
					<xsl:variable name="schemaNamespace" select="./@namespace"/>
					<xsl:variable name="schemaFile">
						<xsl:choose>
							<xsl:when test="./@schemaLocation">
								<xsl:value-of select="./@schemaLocation"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="util:getImportedWsdlFileByNSpace(util:createNSpace('',$schemaNamespace))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="schemaDocumentationPath" select="CustomFunctions:getSchemaDocumentationLink($level, $schemaFile, $inputFileName, $relativePath)" />
					<title>
						Namespace:
						<xsl:value-of select="$schemaNamespace" />
					</title>
					<conbody>
						<p>
						Imported from file:
						<xsl:element name="xref">
							<xsl:attribute name="href"><xsl:value-of select="$schemaDocumentationPath"/></xsl:attribute>
							<xsl:value-of select="$schemaDocumentationPath"/>
						</xsl:element>
						</p>
					</conbody>
				</xsl:element>
			</xsl:for-each>
		</concept>
	</xsl:template>
	<xsl:template mode="printIncludes" match="*">
		<concept id="Includes" xml:lang="en-us">
			<title>Included files</title>
			<conbody>
				<ul>
					<xsl:for-each select="*[(local-name(.) = 'include')]">
						<xsl:variable name="schemaNamespace" select="./@namespace"/>
						<xsl:variable name="schemaFile" select="./@schemaLocation"/>
						<xsl:variable name="schemaDocumentationPath" select="CustomFunctions:getSchemaDocumentationLink($level, $schemaFile, $inputFileName, $relativePath)" />
						<li>
							<xsl:element name="xref">
								<xsl:attribute name="href"><xsl:value-of select="$schemaDocumentationPath"/></xsl:attribute>
								<xsl:value-of select="$schemaFile"/>
							</xsl:element>
						</li>
					</xsl:for-each>
				</ul>
			</conbody>
		</concept>
	</xsl:template>
</xsl:transform>
<!-- =============================== END OF FILE ================================ -->
