<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE concept PUBLIC "-//OASIS//DTD DITA Concept//EN" "${dtdDirectory}/concept.dtd">
<#if introId??>
<concept id="${introId}_summary" xml:lang="en-us">
<#if navtitle??>
<title>${navtitle}</title>
<titlealts><navtitle>${navtitle}</navtitle></titlealts>
<conbody>
<p>Chapter contains ${navtitle} Cross-reference documentation. <#if summaryDescription??>${summaryDescription}</#if></p>
</#if>
</conbody>
</concept>
</#if>