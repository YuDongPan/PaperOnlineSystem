package com.pyd.paperonlinesystem.mapper;

import com.pyd.paperonlinesystem.entity.Paper;

import java.util.List;

/**
 * @ClassName: EchartsMapper
 * @Description: TODO
 * @author: Ethan_Hunt
 * @date: 2021/9/25  22:54
 */
public interface EchartsMapper {
    int queryEEGPaperCnt();
    int queryMIPPaperCnt();
    int queryPaper10yearsAgo();
    List<Paper> queryPaperIn10years();
    List<Paper> queryJournalDistribution();
    int queryOperationLastYear();
    int queryOperationLastQuarter();
    int queryOperationLastMonth();
    int queryOperationLastSevenDays();
    int queryOperationYesterday();
    int queryOperationToday();

}
