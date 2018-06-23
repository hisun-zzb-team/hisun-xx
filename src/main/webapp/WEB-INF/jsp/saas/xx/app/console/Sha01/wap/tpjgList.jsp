<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="Select" uri="http://www.springframework.org/tags/form" %>
<%@include file="/WEB-INF/jsp/inc/servlet.jsp" %>
<%@include file="/WEB-INF/jsp/inc/import.jsp" %>
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
<link rel="stylesheet" type="text/css" href="${path }/css/bootstrap-fileupload.css">

<link href="${path }/css/style.css" rel="stylesheet" type="text/css">
<!-- END PAGE LEVEL STYLES -->
<title>20180611 投票名单</title>
	<style type="text/css">
		form {
			margin: 0 0 0px;
		}
		.radio input[type="radio"], .checkbox input[type="checkbox"]{
			margin-left:0px;
		}
		.table td a{
			margin:0px;
		}
		.table td.Left_alignment em{
			color:#333;
		}
	</style>
</head>
<body>
<div id="selectTypeModal" class="modal container hide fade" tabindex="-1" data-width="400">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button data-dismiss="modal" class="close"  type="button"></button>
				<h3 class="modal-title" id="title" >
					选择批量上传匹配方式
				</h3>
			</div>
			<div class="modal-body" id="dabzAddDiv">
				<div  style="padding: 15px 0;">
					<span style="margin-top: 5px; margin-right: 10px; display: inline-block;"><input type="radio" value="1" checked  name="selectType" id="selectTypeByName"  onchange="hiddenSplitDiv(this)">按姓名匹配</span>
					<span  style="margin-top: 5px; margin-right: 10px; display: inline-block;"><input type="radio" value="0" name="selectType" id="selectTypeByNum" onchange="changeSplitDiv(this)">按序号匹配</span>
					<span id="splitDiv" style="margin-top: 5px;visibility: hidden">
						匹配符号<span style="color: red">*</span>
						<input type="text" class="m-wrap" style="width: 40px" name="split" required maxlength="1" id="split" value="."/>
					</span>
				</div>

				<div class="control-group mybutton-group" style="text-align: right;">
					<button type="button" class="btn green" onclick="uploadBatchFile()"><i class="icon-ok"></i> 确定</button>
					<button type="button" class="btn btn-default"  data-dismiss="modal"><i class="icon-remove-sign"></i> 取消</button>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="matchResultModal" class="modal container hide fade" tabindex="-1" data-width="700">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button data-dismiss="modal" class="close"  type="button"></button>
				<h3 class="modal-title" id="matchResulttitle" >
					数据包匹配结果
				</h3>
			</div>
			<div class="modal-body" id="matchResultDiv">
			</div>
		</div>
	</div>
