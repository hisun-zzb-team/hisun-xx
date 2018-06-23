/*
 * Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
 * http://www.hn-hisun.com
 * 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
 */

package com.hisun.saas.xx.app.console.shpc.controller;

import com.hisun.base.controller.BaseController;
import com.hisun.base.dao.util.CommonConditionQuery;
import com.hisun.base.dao.util.CommonOrder;
import com.hisun.base.dao.util.CommonOrderBy;
import com.hisun.base.dao.util.CommonRestrictions;
import com.hisun.base.exception.GenericException;
import com.hisun.base.vo.PagerVo;
import com.hisun.saas.sys.auth.UserLoginDetails;
import com.hisun.saas.sys.auth.UserLoginDetailsUtil;
import com.hisun.saas.xx.app.console.shpc.entity.*;
import com.hisun.saas.xx.app.console.shpc.service.Sha01Service;
import com.hisun.saas.xx.app.console.shpc.service.ShpcService;
import com.hisun.saas.xx.app.console.shpc.vo.Sha01Vo;
import com.hisun.saas.xx.app.console.shtp.service.ShtpsjService;
import com.hisun.saas.sys.util.BeanTrans;
import com.hisun.util.FileUtil;
import com.hisun.util.StringUtils;
import com.hisun.util.UUIDUtil;
import com.hisun.util.WordUtil;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.io.FileUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.util.StreamUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by zhouying on 2017/9/8.
 */
@Controller
@RequestMapping("/xx/app/console/Sha01")
public class Sha01Controller extends BaseController {
    @Autowired
    private ShpcService shpcService;

    @Autowired
    private Sha01Service sha01Service;

    @Value("${upload.absolute.path}")
    private String uploadAbsolutePath;

    private final static String DEFAULT_IMG_HEAD_PATH = "/WEB-INF/images/defaultHeadImage.png";

    @Autowired
    private ShtpsjService shtpsjService;

    @RequestMapping("/list")
    public ModelAndView list(HttpServletRequest req,@RequestParam(value="shpcId")String shpcId,String xmQuery,String noFileQuert,
                            @RequestParam(value = "shpcPageNum", defaultValue = "1") int shpcPageNum,
                             @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
                             @RequestParam(value = "pageSize" ,required=false) String pageSize) throws GenericException {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            Session session = SecurityUtils.getSubject().getSession();
            if(pageSize==null){
                if(session.getAttribute("Sha01pageSize")!=null){
                    pageSize = session.getAttribute("Sha01pageSize").toString();
                }else{
                    pageSize = "20";
                }
            }
            session.setAttribute("Sha01pageSize",pageSize);

            PagerVo<Sha01Vo> pager = this.sha01Service.getSha01VoS( Integer.parseInt(pageSize),pageNum,shpcId, xmQuery, noFileQuert);
            map.put("pager", pager);
            map.put("shpcPageNum", shpcPageNum);
            map.put("shpcId", shpcId);
            map.put("xmQuery", xmQuery);
            map.put("noFileQuert", noFileQuert);
        } catch (Exception e) {
            throw new GenericException(e);
        }
        return new ModelAndView("/saas/xx/app/console/Sha01/list", map);
    }

    @RequestMapping(value="/ajax/execute")
    public @ResponseBody
    Map<String,Object> importExcel(String shpcId, String token, @RequestParam(value="attachFile",required=false) MultipartFile file, HttpServletRequest req, HttpServletResponse resp) throws IOException {
        UserLoginDetails userLoginDetails = UserLoginDetailsUtil.getUserLoginDetails();
        Map<String,Object> map = new HashMap<String,Object>();
        if(file==null || file.isEmpty()){
            map.put("code", -1);
            map.put("message", "文件没有内容");
            return map;
        }

        try{
            String fileName = file.getOriginalFilename();
            if(fileName.endsWith(".doc") ||fileName.endsWith(".DOC")
                    ||fileName.endsWith(".docx") ||fileName.endsWith(".DOCX") ){
                String fileDir = uploadAbsolutePath +Sha01Service.ATTS_PATH;
                File _fileDir = new File(fileDir);
                if (_fileDir.exists() == false) {
                    _fileDir.mkdirs();
                }
                String savePath = fileDir + UUIDUtil.getUUID()+ "" + FileUtil.getExtend(fileName);

                try {
                    FileOutputStream fos = new FileOutputStream(new File(savePath));
                    fos.write(file.getBytes());
                    fos.flush();
                    fos.close();

                    //处理上传文件
                    //先将word转成Map
                    String tmplateWordPath = uploadAbsolutePath+Sha01Service.IMPORT_DOC_TEMPLATE;
                    WordUtil wordUtil = WordUtil.newInstance();
                    Map<String,String> dataMap = wordUtil.convertMapByTemplate(savePath,tmplateWordPath,"");
                    sha01Service.saveFromWordDataMap(userLoginDetails.getTenant(),dataMap,shpcId);
                    FileUtils.deleteQuietly(new File(savePath));
                } catch (Exception e) {
                    e.printStackTrace();
                    throw new GenericException(e);
                }
            }else{
                map.put("code", -1);
                map.put("message", "请上传word");
                return map;
            }
        }catch(Exception e){
            e.printStackTrace();
            map.put("code", -1);
            map.put("message", "读取文件错误，请检查word是否能正确打开");
            return map;
        }
        try{

        }catch(GenericException e){
            logger.error(e, e);
            map.put("code", -1);
            map.put("message", e.getMessage());
            return map;
        }catch(Exception e){
            logger.error(e, e);
            map.put("code", -1);
            map.put("message", "系统错误，请联系管理员");
            return map;
        }
        map.put("code", 1);
        return map;
    }



