# com.behaimits.sample.http.requestor {#violation1 .concept}

License for TIBCO Software Use Only!

Description of rule: Item doesn't contain any description or description too short

Violation appeared in following files:

**Parent topic:**[WARNING - Incorrect description](../../../qa/rules/WARNING_-_Incorrect_description.md)

## Activities {#Activities}

-   */Processes/Dispatcher.bwp* - activity End
-   */Processes/Dispatcher.bwp* - activity SendHTTPRequest
-   */Processes/HTTPReceiver.bwp* - activity SendHTTPResponse
-   */Processes/Log.bwp* - activity End
-   */Processes/Log.bwp* - activity log
-   */Processes/ReceiveLog.bwp* - activity ParseXml
-   */Processes/WriteFact.bwp* - activity End
-   */Processes/WriteFact.bwp* - activity JDBCUpdate
-   */Processes/WriteFact.bwp* - activity ParseJSON
-   */Processes/WriteLog.bwp* - activity End
-   */Processes/WriteLog.bwp* - activity JDBCUpdate

## Module {#Module}

-   [/META-INF/module.bwm](../../../projects/com.behaimits.sample.http.requestor/META-INF/module.bwm.md) - module com.behaimits.sample.http.requestor

## Resources {#Resources}

-   */Resources/RequestingHTTPConnection.httpClientResource* - resource com.behaimits.sample.http.requestor.RequestingHTTPConnection

