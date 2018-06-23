<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/inc/servlet.jsp" %>
<%@taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
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
<title>学位会批次</title>
</head>
<body>
	<div class="container-fluid">

		<div class="row-fluid">
			<div class="span12 responsive">
				<%-- 表格开始 --%>
				<div class="portlet box grey">
					<div class="portlet-title">
						<div class="caption">学位会批次</div>
					</div>
					<form action="" class="form-horizontal" id="form1" method="post">
					<div class="portlet-body">
						<table class="table table-striped table-bordered table-hover dataTable table-set">
							<thead>
								<tr>
									<th width="50">排序</th>
									<th width="10%">批次号</th>
									<th >批次名称</th>
								<%--<th width="10%">投票类型</th>--%>
									<th width="10%">投票名单</th>
								</tr>
							</thead>
						<tbody>
							<c:forEach items="${datas}" var="vo">
								<tr style="text-overflow:ellipsis;">
									<td><c:out value="${vo.px}"></c:out></td>
									<td><c:out value="${vo.pchXx}"></c:out></td>
									<td>
										<a href="${path}/xx/app/console/Sha01/un/wap/list?shpcId=${vo.id }&OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}"><c:out value="${vo.pcmc}"></c:out></a>
									</td>
									<%--<td><c:out value="${vo.shlxValue}"></c:out></td>--%>
									<td>
											<a href="${path}/xx/app/console/Sha01/un/wap/list?shpcId=${vo.id }&OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}" class="">共${vo.a01Count }人</a>
									</td>
								</tr>
							</c:forEach>
							<%--<tr style="text-overflow:ellipsis;">--%>
								<%--<td>20180611</td>--%>
								<%--<td>--%>
									<%--<a href="${path}/xx/app/console/Sha01/list?shpcId=&shpcPageNum=${pager.pageNum}&OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}">20180611学位会投票</a>--%>
								<%--</td>--%>
								<%--<td>学术型博士</td>--%>
								<%--<td>2018.06.20</td>--%>
								<%--<td>待投票</td>--%>
								<%--<td>--%>
									<%--<a href="${path}/xx/app/console/Sha01/list?shpcId=${vo.id }&shpcPageNum=${pager.pageNum}&OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}" class="">共10人</a>--%>
								<%--</td>--%>
								<%--<td>1</td>--%>
								<%--<td class="Left_alignment">--%>
									<%--<a href="${path}/xx/app/console/bwh/edit?id=${vo.id }&shpcPageNum=${pager.pageNum}&OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}" class="">开始投票</a>|--%>
									<%--<a href="${path}/xx/app/console/bwh/edit?id=${vo.id }&shpcPageNum=${pager.pageNum}&OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}" class="">编辑</a>|--%>
									<%--<a href="javascript:del('${vo.id }','${vo.pcmc}')" class="">删除</a>--%>
								<%--</td>--%>
							<%--</tr>--%>
							</tbody>
						</table>
					</div>
					</form>
				</div>
				<%-- 表格结束 --%>
			</div>
		</div>
		
		<%-- END PAGE CONTENT--%>  
	</div>
	<script type="text/javascript" src="${path }/js/common/30CloudAjax.js"></script>
<script type="text/javascript" src="${path }/js/common/loading.js"></script>
<%--<%@ include file="/WEB-INF/jsp/inc/confirmModal.jsp" %>--%>
	<script type="text/javascript">
		(function(){
			App.init();
		})();
		var myLoading = new MyLoading("${path}",{zindex:20000});
		var addAtts = function(shpcId){
			$.ajax({
				url : "${path}/xx/app/console/shpcAtts/ajax/editAtts",
				type : "post",
				data: {"shpcId":shpcId,"shpcPageNum":"${pager.pageNum }"},
				headers:{
					OWASP_CSRFTOKEN:"${sessionScope.OWASP_CSRFTOKEN}"
				},
				dataType : "html",
				success : function(html){
					$('#attsAddDiv').html(html);
					$('#attsModal').modal({
						keyboard: true
					});
				},
				error : function(){
					showTip("提示","出错了请联系管理员", 1500);
				}
			});
		}

		function pagehref (pageNum ,pageSize){
			window.location.href ="${path}/xx/app/console/bwh/?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&pageNum="+pageNum+"&pageSize="+pageSize;
		}
		
		function searchSubmit(){
			document.searchForm.submit();
		}
		function fileDown(id) {
			window.open("${path }/xx/app/console/bwh/ajax/down?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&id="+id);
		}
		var del = function(id,itemName){
			actionByConfirm1(itemName, "${path}/xx/app/console/bwh/delete/?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&id=" + id+"&shpcPageNum=${pager.pageNum }",{} ,function(data,status){
				if (data.success == true) {
					showTip("提示","删除成功", 2000);
					setTimeout(function(){window.location.href = "${path}/xx/app/console/bwh/?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&pageNum=${shpcPageNum}"},2000);
				}else{
					showTip("提示", data.message, 2000);	
				}
			});
		};
		function changeShZt(id){
			$.cloudAjax({
				path : '${path}',
				url : "${path }/xx/app/console/bwh/changeShZt/"+id,
				type : "post",
				data : $("#form1").serialize(),
				dataType : "json",
				headers:{
					"OWASP_CSRFTOKEN":'${sessionScope.OWASP_CSRFTOKEN}'
				},
				success : function(data){
					if(data.success){
						document.getElementById(id+"_shZt").innerHTML  = data.shZtValue;
						showTip("提示","上会状态成功修改为“"+data.shZtValue+"”",2000);
						//setTimeout(function(){window.location.href = "${path}/xx/app/console/bwh/"},2000);
					}else{
						showTip("提示", json.message, 2000);
					}
				},
				error : function(){
					showTip("提示","出错了请联系管理员",2000);
				}
			});
		}

	</script>
</body>
</html>
