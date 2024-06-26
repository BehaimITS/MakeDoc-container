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
		
		<#list references as item>
			<#if item?exists && item.referencedFrom?size &gt; 0>
			    <p>Referenced From:
			        <ul>
			            <#list item.referencedFrom as refFrom>        
			                <li>
			                    <#if refFrom.location??>
			                        <xref href="../../../projects<@ncnamepath>${refFrom.location}</@ncnamepath>.dita">${refFrom.name}</xref>
			                    <#else>
			                        ${refFrom.name}
			                    </#if>
			                </li>
			            </#list>
			        </ul>
			    </p>
			</#if>
			<#if item?exists && item.referencesTo?size &gt; 0>
				<p>References To:
					<ul>
						<#list item.referencesTo as refTo>		
							<li>
								<#if refTo.location??>
									<xref href="../../../projects<@ncnamepath>${refTo.location}</@ncnamepath>.dita">${refTo.name}</xref>
								<#else>
									${refTo.name}
								</#if>
							</li>
						</#list>
					</ul>
				</p>
			</#if>
		</#list>
		
		</#if>
	</conbody>
</concept>
</#if>
