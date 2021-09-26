<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="<%=basePath%>/css/chartSearch.css" type="text/css">
    <script src="<%=basePath%>/js/echarts.js"></script>
    <script src="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.min.js"></script>
    <link rel="stylesheet" type ="text/CSS" href="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.css">
    <title>系统数据报表</title>
</head>
<body>
<div align="center" class="bgimg">
    <h1>相关数据统计</h1>
    <div class="top">
        <p class="txt">请选择查询条目:</p>
        <select class="sel" onchange="Energy(this)">
            <option value="1">文献类型统计</option>
            <option value="2">文献年份分布</option>
            <option value="3">文献期刊分布</option>
            <option value="4">系统运营统计</option>
        </select>
    </div>


    <!-- 为echarts准备好一个具体宽高的dom -->
    <div class="chart" id="myChart1" style="width:600px;height:400px;">
    </div>
    <div class="chart" id="myChart2" style="width:600px;height:400px;">
    </div>
    <div class="chart" id="myChart3" style="width:600px;height:400px;">
    </div>
    <div class="chart" id="myChart4" style="width:600px;height:400px;">
    </div>
</div>

<script src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
<script src="<%=basePath%>/js/bootstrap.min.js"></script>
<script type="text/javascript">
    function Energy(obj){
        //代表的是选中项的索引值
        var index = obj.selectedIndex;
        //代表的是选中项的值
        var val = obj.options[index].value;
        if(val == "1"){
            $.ajax({
                type:"POST",
                url:"<%=basePath%>/visualization/queryCntTypetoEcharts.do",
                dataType:'json',
                success:function(json){
                    $("#mainChart").html("");
                    Myecharts1(json);
                    console.log(json);
                },
                error:function(){
                    swal('数据模块1加载失败','','error');
                }
            });
        }
        else if(val == "2"){
            $.ajax({
                type:"POST",
                url:"<%=basePath%>/visualization/queryYeartoEcharts.do",
                dataType:'json',
                success:function(json){
                    Myecharts2(json);
                    console.log(json);
                },
                error:function(){
                    swal('数据模块2加载失败','','error');
                }
            });
        }
        else if(val == "3"){
            $.ajax({
                type:"POST",
                url:"<%=basePath%>/visualization/queryJournaltoEcharts.do",
                dataType:'json',
                success:function(json){
                    Myecharts3(json);
                    console.log(json);
                },
                error:function(){
                    swal('数据模块3加载失败','','error');
                }
            });
        }

        else if(val == "4"){
            $.ajax({
                type:"POST",
                url:"<%=basePath%>/visualization/queryOperationtoEcharts.do",
                dataType:'json',
                success:function(json){
                    Myecharts4(json);
                    console.log(json);
                },
                error:function(){
                    swal('数据模块4加载失败','','error');
                }
            });
        }

    }

    $(function(){
        $.ajax({
            type:"POST",
            url:"<%=basePath%>/visualization/queryCntTypetoEcharts.do",
            dataType:'json',
            success:function(json){
                Myecharts1(json);
                console.log(json);
            },
            error:function(){
                swal('数据模块1加载失败','','error');
            }
        });
    });

    function Myecharts1(json){
        //基于准备好的dom,初始echarts实例
        let data = json;
        /*  console.log(typeof(data)); */
        $("#myChart1").show();
        $("#myChart2").hide();
        $("#myChart3").hide();
        $("#myChart4").hide();
        let myChart = echarts.init(document.getElementById("myChart1"));
        let option = {
            title: {
                text: '文献类型比例分布',
                left: 'center',
                textStyle:{
                    color:"#E6E6FA"
                }
            },
            tooltip: {
                trigger: 'item',
                formatter: '{b}: {c} <br/> {d}%'
            },
            legend: {
                orient: 'vertical',
                left: 'left',
                textStyle:{
                    color:"#F5F5DC"
                }
            },
            series: [
                {
                    name: '访问来源',
                    type: 'pie',
                    radius: '50%',
                    data: [
                        {value: data.cntEEG, name: 'EEG'},
                        {value: data.cntMIP, name: 'MIP'},
                    ],
                    emphasis: {
                        itemStyle: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    },

                }
            ]
        };
        //使用刚才指定的配置项和数据显示图表
        myChart.setOption(option);
    }

    function Myecharts2(json){
        //基于准备好的dom,初始echarts实例
        let myData = json;
        /*  console.log(typeof(data)); */
        $("#myChart1").hide();
        $("#myChart2").show();
        $("#myChart3").hide();
        $("#myChart4").hide();
        let myChart = echarts.init(document.getElementById("myChart2"));
        let statisticsData = [];
        let statisticsKeys = [];
        for(let key in myData) {
            let statisticsObj = {name:'',value:''};   //ECharts里边需要的的数据格式是这样的
            statisticsObj.name = key;
            statisticsObj.value = myData[key];
            statisticsKeys.push(key);          //获取所有key作为X轴数据
            statisticsData.push(statisticsObj);   //获取所有key-value对
            console.log(statisticsObj);
        }
        // 显示标题，图例和空的坐标轴
        let option = ({
            title: {
                text: '文献年份统计',
                left: 'center',
                textStyle: {
                    color: "#F5F5DC"
                }
            },
            tooltip: {},
            legend: {
                data: ['文献数量']
            },
            xAxis: {
                name: '年份',
                data: statisticsKeys,
                nameTextStyle:{
                    color:'#E6E6FA',
                    fontSize:14,
                },
                axisLabel: {//修改坐标系字体颜色
                    show: true,
                    textStyle: {
                        color: "#E6E6FA"
                    }
                },
            },
            yAxis: {
                name:'文献数量',
                nameTextStyle:{
                    color:'#E6E6FA',
                    fontSize:14,
                },
                type: 'value',
                axisLabel: {//修改坐标系字体颜色
                    show: true,
                    textStyle: {
                        color: "#E6E6FA"
                    }
                }
            },
            series: [
                {
                    name: '文献数量',
                    type: 'bar',
                    data: statisticsData
                }
            ]
        });
        //使用刚才指定的配置项和数据显示图表
        myChart.setOption(option);

    }

    function Myecharts3(json){
        //基于准备好的dom,初始echarts实例
        let myData = json;
        /*  console.log(typeof(data)); */
        $("#myChart1").hide();
        $("#myChart2").hide();
        $("#myChart3").show();
        $("#myChart4").hide();
        let myChart = echarts.init(document.getElementById("myChart3"));
        let statisticsData = [];
        let statisticsKeys = [];
        for(let key in myData) {
            let statisticsObj = {name:'',value:''};   //ECharts里边需要的的数据格式是这样的
            statisticsObj.name = key;
            statisticsObj.value = myData[key];
            statisticsKeys.push(key);   // 获取所有key作为X轴数据
            statisticsData.push(statisticsObj);   // 获取所有key-value数据
            console.log(statisticsObj);
        }
        console.log(statisticsKeys);
        // 显示标题，图例和空的坐标轴
        let option = {
            title:{
                text: '期刊分布统计',
                left: 'center',
                textStyle:{
                    color:"#F5F5DC"
                }
            },
            tooltip: {},
            legend: {
                data: ['文献数量']
            },
            xAxis: {
                name:'期刊',
                data: statisticsKeys,
                nameTextStyle:{
                    color:'#E6E6FA',
                    fontSize:14,
                },
                axisLabel: {//修改坐标系字体颜色
                    show: true,
                    textStyle: {
                        color: "#E6E6FA"
                    }
                },
            },
            yAxis: {
                name:'文献数量',
                nameTextStyle:{
                    color:'#E6E6FA',
                    fontSize:14,
                },
                type: 'value',
                axisLabel: {//修改坐标系字体颜色
                    show: true,
                    textStyle: {
                        color: "#E6E6FA"
                    }
                }
                },
            series: [
                {
                    name: '文献数量',
                    type: 'bar',
                    data: statisticsData,
                    showBackground: true,
                    backgroundStyle: {
                        color: 'rgba(180, 180, 180, 0.2)'
                    }
                }
            ]
        };
        //使用刚才指定的配置项和数据显示图表
        myChart.setOption(option);

    }

    function Myecharts4(json){
        //基于准备好的dom,初始echarts实例
        let myData = json;
        /*  console.log(typeof(data)); */
        $("#myChart1").hide();
        $("#myChart2").hide();
        $("#myChart3").hide();
        $("#myChart4").show();
        var myChart = echarts.init(document.getElementById("myChart4"));
        option = {
            title:{
                text: '系统运营情况统计',
                left: 'center',
                textStyle:{
                    color:"#F5F5DC"
                }
            },
            xAxis: {
                name:'时间',
                nameTextStyle:{
                    color:'#E6E6FA',
                    fontSize:14,
                },
                type: 'category',
                data: ['上一年', '上一季度', '上一个月','过去七天','昨天', '今天'],
                axisLabel:{//修改坐标系字体颜色
                    show:true,
                    textStyle:{
                        color:"#E6E6FA"
                    }

                }
            },
            yAxis: {
                name:'系统周转次数',
                nameTextStyle:{
                    color:'#E6E6FA',
                    fontSize:14,
                },
                type: 'value',
                axisLabel:{//修改坐标系字体颜色
                    show:true,
                    textStyle:{
                        color:"#E6E6FA"}

                }
            },
            series: [{
                data: [myData.last_year,myData.last_quarter,myData.last_month,myData.last_sevendays,myData.yesterday,myData.today],
                type: 'line'
            }]
        };
        //使用刚才指定的配置项和数据显示图表
        myChart.setOption(option);
    }
</script>
</body>
</html>