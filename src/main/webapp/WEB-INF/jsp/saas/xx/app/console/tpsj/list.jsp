<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/inc/taglib.jsp" %>
<%--
  ~ Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
  ~ http://www.hn-hisun.com
  ~ 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
  --%>

<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link href="${path}/css/common/common.css" rel="stylesheet" type="text/css"/>
<!-- BEGIN PAGE LEVEL STYLES -->
<link rel="stylesheet" href="${path }/css/DT_bootstrap.css" />
<link rel="stylesheet" type="text/css" href="${path }/css/bootstrap-fileupload.css">

<link href="${path }/css/style.css" rel="stylesheet" type="text/css">
<!-- END PAGE LEVEL STYLES -->
<title>"${tprxm}"  票决情况</title>
    <style type="text/css">
        form {
            margin: 0 0 0px;
        }
    </style>
</head>
<body>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12 responsive">
				<%-- 表格开始 --%>
					<div class="portlet-title">
						<div class="caption">"${tprxm}"  票决情况
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            注：各颜色代表的含义  &nbsp;  &nbsp;<h style="color:#00BF35">同意</h>
                            <h style="color: #FF0000 ">不同意</h>
                            <h style="color: #C0C0C0 "> 弃权</h>
                        </div>
						<div class="clearfix fr">
                                <a class="btn" href="${path }/xx/app/console/tp/list?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&shpcId=${shpcId}"><i class="icon-undo"></i>返回</a>
                            </div>

                        </div>
                        <div class="clearfix">
                            <div class="control-group">
                                <div id="query" style="float: left;">
                                    <form action="${path }/xx/app/console/tpsj/?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}" method="POST" id="searchForm" name="searchForm">
                                        <input type="hidden" name="OWASP_CSRFTOKEN" value="${sessionScope.OWASP_CSRFTOKEN}"/>
                                        <input type="hidden" name="pageNum" value="${pager.pageNum }" id="pageNum">
                                        <input type="hidden" name="shtpId" value="${shtpId }" id="shtpId">
                                        <input type="hidden" name="pageSize" value="${pager.pageSize }" id="pageSize">
                                        票决意见：
                                        <select name="tpyj"  style="margin: 0px;width: 80px;" onchange="searchSubmit()">
                                            <option value="all" ${"all" eq tpyj?'selected':''}></option>
                                            <option value="1" ${"1" eq tpyj?'selected':''}>同意</option>
                                            <option value="2" ${"2" eq tpyj?'selected':''}>不同意</option>
                                            <option value="3" ${"3" eq tpyj?'selected':''}>弃权</option>
                                        </select>
                                        <%--<button type="button" class="btn Short_but" onclick="searchSubmit()">查询</button>--%>
                                        <%--<button type="button" class="btn Short_but" onclick="clearData()">清空</button>--%>
                                    </form>
                                </div>
                            </div>

                        </div>
                        <div class="portlet-body">
                            <table class="table table-striped table-bordered table-hover dataTable table-set">
                                <thead>
                                <tr>
                                    <th width="25">序号</th>
                                    <th width="70">学号</th>
                                    <th width="50">姓名</th>
                                    <th width="30">性别</th>
                                    <th width="50">政治面貌</th>
                                    <th width="80">入学年月</th>
                                    <th width="120">学院名称</th>
                                    <th width="80">专业名称</th>
                                    <th width="60">培养表</th>
                                    <th width="90">加分项</th>
                                    <th >毕业论文</th>
                                    <th width="50">导师姓名</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${pager.datas}" var="vo">
                                        <tr style="text-overflow:ellipsis;">
                                            <td <c:if test="${vo.tp eq 1}">style="color: #00BF35"</c:if>
                                                <c:if test="${vo.tp eq 2}">style="color: #FF0000"</c:if>
                                                <c:if test="${vo.tp eq 3}">style="color: #C0C0C0"</c:if>>
                                                <c:out value="${vo.sha01Vo.px}"></c:out>
                                            </td>
                                            <td <c:if test="${vo.tp eq 1}">style="color: #00BF35"</c:if>
                                                <c:if test="${vo.tp eq 2}">style="color: #FF0000"</c:if>
                                                <c:if test="${vo.tp eq 3}">style="color: #C0C0C0"</c:if>>
                                                <c:out value="${vo.sha01Vo.xhXx}"></c:out>
                                            </td>
                                            <td <c:if test="${vo.tp eq 1}">style="color: #00BF35"</c:if>
                                                <c:if test="${vo.tp eq 2}">style="color: #FF0000"</c:if>
                                                <c:if test="${vo.tp eq 3}">style="color: #C0C0C0"</c:if>><c:out value="${vo.sha01Vo.xm}"></c:out></td>
                                            <td <c:if test="${vo.tp eq 1}">style="color: #00BF35"</c:if>
                                                <c:if test="${vo.tp eq 2}">style="color: #FF0000"</c:if>
                                                <c:if test="${vo.tp eq 3}">style="color: #C0C0C0"</c:if>><c:out value="${vo.sha01Vo.xb}"></c:out></td>
                                            <td <c:if test="${vo.tp eq 1}">style="color: #00BF35"</c:if>
                                                <c:if test="${vo.tp eq 2}">style="color: #FF0000"</c:if>
                                                <c:if test="${vo.tp eq 3}">style="color: #C0C0C0"</c:if>><c:out value="${vo.sha01Vo.zzmmXx}"></c:out></td>
                                            <td <c:if test="${vo.tp eq 1}">style="color: #00BF35"</c:if>
                                                <c:if test="${vo.tp eq 2}">style="color: #FF0000"</c:if>
                                                <c:if test="${vo.tp eq 3}">style="color: #C0C0C0"</c:if>><c:out value="${vo.sha01Vo.rxsjXx}"></c:out></td>
                                            <td <c:if test="${vo.tp eq 1}">style="color: #00BF35"</c:if>
                                                <c:if test="${vo.tp eq 2}">style="color: #FF0000"</c:if>
                                                <c:if test="${vo.tp eq 3}">style="color: #C0C0C0"</c:if>><c:out value="${vo.sha01Vo.xymcXx}"></c:out></td>
                                            <td <c:if test="${vo.tp eq 1}">style="color: #00BF35"</c:if>
                                                <c:if test="${vo.tp eq 2}">style="color: #FF0000"</c:if>
                                                <c:if test="${vo.tp eq 3}">style="color: #C0C0C0"</c:if>><c:out value="${vo.sha01Vo.zymcXx}"></c:out></td>
                                            <td <c:if test="${vo.tp eq 1}">style="color: #00BF35"</c:if>
                                                <c:if test="${vo.tp eq 2}">style="color: #FF0000"</c:if>
                                                <c:if test="${vo.tp eq 3}">style="color: #C0C0C0"</c:if>><c:out value="${vo.sha01Vo.pybXx}"></c:out></td>
                                            <td <c:if test="${vo.tp eq 1}">style="color: #00BF35"</c:if>
                                                <c:if test="${vo.tp eq 2}">style="color: #FF0000"</c:if>
                                                <c:if test="${vo.tp eq 3}">style="color: #C0C0C0"</c:if>><c:out value="${vo.sha01Vo.jfxXx}"></c:out></td>

                                            <td <c:if test="${vo.tp eq 1}">style="color: #00BF35"</c:if>
                                                <c:if test="${vo.tp eq 2}">style="color: #FF0000"</c:if>
                                                <c:if test="${vo.tp eq 3}">style="color: #C0C0C0"</c:if>>
                                                <c:out value="${vo.sha01Vo.lunwenXx}"></c:out>
                                            </td>
                                            <td <c:if test="${vo.tp eq 1}">style="color: #00BF35"</c:if>
                                                <c:if test="${vo.tp eq 2}">style="color: #FF0000"</c:if>
                                                <c:if test="${vo.tp eq 3}">style="color: #C0C0C0"</c:if>><c:out value="${vo.sha01Vo.dsxmXx}"></c:out></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <jsp:include page="/WEB-INF/jsp/common/page.jsp">
                                <jsp:param value="${pager.total }" name="total"/>
                                <jsp:param value="${pager.pageCount }" name="endPage"/>
                                <jsp:param value="${pager.pageSize }" name="pageSize"/>
                                <jsp:param value="${pager.pageNum }" name="page"/>
                            </jsp:include>
                        </div>
                    </div>
                    <%-- 表格结束 --%>
			</div>
		</div>

		<%-- END PAGE CONTENT--%>
	</div>
	<script type="text/javascript" src="${path }/js/common/loading.js"></script>
	<script src="${path }/js/bootstrap-fileupload.js"></script>
	<script src="${path }/js/bootstrap-fileupload.js"></script>
	<!— 引入确认框模块 —>
	<%@ include file="/WEB-INF/jsp/inc/confirmModal.jsp" %>
	<script type="text/javascript">




		function pagehref (pageNum ,pageSize){
			<%--window.location.href ="${path}/xx/app/console/tpsj/?shtpId=${shtpId}&pageNum="+pageNum+"&pageSize="+pageSize;--%>
            $("#pageNum").val(pageNum);
            $("#pageSize").val(pageSize);
            $("#searchForm").submit();
		}

        function searchSubmit(){
            document.searchForm.submit();
        }
        function clearData(){
            $("#tpyj").val('');
            document.searchForm.submit();
        }
	</script>
</body>
</html>
