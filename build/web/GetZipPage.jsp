<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="1.2" xmlns:f="http://java.sun.com/jsf/core" xmlns:h="http://java.sun.com/jsf/html" xmlns:jsp="http://java.sun.com/JSP/Page" xmlns:ui="http://www.sun.com/web/ui">
    <jsp:directive.page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"/>
    <f:view>
        <ui:page binding="#{GetZipPage.page1}" id="page1">
            <ui:html binding="#{GetZipPage.html1}" id="html1">
                <ui:head binding="#{GetZipPage.head1}" id="head1">
                    <ui:link binding="#{GetZipPage.link1}" id="link1" url="/resources/stylesheet.css"/>
                </ui:head>
                <ui:body binding="#{GetZipPage.body1}" id="body1" style="-rave-layout: grid">
                    <ui:form binding="#{GetZipPage.form1}" id="form1">
                        <ui:panelLayout binding="#{GetZipPage.layoutPanel1}" id="layoutPanel1" style="height: 118px; left: 288px; top: 168px; position: absolute; width: 262px; -rave-layout: grid">
                            <ui:textField binding="#{GetZipPage.zipCode}" id="zipCode" required="true"
                                style="left: 120px; top: 24px; position: absolute; width: 119px" validator="#{GetZipPage.lengthValidator1.validate}" valueChangeListener="#{GetZipPage.zipCode_processValueChange}"/>
                            <ui:button action="#{GetZipPage.submitZip_action}" binding="#{GetZipPage.submitZip}" id="submitZip"
                                style="left: 95px; top: 72px; position: absolute" text="Find 'Em"/>
                            <ui:label binding="#{GetZipPage.labZip}" id="labZip" style="left: 24px; top: 24px; position: absolute" text="ZIP Code:"/>
                        </ui:panelLayout>
                    </ui:form>
                </ui:body>
            </ui:html>
        </ui:page>
    </f:view>
</jsp:root>
