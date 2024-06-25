<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE concept PUBLIC "-//OASIS//DTD DITA Concept//EN" "../dtd/concept.dtd">
<#if introId??>
<concept id="${introId}_summary" xml:lang="en-us">
<#if introText??>
<#if navtitle??>
<title>${navtitle}</title>
<titlealts><navtitle>${navtitle}</navtitle></titlealts>
<#else>
<title>${introText}</title>
<titlealts><navtitle>${introText}</navtitle></titlealts>
</#if>
<conbody>
<p>Chapter contains ${introText} documentation.</p>
</#if>
</conbody>
</concept>
</#if>