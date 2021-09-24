package com.pyd.paperonlinesystem.mapper;

import com.pyd.paperonlinesystem.entity.Paper;

import java.util.List;

/**
 * @ClassName: PaperMapper
 * @Description: TODO
 * @author: Ethan_Hunt
 * @date: 2021/9/22  20:26
 */
public interface PaperMapper {
    int insertPaper(Paper paper);
    List<Paper> queryAllPaper();
    List<Paper> queryPaperByCondition(String condition);
    List<Paper> queryPaperByName(String name);
    List<Paper> queryPaperByNameType(Paper paper);
    List<Paper> queryPaperByType(String type);
    List<Paper> queryPaperByJournal(String journal);
    List<Paper> queryPaperByTitle(String title);
    List<Paper> queryPaperByYear(String year);
}
