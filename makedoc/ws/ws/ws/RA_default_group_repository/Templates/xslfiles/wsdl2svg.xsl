<?xml version="1.0" encoding="utf-8" ?>

<!-- ============================================================================ -->
<!--                                                                              -->
<!--                             BEHAIM IT SOLUTIONS                              -->
<!--                                                                              -->
<!--                             All Rights Reserved                              -->
<!--                                                                              -->
<!--                                                                              -->
<!-- project         : MakeDoc                                                    -->
<!-- filename        : wsdl2svg.xsl                                               -->
<!-- originator      : Jan Kaspar                                                 -->
<!-- creation date   : 2015/07/11                                                 -->
<!-- description     : XSL template transfers *.wsdl file into			          -->
<!--                   svg file 						                          -->
<!-- ============================================================================ -->

<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:svg="http://www.w3.org/2000/svg" 
	xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" 
	xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" 
	xmlns:CustomFunctions="com.behaim.commons.xsl.CustomFunctions" 
	xmlns:map="xalan://java.util.Map" extension-element-prefixes="map">
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
	<xsl:param name="imageNotExist" select="false" />

	<!-- added by mrozsypal - for displaying last modification time of object 
		(system time) -->
	<xsl:param name="ModificationTime" />
	<xsl:param name="icons"/>
	<!-- Special folder names -->
    <xsl:param name="wsdlFolder"/>
    <xsl:param name="processesFolder"/>
    <xsl:param name="schemasFolder"/>
    <xsl:param name="policiesFolder"/>
    <xsl:param name="resourcesFolder"/>
   <xsl:output encoding="utf-8" method="xml" indent="no"/>
   <xsl:template match="/">
   		<!-- MaxHeight -->
   		<xsl:variable name="IOFElements" select="./wsdl:definitions/wsdl:portType/wsdl:operation/*[self::wsdl:input or self::wsdl:output or self::wsdl:fault]"/>
		<xsl:variable name="allMessages" select="./wsdl:definitions/wsdl:message"/>
		<xsl:variable name="countPreviousParts" select="CustomFunctions:getCountOfPreviousParts($IOFElements,$allMessages)"/>
   		<xsl:variable name="maxHeight" select="(count(./wsdl:definitions/wsdl:portType)*40)+(count(./wsdl:definitions/wsdl:portType/wsdl:operation)*20)+($countPreviousParts*20)"/>
   		<!-- MaxWidth -->
   		<xsl:variable name="portNames" select="./wsdl:definitions/wsdl:service/wsdl:port"/>
		<xsl:variable name="maxPortName"><xsl:choose><xsl:when test="count(./wsdl:definitions/wsdl:service/wsdl:port) &gt; 0">
			<xsl:for-each select="$portNames">
					<xsl:sort select="string-length(@name)" order="descending" data-type="number"/>
					<xsl:if test="position() = 1">
          				<xsl:value-of select="string-length(@name)"/>
          			</xsl:if>
				</xsl:for-each></xsl:when><xsl:otherwise>0</xsl:otherwise>
				</xsl:choose></xsl:variable>
		<xsl:variable name="serviceNames" select="./wsdl:definitions/wsdl:service"/>
		<xsl:variable name="maxServiceName"><xsl:choose><xsl:when test="count(./wsdl:definitions/wsdl:service) &gt; 0"> 
			<xsl:for-each select="$serviceNames">
				<xsl:sort select="string-length(@name)" order="descending" data-type="number"/>
				<xsl:if test="position() = 1">
         			<xsl:value-of select="string-length(@name)"/>
        		</xsl:if>
			</xsl:for-each></xsl:when><xsl:otherwise>0</xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="addressLocations" select="./wsdl:definitions/wsdl:service/wsdl:port/*[local-name()='address']"/>
		<xsl:variable name="maxAddressLocation"><xsl:choose><xsl:when test="count(./wsdl:definitions/wsdl:service/wsdl:port/*[local-name()='address']) &gt; 0"> 
			<xsl:for-each select="$addressLocations">
				<xsl:sort select="string-length(@location)" order="descending" data-type="number"/>
				<xsl:if test="position() = 1">
         			<xsl:value-of select="string-length(@location)"/>
         		</xsl:if>
			</xsl:for-each></xsl:when><xsl:otherwise>0</xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="maxServiceWidth" select="160 + CustomFunctions:max(number($maxServiceName),number($maxAddressLocation),number($maxPortName))*9"/>
		<xsl:variable name="portTypeNames" select="./wsdl:definitions/wsdl:portType"/>
		<xsl:variable name="maxPortTypeName"><xsl:choose><xsl:when test="count(./wsdl:definitions/wsdl:portType) &gt; 0"> 
			<xsl:for-each select="$portTypeNames">
				<xsl:sort select="string-length(@name)" order="descending" data-type="number"/>
				<xsl:if test="position() = 1">
        			<xsl:value-of select="string-length(@name)"/>
        		</xsl:if>
			</xsl:for-each></xsl:when><xsl:otherwise>0</xsl:otherwise></xsl:choose></xsl:variable>
   		<xsl:variable name="faultNames" select="./wsdl:definitions/wsdl:portType/wsdl:operation/wsdl:fault"/>
		<xsl:variable name="maxFaultName"><xsl:choose><xsl:when test="count(./wsdl:definitions/wsdl:portType/wsdl:operation/wsdl:fault) &gt; 0">
			<xsl:for-each select="$faultNames">
				<xsl:sort select="string-length(@name)" order="descending" data-type="number"/>
				<xsl:if test="position() = 1"><xsl:value-of select="string-length(@name)"/></xsl:if>
			</xsl:for-each></xsl:when><xsl:otherwise>6</xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="allMessageAttributes" select="./wsdl:definitions/wsdl:portType/wsdl:operation/wsdl:*/@message"/>
		<xsl:variable name="allMessageAttributesConcatenated">
			<xsl:for-each select="./wsdl:definitions/wsdl:portType/wsdl:operation/wsdl:*/@message">
				<xsl:value-of select="concat(.,' ')"/>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="allParts" select="./wsdl:definitions/wsdl:message[contains(concat($allMessageAttributesConcatenated,' '),concat(':',@name,' '))]/wsdl:part"/>
		<xsl:variable name="maxWidthsPart" select="CustomFunctions:getMaxLengthOfPart($allParts)"/>
		<xsl:variable name="maxPartName" select="number(normalize-space(substring-before($maxWidthsPart,':')))"/>
		<xsl:variable name="maxPartType" select="number(normalize-space(substring-after($maxWidthsPart,':')))"/>
		<xsl:variable name="maxPartLength" select="$maxFaultName + $maxPartType + $maxPartName"/>
		<xsl:variable name="maxWidth" select="CustomFunctions:max(number($maxPartLength), number($maxPortTypeName))*9"/>		
      <xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
      ]]></xsl:text>
      <svg:svg version="1.1" id="Layer_1" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:html="http://www.w3.org/1999/xhtml" x="0px" y="0px" width="{$maxServiceWidth + $maxWidth +50}" height="{$maxHeight + 100}" xml:space="preserve">
		 <svg:style type="text/css"><![CDATA[
    .Rect { fill:rgb(245,246,206); stroke:rgb(150,0,0); stroke-width:1 }
    .Line { fill:none; stroke:black; stroke-width:1 }
    .DashLine { stroke:rgb(150,0,0); stroke-width:2; stroke-dasharray:10,10,10 }
    .Text {font-family:courier; font-weight:bold; font-size:12px; text-anchor: middle}
    .TextRight {font-family:courier; font-weight:normal; font-size:12px; text-anchor: left}
    .Operation {fill:rgb(224,233,246); stroke:black; stroke-width:0.5}
    .Message {fill:rgb(255,255,255); stroke:black; stroke-width:0.5}
    .IOPut {fill:rgb(255,255,225); stroke:black; stroke-width:0.5}
    .Port {fill:rgb(255,255,255); stroke:black; stroke-width:0.5}
    .Service {fill:url(#Header); stroke:black; stroke-width:0.5}
    .PortType {fill:url(#Header); stroke:black; stroke-width:0.5}
	]]></svg:style>
		<svg:defs>
			<svg:marker id="arrow" viewBox="0 0 80 80" refX="60" refY="40" markerUnits="strokeWidth" markerWidth="8" markerHeight="7" orient="auto">
				<svg:polyline points="0,0 80,40 0,80"></svg:polyline>
			</svg:marker>
			<svg:marker id="arrowfilled" viewBox="0 -20 100 80" refX="60" refY="20" markerUnits="strokeWidth" markerWidth="12" markerHeight="12" orient="auto">
				<svg:polyline points="0,0 60,20 0,40 0,0" style="black;stroke-width:10" fill="black"></svg:polyline>
			</svg:marker>
			<svg:marker id="composite" viewBox="0 0 180 80" refX="60" refY="40" markerUnits="strokeWidth" markerWidth="12" markerHeight="12" orient="auto">
				<svg:polyline points="60,40 120,0 180,40 120,80 60,40" style="stroke:rgb(150,0,0);stroke-width:10" fill="rgb(255,255,255)"></svg:polyline>
			</svg:marker>
			<svg:linearGradient id="Header" x1="20%" y1="20%" x2="100%" y2="100%">
				<svg:stop offset="0%" style="stop-color:rgb(227,236,247);stop-opacity:1" />
				<svg:stop offset="100%" style="stop-color:rgb(251,252,254);stop-opacity:1" />
			</svg:linearGradient>
		</svg:defs>
			<xsl:for-each select="./wsdl:definitions/wsdl:service">
				<xsl:variable name="ports" select="./wsdl:port"/>
				<xsl:variable name="widthPort" select="CustomFunctions:getMaxLengthOfPort($ports)"/>
				<xsl:variable name="widthService" select="CustomFunctions:max(number(string-length(./@name)), number($widthPort))*9"/>
				<xsl:variable name="previousServiceHeights" select="(count(preceding-sibling::wsdl:service)*40)+(count(preceding-sibling::wsdl:service/wsdl:port)*20)+(count(preceding-sibling::wsdl:service/wsdl:port/*[local-name()='address'])*20)"/>
				<svg:rect x="60" y="{30+$previousServiceHeights}" height="20" width="{$widthService}" class="Service"></svg:rect>
				<xsl:variable name="imageService"><xsl:value-of select="map:get($icons, 'com/pike/commons/wsdl/service_obj.gif')" /></xsl:variable> 
				<svg:image x="62" y="{30+$previousServiceHeights + 2}" height="16" width="16" xlink:href="data:image/gif;base64,{normalize-space($imageService)}"/>
				<svg:text x="82" y="{45+$previousServiceHeights}" class="TextRight"><xsl:value-of select="./@name"/></svg:text>
				<xsl:for-each select="./wsdl:port">
					<xsl:variable name="portPosition" select="position()"/>
					<xsl:variable name="portsWithAddressHeights" select="(count(preceding-sibling::wsdl:port)*20)+(count(preceding-sibling::wsdl:port/*[local-name()='address'])*20)"></xsl:variable>
					<svg:rect x="60" y="{50 + $previousServiceHeights + $portsWithAddressHeights}" height="{20+(20*count(./*[local-name()='address']))}" width="{$widthService}" class="Port"></svg:rect>
					<xsl:variable name="imagePort"><xsl:value-of select="map:get($icons, 'com/pike/commons/wsdl/port_obj.gif')" /></xsl:variable>
					<svg:image x="62" y="{52 + $previousServiceHeights + $portsWithAddressHeights}" height="16" width="16" xlink:href="data:image/gif;base64,{normalize-space($imagePort)}"/>
					<svg:text x="82" y="{65+$previousServiceHeights + $portsWithAddressHeights}" class="TextRight"><xsl:value-of select="./@name"/></svg:text>
					<xsl:for-each select="./*[local-name()='address']">		
						<svg:text x="82" y="{65 + (20*position())+$previousServiceHeights + $portsWithAddressHeights}" class="TextRight"><xsl:value-of select="@location"/></svg:text>
					</xsl:for-each>			
				</xsl:for-each>
			</xsl:for-each>
			<xsl:variable name="portNames" select="./wsdl:definitions/wsdl:service/wsdl:port"/>
			<xsl:variable name="maxPortName"><xsl:choose><xsl:when test="count(./wsdl:definitions/wsdl:service/wsdl:port) &gt; 0">
			<xsl:for-each select="$portNames">
					<xsl:sort select="string-length(@name)" order="descending" data-type="number"/>
					<xsl:if test="position() = 1">
          				<xsl:value-of select="string-length(@name)"/>
          			</xsl:if>
				</xsl:for-each></xsl:when><xsl:otherwise>0</xsl:otherwise>
				</xsl:choose></xsl:variable>
			<xsl:variable name="serviceNames" select="./wsdl:definitions/wsdl:service"/>
			<xsl:variable name="maxServiceName"><xsl:choose><xsl:when test="count(./wsdl:definitions/wsdl:service) &gt; 0"> 
				<xsl:for-each select="$serviceNames">
					<xsl:sort select="string-length(@name)" order="descending" data-type="number"/>
					<xsl:if test="position() = 1">
          				<xsl:value-of select="string-length(@name)"/>
          			</xsl:if>
				</xsl:for-each></xsl:when><xsl:otherwise>0</xsl:otherwise>
				</xsl:choose></xsl:variable>
			<xsl:variable name="addressLocations" select="./wsdl:definitions/wsdl:service/wsdl:port/*[local-name()='address']"/>
			<xsl:variable name="maxAddressLocation"><xsl:choose><xsl:when test="count(./wsdl:definitions/wsdl:service/wsdl:port/*[local-name()='address']) &gt; 0"> 
				<xsl:for-each select="$addressLocations">
					<xsl:sort select="string-length(@location)" order="descending" data-type="number"/>
					<xsl:if test="position() = 1">
          				<xsl:value-of select="string-length(@location)"/>
          			</xsl:if>
				</xsl:for-each></xsl:when><xsl:otherwise>0</xsl:otherwise>
				</xsl:choose></xsl:variable>
			<xsl:variable name="maxServiceWidth" select="160 + CustomFunctions:max(number($maxServiceName),number($maxAddressLocation),number($maxPortName))*9 "/>
			<xsl:for-each select="./wsdl:definitions/wsdl:portType">
				<xsl:variable name="messages" select="./wsdl:operation/wsdl:*/@message"/>
				<xsl:variable name="messagesConcatenated">
					<xsl:for-each select="./wsdl:operation/wsdl:*/@message">
						<xsl:value-of select="concat(.,' ')"/>;
					</xsl:for-each>
				</xsl:variable>
				<xsl:variable name="parts" select="../wsdl:message[contains(concat($messagesConcatenated,' '),concat(':',@name,' '))]/wsdl:part"/>
				<xsl:variable name="widthPart" select="CustomFunctions:getMaxLengthOfPart($parts)"/>
				<xsl:variable name="faultNames" select="./wsdl:operation/wsdl:fault"/>				
				<xsl:variable name="maxFaultName"><xsl:choose><xsl:when test="count(./wsdl:operation/wsdl:fault) &gt; 0">
					<xsl:for-each select="$faultNames">
						<xsl:sort select="string-length(@name)" order="descending" data-type="number"/>
						 <xsl:if test="position() = 1"><xsl:value-of select="string-length(@name)"/></xsl:if>
					</xsl:for-each></xsl:when><xsl:otherwise>6</xsl:otherwise>
				</xsl:choose></xsl:variable>
				<xsl:variable name="previousIOFElements" select="preceding-sibling::wsdl:portType/wsdl:operation/*[self::wsdl:input or self::wsdl:output or self::wsdl:fault]"/>
				<xsl:variable name="allMessages" select="/wsdl:definitions/wsdl:message"/>
				<xsl:variable name="countPreviousParts" select="CustomFunctions:getCountOfPreviousParts($previousIOFElements,$allMessages)"/>
				<xsl:variable name="previousPortTypeHeights" select="(count(preceding-sibling::wsdl:portType)*40)+(count(preceding-sibling::wsdl:portType/wsdl:operation)*20)+($countPreviousParts*20)"/>	
				<xsl:variable name="partNameColumn" select="(number(normalize-space(substring-before($widthPart,':')))*9)+16"/>
				<xsl:variable name="partTypeColumn" select="(number(normalize-space(substring-after($widthPart,':')))*9)+16"/>
				<xsl:variable name="iofColumn" select="CustomFunctions:max(number(normalize-space($maxFaultName)),6)*9 + 16"/>
				<xsl:variable name="portTypeWidth" select="$iofColumn + $partTypeColumn + $partNameColumn"/>
				<!-- PORT TYPE -->
				<xsl:variable name="imagePortType"><xsl:value-of select="map:get($icons, 'com/pike/commons/wsdl/porttype_obj.gif')" /></xsl:variable>
				<svg:rect x="{$maxServiceWidth}" y="{30+$previousPortTypeHeights}" height="20" width="{$portTypeWidth}" class="PortType"></svg:rect>
				<svg:image x="{$maxServiceWidth +2}" y="{30 + $previousPortTypeHeights + 2}" height="16" width="16" xlink:href="data:image/gif;base64,{normalize-space($imagePortType)}"/>
				<svg:text x="{$maxServiceWidth +18}" y="{45 + $previousPortTypeHeights}" class="TextRight"><xsl:value-of select="./@name"/></svg:text>
				<!-- OPERATIONS -->
				<xsl:for-each select="./wsdl:operation">
					<xsl:variable name="operationPosition" select="position()"/>
					<xsl:variable name="messageTypesConcatenated" select="concat('input',' ','output',' ','fault')"/>
					<xsl:variable name="previousOperationMessages" select="preceding-sibling::wsdl:operation/wsdl:*[contains(concat($messageTypesConcatenated,' '),local-name())]/@message"/>
					<xsl:variable name="previousOperationMessagesConcatenated">
						<xsl:for-each select="preceding-sibling::wsdl:operation/wsdl:*[contains(concat($messageTypesConcatenated,' '),local-name())]/@message">
							<xsl:value-of select="concat(.,' ')"/>;
						</xsl:for-each>
					</xsl:variable>
					<xsl:variable name="previousOperationRows" select="count(../../wsdl:message[contains(concat($previousOperationMessagesConcatenated,' '),concat(':',@name,' '))]/wsdl:part)*20"/>
					<!-- xsl:variable name="previousOperationHeight" select="count(../../wsdl:message[@name=$inputMessage]/wsdl:part)*20"/-->
					<xsl:variable name="imageOperation"><xsl:value-of select="map:get($icons, 'com/pike/commons/wsdl/operation_obj.gif')" /></xsl:variable>
					<svg:rect x="{$maxServiceWidth}" y="{30 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows}" height="20" width="{$portTypeWidth}" class="Operation"></svg:rect>
					<svg:image x="{$maxServiceWidth +2}" y="{30 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows + 2}" height="16" width="16" xlink:href="data:image/gif;base64,{normalize-space($imageOperation)}"/>
					<svg:text x="{$maxServiceWidth +18}" y="{45 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows}" class="TextRight"><xsl:value-of select="./@name"/></svg:text>	   
					<!-- INPUT -->
					<xsl:variable name="inputMessage" select="substring-after(./wsdl:input/@message,':')"/>					
					<xsl:variable name="inputRowCount" select="count(../../wsdl:message[@name=$inputMessage]/wsdl:part)*20"/>
					<xsl:if test="./wsdl:input">
					<xsl:variable name="imageInput"><xsl:value-of select="map:get($icons, 'com/pike/commons/wsdl/input_obj.gif')" /></xsl:variable>
					<svg:rect x="{$maxServiceWidth}" y="{50 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows}" height="{$inputRowCount}" width="{$iofColumn}" class="IOPut"></svg:rect>
					<svg:image x="{$maxServiceWidth +2}" y="{50 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows +($inputRowCount div 2)-8}" height="16" width="16" xlink:href="data:image/gif;base64,{normalize-space($imageInput)}"/>
					<svg:text x="{$maxServiceWidth + 20}" y="{54 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows +($inputRowCount div 2)}" class="TextRight">input</svg:text>
					<xsl:for-each select="../../wsdl:message[@name=$inputMessage]/wsdl:part">
						<xsl:variable name="imageInputPartType"><xsl:choose><xsl:when test="./@type"><xsl:value-of select="map:get($icons, 'com/pike/commons/wsdl/simpletype_obj.gif')"/></xsl:when><xsl:when test="./@element"><xsl:value-of select="map:get($icons, 'com/pike/commons/wsdl/element_obj.gif')"/></xsl:when></xsl:choose></xsl:variable>
						<!-- Input Part Name -->
						<xsl:variable name="imageInputPart"><xsl:value-of select="map:get($icons, 'com/pike/commons/wsdl/part_obj.gif')" /></xsl:variable>
						<svg:rect x="{$maxServiceWidth + $iofColumn}" y="{50 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows +((position()-1)*20)}" height="20" width="{$partNameColumn}" class="Port"></svg:rect>
						<svg:image x="{$maxServiceWidth + $iofColumn +2}" y="{50 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows +(position()*20)-16}" height="16" width="16" xlink:href="data:image/gif;base64,{normalize-space($imageInputPart)}"/>
						<svg:text x="{$maxServiceWidth + $iofColumn + 20}" y="{45 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows +(position()*20)}" class="TextRight"><xsl:value-of select="@name"/></svg:text>
						<!-- Input Part Type -->
						<svg:rect x="{$maxServiceWidth + $iofColumn + $partNameColumn}" y="{50 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows +((position()-1)*20)}" height="20" width="{$partTypeColumn}" class="Port"></svg:rect>
						<svg:image x="{$maxServiceWidth + $iofColumn + $partNameColumn +2}" y="{50 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows +(position()*20)-16}" height="16" width="16" xlink:href="data:image/gif;base64,{normalize-space($imageInputPartType)}"/>
						<svg:text x="{$maxServiceWidth + $iofColumn + $partNameColumn + 20}" y="{45 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows +(position()*20)}" class="TextRight"><xsl:value-of select="@element"/><xsl:value-of select="@type"/></svg:text>
					</xsl:for-each>
					</xsl:if>
					<!-- OUTPUT -->
					<xsl:variable name="outputMessage" select="substring-after(./wsdl:output/@message,':')"/>
					<xsl:variable name="outputRowCount" select="count(../../wsdl:message[@name=$outputMessage]/wsdl:part)*20"/>
					<xsl:if test="./wsdl:output">
					<xsl:variable name="imageOutput"><xsl:value-of select="map:get($icons, 'com/pike/commons/wsdl/output_obj.gif')" /></xsl:variable>
					<svg:rect x="{$maxServiceWidth}" y="{50 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows + $inputRowCount}" height="{$outputRowCount}" width="{$iofColumn}" class="IOPut"></svg:rect>
					<svg:image x="{$maxServiceWidth +2}" y="{50 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows + $inputRowCount +($outputRowCount div 2)-8}" height="16" width="16" xlink:href="data:image/gif;base64,{normalize-space($imageOutput)}"/>
					<svg:text x="{$maxServiceWidth + 20}" y="{53 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows + $inputRowCount +($outputRowCount div 2)}" class="TextRight">output</svg:text>
					<xsl:for-each select="../../wsdl:message[@name=$outputMessage]/wsdl:part">
						<xsl:variable name="imageOutputPartType"><xsl:choose><xsl:when test="./@type"><xsl:value-of select="map:get($icons, 'com/pike/commons/wsdl/simpletype_obj.gif')"/></xsl:when><xsl:when test="./@element"><xsl:value-of select="map:get($icons, 'com/pike/commons/wsdl/element_obj.gif')"/></xsl:when></xsl:choose></xsl:variable>
						<!-- Output Part Name -->
						<xsl:variable name="imageOutputPartName"><xsl:value-of select="map:get($icons, 'com/pike/commons/wsdl/part_obj.gif')" /></xsl:variable>
						<svg:rect x="{$maxServiceWidth + $iofColumn}" y="{50 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows + $inputRowCount +((position()-1)*20)}" height="20" width="{$partNameColumn}" class="Port"></svg:rect>
						<svg:image x="{$maxServiceWidth + $iofColumn +2}" y="{50 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows + $inputRowCount +(position()*20)-16}" height="16" width="16" xlink:href="data:image/gif;base64,{normalize-space($imageOutputPartName)}"/>
						<svg:text x="{$maxServiceWidth + $iofColumn + 20}" y="{45 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows + $inputRowCount +(position()*20)}" class="TextRight"><xsl:value-of select="@name"/></svg:text>
						<!-- Output Part Type -->
						<svg:rect x="{$maxServiceWidth + $iofColumn + $partNameColumn}" y="{50 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows + $inputRowCount +((position()-1)*20)}" height="20" width="{$partTypeColumn}" class="Port"></svg:rect>
						<svg:image x="{$maxServiceWidth + $iofColumn + $partNameColumn +2}" y="{50 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows + $inputRowCount +(position()*20)-16}" height="16" width="16" xlink:href="data:image/gif;base64,{normalize-space($imageOutputPartType)}"/>
						<svg:text x="{$maxServiceWidth + $iofColumn + $partNameColumn + 20}" y="{45 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows + $inputRowCount +(position()*20)}" class="TextRight"><xsl:value-of select="@element"/><xsl:value-of select="@type"/></svg:text>
					</xsl:for-each>
					</xsl:if>
					<!-- FAULT -->
					<xsl:for-each select="./wsdl:fault">
					<xsl:variable name="previousFaultMessages" select="preceding-sibling::wsdl:fault/@message"/>
					<xsl:variable name="previousFaultMessagesConcatenated">
					<xsl:for-each select="preceding-sibling::wsdl:fault/@message">
						<xsl:value-of select="concat(.,' ')"/>;
					</xsl:for-each>
					</xsl:variable>
					<xsl:variable name="previousFaultRows" select="count(../../../wsdl:message[contains(concat($previousFaultMessagesConcatenated,' '),concat(':',@name,' '))]/wsdl:part)*20"/>
					<xsl:variable name="faultMessage" select="substring-after(./@message,':')"/>
					<xsl:variable name="faultRowCount" select="count(../../../wsdl:message[@name=$faultMessage]/wsdl:part)*20"/>
					<xsl:variable name="imageFault"><xsl:value-of select="map:get($icons, 'com/pike/commons/wsdl/fault_obj.gif')" /></xsl:variable>
						<svg:rect x="{$maxServiceWidth}" y="{50 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows + $inputRowCount + $outputRowCount + $previousFaultRows}" height="{$faultRowCount }" width="{$iofColumn}" class="IOPut"></svg:rect>
						<svg:image x="{$maxServiceWidth +2}" y="{50 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows + $inputRowCount + $outputRowCount + $previousFaultRows +($faultRowCount div 2)-8}" height="16" width="16" xlink:href="data:image/gif;base64,{normalize-space($imageFault)}"/>
						<svg:text x="{$maxServiceWidth + 20}" y="{53 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows + $inputRowCount + $outputRowCount + $previousFaultRows +($faultRowCount div 2)}" class="TextRight"><xsl:value-of select="@name"/></svg:text>
						<xsl:for-each select="../../../wsdl:message[@name=$faultMessage]/wsdl:part">
							<xsl:variable name="imageFaultPartType"><xsl:choose><xsl:when test="./@type"><xsl:value-of select="map:get($icons, 'com/pike/commons/wsdl/simpletype_obj.gif')"/></xsl:when><xsl:when test="./@element"><xsl:value-of select="map:get($icons, 'com/pike/commons/wsdl/element_obj.gif')"/></xsl:when></xsl:choose></xsl:variable>
							<!-- Fault Part Name -->
							<xsl:variable name="imageFaultPartName"><xsl:value-of select="map:get($icons, 'com/pike/commons/wsdl/part_obj.gif')" /></xsl:variable>
							<svg:rect x="{$maxServiceWidth + $iofColumn}" y="{50 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows + $inputRowCount + $outputRowCount + $previousFaultRows +((position()-1)*20)}" height="20" width="{$partNameColumn}" class="Port"></svg:rect>
							<svg:image x="{$maxServiceWidth + $iofColumn +2}" y="{50 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows + $inputRowCount + $outputRowCount + $previousFaultRows +(position()*20)-16}" height="16" width="16" xlink:href="data:image/gif;base64,{normalize-space($imageFaultPartName)}"/>
							<svg:text x="{$maxServiceWidth + $iofColumn + 20}" y="{45 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows + $inputRowCount + $outputRowCount + $previousFaultRows +(position()*20)}" class="TextRight"><xsl:value-of select="@name"/></svg:text>
							<!-- Fault Part Type -->
							<svg:rect x="{$maxServiceWidth + $iofColumn + $partNameColumn}" y="{50 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows + $inputRowCount + $outputRowCount + $previousFaultRows +((position()-1)*20)}" height="20" width="{$partTypeColumn}" class="Port"></svg:rect>
							<svg:image x="{$maxServiceWidth + $iofColumn + $partNameColumn +2}" y="{50 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows + $inputRowCount + $outputRowCount + $previousFaultRows +(position()*20)-16}" height="16" width="16" xlink:href="data:image/gif;base64,{normalize-space($imageFaultPartType)}"/>
							<svg:text x="{$maxServiceWidth + $iofColumn + $partNameColumn + 20}" y="{45 + (20*$operationPosition) + $previousPortTypeHeights + $previousOperationRows + $inputRowCount + $outputRowCount + $previousFaultRows +(position()*20)}" class="TextRight"><xsl:value-of select="@element"/><xsl:value-of select="@type"/></svg:text>
						</xsl:for-each>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:for-each>
			<!-- BINDINGS -->
			<xsl:for-each select="./wsdl:definitions/wsdl:binding">
				<xsl:variable name="bindingName" select="@name"/>
				<xsl:variable name="bindingType" select="substring-after(@type,':')"/>
				<xsl:variable name="service" select="../wsdl:service/wsdl:port[substring(@binding, string-length(@binding)-string-length(concat(':',$bindingName)) +1)]/.."/>
				<xsl:variable name="portType" select="../wsdl:portType[@name=$bindingType]"/>
				<xsl:for-each select="$service">
					<xsl:variable name="serviceY" select="(count(preceding-sibling::wsdl:service)*40)+(count(preceding-sibling::wsdl:service/wsdl:port)*20)+(count(preceding-sibling::wsdl:service/wsdl:port/*[local-name()='address'])*20)"/>
					<xsl:variable name="addresses" select="./wsdl:port/*[local-name()='address']"/>
					<xsl:variable name="portHeight" select="20 + ((20+ count(./wsdl:port[substring(@binding, string-length(@binding)-string-length(concat(':',$bindingName)) +1)]/*[local-name()='address'])*20) - 10) + count(./wsdl:port[substring(@binding, string-length(@binding)-string-length(concat(':',$bindingName)) +1)]/preceding-sibling::wsdl:port/*[local-name()='address'])*20"/>
					<xsl:variable name="maxAddressLocationLength"><xsl:choose><xsl:when test="count(./wsdl:port/*[local-name()='address']) &gt; 0"> 
					<xsl:for-each select="$addresses">
					<xsl:sort select="string-length(@location)" order="descending" data-type="number"/>
					<xsl:if test="position() = 1">
          				<xsl:value-of select="string-length(@location)"/>
          			</xsl:if>
					</xsl:for-each></xsl:when><xsl:otherwise>0</xsl:otherwise></xsl:choose></xsl:variable>				
					<xsl:variable name="ports1" select="./wsdl:port"/>
					<xsl:variable name="maxPortNameLength"><xsl:choose><xsl:when test="count(./wsdl:port) &gt; 0"> 
					<xsl:for-each select="$ports1">
					<xsl:sort select="string-length(@name)" order="descending" data-type="number"/>
					<xsl:if test="position() = 1">
          				<xsl:value-of select="string-length(@name)"/>
          			</xsl:if>
					</xsl:for-each></xsl:when><xsl:otherwise>0</xsl:otherwise>
					</xsl:choose></xsl:variable>
					<xsl:variable name="widthService1" select="CustomFunctions:max(number(string-length(@name)),number($maxPortNameLength),number($maxAddressLocationLength))*9"/>				
					<xsl:variable name="serviceY" select="(count(preceding-sibling::wsdl:service)*40)+(count(preceding-sibling::wsdl:service/wsdl:port)*20)+(count(preceding-sibling::wsdl:service/wsdl:port/*[local-name()='address'])*20)"/>
					<xsl:variable name="previousInputMessages1" select="/wsdl:definitions/wsdl:portType[@name=$bindingType]/preceding-sibling::wsdl:portType/wsdl:operation/wsdl:input/@message"></xsl:variable>
					<xsl:variable name="previousInputMessages1Concatenated">
					<xsl:for-each select="/wsdl:definitions/wsdl:portType[@name=$bindingType]/preceding-sibling::wsdl:portType/wsdl:operation/wsdl:input/@message">
						<xsl:value-of select="concat(.,' ')"/>;
					</xsl:for-each>
					</xsl:variable>
					<xsl:variable name="previousInputs1" select="count(/wsdl:definitions/wsdl:message[contains(concat($previousInputMessages1Concatenated,' '),concat(':',@name,' '))]/wsdl:part)"/>
					<xsl:variable name="previousOutputMessages1" select="/wsdl:definitions/wsdl:portType[@name=$bindingType]/preceding-sibling::wsdl:portType/wsdl:operation/wsdl:output/@message"></xsl:variable>
					<xsl:variable name="previousOutputMessages1Concatenated">
					<xsl:for-each select="/wsdl:definitions/wsdl:portType[@name=$bindingType]/preceding-sibling::wsdl:portType/wsdl:operation/wsdl:output/@message">
						<xsl:value-of select="concat(.,' ')"/>;
					</xsl:for-each>
					</xsl:variable>
					<xsl:variable name="previousOutputs1" select="count(/wsdl:definitions/wsdl:message[contains(concat($previousOutputMessages1Concatenated,' '),concat(':',@name,' '))]/wsdl:part)"/>
					<xsl:variable name="previousFaultMessages1" select="/wsdl:definitions/wsdl:portType[@name=$bindingType]/preceding-sibling::wsdl:portType/wsdl:operation/wsdl:fault/@message"></xsl:variable>
					<xsl:variable name="previousFaultMessages1Concatenated">
					<xsl:for-each select="/wsdl:definitions/wsdl:portType[@name=$bindingType]/preceding-sibling::wsdl:portType/wsdl:operation/wsdl:fault/@message">
						<xsl:value-of select="concat(.,' ')"/>;
					</xsl:for-each>
					</xsl:variable>
					<xsl:variable name="previousFaults1" select="count(/wsdl:definitions/wsdl:message[contains(concat($previousFaultMessages1Concatenated,' '),concat(':',@name,' '))]/wsdl:part)"/>				
					<xsl:variable name="previousPortTypeHeights1" select="(count(/wsdl:definitions/wsdl:portType[@name=$bindingType]/preceding-sibling::wsdl:portType)*40)+(count(/wsdl:definitions/wsdl:portType[@name=$bindingType]/preceding-sibling::wsdl:portType/wsdl:operation)*20)+(($previousInputs1+$previousOutputs1+$previousFaults1)*20)"/>	
					<svg:line x1="{60 + $widthService1}" y1="{30 + $serviceY + $portHeight}" x2="{$maxServiceWidth}" y2="{30 + $previousPortTypeHeights1 + 10}" class="Line" marker-end="url(#arrowfilled)"></svg:line>
				</xsl:for-each>
			</xsl:for-each>
			<svg:text x="15" y="15" fill="gray"><xsl:value-of select="CustomFunctions:initializeTemplate('wsdl2svg.xsl')"/></svg:text>		  
		</svg:svg>
	</xsl:template>
</xsl:stylesheet>
