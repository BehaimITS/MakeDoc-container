<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE map PUBLIC "-//OASIS//DTD DITA Map//EN"
                     "${dtdDirectory}/map.dtd">
<map title="${navtitle} cross-reference documentation">
	<topicmeta>
		<critdates>
			<created date="${createdDate}"/>
		</critdates>
	</topicmeta>
    <#if references??>
         <#list references?keys as prop>
			<topicref href="cross_<@ncname>${prop}</@ncname>.dita"/>	
        </#list>    
    </#if>    
</map>