# Quality Assurance Rule Editor {#qualityAssuranceDialog .concept}

**Note:** This dialog is available only if you have purchased product Quality Assurance.

This dialog is used for editing of Quality Assurance rules. It is possible to open MakeDoc's \*.rule files in order to modifying them. The rule is classified by its group, type and name \(this combination has to be unique within MakeDoc's project\). Group also reflects output chapter in documentation and rule's topic group.

It can be opened by double-clicking on \*.rule item from **MakeDoc Explorer** view.

![Screenshot of Quality Assurance Rule Editor Page](img/RuleEditor.png "QA Rule General Settings Page")

There are several fields to modify within rule:

-   **Group** - Specifies the group to which rule belongs - this division also determines how the output documentation will be structured.
-   **Type** - It determines the rule within the group \(chapter\) - it usually specifies exact item, to which the rule refers.
-   **Description** - Kind characteristics of rule - every rule in chapter should have the same description.
-   **Mask** - Together with configuration items allows to add extra information for concrete rule violation to output document.
-   **Name** - Name of the rule for better recognition and orientation.
-   **Severity** - Severity of rule - rules are also sorted in output documentation by this item.
-   **Filter** - File types to which the rule refers to can be chosen.
-   **Configuration** - Detailed configuration of rule which depends on its type and implementation details.

**Parent topic:**[Working with Rules](../../../modules/qa/setup/workingWithRules.md)

