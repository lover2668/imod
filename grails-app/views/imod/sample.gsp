
<%@ page import="imod.Imod" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'imod.label', default: 'Imod')}" />
        <title>
            <g:message code="default.list.label" args="[entityName]" />
        </title>
    </head>
    <body>

        <a href="/imod/imod/sample">Create SAMPLE IMOD</a>

        <div class="list-imod-body">
            <div id="list-imod" class="content scaffold-list" role="main">
                <g:if test="${flash.message}">
                    <div class="message" role="status">
                        ${flash.message}
                    </div>
                </g:if>
                <g:link class="dashed-square" action="create" >
                    <br/>
                    <br/>
                    New IMOD
                </g:link>
                <g:each in="${imodInstanceList}" var="imodInstance">
                    <g:link controller="courseOverview" action="index" id="${imodInstance.id}" class="square">
                        <br/>
                        <br/>
                        ${fieldValue(bean: imodInstance, field: "name")}
                    </g:link>
                </g:each>
            </div>
        </div>
    </body>
</html>
