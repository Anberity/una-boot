<#macro paging url p spans>
    <#local span = (spans-3)/2 />
    <#local pageNo = p.number+1 />
    <#if (url?index_of("?") != -1)>
        <#local curl = (url+"&offset=") />
    <#else>
        <#local curl = (url+"?offset=")/>
    </#if>
    <ul class="pagination">
        <#if (pageNo > 1) >
            <#local prev = pageNo-1 />
            <li class="page-item">
                <a class="page-link" href="${curl}${prev}">Previous</a>
            </li>
        <#else>
            <li class="page-item disabled">
                <a class="page-link" href="javascript:void(0);">Previous</a>
            </li>
        </#if>

        <#local totalNo = span*2+3 />
        <#local totalNo1 = totalNo-1 />

        <#if (p.totalPages > totalNo)>
            <#if (pageNo <= span +2)>
                <#list 1..totalNo1 as i>
                    <@pageLink pageNo,i,curl/>
                </#list>
                <@pageLink 0,0,"javascript:void(0);"/>
                <@pageLink pageNo,p.totalPages,curl/>
            <#elseif (pageNo > (p.totalPages -(span+2)))>
                <@pageLink pageNo,1,curl/>
                <@pageLink 0,0,"javascript:void(0);"/>
                <#local num = p.totalPages - totalNo +2 />
                <#list num..p.totalPages as n>
                    <@pageLink pageNo,n,curl/>
                </#list>
            <#else>
                <@pageLink pageNo,1,curl/>
                <@pageLink 0,0,"javascript:void(0);"/>
                <#local num = pageNo - span />
                <#local num2 = pageNo + span />
                <#list num..num2 as n>
                    <@pageLink pageNo,n,curl/>
                </#list>
                <@pageLink 0,0,"javascript:void(0);"/>
                <@pageLink pageNo,p.totalPages,curl/>
            </#if>
        <#elseif (p.totalPages > 1)>
            <#list 1..p.totalPages as i >
                <@pageLink pageNo,i,curl />
            </#list>
        <#else>
            <@pageLink 1, 1, curl/>
        </#if>

        <#if (pageNo < p.totalPages)>
            <#local next = pageNo+1 />
            <li class="page-item">
                <a class="page-link" href="${curl}${next}">Next</a>
            </li>
        <#else>
            <li class="page-item disabled">
                <a class="page-link" href="javascript:void(0);">Next</a>
            </li>
        </#if>
    </ul>
</#macro>

<#macro pageLink pageNo idx url>
    <#if (idx ==0)>
        <li><span style="margin: 0 5px;letter-spacing: 5px;font-size: 16px">...</span></li>
    <#elseif (pageNo == idx)>
        <li class="page-item active">
            <a class="page-link" href="javascript:void(0);">${idx}<span class="sr-only">(current)</span></a>
        </li>
    <#else>
        <li class="page-item">
            <a class="page-link" href="${url}${idx}">${idx}</a>
        </li>
    </#if>
</#macro>