</div>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span12 responsive">
				<%-- 表格开始 --%>
				<form class=""id="importForm" enctype="multipart/form-data">
					<div class="portlet-title">
						<div class="caption">20180611 投票结果</div>
						<div class="clearfix fr">
							<a class="btn" style="color: #00BF35;"href="javascript:tp('1')">
								<i class="icon-ok"></i>同意
							</a>
							<a class="btn" style="color: #FF0000;" href="javascript:tp('2')">
								<i class="icon-remove"></i>不同意
							</a>
							<a class="btn" style="color: #C0C0C0;" href="javascript:tp('3')">
								<i class="icon-info-sign"></i>弃权
							</a>
							<a class="btn" href="javascript:returnList()"><i class="icon-undo"></i>返回</a>
						</div>
						<div class="clearfix">
							<div class="control-group">
								<div id="query" style="float: left;width: 330px;margin-left: 100px;">
									<div class="span3" style="margin-left: 5px;" onclick="search('1')">
										<div class="Round_01" style="width: 65px;height: 65px;line-height: 65px;font-size: 13px;background-color: #00BF35;">同意(${tyNum})

										</div>
										<%--<h4 class="Statist_h4" >${tyNum}</h4>--%>
									</div>
									<div class="span3" style="margin-left: 5px;" onclick="search('2')">
										<div class="Round_02" style="width: 65px;height: 65px;line-height: 65px;font-size: 12px;background-color: #FF0000;">不同意(${btyNum})

										</div>
										<%--<h4 class="Statist_h4">${btyNum}</h4>--%>
									</div>
									<div class="span3" style="margin-left: 5px;" onclick="search('3')">
										<div class="Round_03" style="width: 65px;height: 65px;line-height: 65px;font-size: 13px;background-color: #C0C0C0;">弃权(${qqNum})

										</div>
										<%--<h4 class="Statist_h4">${qqNum}</h4>--%>
									</div>
									<div class="span3" style="margin-left: 5px;" onclick="search('4')">
										<div class="Round_04" style="width: 65px;height: 65px;line-height: 65px;font-size: 13px;background-color: #444444;">漏投(${ltNum})
										</div>
										<%--<h4 class="Statist_h4">${ltNum}</h4>--%>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
				<%-- 表格结束 --%>

				<%--<div class="clearfix">--%>
					<%--<div class="control-group">--%>
						<%--<div id="query" style="float: left;">--%>
							<%--<form action="${path }/xx/app/console/Sha01/list/?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&shpcPageNum=${shpcPageNum}" method="POST" id="searchForm" name="searchForm">--%>
								<%--<input type="hidden" id="shpcId" name="shpcId" value="${shpcId}"/>--%>
								<%--<input type="hidden" name="OWASP_CSRFTOKEN" value="${sessionScope.OWASP_CSRFTOKEN}"/>--%>
								<%--<input type="hidden" name="pageNum" value="${pager.pageNum }" id="pageNum">--%>
								<%--<input type="hidden" name="pageSize" value="${pager.pageSize }" id="pageSize">--%>
								<%--学号：<input type="text" class="m-wrap" name="xmQuery" id="xmQuery" value="${xmQuery}" style="width: 100px;" />--%>
								<%--姓名：<input type="text" class="m-wrap" name="xmQuery" id="xmQuery" value="${xmQuery}" style="width: 100px;" />--%>
								<%--<button type="button" class="btn Short_but" onclick="searchSubmit()">查询</button>--%>
								<%--<button type="button" class="btn Short_but" onclick="clearData()">清空</button>--%>
							<%--</form>--%>
						<%--</div>--%>
					<%--</div>--%>

				<%--</div>--%>
					<div class="portlet-body">
						<table class="table table-striped table-bordered table-hover dataTable table-set">
							<thead>
								<tr>
									<th width="3%">序号</th>
									<th width="6%">学号</th>
									<th width="5%">姓名</th>
									<th width="3%">性别</th>
									<th width="5%">政治面貌</th>
									<th width="6%">入学年月</th>
									<th width="10%">学院名称</th>
									<th width="6%">专业名称</th>
									<th width="5%">培养表</th>
									<th width="7%">加分项</th>
									<th width="7%">毕业论文</th>
									<th width="5%">导师姓名</th>
									<th width="5%">选择投票</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${datas}" var="vo">
								<tr style="text-overflow:ellipsis; background-color: <c:if test="${vo.shtpsjVo.tp==1}">#03a14a</c:if><c:if test="${vo.shtpsjVo.tp==2}">#ce00f1</c:if><c:if test="${vo.shtpsjVo.tp==3}">#adabb0</c:if> ;">
									<td title="${vo.shyj}"
										<c:if test="${vo.shtpsjVo.tp eq 1}">style="color: #00BF35"</c:if>
										<c:if test="${vo.shtpsjVo.tp eq 2}">style="color: #FF0000"</c:if>
										<c:if test="${vo.shtpsjVo.tp eq 3}">style="color: #C0C0C0"</c:if>>
										<c:out value="${vo.px}"></c:out></td>
									<td title="${vo.xhXx}"
										<c:if test="${vo.shtpsjVo.tp eq 1}">style="color: #00BF35"</c:if>
										<c:if test="${vo.shtpsjVo.tp eq 2}">style="color: #FF0000"</c:if>
										<c:if test="${vo.shtpsjVo.tp eq 3}">style="color: #C0C0C0"</c:if>>
										<c:out value="${vo.xhXx}"></c:out></td>
									<td
											<c:if test="${vo.shtpsjVo.tp eq 1}">style="color: #00BF35"</c:if>
											<c:if test="${vo.shtpsjVo.tp eq 2}">style="color: #FF0000"</c:if>
											<c:if test="${vo.shtpsjVo.tp eq 3}">style="color: #C0C0C0"</c:if>>
										<c:out value="${vo.xm}"></c:out></td>
									<td
											<c:if test="${vo.shtpsjVo.tp eq 1}">style="color: #00BF35"</c:if>
											<c:if test="${vo.shtpsjVo.tp eq 2}">style="color: #FF0000"</c:if>
											<c:if test="${vo.shtpsjVo.tp eq 3}">style="color: #C0C0C0"</c:if>>
										<c:out value="${vo.xb}"></c:out></td>
									<td
											<c:if test="${vo.shtpsjVo.tp eq 1}">style="color: #00BF35"</c:if>
											<c:if test="${vo.shtpsjVo.tp eq 2}">style="color: #FF0000"</c:if>
											<c:if test="${vo.shtpsjVo.tp eq 3}">style="color: #C0C0C0"</c:if>>
										<c:out value="${vo.zzmmXx}"></c:out></td>
									<td
											<c:if test="${vo.shtpsjVo.tp eq 1}">style="color: #00BF35"</c:if>
											<c:if test="${vo.shtpsjVo.tp eq 2}">style="color: #FF0000"</c:if>
											<c:if test="${vo.shtpsjVo.tp eq 3}">style="color: #C0C0C0"</c:if>>
										<c:out value="${vo.rxsjXx}"></c:out></td>
									<td title="${vo.xymcXx}"
										<c:if test="${vo.shtpsjVo.tp eq 1}">style="color: #00BF35"</c:if>
										<c:if test="${vo.shtpsjVo.tp eq 2}">style="color: #FF0000"</c:if>
										<c:if test="${vo.shtpsjVo.tp eq 3}">style="color: #C0C0C0"</c:if>>
										<c:out value="${vo.xymcXx}"></c:out></td>
									<td title="${vo.zymcXx}"
										<c:if test="${vo.shtpsjVo.tp eq 1}">style="color: #00BF35"</c:if>
										<c:if test="${vo.shtpsjVo.tp eq 2}">style="color: #FF0000"</c:if>
										<c:if test="${vo.shtpsjVo.tp eq 3}">style="color: #C0C0C0"</c:if>>
										<c:out value="${vo.zymcXx}"></c:out></td>
									<td title="${vo.pybXx}"
										<c:if test="${vo.shtpsjVo.tp eq 1}">style="color: #00BF35"</c:if>
										<c:if test="${vo.shtpsjVo.tp eq 2}">style="color: #FF0000"</c:if>
										<c:if test="${vo.shtpsjVo.tp eq 3}">style="color: #C0C0C0"</c:if>>
										<c:out value="${vo.pybXx}"></c:out></td>
									<td title="${vo.jfxXx}"
										<c:if test="${vo.shtpsjVo.tp eq 1}">style="color: #00BF35"</c:if>
										<c:if test="${vo.shtpsjVo.tp eq 2}">style="color: #FF0000"</c:if>
										<c:if test="${vo.shtpsjVo.tp eq 3}">style="color: #C0C0C0"</c:if>>
										<c:out value="${vo.jfxXx}"></c:out></td>

									<td title="${vo.lunwenXx}"
										<c:if test="${vo.shtpsjVo.tp eq 1}">style="color: #00BF35"</c:if>
										<c:if test="${vo.shtpsjVo.tp eq 2}">style="color: #FF0000"</c:if>
										<c:if test="${vo.shtpsjVo.tp eq 3}">style="color: #C0C0C0"</c:if>>
									<c:out value="${vo.lunwenXx}"></c:out>
									</td>
									<td title="${vo.dsxmXx}"
										<c:if test="${vo.shtpsjVo.tp eq 1}">style="color: #00BF35"</c:if>
										<c:if test="${vo.shtpsjVo.tp eq 2}">style="color: #FF0000"</c:if>
										<c:if test="${vo.shtpsjVo.tp eq 3}">style="color: #C0C0C0"</c:if>>
										<c:out value="${vo.dsxmXx}"></c:out></td>
									<td><input type="checkbox" onchange="checkChange(this)" value="${vo.id }"/></td>
								</tr>
							</c:forEach>

							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

		<%-- END PAGE CONTENT--%>
	</div>
	<script type="text/javascript" src="${path }/js/common/loading.js"></script>
	<script src="${path }/js/bootstrap-fileupload.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-1.10.1.min.js" type="text/javascript"></script>
	<%--<script src="${path }/js/bootstrap-fileupload.js"></script>--%>
	<!— 引入确认框模块 —>
	<%@ include file="/WEB-INF/jsp/inc/confirmModal.jsp" %>
	<script type="text/javascript">
        var ids = [];
        function indexOf(arr, str){
            if(arr && arr.indexOf){
                return arr.indexOf(str);
            }
            var len = arr.length;
            for(var i = 0; i < len; i++){
                // 定位该元素位置
                if(arr[i] == str){
                    return i;
                }
            }
            // 数组中不存在该元素
            return -1;
        }

        function checkChange(obj){
            var check=obj.checked;
            var id = obj.value;
            var index = indexOf(ids,id);
            var idsLength = ids.length;
            if(check&&index==-1){
                ids[idsLength] = id;
            }else if(!check&&index>-1){
                ids.splice(index,1);
            }

        }
        function tp(tp){
            var idStr = "";
            for(var i= 0;i<ids.length;i++){
                idStr=idStr+ids[i];
                if(i<ids.length-1){
                    idStr=idStr+",";
                }
            }
            $.ajax({
                url : "${path }/xx/app/console/Sha01/un/wap/tp",
                type : "post",
                data : {
                    "tp":tp,
                    "shpcId":"${shpcId}",
                    "idStr":idStr
				},
                dataType : "json",
                headers:{
                    OWASP_CSRFTOKEN:"${sessionScope.OWASP_CSRFTOKEN}"
                },
                success : function(json){
                    window.location.href ="${path }/xx/app/console/Sha01/un/wap/jgList?shpcId=${shpcId}&tp=${tp}&OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}";
                },
                error : function(arg1, arg2, arg3){
                    // showTip("提示","职务管理加载失败");
                }
            });
        }
        function search(tp){
            window.location.href ="${path }/xx/app/console/Sha01/un/wap/jgList?shpcId=${shpcId}&tp="+tp+"&OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}";
        }

        function returnList(){
            window.location.href ="${path }/xx/app/console/Sha01/un/wap/list?shpcId=${shpcId}&OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}";
        }


	</script>
</body>
</html>
