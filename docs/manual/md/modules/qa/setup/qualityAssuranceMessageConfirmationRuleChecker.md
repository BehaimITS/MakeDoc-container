# MessageConfirmationRuleChecker {#MessageConfirmationRuleChecker .concept}

Groups of preconfigured MessageConfirmationRuleChecker types of rules with instance distinction and violation description:

-   **Presence of messages confirmation activities** - Messages consumed by activities are not confirmed
    -   JMS activities
    -   RV activities
    -   Adapter activities

![MessageConfirmationRuleChecker particular violation](img/MessageConfirmationRuleChecker.png "MessageConfirmationRuleChecker particular violation")

This type of rule allows to check whether is present in process for activity appropriate confirmation activity \(or activity has auto confirmation set\). Example in picture above shows missing corresponding confirmation activity for JMS Queue Receiver. Violation will be discovered in this case.

![MessageConfirmationRuleChecker configuration](img/MessageConfirmationRuleCheckerConfiguration.png "MessageConfirmationRuleChecker configuration")

In configuration section is possible to choose from three types of activities which will be checked - JMS, RV or Ada.

![MessageConfirmationRuleChecker particular violation documentation output](img/MessageConfirmationRuleCheckerOutput.png "MessageConfirmationRuleChecker particular violation documentation output")

**Parent topic:**[Rule types description](../../../modules/qa/setup/qualityAssuranceRuleTypesDescription.md)

