<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>BAI文献系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/main_raw.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/bootstrap-responsive.min.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/amazeui.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/admin.css" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=basePath%>/css/search.css" />
    <script src="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.min.js"></script>
    <link rel="stylesheet" type ="text/css" href="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.css">
</head>
<body>
<!-- 右 -->
<div class="content">
    <div class="header">
        <h1 align="center" class="page-title"><strong class="am-text-primary am-text-lg">系统日志</strong></h1>
    </div>
    <div class="save_money" style="margin-top:20px;margin-left:25px;margin-right:25px;text-align:center">
        <div class="search bar6">
            <form action="">
                <input id="searchInfo" type="text" placeholder="请输入查询信息" name="condition">
                <button class="sc_button" id="do_search" type="submit" lay-submit lay-filter="data-search-btn"></button>
            </form>
        </div>
    </div>
    <div align="center">
        <table id="logList" lay-filter="test" ></table>
    </div>
</div>
<script src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/layui/layui.js"></script>
<script type="text/javascript">
    layui.use('table',function(){
        var form = layui.form;
        var table = layui.table;
        table.render({
            width:1100,
            elem:'#logList',
            url:'../log/selectLogList.do',
            limits:[5,10,15,20,50,100],
            skin:"line",
            limit:10,
            toolbar:true,
            cols:[[
                {type:'checkbox'},
                {field:'id',width:80,title:'编号',sort:'true',align:'center'},
                //sort:true属性可使得按字段进行排序
                {field:'username',width:150,title:'用户名',sort:'true',align:'center'},
                //sort:true属性可使得按字段进行排序
                {field:'paper_name',width:300,title:'文献名称',align:'center',
                    style:'white-space:nowrap;word-break:keep-all;overflow:hidden;text-overflow',
                    templet:function(d){
                        var str = d.paper_name.split('.');
                        var fileType = str[1];
                        var icon = (fileType === 'pdf') ? "<i class='fa fa-file-pdf-o' style='color:orange;margin-right:5px'" +
                            " aria-hidden='true'></i>" : "<i class='fa fa-file-word-o' style='color:blue;margin-right:5px'" +
                            " aria-hidden='true'></i>";
                        return icon + str[0];
                    }},
                {field:'paper_type',width:100,tistle:'类型',align:'center'},
                {field:'msg',width:170,title:'处理操作',align:'center'},
                {field:"deal_time", width:250,title:'处理时间',align:'center', templet:function(d){
                        return layui.util.toDateString(d.deal_time, "yyyy-MM-dd HH:mm:ss");
                    }},
            ]],
            page:true,
            done: function(res,curr,count){
                //数据的回调,可选写
                //获取回调数据
                console.log(res);
                //获取当前页数
                console.log(curr);
                //获取数据个数
                console.log(count);
            }
        });

        //监听按钮操作
        form.on('submit(data-search-btn)',function(){
            var sss = $("#searchInfo").val();
            console.log(sss);
            //数据表格重载
            table.reload('paperList',{
                page:{
                    //从第一页开始
                    curr:1,
                },
                where:{
                    //获取查询参数
                    condition:$("#searchInfo").val()
                }
            });
            return false;
        });
    });
</script>
</body>
</html>
