<?xml version="1.0" encoding="utf-8"?>
<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             BEHAIM IT Solutions                              -->
<!--                                                                              -->
<!--                            All Rights Reserved                               -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : ldapConfiguration.xsl                                      -->
<!-- originator      : lsatin                                                     -->
<!-- creation date   : 2015/09/01                                                 -->
<!-- description     : XSL template transfers BW XML file of type                 -->
<!--                   .ldapResource into DITA format.                      -->
<!-- ============================================================================ -->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:java="http://xml.apache.org/xalan/java" 
	xmlns:id="http://www.tibco.com/ws/2013/11/identity" 
	xmlns:sca_ext="http://www.tibco.com/ns/sca/201311" 
	xmlns:CustomFunctionsEagle="com.behaim.commons.eagle.CustomFunctions" 
	xmlns:CustomFunctions="com.behaim.commons.xsl.CustomFunctions" 
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

		<concept id="LDAPConfigurationsMain" xml:lang="en-us">
		<xsl:variable name="processName" select="substring-before($heading,'.ldapResource')"/>
		<title>
			<xsl:value-of select="$processName"/>
		</title>
		<titlealts>
			<navtitle>
				<xsl:choose>
					<xsl:when test="$displayPathInTopicName">
              			<xsl:value-of select="substring-before($relativePath,'.ldapResource')"/>
            		</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$processName"/>
					</xsl:otherwise>
				</xsl:choose>
			</navtitle>
		</titlealts>
					<conbody>
						<p>
							<xsl:value-of select="CustomFunctions:initializeTemplate('ldapConfiguration.xsl')"/>
						</p>
						<p>
							Section contains description of LDAP Configurations "
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
		
		<concept id="LDAPConfigurations">
		<title>LDAP Configurations</title>
			<conbody>
				<ul>
					<xsl:apply-templates select="jndi:configuration" mode="Connection"></xsl:apply-templates>		
				</ul>
			</conbody>
		</concept>
			<concept id="LDAPConfigurationsAdmin">
				<title>Admin User Credentials</title>
				<conbody>					
					<xsl:apply-templates select="/" mode="Admin"></xsl:apply-templates>
				</conbody>
			</concept>
			<concept id="LDAPConfigurationsSSL">
				<title>SSL</title>
				<conbody>
						<xsl:apply-templates select="/" mode="SSL"></xsl:apply-templates>
				</conbody>
			</concept>
			<concept id="LDAPConfigurationsUserGroups">
				<title>Users and Groups</title>
				<conbody>
					<ul>
						<xsl:apply-templates select="jndi:configuration" mode="UserGroups"></xsl:apply-templates>
					</ul>
				</conbody>
			</concept>
			<concept id="LDAPConfigurationsSearch">
				<title>Search</title>
				<conbody>
					<ul>
						<xsl:apply-templates select="jndi:configuration" mode="Search"></xsl:apply-templates>
					</ul>
				</conbody>
			</concept>
			<concept id="LDAPConfigurationsAdvanced">
				<title>Advanced</title>
				<conbody>
					<ul>
						<xsl:apply-templates select="jndi:configuration" mode="Advanced"></xsl:apply-templates>
					</ul>
				</conbody>
			</concept>
		</concept>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="jndi:configuration" mode="Advanced">
		<li>
			Follow Referrals:
			<xsl:choose>
				<xsl:when test="./@followReferals = 'false'">
					false
				</xsl:when>
				<xsl:otherwise>
					true
				</xsl:otherwise>
			</xsl:choose>
		</li>
		<li>
			Connection Pool: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@connectionPools"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='connectionPools']/@propName"/>
				<xsl:with-param name="defaultValue" select="'10'"/>
			</xsl:call-template>
		</li>
		<li>
			Search Timeout: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@searchTimeOut"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='searchTimeOut']/@propName"/>
				<xsl:with-param name="defaultValue" select="'0'"/>
			</xsl:call-template>
		</li>
	</xsl:template>

	<!-- Sub template -->
	<xsl:template match="jndi:configuration" mode="Search">
		<li>
			User Search Scope: 
			<xsl:choose>
				<xsl:when test="./@userSearchScopeSubtree = 'false'">
					One level
				</xsl:when>
				<xsl:otherwise>
					Subtree
				</xsl:otherwise>
			</xsl:choose>
		</li>
		<li>
			Group Root DN: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@groupSearchBaseDN"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='groupSearchBaseDN']/@propName"/>
				<xsl:with-param name="defaultValue" select="''"/>
			</xsl:call-template>
		</li>
		<li>
			Group Search Scope:
			<xsl:choose>
				<xsl:when test="groupSearchScopeSubtree = 'false'">
					false
				</xsl:when>
				<xsl:otherwise>
					true
				</xsl:otherwise>
			</xsl:choose>
		</li>
		<li>
			Group Search Expression: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@groupSearchExpression"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='groupSearchExpression']/@propName"/>
				<xsl:with-param name="defaultValue" select="''"/>
			</xsl:call-template>
		</li>
	</xsl:template>

	<!-- Sub template -->
	<xsl:template match="jndi:configuration" mode="UserGroups">
		<li>
			User's Name: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@userAttributeUsersName"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='userAttributeUsersName']/@propName"/>
				<xsl:with-param name="defaultValue" select="''"/>
			</xsl:call-template>
		</li>
		<li>
			Additional User Attributes to Retrieve:
			<xsl:for-each select="./userAttributesExtraList">
			 	<ul>
					<li><xsl:value-of select="."/></li>
				</ul>
			</xsl:for-each>
		</li>
		<li>
			Group Indication: 
			<xsl:choose>
				<xsl:when test="@userIndicatesGroups = 'userHasGroups'">User Attribute Indicates Group</xsl:when>
				<xsl:when test="@userIndicatesGroups = 'userDNHasGroups'">User DN Indicates Group</xsl:when>
				<xsl:when test="@userIndicatesGroups = 'groupHasUsers'">Search Groups</xsl:when>
				<xsl:otherwise>No Group Info</xsl:otherwise>
			</xsl:choose>
		</li>
		<xsl:choose>
			<xsl:when test="@userIndicatesGroups = 'groupHasUsers'">
				<li>
					Group Root DN:						
					<xsl:call-template name="getValueFromLiteralModule">
						<xsl:with-param name="valueLiteral" select="@groupSearchBaseDN"/>
						<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='groupSearchBaseDN']/@propName"/>
						<xsl:with-param name="defaultValue" select="''"/>
					</xsl:call-template>
				</li>
				<li>
				Group Search Expression:						
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@groupSearchExpression"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='groupSearchExpression']/@propName"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template>
			</li>
			</xsl:when>
			<xsl:otherwise>
			<li>
				User Attribute Groups Name:						
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="@userAttributeGroupsName"/>
					<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='userAttributeGroupsName']/@propName"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template>
			</li>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="jndi:configuration" mode="Connection">
		<li>
			Server URL: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@serverURL"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='serverURL']/@propName"/>
				<xsl:with-param name="defaultValue" select="'ldap://localhost:389'"/>
			</xsl:call-template>
		</li>
		<li>
			User Search Expression: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@userSearchExpression"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='userSearchExpression']/@propName"/>
				<xsl:with-param name="defaultValue" select="''"/>
			</xsl:call-template>
		</li>
		<li>
			User DN Template: 
			<xsl:call-template name="getValueFromLiteralModule">
				<xsl:with-param name="valueLiteral" select="@userDNTemplate"/>
				<xsl:with-param name="valueModuleProp" select="substitutionBindings[@template='userDNTemplate']/@propName"/>
				<xsl:with-param name="defaultValue" select="''"/>
			</xsl:call-template>
		</li>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="/" mode="Admin">
		<xsl:if test="/jndi:namedResource/jndi:reference[@type='sp:CredentialSecurityProvider']/@value">
		<ul>
			<li>
				Credentials Provider:
				<xsl:variable name="identityProvider" select="/jndi:namedResource/jndi:reference[@type='sp:CredentialSecurityProvider']/@value"/>
						<xsl:variable name="identityProviderFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level),$resourcesFolder, translate($identityProvider, '.','/'), '.userIdResource.dita')"/>
						<xsl:variable name="identityProviderRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($identityProviderFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
						<xsl:element name="xref">
							<xsl:attribute name="href"><xsl:value-of select="$identityProviderRef"/></xsl:attribute>
							<xsl:value-of select="$identityProvider"/>
						</xsl:element>
			</li>
			<li>
				User Search Base DN:
				<xsl:call-template name="getValueFromLiteralModule">
					<xsl:with-param name="valueLiteral" select="./jndi:namedResource/jndi:configuration/@userSearchBaseDN"/>
					<xsl:with-param name="valueModuleProp" select="./jndi:namedResource/jndi:configuration/substitutionBindings[@template='userSearchBaseDN']/@propName"/>
					<xsl:with-param name="defaultValue" select="''"/>
				</xsl:call-template>
			</li>
		</ul>
		</xsl:if>
	</xsl:template>
	
	<!-- Sub template -->
	<xsl:template match="/" mode="SSL">
		<xsl:if test="/jndi:namedResource/jndi:reference[@type='sp:IdentitySecurityProvider']/@value">
			<ul>
			<li>
				SSL Client:
				<xsl:variable name="sslClient" select="/jndi:namedResource/jndi:reference[@type='sp:IdentitySecurityProvider']/@value"/>
						<xsl:variable name="sslClientFile" select="concat(CustomFunctionsEagle:getRelativeRootDir($level),$resourcesFolder, translate($sslClient, '.','/'), '.sslClientResource.dita')"/>
						<xsl:variable name="sslClientRef" select="concat(CustomFunctionsEagle:getRelativeRootDir($level+1),CustomFunctions:getPath(CustomFunctions:substringBeforeLast($projectRoot,'/'),concat('/',substring-before(substring-after($sslClientFile,CustomFunctionsEagle:getRelativeRootDir($level)),'.dita'))),'.dita')"/>
						<xsl:element name="xref">
							<xsl:attribute name="href"><xsl:value-of select="$sslClientRef"/></xsl:attribute>
							<xsl:value-of select="$sslClient"/>
						</xsl:element>
			</li>
			</ul>
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



