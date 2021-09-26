package com.pyd.paperonlinesystem.controller;

import com.pyd.paperonlinesystem.entity.Paper;
import com.pyd.paperonlinesystem.service.PaperService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

/**
 * @ClassName: GetMediaController
 * @Description: TODO
 * @author: Ethan_Hunt
 * @date: 2021/9/25  15:29
 */
@RestController
@RequestMapping("/media")
public class GetMediaController {
    @Value("${springConfigs.params.filePaths}")
    private String filePath;
    @Autowired
    private PaperService paperService;

    @RequestMapping(value = "/preview/{id}", method = RequestMethod.GET)
    public void pdfStreamHandler(@PathVariable("id") String id, HttpServletResponse response) {
        //PDF文件地址
        Integer fid = Integer.valueOf(id);
        Paper newPaper = paperService.queryPaperById(fid);
        System.out.println(newPaper.getName());
        File file = new File(filePath + newPaper.getName());
        //File file = new File(filePath + newPaper.getName());
        if (file.exists()) {
            byte[] data = null;
            FileInputStream input=null;
            try {
                input= new FileInputStream(file);
                data = new byte[input.available()];
                input.read(data);
                response.getOutputStream().write(data);
            } catch (Exception e) {
                System.out.println("pdf文件处理异常：" + e);
            }finally{
                try {
                    if(input!=null){
                        input.close();
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
