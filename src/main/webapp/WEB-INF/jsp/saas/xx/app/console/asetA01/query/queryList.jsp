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
<!-- END PAGE LEVEL STYLES -->
<title>干部查询条件列表</title>
</head>
<body>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12 responsive">
				<%-- 表格开始 --%>
				<div class="portlet box grey">
					<div class="portlet-title">
						<div class="caption">干部查询条件列表</div>
						<div class="clearfix fr">
							<a class="btn green" href="${path }/xx/app/console/asetA01Query/add?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}">
								<i class="icon-plus"></i>添加条件
							</a>
							<a class="btn" href="${path }/xx/app/console/asetA01Query/?queryId=${queryId}&OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}"><i class="icon-undo"></i>返回</a>
						</div>
					</div>
			
					<div class="portlet-body">
						<table class="table table-striped table-bordered table-hover dataTable table-set">
							<thead>
								<tr>
									<th>条件名称</th>
									<th width="80"style="text-align: center">排序</th>
									<th width="120">操作</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${pager.datas}" var="vo">
								<tr style="text-overflow:ellipsis;">
									<td title="${vo.queryName}"><a href="${path}/xx/app/console/asetA01Query/?queryId=${vo.id }&queryPosition=queryList&OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}"><c:out value="${vo.queryName}"></c:out></a></td>
									<td title="${vo.querySort}" style="text-align: center" ><c:out value="${vo.querySort}"></c:out></td>
									<td class="Left_alignment">
										<a href="${path}/xx/app/console/asetA01Query/?queryId=${vo.id }&queryPosition=queryList&OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}" class="">查询</a>|
										<a href="${path}/xx/app/console/asetA01Query/edit?id=${vo.id }&OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}" class="">编辑</a>|
										<a href="javascript:del('${vo.id }','${vo.queryName}')" class="">删除</a>
									</td>
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
	<script type="text/javascript">
		(function(){
			App.init();
		})();
	
		function pagehref (pageNum ,pageSize){
			window.location.href ="${path}/xx/app/console/asetA01Query/?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&pageNum="+pageNum+"&pageSize="+pageSize;
		}
		
		function searchSubmit(){
			document.searchForm.submit();
		}
		
		var del = function(id,itemName){
			actionByConfirm1(itemName, "${path}/xx/app/console/asetA01Query/delete/" + id+"?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}",{} ,function(data,status){
				if (data.success == true) {
					showTip("提示","删除成功", 2000);
					setTimeout(function(){window.location.href = "${path}/xx/app/console/asetA01Query/queryList?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}"},2000);
				}else{
					showTip("提示", data.message, 2000);	
				}
			});
		};

	</script>
</body>
</html>
