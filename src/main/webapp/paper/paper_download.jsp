<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>文献下载</title>
    <script type="text/javascript" src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
    <link rel="stylesheet" href="<%=basePath%>/layui/css/layui.css">
    <script src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
    <script src="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.min.js"></script>
    <link rel="stylesheet" type ="text/css" href="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.css">
    <link rel="stylesheet" type ="text/css" href="<%=basePath%>/css/design.css">
</head>
<body>
<div>
    <div class="header"><strong>文献下载</strong></div>
    <div align="center" class="layui-upload">
        <div align="left" style="margin-left: 35px">
            <button type="button" class="layui-btn layui-btn-normal" id="testList">选择多文件</button>
        </div>
        <div class="save_money" style="margin-top:50px;margin-left:25px;margin-right:25px;text-align:center">
            <div class="search bar6">
                <form action="">
                    <input id="searchInfo" type="text" placeholder="请输入查询信息" value="${scIndex.condition }" name="condition">
                    <button class="sc_button" id="do_search" type="submit" lay-submit lay-filter="data-search-btn"></button>
                    <input type="hidden" value="1" name="pageNow">
                </form>
            </div>
            <div align="center">
                <table id="paperList" lay-filter="test" ></table>
            </div>
        </div>
    </div>
<script src="<%=basePath%>/layui/layui.js"></script>
<script type="text/javascript">
        layui.use('table',function(){
        var form = layui.form;
        var table = layui.table;
        table.render({
        width:700,
        elem:'#userList',
        url:'<%=basePath%>/paper/selectPaperList.do',
        limits:[5,10,15,20,50,100],
        skin:"line",
        limit:5,
        toolbar:true,
        cols:[[
    {type:'checkbox'},
    {field:'id',width:80,title:'编号',sort:'true',align:'center'},
        //sort:true属性可使得按字段进行排序
    {field:'name',width:200,title:'文献名称',align:'center',
        style:'white-space:nowrap;word-break:keep-all;overflow:hidden;text-overflow',
        templet:function(d){
          var fileType = d.name.split('.')[1];

        }},
    {field:'journal',width:100,title:'期刊',align:'center'},
    {field:'year',width:100,title:'年份',align:'center'},
    {field:'type',width:100,title:'类型',align:'center'},
    {field:'title',width:150,title:'标题',align:'center'},
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
        table.reload('userList',{
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
