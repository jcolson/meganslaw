<?xml version="1.0" encoding="UTF-8"?>
<jsp:root version="1.2" xmlns:f="http://java.sun.com/jsf/core" xmlns:h="http://java.sun.com/jsf/html" xmlns:jsp="http://java.sun.com/JSP/Page" xmlns:ui="http://www.sun.com/web/ui">
    <jsp:directive.page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"/>
    <f:view>
        <ui:page binding="#{ScumXmlOutput.page1}" id="page1">
            <ui:html binding="#{ScumXmlOutput.html1}" id="html1">
                <ui:head binding="#{ScumXmlOutput.head1}" id="head1">
                    <ui:link binding="#{ScumXmlOutput.link1}" id="link1" url="/resources/stylesheet.css"/>
                </ui:head>
                <ui:body binding="#{ScumXmlOutput.body1}" id="body1" style="-rave-layout: grid">
                    <ui:form binding="#{ScumXmlOutput.form1}" id="form1">
                        <ui:markup binding="#{ScumXmlOutput.markup1}" id="markup1" style="position: absolute; left: 216px; top: 72px"/>
                    </ui:form>
                </ui:body>
            </ui:html>
        </ui:page>
    </f:view>
</jsp:root>
