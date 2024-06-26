<?xml version="1.0" encoding="utf-8"?>
<!--============================================================================-->
<!--                                                                            -->
<!--                             Behaim IT Solutions                            -->
<!--                                                                            -->
<!--                            All Rights Reserved                             -->
<!--                                                                            -->
<!--                                                                            -->
<!-- project         : MakeDoc                                                  -->
<!-- filename        : doccontent.xsl                                           -->
<!-- originator      : jkaspar                                                  -->
<!-- creation date   : 2016-02-24                                               -->
<!-- description     : This header was automatically created                    -->
<!--                                                                            -->
<!--============================================================================-->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:java="http://xml.apache.org/xalan/java" 
	xmlns:CustomFunctions="com.behaim.commons.xsl.CustomFunctions"
	exclude-result-prefixes="java">
	<!-- Parameters passed by java XSL transformer launcher -->
	<xsl:param name="mdcfg"/>
	<xsl:param name="heading" />
	<xsl:param name="outputFileName" />

	<xsl:output encoding="utf-8" method="xml" indent="yes" />
	<!-- Match document root tag -->
	<xsl:template match="/">

		<!-- ditamap heading -->
		<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[<!DOCTYPE map PUBLIC "-//OASIS//DTD DITA Map//EN" "]]></xsl:text><xsl:value-of select="concat($mdcfg,'/dtd','/map.dtd')"/><xsl:text disable-output-escaping="yes">"></xsl:text>
		<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[  <map title="]]></xsl:text>
		<xsl:value-of select="$heading" />
		<xsl:text disable-output-escaping="yes"><![CDATA[">]]></xsl:text>
		<xsl:apply-templates select="content" />
		<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[  </map>]]></xsl:text>
	</xsl:template>
	<!-- Match <content> tag, contains all other tags -->
	<xsl:template match="content">
		<!-- ADAPTERS -->
		<xsl:if test="*[@type='adapter']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/adapter.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='adapter']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- PROCESSES -->
		<xsl:if test="*[@type='process']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/process.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='process']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
	    <!-- ORCHESTRATION -->
	    <xsl:if test="*[@type='orchestration']">
	      <xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/orchestration.dita">]]></xsl:text>
	      <xsl:for-each select="*[@type='orchestration']">
	        <xsl:sort select="@path" />
	        <xsl:sort select="@name" />
	        <xsl:apply-templates select="." mode="detail" />
	      </xsl:for-each>
	      <xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
	    </xsl:if>
		<!-- AE SCHEMAS -->
		<xsl:if test="*[@type='aeschema']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/aeschema.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='aeschema']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- GLOBAL VARIABLES -->
		<xsl:if test="*[@type='substvar']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/substvar.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='substvar']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- PARAMETER LIST OAuth -->
		<xsl:if test="*[@type='oauthshared']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/oauthshared.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='oauthshared']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- ARCHIVES -->
		<xsl:if test="*[@type='archive']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/archive.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='archive']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- WSDL -->
		<xsl:if test="*[@type='wsdl']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/wsdl.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='wsdl']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- RENDEZVOUS -->
		<xsl:if test="*[@type='rendezvous']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/rendezvous.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='rendezvous']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- SHARED JMS Connection -->
		<xsl:if test="*[@type='sharedjmscon']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/sharedjmscon.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='sharedjmscon']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- SHARED JNDI Config -->
		<xsl:if test="*[@type='sharedjndiconfig']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/sharedjndiconfig.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='sharedjndiconfig']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- SHARED JDBC -->
		<xsl:if test="*[@type='sharedjdbc']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/sharedjdbc.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='sharedjdbc']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- SHARED EJB con -->
		<xsl:if test="*[@type='sharedejbcon']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/sharedejbcon.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='sharedejbcon']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- SHARED OSB Connection -->
		<xsl:if test="*[@type='sharedoscon']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/sharedoscon.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='sharedoscon']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- SHARED OSB Transaction -->
		<xsl:if test="*[@type='ostar']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/ostar.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='ostar']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- SHARED FTP -->
		<xsl:if test="*[@type='sharedftp']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/sharedftp.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='sharedftp']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- SHARED HTTP -->
		<xsl:if test="*[@type='sharedhttp']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/sharedhttp.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='sharedhttp']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>		
		<xsl:if test="*[@type='httpClientConfiguration']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/httpClientConfiguration.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='httpClientConfiguration']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='dataFormat']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/dataFormat.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='dataFormat']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='copybook']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/copybook.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='copybook']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>		
		<xsl:if test="*[@type='sharepointConnection']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/sharepointConnection.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='sharepointConnection']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='dynamicscrm']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/dynamicscrm.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='dynamicscrm']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='sftp']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/sftp.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='sftp']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='smtp']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/smtp.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='smtp']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='wssauth']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/wssAuthentication.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='wssauth']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='xmlauth']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/xmlAuthentication.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='xmlauth']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='ftlConnection']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/ftlConnection.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='ftlConnection']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='httpConnector']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/httpConnector.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='httpConnector']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='identityProvider']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/identityProvider.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='identityProvider']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='javaGlobalInstance']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/javaGlobalInstance.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='javaGlobalInstance']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='keystoreProvider']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/keystoreProvider.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='keystoreProvider']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='policy']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/policy.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='policy']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='policy']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/policy.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='policy']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='ldapConfiguration']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/ldapConfiguration.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='ldapConfiguration']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='ldapConnection']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/ldapConnection.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='ldapConnection']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='piafConnection']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/PIAFConnection.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='piafConnection']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='pijdbcConnection']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/PIJDBCConnection.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='pijdbcConnection']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='sslClient']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/sslClient.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='sslClient']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='sslServer']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/sslServer.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='sslServer']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='subjectProvider']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/subjectProvider.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='subjectProvider']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='trustProvider']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/trustProvider.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='trustProvider']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='tcpConnection']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/tcp.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='tcpConnection']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='threadPool']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/threadPool.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='threadPool']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- HTTP PROXY -->
		<xsl:if test="*[@type='httpProxy']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/httpProxy.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='httpProxy']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='sharediprocesscon']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/sharediprocesscon.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='sharediprocesscon']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='sharedvariable']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/sharedvariable.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='sharedvariable']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='moduleDescriptor']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/moduleDescriptor.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='moduleDescriptor']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='application']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/application.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='application']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='jobsharedvariable']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/jobsharedvariable.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='jobsharedvariable']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<xsl:if test="*[@type='serviceagent']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/serviceagent.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='serviceagent']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- Smart Mapper Adapter Configurations -->
		<xsl:if test="*[@type='smartmapperadapter']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/smartmapperadapter.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='smartmapperadapter']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- Smart Mapper ER Models -->
		<xsl:if test="*[@type='smartmapperermodel']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/smartmapperermodel.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='smartmapperermodel']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- R3 CONNECIONS -->
		<xsl:if test="*[@type='adr3Connections']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/adr3Connections.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='adr3Connections']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- SHARED PARSE DATA -->
		<xsl:if test="*[@type='sharedparse']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/sharedparse.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='sharedparse']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- CONCEPT -->
		<xsl:if test="*[@type='concept']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/concept.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='concept']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- CONCEPT VIEW -->
		<xsl:if test="*[@type='conceptview']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/conceptview.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='conceptview']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- CHANNEL -->
		<xsl:if test="*[@type='channel']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/channel.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='channel']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- EVENT -->
		<xsl:if test="*[@type='event']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/event.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='event']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- TIMEEVENT -->
		<xsl:if test="*[@type='time']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/time.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='time']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes"><![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- RULESET -->
		<xsl:if test="*[@type='ruleset']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/ruleset.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='ruleset']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- RULEFUNCTION -->
		<xsl:if test="*[@type='rulefunction']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/rulefunction.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='rulefunction']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- RULEFUNCTION -->
		<xsl:if test="*[@type='scorecard']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/scorecard.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='scorecard']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- XSD -->
		<xsl:if test="*[@type='xsd']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/xsd.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='xsd']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- BCSC -->
		<xsl:if test="*[@type='bcsc']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/bcsc.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='bcsc']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
		<!-- NOTIFYCONFIGURATION -->
		<xsl:if test="*[@type='notifyConfiguration']">
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    <topicref href="common/notifyConfiguration.dita">]]></xsl:text>
			<xsl:for-each select="*[@type='notifyConfiguration']">
				<xsl:sort select="@path" />
				<xsl:sort select="@name" />
				<xsl:apply-templates select="." mode="detail" />
			</xsl:for-each>
			<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[    </topicref>]]></xsl:text>
		</xsl:if>
	</xsl:template>

	<!-- This template output each row for selected area (process, adapter, 
		etc.) -->
	<xsl:template match="*" mode="detail">
		<xsl:text disable-output-escaping="yes">&#xA;<![CDATA[      <topicref href="]]></xsl:text>
		<xsl:value-of select="@path" />
		<xsl:if test="@path!=''">
			<xsl:text disable-output-escaping="yes"><![CDATA[/]]></xsl:text>
		</xsl:if>
		<xsl:value-of select="@name" />
		<xsl:text disable-output-escaping="yes"><![CDATA["/>]]></xsl:text>
	</xsl:template>
</xsl:stylesheet>

<!-- ================================= END OF FILE ============================== -->
