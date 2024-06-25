<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE map PUBLIC "-//OASIS//DTD DITA Map//EN" "../dtd/map.dtd">
  <map title="Documentation content">
    <#if ClusterDeployementDescriptors??>
      <#if ClusterDeployementDescriptors?size &gt; 0>
        <topicref href="ClusterDeployementDescriptors/ClusterDeployementDescriptors.dita">
          <#list ClusterDeployementDescriptors as clusterDeployementDescriptor>
            <#if ClusterDeployementDescriptors??>
              <topicref href="${clusterDeployementDescriptor}"/>
            </#if>
          </#list>
        </topicref>
      </#if>
    </#if>
    <#if concepts??>
      <#if concepts?size &gt; 0>
        <topicref href="Concepts/Concepts.dita">
          <#list concepts as concept>
            <#if concept??>
              <topicref href="${concept}"/>
            </#if>
          </#list>
        </topicref>
      </#if>
    </#if>
    <#if conceptViews??>
      <#if conceptViews?size &gt; 0>
        <topicref href="ConceptViews/ConceptViews.dita">
          <#list conceptViews as conceptView>
            <#if conceptView??>
              <topicref href="${conceptView}"/>
            </#if>
          </#list>
        </topicref>
      </#if>
    </#if>
    <#if eventViews??>
      <#if eventViews?size &gt; 0>
        <topicref href="EventViews/EventViews.dita">
          <#list eventViews as eventView>
            <#if eventView??>
              <topicref href="${eventView}"/>
            </#if>
          </#list>
        </topicref>
      </#if>
    </#if>
    <#if GenerateGlobalVariables??>
      <topicref href="GlobalVariables/GlobalVariables.dita">
        <#if GlobalVariablesDitaMapFiles??>
          <#if GlobalVariablesDitaMapFiles?size &gt; 0>
            <#list GlobalVariablesDitaMapFiles as globalVarDitaMap>
              <#if globalVarDitaMap??>
                <topicref href="GlobalVariables/${globalVarDitaMap}.dita">
                  <topicref format="ditamap" href="GlobalVariables/${globalVarDitaMap}.globalVariables.ditamap"/>
                </topicref>
              </#if>
            </#list>
          </#if>
        </#if>
        <#if GlobalVariablesDitaFiles??>
          <#if GlobalVariablesDitaFiles?size &gt; 0>
            <#list GlobalVariablesDitaFiles as globalVariable>
              <#if globalVariable??>
                <topicref href="GlobalVariables/${globalVariable}"/>
              </#if>
            </#list>
          </#if>
        </#if>
      </topicref>
    </#if>
    <#if channels??>
      <#if channels?size &gt; 0>
        <topicref href="Channels/Channels.dita">
          <#list channels as channel>
            <#if channel??>
              <topicref href="${channel}"/>
            </#if>
          </#list>
        </topicref>
      </#if>
    </#if>
    <#if projectViews??>
      <#if projectViews?size &gt; 0>
        <topicref href="ProjectViews/ProjectViews.dita">
          <#list projectViews as projectView>
            <#if projectView??>
              <topicref href="${projectView}"/>
            </#if>
          </#list>
        </topicref>
      </#if>
    </#if>
    <#if rules??>
      <#if rules?size &gt; 0>
        <topicref href="Rules/Rules.dita">
          <#list rules as rule>
            <#if rule??>
              <topicref href="${rule}"/>
            </#if>
          </#list>
        </topicref>
      </#if>
    </#if>
    <#if rulefunctions??>
      <#if rulefunctions?size &gt; 0>
        <topicref href="RuleFunctions/RuleFunctions.dita">
          <#list rulefunctions as rulefunction>
            <#if rulefunction??>
              <topicref href="${rulefunction}"/>
            </#if>
          </#list>
        </topicref>
      </#if>
    </#if>
    <#if rulefunctionimpls??>
      <#if rulefunctionimpls?size &gt; 0>
        <topicref href="DecisionTables/DecisionTables.dita">
          <#list rulefunctionimpls as rulefunctionimpl>
            <#if rulefunctionimpl??>
              <topicref href="${rulefunctionimpl}"/>
            </#if>
          </#list>
        </topicref>
      </#if>
    </#if>
    <#if scorecards??>
      <#if scorecards?size &gt; 0>
        <topicref href="ScoreCards/ScoreCards.dita">
          <#list scorecards as scorecard>
            <#if scorecard??>
              <topicref href="${scorecard}"/>
            </#if>
          </#list>
        </topicref>
      </#if>
    </#if>
    <#if sharedresources??>
      <topicref href="SharedResources/SharedResources.dita">
        <#if sharedHttpResources??>
          <#if sharedHttpResources?size &gt; 0>
            <topicref href="SharedResources/SharedHttpConnections.dita">
              <#list sharedHttpResources as httpresource>
                <#if httpresource??>
                  <topicref href="${httpresource}"/>
                </#if>
              </#list>
            </topicref>
          </#if>
        </#if>
       <#if sharedJdbcResources??>
          <#if sharedJdbcResources?size &gt; 0>
            <topicref href="SharedResources/SharedJdbcConnections.dita">
              <#list sharedJdbcResources as jdbcresource>
                <#if jdbcresource??>
                  <topicref href="${jdbcresource}"/>
                </#if>
              </#list>
            </topicref>
          </#if>
        </#if>
        <#if sharedJmsApplicationPropertiesDitaFiles??>
          <#if sharedJmsApplicationPropertiesDitaFiles?size &gt; 0>
            <topicref href="SharedResources/SharedJmsApplicationProperties.dita">
              <#list sharedJmsApplicationPropertiesDitaFiles as jmsappprop>
                <#if jmsappprop??>
                  <topicref href="${jmsappprop}"/>
                </#if>
              </#list>
            </topicref>
          </#if>
        </#if>
        <#if sharedJmsResources??>
          <#if sharedJmsResources?size &gt; 0>
            <topicref href="SharedResources/SharedJmsConnections.dita">
              <#list sharedJmsResources as jmsresource>
                <#if jmsresource??>
                  <topicref href="${jmsresource}"/>
                </#if>
              </#list>
            </topicref>
          </#if>
        </#if>
        <#if sharedsharedJndiConfigDitaFiles??>
          <#if sharedsharedJndiConfigDitaFiles?size &gt; 0>
            <topicref href="SharedResources/SharedJndiConfigs.dita">
              <#list sharedsharedJndiConfigDitaFiles as jndiconfig>
                <#if jndiconfig??>
                  <topicref href="${jndiconfig}"/>
                </#if>
              </#list>
            </topicref>
          </#if>
        </#if>
      </topicref>
    </#if>
    <#if simpleevents??>
      <#if simpleevents?size &gt; 0>
        <topicref href="Events/Events.dita">
          <#list simpleevents as event>
            <#if event??>
              <topicref href="${event}"/>
            </#if>
          </#list>
        </topicref>
      </#if>
    </#if>
    <#if statemachines??>
      <#if statemachines?size &gt; 0>
        <topicref href="StateMachines/StateMachines.dita">
          <#list statemachines as machine>
            <#if machine??>
              <topicref href="${machine}"/>
            </#if>
          </#list>
        </topicref>
      </#if>
    </#if>
    <#if timeevents??>
      <#if timeevents?size &gt; 0>
        <topicref href="TimeEvents/TimeEvents.dita">
          <#list timeevents as timeevent>
            <#if timeevent??>
              <topicref href="${timeevent}"/>
            </#if>
          </#list>
        </topicref>
      </#if>
    </#if> 
    <#if xsds??>   
      <#if xsds?size &gt; 0>  
        <topicref href="XSDs/XSDs.dita">
          <#list xsds as xsd>   
            <#if xsd??>
              <topicref href="${xsd}"/>
            </#if>
          </#list>
        </topicref>
      </#if>
    </#if>
  </map>