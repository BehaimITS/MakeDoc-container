# Troubleshooting {#preface .concept}

This chapter describes problems that might arise with MakeDoc release and it's solutions.

|Symptom|Solution|
|-------|--------|
|Generation process ends with an error *Too many open files* when generating under GNU/Linux.|There is limit under GNU/Linux systems for how many files can be opened by certain user simultaneously. It is set to 1024 by default. Increase this limit for user running MakeDoc to generate documentation successfully. This limit can be specified in /etc/security/limits.conf. Using \* instead of username will affect all users on target machine.|
|Generation process ends with an error *java.lang.OutOfMemoryError: Java heap space*|Increase amount of memory available for MakeDoc by the help of *Window -\> Preferences -\> MakeDoc -\> Base configuration* dialog.|

