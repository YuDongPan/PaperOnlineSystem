package com.pyd.paperonlinesystem.service;

import com.pyd.paperonlinesystem.entity.Paper;
import com.pyd.paperonlinesystem.mapper.PaperMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @ClassName: PaperService
 * @Description: TODO
 * @author: Ethan_Hunt
 * @date: 2021/9/22  20:32
 */
@Service
public class PaperService{
    @Resource
    PaperMapper paperMapper;
    public int insertPaper(Paper paper){
        return paperMapper.insertPaper(paper);
    }
    public List<Paper> queryPaperByCondition(String condition){
        return paperMapper.queryPaperByCondition(condition);
    }
    public List<Paper> queryPaperByName(String name){
        return paperMapper.queryPaperByName(name);
    }
    public List<Paper> queryPaperByNameType(Paper paper){
        return paperMapper.queryPaperByNameType(paper);
    }

    public List<Paper> queryPaperByType(String type){
        return paperMapper.queryPaperByType(type);
    }

    public List<Paper> queryPaperByJournal(String journal){ return paperMapper.queryPaperByJournal(journal);}

    public List<Paper> queryPaperByTitle(String title){ return paperMapper.queryPaperByTitle(title);}

    public List<Paper> queryPaperByYear(String year){
        return paperMapper.queryPaperByYear(year);
    }

    public List<Paper> queryAllPaper(){return paperMapper.queryAllPaper();}
}
