<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
  <button id="Btn" class="previewBtn" >预览</button>

</body>
<script type="text/javascript" src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
<script type="text/javascript">
    $(".previewBtn").click(function () {
        var curWwwPath=window.document.location.href;
        var pathName=window.document.location.pathname;
        var pos=curWwwPath.indexOf(pathName);
        var localhostPath=curWwwPath.substring(0,pos);
        window.open(localhostPath+"/pdfjs/web/viewer.html?file=http://localhost:8080/media/preview/1");
    });

</script>
</html>