//    @RequestMapping("/{id}/photo")
//    public ResponseEntity<byte[]> photoToStream (@PathVariable("id")String id,
//                                                 HttpServletRequest request, HttpServletResponse response) throws IOException {
//        HttpHeaders headers = new HttpHeaders();
//        Sha01 sha01 = this.sha01Service.getByPK(id);
//        if(sha01.getZppath()!=null){
//            File file = new File(sha01.getZppath());
//            if(file.exists()){
//                headers.setContentType(MediaType.IMAGE_JPEG);
//                return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),
//                        headers, HttpStatus.OK);
//            }else{
//                //为空或者没有返回默认图片
//                headers.setContentType(MediaType.IMAGE_PNG);
//                File defaultfile = new File(request.getServletContext().getRealPath(DEFAULT_IMG_HEAD_PATH));
//                return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(defaultfile),
//                        headers, HttpStatus.OK);
//            }
//        }else{
//            //为空或者没有返回默认图片
//            headers.setContentType(MediaType.IMAGE_PNG);
//            File defaultfile = new File(request.getServletContext().getRealPath(DEFAULT_IMG_HEAD_PATH));
//            return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(defaultfile),
//                    headers, HttpStatus.OK);
//        }
//
//    }



    @RequestMapping("/{id}/photo")
    public HttpEntity<byte[]> getPhoto (@PathVariable("id")String id,
                                             HttpServletRequest request, HttpServletResponse response) throws IOException {
        Sha01 sha01 = this.sha01Service.getByPK(id);
        if(sha01.getZppath()!=null){
            String zpRealPath = uploadAbsolutePath+sha01.getZppath();
            File file = new File(zpRealPath);
            if(file.exists()){
                FileInputStream fis = new FileInputStream(file);
                StreamUtils.copy(fis,response.getOutputStream());
                response.setContentType(MediaType.IMAGE_JPEG_VALUE);
                return new HttpEntity(HttpStatus.OK);
            }else{
                //为空或者没有返回默认图片
                File defaultfile = new File(request.getServletContext().getRealPath(DEFAULT_IMG_HEAD_PATH));
                FileInputStream fis = new FileInputStream(defaultfile);
                StreamUtils.copy(fis,response.getOutputStream());
                response.setContentType(MediaType.IMAGE_PNG_VALUE);
                return new HttpEntity(HttpStatus.OK);
            }
        }else{
            //为空或者没有返回默认图片
            File defaultfile = new File(request.getServletContext().getRealPath(DEFAULT_IMG_HEAD_PATH));
            FileInputStream fis = new FileInputStream(defaultfile);
            StreamUtils.copy(fis,response.getOutputStream());

            response.setContentType(MediaType.IMAGE_PNG_VALUE);
            return new HttpEntity(HttpStatus.OK);
        }

    }


    /**
     * 调转到查看页面
     * @return
     */
//    @RequiresPermissions("admin-assetStatus:edit")
    @RequestMapping(value = "/view")
    public ModelAndView view(@RequestParam(value = "shpcPageNum", defaultValue = "1") int shpcPageNum,
                             @RequestParam(value = "a01PageNum", defaultValue = "1") int a01PageNum) {
        Map<String, Object> map = new HashMap<String, Object>();

        return new ModelAndView("/saas/xx/app/console/Sha01/view", map);
    }
    @RequestMapping(value = "/delete/{id}")
    public @ResponseBody Map<String, Object> delete(@PathVariable("id")String id,
                                                    @RequestParam(value = "shpcPageNum", defaultValue = "1") int shpcPageNum,
                                                    @RequestParam(value = "a01PageNum", defaultValue = "1") int a01PageNum) {
        Map<String, Object> map = new HashMap<String, Object>();
        try{
            Sha01 sha01 = this.sha01Service.getByPK(id);
            if(sha01 != null){
                this.sha01Service.delete(sha01);
            }
            map.put("success", true);
            map.put("shpcPageNum", shpcPageNum);
            map.put("a01PageNum", a01PageNum);
        }catch(Exception e){
            map.put("success", false);
            map.put("msg", "删除失败！");
            throw new GenericException(e);
        }
        return map;

    }




}
