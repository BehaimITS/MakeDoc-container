<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE concept PUBLIC "-//OASIS//DTD DITA Concept//EN" "${dtdDirectory}/concept.dtd">
<#if navtitle??>
<concept id="${navtitle}" xml:lang="en-us">
	<title>${navtitle}</title>
	<titlealts><navtitle>${navtitle}</navtitle></titlealts>
	<conbody>
		<p>Chapter contains ${navtitle} crossreferences documentation.</p>
		<#if imagemapmodel??>
			<imagemap>
			<image href="${imagemapmodel.image}"/>		
			<#list imagemapmodel.areas as area>
			<area><shape>${area.shape}</shape><coords>${area.coords}</coords><#if area.href??><xref href="${area.href}"><#else><xref href="#"></#if>${area.xref}</xref></area>
			</#list>
			</imagemap>
		</#if>
		<#if references??>
		<#assign resolved=0>
		<p>Resolved references</p>
		<ul>
		<#list references as activity>		
			 
					<#if activity.destinationName??>
						<li>Reference from process ${activity.item.location} via activity <xref href="../../../projects${activity.item.location}.dita#${activity.objectInfo.name}">${activity.objectInfo.name}</xref></li>
						<#assign resolved=1>
					<#else>
					<#if activity.subProcessFile??>
						<li>Reference from process ${activity.item.location} via activity <xref href="../../../projects${activity.item.location}.dita#${activity.objectInfo.name}">${activity.objectInfo.name}</xref> to process <xref href="../../../projects${activity.subProcessFile}.dita">${activity.subProcessFile}</xref></li> 
						<#assign resolved=1>
					</#if></#if>
			
			</#list>
			<#if resolved==0>
			<li>None</li>
			</#if>
			</ul>
			<p>Unresolved references</p>
			<ul>
			<#assign unresolved=0>
			<#list references as activity>					 
					<#if !activity.destinationName?? && !activity.subProcessFile??>					
						 <li>Unresolved reference from ${activity.item.location} via activity <xref href="../../../projects${activity.item.location}.dita#${activity.objectInfo.name}">${activity.objectInfo.name}</xref></li>
						<#assign unresolved=1>
					</#if>			
			</#list>
			<#if unresolved==0>
			<li>None</li>
			</#if>
			</ul>
		</#if>
		<#if services??>
		<p>SOAP Over JMS/HTTP references</p>
		<ul>
		<#list services as item>		
			<li> Reference from <xref href="../../../projects${item.location}.dita">${item.name}</xref>
			</li>
			</#list>
			</ul>
		</#if>
	</conbody>
</concept>
</#if>
