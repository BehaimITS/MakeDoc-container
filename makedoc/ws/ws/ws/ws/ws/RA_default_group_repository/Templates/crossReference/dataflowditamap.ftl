<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE map PUBLIC "-//OASIS//DTD DITA Map//EN"
                     "${dtdDirectory}/map.dtd">
<map title="Data flow documentation">
	<topicmeta>
		<critdates>
			<created date="${createdDate}"/>
		</critdates>
	</topicmeta>
    <#if jmsmessagesCrossDita??>
      <topicref href="${jmsmessagesCrossDita}">
        <#if jmsmessagesCrossDitamap??>
          <topicref format="ditamap" href="${jmsmessagesCrossDitamap}"/>
        </#if>
      </topicref>
    </#if>
    <#if processFlowCrossDita??>
      <topicref href="${processFlowCrossDita}">
        <#if processFlowCrossDitamap??>
          <topicref format="ditamap" href="${processFlowCrossDitamap}"/>
        </#if>
      </topicref>
    </#if>
    <#if rvsubjectsCrossDita??>
      <topicref href="${rvsubjectsCrossDita}">
        <#if rvsubjectsCrossDitamap??>
          <topicref format="ditamap" href="${rvsubjectsCrossDitamap}"/>
        </#if>
      </topicref>
    </#if>
    <#if databaseobjectsCrossDita??>
      <topicref href="${databaseobjectsCrossDita}">
        <#if databaseobjectsCrossDitamap??>
          <topicref format="ditamap" href="${databaseobjectsCrossDitamap}"/>
        </#if>
      </topicref>
    </#if>
    <#if httpCrossDita??>
      <topicref href="${httpCrossDita}">
        <#if httpCrossDitamap??>
          <topicref format="ditamap" href="${httpCrossDitamap}"/>
        </#if>
      </topicref>
    </#if>
</map>
