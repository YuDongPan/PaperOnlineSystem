package com.pyd.paperonlinesystem.service;

import com.pyd.paperonlinesystem.entity.Paper;
import com.pyd.paperonlinesystem.mapper.EchartsMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName: EchartsService
 * @Description: TODO
 * @author: Ethan_Hunt
 * @date: 2021/9/25  23:26
 */
@Service
public class EchartsService{
    @Resource
    EchartsMapper echartsMapper;
    public int queryEEGPaperCnt(){
        return echartsMapper.queryEEGPaperCnt();
    }
    public int queryMIPPaperCnt(){
        return echartsMapper.queryMIPPaperCnt();
    }
    public int queryPaper10yearsAgo(){
        return echartsMapper.queryPaper10yearsAgo();
    }
    public Map<String, Integer> queryPaperIn10years(){
        Map<String, Integer> map = new HashMap<>();
        List<Paper> papers = echartsMapper.queryPaperIn10years();
        for(Paper paper:papers){
            Integer cnt = 1;
            String year = Integer.toString(paper.getYear()) + "年";
            if(map.get(year) != null){
                cnt = map.get(year) + 1;
            }
            map.put(year, cnt);
        }
        return map;
    }
    public Map<String, Integer> queryJournalDistribution(){
        Map<String, Integer> map = new HashMap<>();
        List<Paper> papers = echartsMapper.queryJournalDistribution();
        for(Paper paper:papers){
            Integer cnt = 1;
            String journal = paper.getJournal();
            if(map.get(journal) != null){
                cnt = map.get(journal) + 1;
            }
            map.put(journal, cnt);
        }
        return map;
    }
    public int queryOperationLastYear(){
        return echartsMapper.queryOperationLastYear();
    }
    public int queryOperationLastQuarter(){
        return echartsMapper.queryOperationLastQuarter();
    }
    public int queryOperationLastMonth(){
        return echartsMapper.queryOperationLastMonth();
    }
    public int queryOperationLastSevenDays(){
        return echartsMapper.queryOperationLastSevenDays();
    }
    public int queryOperationYesterday(){
        return echartsMapper.queryOperationYesterday();
    }
    public int queryOperationToday(){
        return echartsMapper.queryOperationToday();
    }
}
