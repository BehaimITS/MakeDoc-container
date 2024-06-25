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
		<ul>
		<#list references as activity>		
			<li> 
				<#if flowType != "BWP">
					<#if activity.item.location??>
						Reference from process ${activity.item.location} via activity <xref href="../../../projects${activity.item.location}.dita#${activity.objectInfo.name}">${activity.objectInfo.name}</xref>
					<#else>
						${activity.item.name}
					</#if>
				<#else>
					<#if activity.destinationName??>
						Reference from process ${activity.item.location} via activity <xref href="../../../projects${activity.item.location}.dita#${activity.objectInfo.name}">${activity.objectInfo.name}</xref>
					<#else>
						<xref href="../../${activity.originalDestination}">#</xref>
					</#if>
				</#if>
			</li>
			</#list>
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
