package com.pyd.paperonlinesystem.controller;

/**
 * @ClassName: FileController
 * @Description: TODO
 * @author: Ethan_Hunt
 * @date: 2021/9/22  21:18
 */

import com.pyd.paperonlinesystem.entity.Log;
import com.pyd.paperonlinesystem.entity.Paper;
import com.pyd.paperonlinesystem.service.LogService;
import com.pyd.paperonlinesystem.service.PaperService;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/file")
public class FileController {
    @Resource
    private PaperService paperService;
    @Resource
    private LogService logService;
    @Value("${springConfigs.params.filePaths}")
    private String filePath;
    private static final Logger logger = LoggerFactory.getLogger(FileController.class);

    @CrossOrigin(origins = "*",maxAge = 3600)
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject upload(@RequestParam("file")MultipartFile file, HttpServletRequest request) throws Exception {
        JSONObject final_json = new JSONObject();
        String newFileName = null;
        // 获得提交的文件名
        String fileName = file.getOriginalFilename();
        // 获取文件输入流
        //InputStream ins = file.getInputStream();
        // 获取文件类型
        //String contentType = file.getContentType();
        if (!file.isEmpty()){
            //newFileName = filePath + newFileName;
            File dest = new File(filePath + fileName);
            if (!dest.getParentFile().exists()) { //判断文件父目录是否存在
                dest.getParentFile().mkdir();
            }
            file.transferTo(dest);
            //logger.info("上传成功");
            //返回正确
            final_json.put("code",0);
            final_json.put("msg","");
            final_json.put("data", newFileName);
            return final_json;
            }

        else{
            //返回错误
            final_json.put("code",1); //除了0以外的都是错误
            final_json.put("msg",""); //错误信息自定义即可
            final_json.put("data",""); //需要返回的值自定义
            return final_json;
        }
    }

    @RequestMapping("/insertPaper.do")
    @ResponseBody
    public Map<String, Object> insertPaper(HttpServletRequest request, HttpSession session){
        Map<String, Object> map = new HashMap<String, Object>();
        String username = request.getParameter("username");
        String filename = request.getParameter("filename");
        String journal = request.getParameter("journal");
        String year = request.getParameter("year");
        String type = request.getParameter("type");
        String title = request.getParameter("title");
        Paper newPaper = new Paper(filename, journal, Integer.valueOf(year), type, filePath, title);
        if(paperService.insertPaper(newPaper) > 0) {
            map.put("msg_insert", "ok");
            String msg = "上传文献";
            Log log = new Log(username, filename, type, msg);
            logService.insertLog(log);
        }
        else {
            map.put("msg_insert", "error");
        }
        return map;
    }

    //上传文件
/*    @PostMapping("/upload")
    @ResponseBody
    public Map<String, Object> uploadFile(@RequestParam("file") MultipartFile file, @RequestParam("fid") Integer fid, HttpServletResponse response)  {
        Map<String, Object> map = new HashMap<String, Object>();
        if (file.isEmpty()) {
            map.put("msg_file", "not_found");
            return map;
        }
        // 获得提交的文件名
        String fileName = file.getOriginalFilename();
        // 获取文件输入流
        //InputStream ins = file.getInputStream();
        // 获取文件类型
        //String contentType = file.getContentType();

        //加个时间戳，尽量避免文件名称重复
        fileName = new SimpleDateFormat("yyyyMMddHHmmssSSSS").format(new Date()) + "_" + fileName;

        File dest = new File(filePath + fileName);
        if (!dest.getParentFile().exists()) { //判断文件父目录是否存在
            dest.getParentFile().mkdir();
        }
        try {
            file.transferTo(dest);
            //logger.info("上传成功");
            map.put("msg_file", "upload_success");
            map.put("file_name", fileName);
            return map;
        } catch (Exception e) {
            //logger.error(e.getMessage());
            map.put("msg_file", "upload_failed");
            return map;
        }
    }
*/
    //下载文件
    @RequestMapping(value = "/download/{name}/{type}")
    public void downloadFile(@PathVariable("name") String fileName, @PathVariable("type") String type, HttpServletResponse response, HttpSession session) throws IOException {
        //logger.info("download....file_name:" + fileName);
        File file = new File(filePath + "/" + fileName);
        if (file.exists()) { //判断文件是否存在
            response.setContentType("application/force-download");
            response.setHeader("Content-Disposition", "attachment;fileName=" + fileName);
            byte[] buffer = new byte[1024];
            FileInputStream fis = null; //文件输入流
            BufferedInputStream bis = null;
            OutputStream os = null; //输出流
            try {
                os = response.getOutputStream();
                fis = new FileInputStream(file);
                bis = new BufferedInputStream(fis);
                int i = bis.read(buffer);
                while (i != -1) {
                    os.write(buffer);
                    i = bis.read(buffer);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            logger.info("----------file download" + fileName);
            try {
                bis.close();
                fis.close();
                String username = (String)session.getAttribute("loginUsername");
                String msg = "下载文献";
                Log log = new Log(username, fileName, type, msg);
                logService.insertLog(log);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }else{
            response.setStatus(404);
        }
    }

}
