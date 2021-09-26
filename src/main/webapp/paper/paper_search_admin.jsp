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
    <title>BAI文献系统</title>
    <script type="text/javascript" src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
    <link rel="stylesheet" type ="text/css" href="<%=basePath%>/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/main_raw.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/amazeui.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/admin.css"/>
    <script src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
    <script src="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.min.js"></script>
    <link rel="stylesheet" type ="text/css" href="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type ="text/css" href="<%=basePath%>/css/design.css">
    <link rel="stylesheet" type ="text/css" href="<%=basePath%>/css/search.css">
    <style>
        .layui-table-cell .layui-form-checkbox[lay-skin="primary"]{
            top: 50%;
            transform: translateY(-50%);
        }
        .my_option{
            display:flex;
            flex-direction:row;
            padding-left: 45px;
        }
    </style>
</head>
<body>
<div>
    <div class="header"><strong>文献查询</strong></div>
    <div align="center" class="layui-upload">
        <div class="save_money" style="margin-top:20px;margin-left:25px;margin-right:25px;text-align:center">
            <div class="search bar6">
                <form action="">
                    <input id="searchInfo" type="text" placeholder="请输入查询信息" name="condition">
                    <button class="sc_button" id="do_search" type="submit" lay-submit lay-filter="data-search-btn"></button>
                    <input type="hidden" value="1" name="pageNow">
                </form>
            </div>
            <div align="center">
                <table id="paperList" lay-filter="test" ></table>
            </div>
        </div>
    </div>
</div>
<script src="<%=basePath%>/layui/layui.js"></script>
<script type="text/javascript">
    layui.use('table',function(){
        var form = layui.form;
        var table = layui.table;
        table.render({
            width:1200,
            elem:'#paperList',
            url:'<%=basePath%>/paper/selectPaperList.do',
            limits:[5,10,15,20,50,100],
            skin:"line",
            limit:7,
            toolbar:true,
            cols:[[
                {type:'checkbox'},
                {field:'id',width:80,title:'编号',sort:'true',align:'center'},
                //sort:true属性可使得按字段进行排序
                {field:'name',width:300,title:'文献名称',align:'center',
                    style:'white-space:nowrap;word-break:keep-all;overflow:hidden;text-overflow',
                    templet:function(d){
                        var str = d.name.split('.');
                        var fileType = str[1];
                        var icon = (fileType === 'pdf') ? "<i class='fa fa-file-pdf-o' style='color:orange;margin-right:5px'" +
                            " aria-hidden='true'></i>" : "<i class='fa fa-file-word-o' style='color:blue;margin-right:5px'" +
                            " aria-hidden='true'></i>";
                        return icon + str[0];
                    }},
                {field:'journal',width:100,title:'期刊',align:'center'},
                {field:'year',width:100,title:'年份',align:'center'},
                {field:'type',width:100,title:'类型',align:'center'},
                {field:'title',width:300,title:'标题',align:'center', style:'white-space:nowrap;word-break:keep-all;overflow:hidden;text-overflow'},
                {width:170,title:'操作',align:'center', style:'padding-top:20px', templet:function(d){
                        var str = d.name.split('.');
                        var fileType = str[1];
                        if(fileType == 'pdf')
                        var prev = "<div class='my_option'><a target='_blank' style='display:block;' title='预览' href='" + "<%=basePath%>pdfjs/web/viewer.html?file=<%=basePath%>media/preview/" +
                            d.id + "'>" + "<i class='fa fa-arrows-alt' aria-hidden='true'></i></a>";
                        var del = "<a style='display:block;margin-left:10px;width:40%' title='删除' href='<%=basePath%>/paper/deletePaper/" +
                            d.id + "/" + d.type + "'>" + "<i class='fa fa-trash' aria-hidden='true'></i></a></div>"
                        return prev + del;
                        //if(fileType == 'pdf')
                        //return "<button class='previewBtn' id='preBtn" + d.id + "'title='预览'><i class='fa fa-arrows-alt' aria-hidden='true'></i></button>";
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

        /*$(document).on("click", ".previewBtn", function () {
            alert(this.id);
            var str = this.id;
            var curWwwPath=window.document.location.href;
            var pathName=window.document.location.pathname;
            var pos=curWwwPath.indexOf(pathName);
            var localhostPath=curWwwPath.substring(0,pos);
            window.open(localhostPath+"/pdfjs/web/viewer.html?file=http://localhost:8080/media/preview/" + str[str.length-1]);
        });*/

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
