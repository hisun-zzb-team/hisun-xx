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
					<div class="caption">20180611 投票名单</div>
					<div class="clearfix fr">
						<span class="controllerClass btn green file_but" >
								<i class="icon-circle-arrow-up"></i>上传名单
								<input class="file_progress" type="file" name="attachFile" id="btn-browseTemplate">
						</span>


							<a class="btn" href="${path }/xx/app/console/bwh/?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&pageNum=${shpcPageNum}"><i class="icon-undo"></i>返回</a>
						</div>
					</div>
				</form>
				<%-- 表格结束 --%>
				<div class="clearfix">
					<div class="control-group">
						<div id="query" style="float: left;">
							<form action="${path }/xx/app/console/Sha01/list/?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&shpcPageNum=${shpcPageNum}" method="POST" id="searchForm" name="searchForm">
								<input type="hidden" id="shpcId" name="shpcId" value="${shpcId}"/>
								<input type="hidden" name="OWASP_CSRFTOKEN" value="${sessionScope.OWASP_CSRFTOKEN}"/>
								<input type="hidden" name="pageNum" value="${pager.pageNum }" id="pageNum">
								<input type="hidden" name="pageSize" value="${pager.pageSize }" id="pageSize">
								学号：<input type="text" class="m-wrap" name="xhQuery" id="xhQuery" value="${xhQuery}" style="width: 100px;" />
								姓名：<input type="text" class="m-wrap" name="xmQuery" id="xmQuery" value="${xmQuery}" style="width: 100px;" />
								<button type="button" class="btn Short_but" onclick="searchSubmit()">查询</button>
								<button type="button" class="btn Short_but" onclick="clearData()">清空</button>
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
									<td title="${vo.shyj}"><c:out value="${vo.px}"></c:out></td>
									<td title="${vo.xhXx}"><c:out value="${vo.xhXx}"></c:out></td>
									<td><a href="${path}/xx/app/console/Sha01/view?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&id=${vo.id }&shpcPageNum=${shpcPageNum}&a01PageNum=${pager.pageNum}"><c:out value="${vo.xm}"></c:out></a></td>
									<td><c:out value="${vo.xb}"></c:out></td>
									<td><c:out value="${vo.zzmmXx}"></c:out></td>
									<td><c:out value="${vo.rxsjXx}"></c:out></td>
									<td title="${vo.xymcXx}"><c:out value="${vo.xymcXx}"></c:out></td>
									<td title="${vo.zymcXx}"><c:out value="${vo.zymcXx}"></c:out></td>
									<td title="${vo.pybXx}"><c:out value="${vo.pybXx}"></c:out></td>
									<td title="${vo.jfxXx}"><c:out value="${vo.jfxXx}"></c:out></td>

									<td class="Left_alignment">
										<a href="javascript:gbrmspbDown('${vo.id }')" class=""><c:out value="${vo.lunwenXx}"></c:out></a>
									</td>
									<td title="${vo.dsxmXx}"><c:out value="${vo.dsxmXx}"></c:out></td>
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
		var uploadMatchingMode = "";//批量上传匹配方式 0按序号匹配 1按姓名匹配
		var split = "";
		var unloadOnlyFileOrBatch = "batch";//批量上传还是单个上传 only为单个文件上传 batch为批量上传
		var a01Id = "";//上传附件的a01Id
		function changeSplitDiv(obj){
			if(obj.checked==true){
				window.document.getElementById("splitDiv").style.visibility = "visible";
			}
		}
		function hiddenSplitDiv(obj){
			if(obj.checked==true){
				window.document.getElementById("splitDiv").style.visibility = "hidden";
			}
		}

		function matchResult(itemName,url){
			$("#importForm").ajaxSubmit({
				url : url,
				type : "post",
				headers:{
					OWASP_CSRFTOKEN:"${sessionScope.OWASP_CSRFTOKEN}"
				},
				dataType : "html",
				success : function(html){
					$('#matchResulttitle').text(itemName+'匹配结果');
					$('#matchResultDiv').html(html);
					$('#matchResultModal').modal({
						keyboard: true
					});
				},
				error : function(){
					showTip("提示","出错了请联系管理员", 1500);
				}
			});
		}
		(function(){
			App.init();

			$("#btn-browseTemplate").bind("change",function(evt){
				if($(this).val()){
					ajaxSubmit();
				}
				$(this).val('');
			});
			var myLoading = new MyLoading("${path}",{zindex:20000});
			function ajaxSubmit(){
				var fileInput = document.getElementById("btn-browseTemplate");
				if(fileInput.files.length>0){
					var name = fileInput.files[0].name
					var arr = name.split(".");
					if(arr.length<2 || !(arr[arr.length-1]=="doc" || arr[arr.length-1]=="docx"|| arr[arr.length-1]=="DOC"|| arr[arr.length-1]=="DOCX")){
						showTip("提示","请上传word文件",2000);
						return;
					}
				}else{
					showTip("提示","请选择文件上传",2000);
					return;
				}
				//hideErrorMsg();
				$("#importForm").ajaxSubmit({
					url : "${path }/xx/app/console/Sha01/ajax/execute?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&shpcId=${shpcId}",
					type : "post",
					headers:{
						OWASP_CSRFTOKEN:"${sessionScope.OWASP_CSRFTOKEN}"
					},
					beforeSend:function(XHR){
						myLoading.show();
					},
					success : function(json){
						if(json.code == 1){
							showTip("提示","操作成功",500);
							//loadCiList(ciObjectId);
							window.location.href="${path }/xx/app/console/Sha01/list?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&shpcId=${shpcId}&shpcPageNum=${shpcPageNum}&pageNum=${pager.pageNum}";
						}else if(json.code == -1){
							showTip("提示", json.message, 500);
						}else if(json.code == -2){
							showTip("提示", "导入数据存在错误，请及时下载已标记错误处的日志模板文件",500);
							//$('#downloanErrorTd').show();
							//$('#downloanError').attr('href','${path}/sacm/asset/export/downloanError?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&path='+encodeURIComponent(encodeURIComponent(json.path)));
							//$('#errorMsg').text('导入数据存在错误，请及时下载已标记错误处的日志模板文件');
						}else{
							showTip("提示","出错了,请检查网络!",500);
						}
					},
					error : function(arg1, arg2, arg3){
						showTip("提示","出错了,请检查网络!",500);
					},
					complete : function(XHR, TS){
						myLoading.hide();
					}
				});
			}

			//干部详细信息附件
			$("#btn-gbrmspb").bind("change", function (evt) {
				if ($(this).val()) {
					gbrmspbSubmit();
				}
				$(this).val('');
			});
			var myLoading = new MyLoading("${path}", {zindex: 20000});

			function gbrmspbSubmit() {
				var fileInput = document.getElementById("btn-gbrmspb");
				if (fileInput.files.length > 0) {
					var name = fileInput.files[0].name
					var arr = name.split(".");
					if(unloadOnlyFileOrBatch =="batch") {
						if (arr.length < 2 || !(arr[arr.length - 1] == "zip" || arr[arr.length - 1] == "ZIP")) {
							showTip("提示", "请上传zip文件", 2000);
							return;
						}
					}else{
						if (arr.length < 2 || !(arr[arr.length - 1] == "doc" || arr[arr.length - 1] == "docx" || arr[arr.length - 1] == "DOC" || arr[arr.length - 1] == "DOCX")) {
							showTip("提示", "请上传word文件", 2000);
							return;
						}
					}
				} else {
					showTip("提示", "请选择文件上传", 2000);
					return;
				}
				var url = "";
				if(unloadOnlyFileOrBatch =="batch") {
					matchResult("干部任免审批表","${path }/xx/app/Sha01/gbrmspb/ajax/batch/match?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&shpcId=${shpcId}&split="+split+"&uploadMatchingMode="+uploadMatchingMode);
					<%--url = "${path }/xx/app/Sha01/gbrmspb/ajax/batch/upload?shpcId=${shpcId}&split="+split+"&uploadMatchingMode="+uploadMatchingMode;--%>
				}else{
					url = "${path }/xx/app/Sha01/gbrmspb/ajax/uploadFile?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&sha01Id="+a01Id;
					$("#importForm").ajaxSubmit({
						url:url ,
						type: "post",
						headers: {
							OWASP_CSRFTOKEN: "${sessionScope.OWASP_CSRFTOKEN}"
						},
						beforeSend: function (XHR) {
							myLoading.show();
						},
						success: function (json) {
							if (json.code == 1) {
								showTip("提示","上传成功",2000);
								searchSubmit();
							} else if (json.code == -1) {
								showTip("提示", json.message, 2000);
							} else {
								showTip("提示", "出错了,请检查网络!", 2000);
							}
						},
						error: function (arg1, arg2, arg3) {
							showTip("提示", "出错了,请检查网络!", 2000);
						},
						complete: function (XHR, TS) {
							myLoading.hide();
						}
					});
				}
			}

			//考察材料附件
			$("#btn-kccl").bind("change", function (evt) {
				if ($(this).val()) {
					kcclSubmit();
				}
				$(this).val('');
			});
			var myLoading = new MyLoading("${path}", {zindex: 20000});

			function kcclSubmit() {
				var fileInput = document.getElementById("btn-kccl");
				if (fileInput.files.length > 0) {
					var name = fileInput.files[0].name
					var arr = name.split(".");
					if(unloadOnlyFileOrBatch =="batch") {
						if (arr.length < 2 || !(arr[arr.length - 1] == "zip" || arr[arr.length - 1] == "ZIP")) {
							showTip("提示", "请上传zip文件", 2000);
							return;
						}
					}else{
						if (arr.length < 2 || !(arr[arr.length - 1] == "doc" || arr[arr.length - 1] == "docx" || arr[arr.length - 1] == "DOC" || arr[arr.length - 1] == "DOCX")) {
							showTip("提示", "请上传word文件", 2000);
							return;
						}
					}
				} else {
					showTip("提示", "请选择文件上传", 2000);
					return;
				}
				var url = "";
				if(unloadOnlyFileOrBatch =="batch") {
					matchResult("考察材料","${path }/xx/app/Sha01/kccl/ajax/batch/match?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&shpcId=${shpcId}&split="+split+"&uploadMatchingMode="+uploadMatchingMode);
					<%--url = "${path }/xx/app/Sha01/kccl/ajax/batch/match?shpcId=${shpcId}&split="+split+"&uploadMatchingMode="+uploadMatchingMode;--%>
				}else{
					url = "${path }/xx/app/Sha01/kccl/ajax/uploadFile?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&sha01Id="+a01Id;

					$("#importForm").ajaxSubmit({
						url: url,
						type: "post",
						headers: {
							OWASP_CSRFTOKEN: "${sessionScope.OWASP_CSRFTOKEN}"
						},
						beforeSend: function (XHR) {
							myLoading.show();
						},
						success: function (json) {
							if (json.code == 1) {
								showTip("提示","上传成功",2000);
								searchSubmit();

							} else if (json.code == -1) {
								showTip("提示", json.message, 2000);
							} else {
								showTip("提示", "出错了,请检查网络!", 2000);
							}
						},
						error: function (arg1, arg2, arg3) {
							showTip("提示", "出错了,请检查网络!", 2000);
						},
						complete: function (XHR, TS) {
							myLoading.hide();
						}
					});
				}
			}

			//档案审查情况附件
			$("#btn-dascqk").bind("change", function (evt) {
				if ($(this).val()) {
					dascqkSubmit();
				}
				$(this).val('');
			});
			var myLoading = new MyLoading("${path}", {zindex: 20000});

			function dascqkSubmit() {
				var fileInput = document.getElementById("btn-dascqk");
				if (fileInput.files.length > 0) {
					var name = fileInput.files[0].name
					var arr = name.split(".");
					if(unloadOnlyFileOrBatch =="batch") {
						if (arr.length < 2 || !(arr[arr.length - 1] == "zip" || arr[arr.length - 1] == "ZIP")) {
							showTip("提示", "请上传zip文件", 2000);
							return;
						}
					}else{
						if (arr.length < 2 || !(arr[arr.length - 1] == "doc" || arr[arr.length - 1] == "docx" || arr[arr.length - 1] == "DOC" || arr[arr.length - 1] == "DOCX")) {
							showTip("提示", "请上传word文件", 2000);
							return;
						}
					}
				} else {
					showTip("提示", "请选择文件上传", 2000);
					return;
				}
				var url = "";
				if(unloadOnlyFileOrBatch =="batch") {
					matchResult("档案审查情况","${path }/xx/app/Sha01/dascqk/ajax/batch/match?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&shpcId=${shpcId}&split="+split+"&uploadMatchingMode="+uploadMatchingMode);
					<%--url = "${path }/xx/app/Sha01/dascqk/ajax/batch/upload?shpcId=${shpcId}&split="+split+"&uploadMatchingMode="+uploadMatchingMode;--%>
				}else{
					url = "${path }/xx/app/Sha01/dascqk/ajax/uploadFile?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&sha01Id="+a01Id;
					$("#importForm").ajaxSubmit({
						url:url,
						type: "post",
						headers: {
							OWASP_CSRFTOKEN: "${sessionScope.OWASP_CSRFTOKEN}"
						},
						beforeSend: function (XHR) {
							myLoading.show();
						},
						success: function (json) {
							if (json.code == 1) {
								showTip("提示","上传成功",2000);
								searchSubmit();

							} else if (json.code == -1) {
								showTip("提示", json.message, 2000);
							} else {
								showTip("提示", "出错了,请检查网络!", 2000);
							}
						},
						error: function (arg1, arg2, arg3) {
							showTip("提示", "出错了,请检查网络!", 2000);
						},
						complete: function (XHR, TS) {
							myLoading.hide();
						}
					});
				}
			}

			//个人重大事项附件
			$("#btn-grzdsx").bind("change", function (evt) {
				if ($(this).val()) {
					grzdsxSubmit();
				}
				$(this).val('');
			});
			var myLoading = new MyLoading("${path}", {zindex: 20000});

			function grzdsxSubmit() {
				var fileInput = document.getElementById("btn-grzdsx");
				if (fileInput.files.length > 0) {
					var name = fileInput.files[0].name
					var arr = name.split(".");
					if(unloadOnlyFileOrBatch =="batch") {
						if (arr.length < 2 || !(arr[arr.length - 1] == "zip" || arr[arr.length - 1] == "ZIP")) {
							showTip("提示", "请上传zip文件", 2000);
							return;
						}
					}else{
						if (arr.length < 2 || !(arr[arr.length - 1] == "doc" || arr[arr.length - 1] == "docx" || arr[arr.length - 1] == "DOC" || arr[arr.length - 1] == "DOCX")) {
							showTip("提示", "请上传word文件", 2000);
							return;
						}
					}
				} else {
					showTip("提示", "请选择文件上传", 2000);
					return;
				}
				var url = "";
				if(unloadOnlyFileOrBatch =="batch") {
					matchResult("个人重大事项","${path }/xx/app/Sha01/grzdsx/ajax/batch/match?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&shpcId=${shpcId}&split="+split+"&uploadMatchingMode="+uploadMatchingMode);
					<%--url = "${path }/xx/app/Sha01/grzdsx/ajax/batch/upload?shpcId=${shpcId}&split="+split+"&uploadMatchingMode="+uploadMatchingMode;--%>
				}else{
					url = "${path }/xx/app/Sha01/grzdsx/ajax/uploadFile?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&sha01Id="+a01Id;

					$("#importForm").ajaxSubmit({
						url: url,
						type: "post",
						headers: {
							OWASP_CSRFTOKEN: "${sessionScope.OWASP_CSRFTOKEN}"
						},
						beforeSend: function (XHR) {
							myLoading.show();
						},
						success: function (json) {
							if (json.code == 1) {
								showTip("提示","上传成功",2000);
								searchSubmit();

							} else if (json.code == -1) {
								showTip("提示", json.message, 2000);
							} else {
								showTip("提示", "出错了,请检查网络!", 2000);
							}
						},
						error: function (arg1, arg2, arg3) {
							showTip("提示", "出错了,请检查网络!", 2000);
						},
						complete: function (XHR, TS) {
							myLoading.hide();
						}
					});
				}
			}
		})();

		function pagehref (pageNum ,pageSize){
			<%--window.location.href ="${path}/xx/app/console/Sha01/list?shpcId=${shpcId}&pageNum="+pageNum+"&pageSize="+pageSize;--%>
			$("#pageNum").val(pageNum);
			$("#pageSize").val(pageSize);
			$("#searchForm").submit();
		}

		function searchSubmit(){
			document.searchForm.submit();
		}

		var del = function(id,itemName){
			actionByConfirm1(itemName, "${path}/xx/app/console/bwh/delete/" + id+"?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}",{} ,function(data,status){
				if (data.success == true) {
					showTip("提示","删除成功", 2000);
					setTimeout(function(){window.location.href = "${path}/xx/app/console/bwh/?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}"},2000);
				}else{
					showTip("提示", data.message, 2000);
				}
			});
		};
		var selectfileName = "";
		function selectTyle(fileName){
			$('#selectTypeModal').modal({
				keyboard: true
			});
			selectfileName = fileName;
//			document.getElementById("btn-"+fileName).click();
		}
		function uploadBatchFile(){
			$('#selectTypeModal').modal('hide');
			split =  $("#split").val()
			uploadMatchingMode = $("input[name='selectType']:checked").val();
			unloadOnlyFileOrBatch = "batch";
			document.getElementById("btn-"+selectfileName).click();
		}

		function unloadFile(fileName,uploadA01Id){
			a01Id = uploadA01Id;
			unloadOnlyFileOrBatch = "only";
			document.getElementById("btn-"+fileName).click();
		}
		function clearData(){
			$("#xmQuery").val('');
			$("#noFileQuert").val('');
			document.searchForm.submit();
		}
		function gbrmspbDown() {
			window.open("${path }/xx/app/Sha01/gbrmspb/ajax/down?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}");
		}
		function kcclDown(a01Id) {
			window.open("${path }/xx/app/Sha01/kccl/ajax/down?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&sha01Id="+a01Id);
		}
		function dascqkDown(a01Id) {
			window.open("${path }/xx/app/Sha01/dascqk/ajax/down?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&sha01Id="+a01Id);
		}
		function grzdsxDown(a01Id) {
			window.open("${path }/xx/app/Sha01/grzdsx/ajax/down?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&sha01Id="+a01Id);
		}
	</script>
</body>
</html>
