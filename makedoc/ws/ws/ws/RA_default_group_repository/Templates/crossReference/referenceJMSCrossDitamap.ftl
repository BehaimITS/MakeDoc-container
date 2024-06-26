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
				<#if prop??>
					<topicref href="cross_<@ncname>${prop}</@ncname>.dita"/>
				</#if>
        </#list>    
    </#if> 
    <#if services??>
    <#list services?keys as serv>
    <#if references?keys?size==0>
    	<topicref href="cross_<@ncname>${serv}</@ncname>.dita"/>
    <#else>
    	<#if !references?keys?seq_contains(serv)>
    		<topicref href="cross_<@ncname>${serv}</@ncname>.dita"/>
    	</#if>    	
    </#if>
	 </#list> 
	 </#if>   
</map>