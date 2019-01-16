<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="1.2" xmlns:f="http://java.sun.com/jsf/core" xmlns:h="http://java.sun.com/jsf/html" xmlns:jsp="http://java.sun.com/JSP/Page" xmlns:ui="http://www.sun.com/web/ui">
    <jsp:directive.page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"/>
    <f:view>
        <ui:page binding="#{DisplayScumBags.page1}" id="page1">
            <ui:html binding="#{DisplayScumBags.html1}" id="html1">
                <ui:head binding="#{DisplayScumBags.head1}" id="head1">
                    <ui:link binding="#{DisplayScumBags.link1}" id="link1" url="/resources/stylesheet.css"/>
                </ui:head>
                <ui:body binding="#{DisplayScumBags.body1}" id="body1" style="-rave-layout: grid">
                    <ui:form binding="#{DisplayScumBags.form1}" id="form1">
                        <ui:panelLayout binding="#{DisplayScumBags.layoutPanel1}" id="layoutPanel1" style="height: 334px; left: 48px; top: 72px; position: absolute; width: 478px; -rave-layout: grid">
                            <ui:table augmentTitle="false" binding="#{DisplayScumBags.tabScumBags}" id="tabScumBags"
                                style="height: 117px; left: 0px; top: 0px; position: absolute" title="Scum Bags" width="480">
                                <script><![CDATA[
/* ----- Functions for Table Preferences Panel ----- */
/*
 * Toggle the table preferences panel open or closed
 */
function togglePreferencesPanel() {
  var table = document.getElementById("form1:table1");
  table.toggleTblePreferencesPanel();
}
/* ----- Functions for Filter Panel ----- */
/*
 * Return true if the filter menu has actually changed,
 * so the corresponding event should be allowed to continue.
 */
function filterMenuChanged() {
  var table = document.getElementById("form1:table1");
  return table.filterMenuChanged();
}
/*
 * Toggle the custom filter panel (if any) open or closed.
 */
function toggleFilterPanel() {
  var table = document.getElementById("form1:table1");
  return table.toggleTableFilterPanel();
}
/* ----- Functions for Table Actions ----- */
/*
 * Initialize all rows of the table when the state
 * of selected rows changes.
 */
function initAllRows() {
  var table = document.getElementById("form1:table1");
  table.initAllRows();
}
/*
 * Set the selected state for the given row groups
 * displayed in the table.  This functionality requires
 * the 'selectId' of the tableColumn to be set.
 *
 * @param rowGroupId HTML element id of the tableRowGroup component
 * @param selected Flag indicating whether components should be selected
 */
function selectGroupRows(rowGroupId, selected) {
  var table = document.getElementById("form1:table1");
  table.selectGroupRows(rowGroupId, selected);
}
/*
 * Disable all table actions if no rows have been selected.
 */
function disableActions() {
  // Determine whether any rows are currently selected
  var table = document.getElementById("form1:table1");
  var disabled = (table.getAllSelectedRowsCount() > 0) ? false : true;
  // Set disabled state for top actions
  document.getElementById("form1:table1:tableActionsTop:deleteTop").setDisabled(disabled);
  // Set disabled state for bottom actions
  document.getElementById("form1:table1:tableActionsBottom:deleteBottom").setDisabled(disabled);
}]]></script>
                                <ui:tableRowGroup binding="#{DisplayScumBags.tableRowGroup1}" id="tableRowGroup1" rows="10"
                                    sourceData="#{DisplayScumBags.scumbagsDataProvider}" sourceVar="currentRow">
                                    <ui:tableColumn binding="#{DisplayScumBags.tableColumn1}" headerText="Full Name" id="tableColumn1" sort="scumbags.full_name">
                                        <ui:staticText binding="#{DisplayScumBags.staticText1}" id="staticText1" text="#{currentRow.value['scumbags.full_name']}"/>
                                    </ui:tableColumn>
                                    <ui:tableColumn binding="#{DisplayScumBags.tableColumn2}" headerText="Image" id="tableColumn2" sort="scumbags.image_url">
                                        <ui:image binding="#{DisplayScumBags.image1}" id="image1" url="#{currentRow.value['scumbags.image_url']}"/>
                                    </ui:tableColumn>
                                    <ui:tableColumn binding="#{DisplayScumBags.tableColumn3}" headerText="Date Updated" id="tableColumn3" sort="scumbags.date_updated">
                                        <ui:staticText binding="#{DisplayScumBags.staticText3}" id="staticText3" text="#{currentRow.value['scumbags.date_updated']}"/>
                                    </ui:tableColumn>
                                    <ui:tableColumn binding="#{DisplayScumBags.tableColumn4}" headerText="Data Status" id="tableColumn4" sort="scumbags.data_status">
                                        <ui:staticText binding="#{DisplayScumBags.staticText4}" id="staticText4" text="#{currentRow.value['scumbags.data_status']}"/>
                                    </ui:tableColumn>
                                </ui:tableRowGroup>
                            </ui:table>
                        </ui:panelLayout>
                    </ui:form>
                </ui:body>
            </ui:html>
        </ui:page>
    </f:view>
</jsp:root>
