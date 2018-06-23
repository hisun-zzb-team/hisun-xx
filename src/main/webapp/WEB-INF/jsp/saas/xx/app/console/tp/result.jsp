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
<title>"${shpcmc}" 票决结果</title>
</head>
<body>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12 responsive">
				<%-- 表格开始 --%>
				<form class="portlet box grey"id="importForm" enctype="multipart/form-data">
					<input type="hidden" id="shpcId" name="shpcId" value="${shpcId}"/>
					<div class="portlet-title">
						<div class="caption">"${shpcmc}" 票决结果</div>
						<div class="clearfix fr">
							<a class="btn green" id="btn-export" onclick="exportCi()"><i class="icon-circle-arrow-down" ></i>导出</a>
							<a class="btn" href="${path }/xx/app/console/tp/?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}"><i class="icon-undo"></i>返回</a>
						</div>

                        </div>

                            <table class="table table-striped table-bordered table-hover dataTable">
                                <thead>
                                    <tr>
										<th width="10px" style="text-align: center;border-right-color: rgb(225, 230, 235);border-right-style: solid;border-right-width: 1px" rowspan=2>序号<br><br><br></th>
										<th width="50px" style="text-align: center;border-right-color: rgb(225, 230, 235);border-right-style: solid;border-right-width: 1px" rowspan=2>姓名<br><br><br></th>
										<th width="25px" style="text-align: center;border-right-color: rgb(225, 230, 235);border-right-style: solid;border-right-width: 1px" rowspan=2>性别<br><br><br></th>
										<th width="50px" style="text-align: center;border-right-color: rgb(225, 230, 235);border-right-style: solid;border-right-width: 1px" rowspan=2>入学年月<br><br><br></th>
										<th width="120px" style="text-align: center;border-right-color: rgb(225, 230, 235);border-right-style: solid;border-right-width: 1px" rowspan=2>学院名称<br><br><br></th>
										<th width="120px" style="text-align: center;border-right-color: rgb(225, 230, 235);border-right-style: solid;border-right-width: 1px" rowspan=2>专业名称<br><br><br></th>
										<th width="50px" style="text-align: center;border-right-color: rgb(225, 230, 235);border-right-style: solid;border-right-width: 1px" rowspan=2>导师姓名<br><br><br></th>
										<th rowspan=2 style="text-align: center;border-right-color: rgb(225, 230, 235);border-right-style: solid;border-right-width: 1px"> 论  文  题  目<br><br><br></th>
										<th colspan="3" style="text-align: center;border-right-color: rgb(225, 230, 235);border-right-style: solid;border-right-width: 1px">答辩委员会<br>表决结果</th>
										<th colspan="3" style="text-align: center;border-right-color: rgb(225, 230, 235);border-right-style: solid;border-right-width: 1px">学位评定分委员<br>会表决结果</th>
										<th width="10px" style="text-align: center;border-right-color: rgb(225, 230, 235);border-right-style: solid;border-right-width: 1px" rowspan=2>表决意见<br><br></th>
                                    </tr>
									<tr>
										<th width="20"style="text-align: center;border-right-color: rgb(225, 230, 235);border-right-style: solid;border-right-width: 1px">同意</th>
										<th width="20"style="text-align: center;border-right-color: rgb(225, 230, 235);border-right-style: solid;border-right-width: 1px">不同意</th>
										<th width="20"style="text-align: center;border-right-color: rgb(225, 230, 235);border-right-style: solid;border-right-width: 1px">平均分</th>
										<th width="20"style="text-align: center;border-right-color: rgb(225, 230, 235);border-right-style: solid;border-right-width: 1px">同意</th>
										<th width="20"style="text-align: center;border-right-color: rgb(225, 230, 235);border-right-style: solid;border-right-width: 1px">不同意</th>
										<th width="20"style="text-align: center;border-right-color: rgb(225, 230, 235);border-right-style: solid;border-right-width: 1px">弃权</th>
									</tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${pager}" var="vo">

                                        <tr style="text-overflow:ellipsis;">
											<td title="${vo.shyj}"><c:out value="${vo.px}"></c:out></td>
											<td><c:out value="${vo.xm}"></c:out></td>
											<td><c:out value="${vo.xb}"></c:out></td>
											<td><c:out value="${vo.rxsjXx}"></c:out></td>
											<td title="${vo.xymcXx}"><c:out value="${vo.xymcXx}"></c:out></td>
											<td title="${vo.zymcXx}"><c:out value="${vo.zymcXx}"></c:out></td>
											<td title="${vo.dsxmXx}"><c:out value="${vo.dsxmXx}"></c:out></td>
											<td class="Left_alignment">
												<a href="javascript:gbrmspbDown('${vo.id }')" class=""><c:out value="${vo.lunwenXx}"></c:out></a>
											</td>
											<td></td>
											<td></td>
											<td></td>
											<td><c:out value="${vo.tyCount}"></c:out></td>
											<td><c:out value="${vo.btyCount}"></c:out></td>
											<td><c:out value="${vo.qqCount}"></c:out></td>
											<td></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <%--<jsp:include page="/WEB-INF/jsp/common/page.jsp">--%>
                                <%--<jsp:param value="${pager.total }" name="total"/>--%>
                                <%--<jsp:param value="${pager.pageCount }" name="endPage"/>--%>
                                <%--<jsp:param value="${pager.pageSize }" name="pageSize"/>--%>
                                <%--<jsp:param value="${pager.pageNum }" name="page"/>--%>
                            <%--</jsp:include>--%>
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
		(function(){
			App.init();

			$("#btn-browseTemplate").bind("change",function(evt){
				if($(this).val()){
					ajaxSubmit();
				}
				$(this).val('');
			});
		})();

		function pagehref (pageNum ,pageSize){
			window.location.href ="${path}/xx/app/console/tp/result?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&shpcId=${shpcId}&pageNum="+pageNum+"&pageSize="+pageSize;
		}

		function searchSubmit(){
			document.searchForm.submit();
		}
		//导出方法
		function exportCi(){
			window.open('${path}/xx/app/console/tp/ajax/exportToExcel?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&shpcId=${shpcId}&OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}');
			<%--window.open('${path }/xx/app/console/tp/exportToExcel?shpcId=${shpcId}');--%>
		}

	</script>
</body>
</html>
