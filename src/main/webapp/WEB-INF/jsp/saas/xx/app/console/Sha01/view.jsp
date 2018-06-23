<%@ page import="com.hisun.util.DateUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/servlet.jsp" %>
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
    <title>“张飞”个人信息</title>

    <link rel="stylesheet" type="text/css" href="${path }/css/style-metro.css">
    <link rel="stylesheet" type="text/css" href="${path }/css/bootstrap-fileupload.css">
    <link rel="stylesheet"type="text/css" href="${path }/css/DT_bootstrap.css" />
    <link href="${path }/css/style.css" rel="stylesheet" type="text/css">
    <style type="text/css">
        .showdabzcss{width:450px;;overflow:hidden;text-overflow:ellipsis; display: inline-block; white-space: nowrap; color: #333; font-size: 13px;
            vertical-align: middle; cursor: pointer; background-color: #f8f8f8; height: 34px; line-height: 34px; padding-left: 10px;  }
        .showdabzcss:hover{  color:#009ae1;}
    </style>
</head>
<body>
<div id="dabzModal" class="modal container hide fade" tabindex="-1" data-width="600">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button data-dismiss="modal" class="close"  type="button"></button>
                <h3 class="modal-title" id="title" >
                    添加备注
                </h3>
            </div>
            <div class="modal-body" id="dabzAddDiv">
            </div>
        </div>
    </div>
</div>
<div class="xwbmain">

    <div class="mainone">

        <div class="mainoneleft">
            <img class="imgtp" width="180" height="200" src="${path}/xx/app/console/Sha01/${shpa01Vo.id}/photo?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}" />
        </div>
        <div class="clearfix fr">
            <a class="btn red" href="javascript:{}"><i class=" icon-remove-sign"></i>删除</a>
            <a class="btn" href="${path }/xx/app/console/Sha01/list?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&shpcId=${shpcId}&shpcPageNum=${shpcPageNum}&pageNum=${a01PageNum}"><i class="icon-undo"></i>返回</a>
        </div>
        <div class="mainoneright">
            <div class="gerenintrodu"><span>姓名：</span>张飞</div>
            <div class="gerenintrodu"><span>学号：</span>201803100</div>
            <div class="gerenintrodu"><span>性别：</span>男</div>
            <div class="gerenintrodu"><span>政治面貌：</span>党员</div>
        </div>
    </div>
    <div class="maintwo">
        <h1 class="tith1">院校及专业</h1>
        <p>学院名称：动物医学院</p>
        <p>专业名称：	兽医专业</p>
        <p>培养表：</p>
        <p>加分项：学术奖励</p>
    </div>
    <div class="mainthree">
        <h1 class="tith1" style="margin-bottom:30px;">论文</h1>

        <form class="form-horizontal" id="importForm" enctype="multipart/form-data">
            <div class="control-group">
                <label class="control-label">干部任免审批表</label>

                <div class="controls">
                    <div class="fileupload fileupload-new" data-provides="fileupload">
                       <span class="btn btn-file">
                        <span class="fileupload-new">点击上传</span>
                        <input type="file" class="default" name="gbrmspbFile" id="btn-gbrmspb"/>
                        </span>
                        <div class="btn-group" id="gbrmspbDownDiv"
                             <c:if test="${!isHavagbrmspbFile }">style="visibility:hidden"</c:if>>
                            <a class="btn blue" herf="javascript:void(0)" onclick="gbrmspbDown()"><i
                                    class="icon-circle-arrow-down"></i>下载文件</a>
                        </div>
                        <%--<a herf="javascript:void(0)" onclick="gbrmspbDelete()" class="close fileupload-exists" data-dismiss="fileupload" style="float: none"></a>--%>
                    </div>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">考察材料</label>

                <div class="controls">
                    <div class="fileupload fileupload-new" data-provides="fileupload">
                       <span class="btn btn-file">
                        <span class="fileupload-new">点击上传</span>
                        <input type="file" class="default" name="kcclFile" id="btn-kccl"/>
                        </span>
                        <div class="btn-group" id="kcclDownDiv"
                             <c:if test="${!isHavakcclFile }">style="visibility:hidden"</c:if>>
                            <a class="btn blue" herf="javascript:void(0)" onclick="kcclDown()"><i
                                    class="icon-circle-arrow-down"></i>下载文件</a>
                        </div>
                        <%--<a herf="javascript:void(0)" onclick="kcclDelete()" class="close fileupload-exists" data-dismiss="fileupload" style="float: none"></a>--%>




                    </div>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">档案审查情况</label>

                <div class="controls">
                    <div class="fileupload fileupload-new" data-provides="fileupload">
                       <span class="btn btn-file">
                        <span class="fileupload-new">点击上传</span>
                        <input type="file" class="default" name="dascqkFile" id="btn-dascqk"/></span>
                        <div class="btn-group" id="dascqkDownDiv"
                            <c:if test="${!isHavaDascqkFile }">style="visibility:hidden"</c:if>>
                            <a class="btn blue" herf="javascript:void(0)" onclick="dascqkDown()"><i
                                    class="icon-circle-arrow-down"></i>下载文件</a>
                            <div class="btn-group" id="dabzAddbtnDiv" <c:if test="${fn:length(dascqkTipe)>0}">style="display:none"</c:if>>
                                <a class="btn"  id="btn-dabzAdd" herf="javascript:void(0)">添加备注</a>
                            </div>
                        </div>
                        <a herf="javascript:void(0)" onclick="dabzUpdate()" <c:if test="${fn:length(dascqkTipe)==0}">style="display:none"</c:if> class="showdabzcss" id='dabzshowspan' title="${dascqkTipe}">${dascqkTipe}</a>
                        <a herf="javascript:void(0)" title="删除备注" id="dabzDelete" onclick="dabzDelete()"  class="close fileupload-exists" style="float: none; <c:if test="${fn:length(dascqkTipe)>0}">display:inline-block</c:if>"></a>

                    </div>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">个人重大事项</label>

                <div class="controls">
                    <div class="fileupload fileupload-new" data-provides="fileupload">
                        <span class="btn btn-file">
                        <span class="fileupload-new">点击上传</span>
                        <input type="file" class="default" name="grzdsxFile" id="btn-grzdsx"/>
                        </span>
                        <div class="btn-group" id="grzdsxDownDiv"
                             <c:if test="${!isHavaGrzdsxFile }">style="visibility:hidden"</c:if>>
                            <a class="btn blue" herf="javascript:void(0)" onclick="grzdsxDown()"><i
                                    class="icon-circle-arrow-down"></i>下载文件</a>
                        </div>
                        <%--<a herf="javascript:void(0)" onclick="grzdsxDelete()" class="close fileupload-exists" data-dismiss="fileupload" style="float: none"></a>--%>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<script type="text/javascript" src="${path }/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="${path }/js/common/est-validate-init.js"></script>
<script type="text/javascript" src="${path }/js/common/validate-message.js"></script>
<script type="text/javascript" src="${path }/js/common/30CloudAjax.js"></script>
<script type="text/javascript" src="${path }/js/common/DataValidate.js"></script>
<script type="text/javascript" src="<%=path%>/js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="<%=path%>/js/bootstrap-datepicker.zh-CN.js"></script>
<script type="text/javascript" src="${path }/js/common/loading.js"></script>
<script src="${path }/js/bootstrap-fileupload.js"></script>
<script type="text/javascript">

    var dasc={};
    dasc.sha01Id='${shpa01Vo.id}';
    dasc.serverBaseForm;
    dasc.init=function(){
        //dasc.list();
        $('#btn-dabzAdd').click(function(){
            dasc.addDabz();
        });
    }

    dasc.addDabz=function(){
        $.ajax({
            url : "${path}/xx/app/Sha01/dascqk/dascqktips/ajax/add",
            type : "get",
            headers:{
                OWASP_CSRFTOKEN:"${sessionScope.OWASP_CSRFTOKEN}"
            },
            dataType : "html",
            success : function(html){
                $('#dabzAddDiv').html(html);
                $('#title').text('添加档案审查备注');
                $('#sha01Id').val(dasc.sha01Id);

                $('#dabzModal').modal({
                    keyboard: true
                });
            },
            error : function(){
                showTip("提示","出错了请联系管理员", 1500);
            }
        });
    }

    function dabzUpdate(){
        $.ajax({
            url : "${path}/xx/app/Sha01/dascqk/dascqktips/ajax/edit",
            type : "get",
            data : {"sha01Id":'${shpa01Vo.id}'},
            headers:{
                OWASP_CSRFTOKEN:"${sessionScope.OWASP_CSRFTOKEN}"
            },
            dataType : "html",
            success : function(html){
                $('#dabzAddDiv').html(html);
                $('#title').text('修改档案审查备注');
                $('#sha01Id').val('${shpa01Vo.id}');
                $('#dabzModal').modal({
                    keyboard: true
                });
            },
            error : function(){
                showTip("提示","出错了请联系管理员", 1500);
            }
        });
    }
    function dabzDelete(){
        actionByConfirm1("档案审查备注", "${path}/xx/app/Sha01/dascqk/dascqktips/delete/${shpa01Vo.id}?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}",{} ,function(data){
            if (data.success == true) {
                showTip("提示","删除成功", 1000);
                <%--window.location.href="${path }/xx/app/console/Sha01/view?id=${shpa01Vo.id}";--%>
                document.getElementById('dabzAddbtnDiv').style.display="inline-block";
                document.getElementById('dabzshowspan').innerHTML="";
                document.getElementById('dabzshowspan').style.display="none";
                document.getElementById('dabzDelete').style.display="none";
            }else{
                showTip("提示", data.message, 1000);
            }
        });

    }


    jQuery(document).ready(function () {
        App.init();
        dasc.init();
        //干部详细信息附件
        $("#btn-gbrmspb").bind("change", function (evt) {
            if ($(this).val()) {
                gbrmspbSubmit();
            }
            $(this).val('');
        });
               //考察材料附件
        $("#btn-kccl").bind("change", function (evt) {
            if ($(this).val()) {
                kcclSubmit();
            }
            $(this).val('');
        });


        //档案审查情况附件
        $("#btn-dascqk").bind("change", function (evt) {
            if ($(this).val()) {
                dascqkSubmit();
            }
            $(this).val('');
        });



        //个人重大事项附件
        $("#btn-grzdsx").bind("change", function (evt) {
            if ($(this).val()) {
                grzdsxSubmit();
            }
            $(this).val('');
        });

    });
    var myLoading = new MyLoading("${path}", {zindex: 20000});

    function grzdsxSubmit() {
        var fileInput = document.getElementById("btn-grzdsx");
        if (fileInput.files.length > 0) {
            var name = fileInput.files[0].name
            var arr = name.split(".");
            if (arr.length < 2 || !(arr[arr.length - 1] == "doc" || arr[arr.length - 1] == "docx" || arr[arr.length - 1] == "DOC" || arr[arr.length - 1] == "DOCX")) {
                showTip("提示", "请上传word文件", 2000);
                return;
            }
        } else {
            showTip("提示", "请选择文件上传", 2000);
            return;
        }
        $("#importForm").ajaxSubmit({
            url: "${path }/xx/app/Sha01/grzdsx/ajax/uploadFile?sha01Id=${shpa01Vo.id}",
            type: "post",
            headers: {
                OWASP_CSRFTOKEN: "${sessionScope.OWASP_CSRFTOKEN}"
            },
            beforeSend: function (XHR) {
                myLoading.show();
            },
            success: function (json) {
                if (json.code == 1) {
                    //showTip("提示","操作成功",2000);
                    window.document.getElementById("grzdsxDownDiv").style.visibility = "visible";
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

    function kcclSubmit() {
        var fileInput = document.getElementById("btn-kccl");
        if (fileInput.files.length > 0) {
            var name = fileInput.files[0].name
            var arr = name.split(".");
            if (arr.length < 2 || !(arr[arr.length - 1] == "doc" || arr[arr.length - 1] == "docx" || arr[arr.length - 1] == "DOC" || arr[arr.length - 1] == "DOCX")) {
                showTip("提示", "请上传word文件", 2000);
                return;
            }
        } else {
            showTip("提示", "请选择文件上传", 2000);
            return;
        }
        $("#importForm").ajaxSubmit({
            url: "${path }/xx/app/Sha01/kccl/ajax/uploadFile?sha01Id=${shpa01Vo.id}",
            type: "post",
            headers: {
                OWASP_CSRFTOKEN: "${sessionScope.OWASP_CSRFTOKEN}"
            },
            beforeSend: function (XHR) {
                myLoading.show();
            },
            success: function (json) {
                if (json.code == 1) {
                    //showTip("提示","操作成功",2000);
                    window.document.getElementById("kcclDownDiv").style.visibility = "visible";
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

    function dascqkSubmit() {
        var fileInput = document.getElementById("btn-dascqk");
        if (fileInput.files.length > 0) {
            var name = fileInput.files[0].name
            var arr = name.split(".");
            if (arr.length < 2 || !(arr[arr.length - 1] == "doc" || arr[arr.length - 1] == "docx" || arr[arr.length - 1] == "DOC" || arr[arr.length - 1] == "DOCX")) {
                showTip("提示", "请上传word文件", 2000);
                return;
            }
        } else {
            showTip("提示", "请选择文件上传", 2000);
            return;
        }
        $("#importForm").ajaxSubmit({
            url: "${path }/xx/app/Sha01/dascqk/ajax/uploadFile?sha01Id=${shpa01Vo.id}",
            type: "post",
            headers: {
                OWASP_CSRFTOKEN: "${sessionScope.OWASP_CSRFTOKEN}"
            },
            beforeSend: function (XHR) {
                myLoading.show();
            },
            success: function (json) {
                if (json.code == 1) {
                    //showTip("提示","操作成功",2000);
                    window.document.getElementById("dascqkDownDiv").style.visibility = "visible";
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

    function gbrmspbSubmit() {
        var fileInput = document.getElementById("btn-gbrmspb");
        if (fileInput.files.length > 0) {
            var name = fileInput.files[0].name
            var arr = name.split(".");
            if (arr.length < 2 || !(arr[arr.length - 1] == "doc" || arr[arr.length - 1] == "docx" || arr[arr.length - 1] == "DOC" || arr[arr.length - 1] == "DOCX")) {
                showTip("提示", "请上传word文件", 2000);
                return;
            }
        } else {
            showTip("提示", "请选择文件上传", 2000);
            return;
        }
        $("#importForm").ajaxSubmit({
            url: "${path }/xx/app/Sha01/gbrmspb/ajax/uploadFile?sha01Id=${shpa01Vo.id}",
            type: "post",
            headers: {
                OWASP_CSRFTOKEN: "${sessionScope.OWASP_CSRFTOKEN}"
            },
            beforeSend: function (XHR) {
                myLoading.show();
            },
            success: function (json) {
                if (json.code == 1) {
                    //showTip("提示","操作成功",2000);

                    window.document.getElementById("gbrmspbDownDiv").style.visibility = "visible";
                    window.location.href="${path }/xx/app/console/Sha01/view?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&id=${shpa01Vo.id}&shpcPageNum=${shpcPageNum}&a01PageNum=${a01PageNum}";
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

    function gbrmspbDown() {
        window.open("${path }/xx/app/Sha01/gbrmspb/ajax/down?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&sha01Id=${shpa01Vo.id}");
    }
    function kcclDown() {
        window.open("${path }/xx/app/Sha01/kccl/ajax/down?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&sha01Id=${shpa01Vo.id}");
    }
    function dascqkDown() {
        window.open("${path }/xx/app/Sha01/dascqk/ajax/down?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&sha01Id=${shpa01Vo.id}");
    }
    function grzdsxDown() {
        window.open("${path }/xx/app/Sha01/grzdsx/ajax/down?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&sha01Id=${shpa01Vo.id}");
    }

     function del(itemName){
        actionByConfirm1(itemName, "${path}/xx/app/console/Sha01/delete/${shpa01Vo.id}?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}",{} ,function(data,status){
            if (data.success == true) {
                showTip("提示","删除成功", 1000);
                setTimeout(function(){window.location.href = "${path}/xx/app/console/Sha01/list?OWASP_CSRFTOKEN=${sessionScope.OWASP_CSRFTOKEN}&shpcId=${shpcId}&shpcPageNum=${shpcPageNum}&pageNum=${a01PageNum}"},1000);
            }else{
                showTip("提示", data.message, 2000);
            }
        });
    }
</script>
</body>
</html>
