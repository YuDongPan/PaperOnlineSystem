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
    <link rel="stylesheet" href="<%=basePath%>/layui/css/layui.css">
    <script src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
    <script src="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.min.js"></script>
    <link rel="stylesheet" type ="text/css" href="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.css">
    <link rel="stylesheet" type ="text/css" href="<%=basePath%>/css/design.css">
</head>
<body>
<div>
    <div class="header"><strong>文献上传</strong></div>
    <div align="center" class="layui-upload">
        <div align="left" style="margin-left:8%">
            <button type="button" class="layui-btn layui-btn-normal" id="testList">选择多文件</button>
            <input id="username" type="hidden" value="${loginUsername}">
        </div>
        <div align="center" class="layui-upload-list" style="max-width: 1100px;text-align:center">
            <table class="layui-table">
                <colgroup>
                    <col width="300">
                    <col width="100">
                    <col width="130">
                    <col width="100">
                    <col width="70">
                    <col width="200">
                    <col width="100">
                    <col width="100">
                </colgroup>
                <thead>
                <tr><th width="300" style="text-align:center">文献名称</th>
                    <th width="100" style="text-align:center">大小</th>
                    <th width="130" style="text-align:center">上传进度</th>
                    <th width="100" style="text-align:center">期刊</th>
                    <th width="70"  style="text-align:center">年份</th>
                    <th width="200" style="text-align:center">标题</th>
                    <th width="100" style="text-align:center">标签</th>
                    <th width="100" style="text-align:center">操作</th>
                </tr></thead>
                <tbody id="demoList"></tbody>
            </table>
        </div>
        <button type="button" class="layui-btn" id="testListAction">开始上传</button>
    </div>
</div>
<script src="<%=basePath%>/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['upload', 'element', 'layer'], function() {
        var $ = layui.jquery
            , upload = layui.upload
            , element = layui.element
            , layer = layui.layer;
        //演示多文件列表
        var uploadListIns = upload.render({
            elem: '#testList'
            , elemList: $('#demoList') //列表元素对象
            , url: 'http://127.0.0.1:8080/file/upload' //此处用的是第三方的 http 请求演示，实际使用时改成您自己的上传接口即可。
            , accept: 'file'
            , multiple: true
            , number: 5
            , data:{
            }
            , auto: false
            , bindAction: '#testListAction'
            //选择文件前的回调
            , choose: function (obj) {
                var that = this;
                var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
                //读取本地文件
                obj.preview(function (index, file, result) {
                    var tr = $(['<tr id="upload-' + index + '">'
                        , '<td width="300">' + file.name + '</td>'
                        , '<td width="100">' + (file.size / 1014).toFixed(1) + 'KB</td>'
                        , '<td width="130"><div class="layui-progress" lay-filter="progress-demo-' + index + '"><div class="layui-progress-bar" lay-percent=""></div></div></td>'
                        , '<td width="100"><div class="edit_div" id="journal-' + index + '" contenteditable>IJCV</div></td>'
                        , '<td width="70"><div class="edit_div" id="year-' + index + '" contenteditable>2016</div></td>'
                        , '<td width="200"><div class="edit_div" id="title-' + index + '" contenteditable>A basic CNN method for classification</div></td>'
                        , '<td width="100"><div class="layui-input-inline"><select id="type-' + index + '">'
                        , '<option value="eeg">EEG</option>'
                        , '<option value="mip">MIP</option></select></div>'
                        , '</td>'
                        , '<td width="100">'
                        , '<button class="layui-btn layui-btn-xs demo-reload layui-hide">重传</button>'
                        , '<button class="layui-btn layui-btn-xs layui-btn-danger demo-delete">删除</button>'
                        , '</td>'
                        , '</tr>'].join(''));

                    //单个重传
                    tr.find('.demo-reload').on('click', function () {
                        obj.upload(index, file);
                    });

                    //删除
                    tr.find('.demo-delete').on('click', function () {
                        delete files[index]; //删除对应的文件
                        tr.remove();
                        uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
                    });

                    that.elemList.append(tr);
                    element.render('progress'); //渲染新加的进度条组件
                });
            },
            //上传前的回调
            before:function(obj){
                //数据传参
                console.log('-----');
            },
            //操作成功后的回调
            done: function (res, index, upload) {
                console.log('******');
                console.log(index);
                // 写入数据库
                $.ajax({
                    url:'<%=basePath%>/file/insertPaper.do',
                    type:"POST",
                    data:{
                        username:$('#username').val(),
                        filename:this.files[index].name,
                        journal:$('#journal-' + index).text(),
                        year:$('#year-' + index).text(),
                        title:$('#title-' + index).text(),
                        type:$('#type-' + index + ' option:selected').val()
                    },
                    dataType:"JSON",
                    success: function(data) {
                        if(data.msg_insert == "ok"){
                            console.log("success" + index);
                        }
                        else if(data.msg_insert == "error"){
                            console.log("success" + index)
                        }
                    }
                });
                var that = this;
                //if(res.code == 0){ //上传成功
                var tr = that.elemList.find('tr#upload-' + index)
                    , tds = tr.children();
                tds.eq(7).html(''); //清空操作
                delete this.files[index]; //删除文件队列已经上传成功的文件
                return;
                //}
                this.error(index, upload);
            }
            // 多文件上传完毕后的状态回调
            , allDone: function (obj) {
                console.log(obj)
            }
            // 上传错误回调
            , error: function (index, upload) {
                var that = this;
                var tr = that.elemList.find('tr#upload-' + index)
                    , tds = tr.children();
                tds.eq(7).find('.demo-reload').removeClass('layui-hide'); //显示重传
            }
            , progress: function (n, elem, e, index) { //注意：index 参数为 layui 2.6.6 新增
                element.progress('progress-demo-' + index, n + '%'); //执行进度条。n 即为返回的进度百分比
            }
        });
    });
</script>
</body>
</html>
