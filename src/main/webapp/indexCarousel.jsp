<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html lang=en>
<meta charset=UTF-8>
<meta http-equiv=X-UA-Compatible content="IE=edge">
<link rel="shortcut icon" href="/favicon.ico">
<link rel=bookmark href="/favicon.ico" type=image/x-icon>
<title>BAI文献系统</title>
<link rel=stylesheet href="<%=basePath%>/css/style.css">
<div class=wrap id=wrap>
    <div class=wrapper>
        <div class=header>
            <div class="head clearfix">
                <div class=logo_box>
                    <h1 class=hidden>BAI Literature System</h1>
                  <!--  <a href='javascript:;' class=logo_link><img src="/picture/BAI_logo.png" alt=xxx></a>-->
                </div>
                <div class=nav_box id=nav_box>
                    <ul>
                        <li>
                            <a href='javascript:;' target=_blank clickid=guanwang_navigation_homepage></a>
                        <li>
                            <a href='javascript:;' target=_blank clickid=guanwang_navigation_productcenter></a>
                        <li>
                            <a href='javascript:;' target=_blank clickid=guanwang_navigation_customer></a>
                        <li>
                            <a href='javascript:;' target=_blank clickid=guanwang_navigation_yangtai></a>
                    </ul><span class=ic_line></span></div>
            </div>
        </div>
        <div class=page_wp id=page_wp>
            <div class="page page_1"><span class="page_bg scale_box"></span>
                <div class=img_box><img src="" alt=""></div>
                <div class="txt_box scale_box">
                    <h2>BAI文献系统将呈现更多精彩</h2>
                    <p class=txt_brief>从现在开始，你就会感觉到它与以往是如此不同。全新的界面体验，高速的引擎支持，丰富的内容推荐，这一切，都让你的生活更加精彩。</div>
            </div>
            <div class="page page_2"><span class="page_bg scale_box"></span>
                <div class=img_box><img src="" alt=""></div>
                <div class="txt_box scale_box">
                    <h2>高速引擎可以带你穿越时空</h2>
                    <p class=txt_brief>我们对速度的渴望从未停止，一起来体验速度超频的感觉。它的技术服务会更加稳定，占用更少的资源提供更高的速度支持，这一切只源于我们对技术的无尽追求。</div>
            </div>
            <div class="page page_3"><span class="page_bg scale_box"></span>
                <div class=img_box><img src="" alt=""></div>
                <div class="txt_box scale_box">
                    <h2>与你一起发现更多精彩资源</h2>
                    <p class=txt_brief>它以生动的方式呈现更多内容，让你在体验极速的同时，拥有更多选择。云计算，医学图像，脑机接口，人工智能，我们准备好了一切，就等你来探索</div>
            </div>
            <div class="page page_4"><span class="page_bg scale_box"></span>
                <div class=img_box><img src="" alt=""></div>
                <div class="light_wp scale_box"><span class=light_box><i class=light_1></i> <i class=light_2></i> <i class=light_3></i> <i class=light_4></i> <i class=light_5></i></span></div><span class="meteor_box scale_box"></span>
                <div class="txt_box scale_box">
                    <h2>还有另一个自己在这里等你</h2>
                    <p class=txt_brief>当你使用BAI文献系统的同时，也许另一个人也和你一样。像一个在海边拾贝壳的孩子,望见了一望无际的知识海洋,丢弃了手中的贝壳,畅游在科研与思索的世界中。</div>
            </div>
        </div>
        <div class="star_wp scale_box" id=star_wp><span class=star_bg></span> <span class=star_box></span></div><canvas id=canvas></canvas>
        <div class="btns_wp scale_box">
            <!--<a class="btn_download JS-btn-download" href='javascript:;'>关于作者</a>-->
        </div>
        <div class=btn_control id=btn_control>
            <a href=javascript:; class=cur></a>
            <a href=javascript:;></a>
            <a href=javascript:;></a>
            <a href=javascript:;></a>
        </div>
        <div class=footer>
            <div class=foot>
        </div>
    </div>
</div>
<script src="<%=basePath%>/js/vendors.js"></script>
<script src="<%=basePath%>/js/index.js"></script>
<!--[if IE 6]>
<script type="text/javascript" src="js/dd_png_min.js"></script>
<script type="text/javascript">
	var links=document.getElementsByTagName("a");
	for(var i=0,l=links.length;i<l;i++){
		links[i].setAttribute("hideFocus",true);
	}
</script>
<![endif]-->
