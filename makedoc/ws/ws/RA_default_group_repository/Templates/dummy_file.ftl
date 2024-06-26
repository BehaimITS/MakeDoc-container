<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE concept PUBLIC "-//OASIS//DTD DITA Concept//EN" "../dtd/concept.dtd">
<#if message?? && dummy_file?? && fullpath??>
<concept id="dummy" xml:lang="en-us">
    <title>${fullpath}</title>
      <titlealts>
        <navtitle>${fullpath}</navtitle>
      </titlealts>
    <conbody>
      <p>Section contains description of generated dummy file:  ${dummy_file}</p>
              <p>BE Object with full path: '${fullpath}' was not documented.</p>
      <section>
        <indexterm>${fullpath}</indexterm>
      </section>
    </conbody>
    <concept id="Message" xml:lang="en-us">
    	<title>Message</title>
    	<conbody>
    		<p>
    			${message}
    		</p>
    	</conbody>
    </concept>
    <#if cause_message??>
    <concept id="CauseMessage" xml:lang="en-us">
    	<title>Cause Message</title>
    	<conbody>
    		<p>
    			${cause_message}
    		</p>
    	</conbody>
    </concept>
    </#if>
</concept>
</#if> 
