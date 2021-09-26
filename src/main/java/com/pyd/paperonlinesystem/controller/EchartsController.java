package com.pyd.paperonlinesystem.controller;

import com.pyd.paperonlinesystem.service.EchartsService;
import net.sf.json.JSONObject;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * @ClassName: EchartsController
 * @Description: TODO
 * @author: Ethan_Hunt
 * @date: 2021/9/26  0:26
 */
@RestController
@RequestMapping("/visualization")
public class EchartsController {
    @Resource
    private EchartsService echartsService;
    private Map<String, Object> sortByKey(Map<String, Integer> map) {
        Map<String, Object> result = new LinkedHashMap<>(map.size());
        map.entrySet().stream()
                .sorted(Map.Entry.comparingByKey())
                .forEachOrdered(e -> result.put(e.getKey(), e.getValue()));
        return result;
    }
    //查询文献列表中的类型统计数据,并传送给数据可视化界面
    @RequestMapping("queryCntTypetoEcharts.do")
    public @ResponseBody Map<String, Object> queryCntSextoEcharts(HttpServletRequest request){
        int cntEEG = echartsService.queryEEGPaperCnt();
        int cntMIP = echartsService.queryMIPPaperCnt();
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("cntEEG", cntEEG);
        map.put("cntMIP", cntMIP);
        return map;
    }

    //查询文献列表中的年份分布数据,并传送给数据可视化界面
    @RequestMapping("queryYeartoEcharts.do")
    public @ResponseBody Map<String, Object> queryYeartoEcharts(HttpServletRequest request){
        int tenYearsAgoCnt = echartsService.queryPaper10yearsAgo();
        Map<String,Integer> inTenYears_map = echartsService.queryPaperIn10years();
        Map<String,Object> map = new LinkedHashMap<String, Object>();
        if(tenYearsAgoCnt > 0)
        map.put("10年前", tenYearsAgoCnt);
        Map<String, Object> sorted_map = sortByKey(inTenYears_map);
        for (String key : sorted_map.keySet()){
            map.put(key, sorted_map.get(key));
        }
        return map;
    }

    //查询文献列表中的期刊分布数据,并传送给数据可视化界面
    @RequestMapping("queryJournaltoEcharts.do")
    public @ResponseBody Map<String, Object> queryJournaltoEcharts(HttpServletRequest request){
        Map<String,Integer> journal_map = echartsService.queryJournalDistribution();
        Map<String, Object> sorted_map = sortByKey(journal_map);
        return sorted_map;
    }

    //根据日志列表查询系统运营情况数据,并传送给数据可视化界面 潘昱东添加
    @RequestMapping("queryOperationtoEcharts.do")
    public @ResponseBody Map<String, Object> queryOperationtoEcharts(HttpServletRequest request){
        int last_year = echartsService.queryOperationLastYear();
        int last_quarter = echartsService.queryOperationLastQuarter();
        int last_month = echartsService.queryOperationLastMonth();
        int last_sevendays = echartsService.queryOperationLastSevenDays();
        int yesterday = echartsService.queryOperationYesterday();
        int today = echartsService.queryOperationToday();
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("last_year",last_year);
        map.put("last_quarter",last_quarter);
        map.put("last_month",last_month);
        map.put("last_sevendays",last_sevendays);
        map.put("yesterday",yesterday);
        map.put("today", today);
        return map;
    }

}
