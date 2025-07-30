# ListeningHTTPConnection {#HTTPConnectorsMain .concept}

License for TIBCO Software Use Only!

Section contains description od HTTP Connectors " ListeningHTTPConnection.httpConnResource " .

**Parent topic:**[HTTP Connectors](../../../../../../../../projects/com.behaimits.sample.http.requestor/common/httpConnector.md)

## Basic Configuration {#HTTPConnectorBasic}

-   Host: [HOST\_NAME](#default:%20localhost,%20UnixProfile:%20localhost,%20WindowsProfile:%20localhost,)
-   Port: [LISTENING\_PORT](#default:%2013008,%20UnixProfile:%2013008,%20WindowsProfile:%2013008,)
-   Accept Queue Size: -1
-   Acceptor Threads: 1

## Advanced Configuration {#HTTPConnectorAdvanced}

-   Head Buffer Size \(B\): 4096
-   Request Buffer Size \(B\): 8192
-   Response Buffer Size \(B\): 24576
-   Max Idle Time \(ms\): 200000
-   Low Resource Max Idle Time \(ms\): 0
-   Linger Time \(ms\): 0
-   Session timeout \(ms\): 1800
-   Max Post Size: 2097152
-   Max Save Post Size: 4096
-   Minimum QTP Threads: 10
-   Maximum QTP Threads: 75
-   Disable HTTP Methods:

    |HTTP Method|
    |-----------|
    | |


-   Use Non-Blocking IO Sockets: true
-   Use Direct Buffers: true
-   URI Encoding:
-   Enable DNS Lookups: false
-   Compression: false
-   Compressible Mime Types text/html,text/xml,text/plain
-   Reverse Proxy Host:
-   Reverse Proxy Port: 0
-   Enable access logs: false
-   Share accross application: false

-   No SSL server configuration chosen.

