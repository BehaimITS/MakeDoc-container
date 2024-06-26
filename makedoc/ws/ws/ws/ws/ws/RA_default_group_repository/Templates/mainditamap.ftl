<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE map PUBLIC "-//OASIS//DTD DITA Map//EN"
                     "../dtd/map.dtd">
<map title="${profileName}">
	<topicmeta>
		<critdates>
			<created date="${createdDate}"/>
		</critdates>
	</topicmeta>
	<topicref href="intro.dita"/>
    <#if projectDita??>
    <topicref href="${projectDita}">
        <#if projectDitamap??>
                <topicref format="ditamap" href="${projectDitamap}"/>
        </#if>              
    </topicref>
    </#if>
    <#if crossDita??>
      <topicref href="${crossDita}">
        <#if crossDitaMap??>
          <topicref format="ditamap" href="${crossDitaMap}"/>
        </#if>
      </topicref>
    </#if>
    <#if qaDita??>
      <topicref href="${qaDita}">
        <#if qaDitaMap??>
          <topicref format="ditamap" href="${qaDitaMap}"/>
        </#if>
      </topicref>
    </#if>
    <#if unresolvedLinks??>
      <topicref href="${unresolvedLinks}"/>
    </#if>
</map>