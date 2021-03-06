<#macro outputBean bean>
	<#assign beanClass = bean.targetSource.target.class>
    <#list beanClass.annotations as ann>
        <#if ann?contains("javax.persistence.Table")>
            <${ann.name()}
        <#else>
            <${beanClass.simpleName}
        </#if>
    </#list>
    <#list beanClass.declaredFields as attrib>
        <#if attrib.type.enum>
            <@invokeMethod bean=bean method=attrib.name/>
        <#elseif attrib.type.name?starts_with("java.util")>
            <@invokeBean alias="property" bean=bean method=attrib.name/>
        <#elseif !attrib.type.name?starts_with("java")>
            <@invokeBean alias="property" bean=bean method=attrib.name/>
        <#else>
            <@invokeMethod bean=bean method=attrib.name/>
        </#if>
    </#list>
	/>
</#macro>
<dataset>
		<#list beans as bean>
			<@outputBean bean=bean />
		</#list>
		<#list property as otherBean>
			<@outputBean bean=otherBean />
		</#list>
</dataset>