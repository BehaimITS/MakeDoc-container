<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE map PUBLIC "-//OASIS//DTD DITA Map//EN"
                     "${dtdDirectory}/map.dtd">
<map title="Dependencies documentation">
	<topicmeta>
		<critdates>
			<created date="${createdDate}"/>
		</critdates>
	</topicmeta>
    <#if policyrossDita??>
    <topicref href="${policyCrossDita}">
        <#if policyCrossDitamap??>
                <topicref format="ditamap" href="${policiyCrossDitamap}"/>
        </#if>              
    </topicref>
    </#if>
    <#if resourcesCrossDita??>
      <topicref href="${resourcesCrossDita}">
        <#if resourcesCrossDitamap??>
          <topicref format="ditamap" href="${resourcesCrossDitamap}"/>
        </#if>
      </topicref>
    </#if>
    <#if processCrossDita??>
      <topicref href="${processCrossDita}">
        <#if processCrossDitamap??>
          <topicref format="ditamap" href="${processCrossDitamap}"/>
        </#if>
      </topicref>
    </#if>
    <#if substvarsCrossDita??>
      <topicref href="${substvarsCrossDita}">
        <#if substvarsCrossDitamap??>
          <topicref format="ditamap" href="${substvarsCrossDitamap}"/>
        </#if>
      </topicref>
    </#if>
    <#if xsdCrossDita??>
      <topicref href="${xsdCrossDita}">
        <#if xsdCrossDitamap??>
          <topicref format="ditamap" href="${xsdCrossDitamap}"/>
        </#if>
      </topicref>
    </#if>
    <#if wsdlCrossDita??>
      <topicref href="${wsdlCrossDita}">
        <#if wsdlCrossDitamap??>
          <topicref format="ditamap" href="${wsdlCrossDitamap}"/>
        </#if>
      </topicref>
    </#if>
</map>