<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE concept PUBLIC "-//OASIS//DTD DITA Concept//EN" "../dtd/concept.dtd">
<concept id="dummy" xml:lang="en-us">
	<title>QA Rules Statistics Summary</title>
		<titlealts>
			<navtitle>QA Rules Statistics</navtitle>
		</titlealts>
		<conbody>
			<p>Section contains summary of QualityAssurance rules statistics.</p>
		</conbody>
		<#if rules??>
		<concept id="Rules" xml:lang="en-us">
		<title>Invalid QA Rules</title>
		<conbody>
			<p>
			<#if rules?size &gt; 0>
				<ul>
				<#list rules as qarules>
					<li>${qarules_index + 1}. ${qarules}</li>
				</#list>
				</ul>
			<#else>
			No invalid rules detected.
			</#if>
			</p>
		</conbody>
	</concept>
	</#if>
	<#if stats??>
	<concept id="RulesStats" xml:lang="en-us">
		<title>QA Rules Statistics</title>
		<conbody>
		<p>
		<#if stats?size &gt; 0>
			<table>
				<tgroup cols="3">
				<colspec colname="rule"/>
				<colspec colname="fired"/>
				<colspec colname="checked"/>
				<thead>
					<row>
						<entry colname="rule">Rule location</entry>
						<entry colname="fired">Rule fired</entry>
						<entry colname="checked">Rule checked</entry>
					</row>
				</thead>
				<tbody>
				<#list stats?keys as key>
					<row>
						<entry>${key}</entry>
						<entry>${stats[key][0]}</entry>
							<entry>${stats[key][1]}</entry>
					</row>
				</#list>
				</tbody>
				</tgroup>
			</table>
		<#else>
		No statistics generated.
		</#if>
		</p>
	</conbody>
</concept>
</#if>
</concept>