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
import com.hisun.saas.sys.util.EntityWrapper;
import com.hisun.saas.xx.app.console.apiregister.entity.ApiRegister;
import com.hisun.saas.xx.app.console.apiregister.service.ApiRegisterService;
import com.hisun.saas.xx.app.console.shpc.entity.*;
import com.hisun.saas.xx.app.console.shpc.service.Sha01Service;
import com.hisun.saas.xx.app.console.shpc.service.ShpcService;
import com.hisun.saas.xx.app.console.shpc.vo.Sha01Vo;
import com.hisun.saas.xx.app.console.shpc.vo.ShpcVo;
import com.hisun.saas.xx.app.console.shtp.entity.Shtp;
import com.hisun.saas.xx.app.console.shtp.entity.Shtpsj;
import com.hisun.saas.xx.app.console.shtp.service.ShtpService;
import com.hisun.saas.xx.app.console.shtp.service.ShtpsjService;
import com.hisun.saas.sys.util.BeanTrans;
import com.hisun.saas.xx.app.console.shtp.vo.ShtpsjVo;
import com.hisun.util.*;
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

import javax.annotation.Resource;
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

    @Value("${sys.upload.absolute.path}")
    private String uploadAbsolutePath;

    private final static String DEFAULT_IMG_HEAD_PATH = "/WEB-INF/images/defaultHeadImage.png";

    @Autowired
    private ShtpsjService shtpsjService;

    @Autowired
    private ShtpService shtpService;

    @Resource
    private ApiRegisterService apiRegisterService;

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
    public ModelAndView view(@RequestParam(value="id")String id,@RequestParam(value = "shpcPageNum", defaultValue = "1") int shpcPageNum,
                             @RequestParam(value = "a01PageNum", defaultValue = "1") int a01PageNum) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            Sha01 sha01 = this.sha01Service.getByPK(id);
            Sha01Vo shpa01Vo = new Sha01Vo();

            if (sha01 == null) {
                logger.error("数据不存在");
                throw new GenericException("数据不存在");
            }

            BeanUtils.copyProperties(shpa01Vo, sha01);

            map.put("shpa01Vo", shpa01Vo);
            map.put("shpcId", sha01.getShpc().getId());
            map.put("shpcPageNum", shpcPageNum);
            map.put("a01PageNum", a01PageNum);
        }catch(Exception e){
            map.put("success", false);
            map.put("msg", "查看失败！");
            throw new GenericException(e);
        }
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

    @RequestMapping(value = "/un/wap/hypcList")
    public ModelAndView list(HttpServletRequest req, String pId,
                             @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
                             @RequestParam(value = "pageSize" ,required=false) String pageSize) throws GenericException {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            Session session = SecurityUtils.getSubject().getSession();
            if(pageSize==null){
                if(session.getAttribute("bwhpageSize")!=null){
                    pageSize = session.getAttribute("bwhpageSize").toString();
                }else{
                    pageSize = "20";
                }
            }
            session.setAttribute("bwhpageSize",pageSize);
            //临时处理,将当前服务IP,端口,context写入ApiRegister
            List<ApiRegister> apiRegisters = this.apiRegisterService.list();
            if(apiRegisters!=null && apiRegisters.size()>0){
                for(ApiRegister apiRegister : apiRegisters){
                    apiRegister.setIp(req.getServerName());
                    apiRegister.setPort(""+req.getServerPort());
                    apiRegister.setContext(req.getContextPath());
                    this.apiRegisterService.update(apiRegister);
                }
            }
            CommonConditionQuery query = new CommonConditionQuery();
            // query.add(CommonRestrictions.and(" shlx = :shlx", "shlx", Shpc.SHLX_BWH));
            query.add(CommonRestrictions.and(" tombstone = :tombstone", "tombstone", 0));
            CommonOrderBy orderBy = new CommonOrderBy();
            orderBy.add(CommonOrder.asc("px"));

            Long total = this.shpcService.count(query);
            List<Shpc> shpcs = this.shpcService.list(query, orderBy, pageNum,
                    Integer.parseInt(pageSize));
            List<ShpcVo> shpcVos = new ArrayList<ShpcVo>();
            if (shpcs != null) {// entity ==> vo
                for (Shpc shpc : shpcs) {
                    ShpcVo vo = new ShpcVo();
                    BeanUtils.copyProperties(vo, shpc);
                    vo.setPcsjValue(DateUtil.formatDateByFormat(shpc.getPcsj(),"yyyyMMdd"));
                    vo.setA01Count(shpc.getSha01s().size());
                    shpcVos.add(vo);
                }
            }
            map.put("datas", shpcVos);
        } catch (Exception e) {
            throw new GenericException(e);
        }
        return new ModelAndView("/saas/xx/app/console/Sha01/wap/hypc/list", map);
    }

    @RequestMapping("/un/wap/list")
    public ModelAndView wapList(HttpServletRequest req,@RequestParam(value="shpcId")String shpcId,String xmQuery,String noFileQuert) throws GenericException {
        Map<String, Object> map = new HashMap<String, Object>();
        UserLoginDetails userLoginDetails = UserLoginDetailsUtil.getUserLoginDetails();
        try {
            Session session = SecurityUtils.getSubject().getSession();
            CommonConditionQuery query = new CommonConditionQuery();
//            query.add(CommonRestrictions.and(" shZt = :shZt", "shZt", 2));
            List<Map> mapList = this.sha01Service.getSha01List(shpcId);

            List<Sha01> list = mapToSha01(mapList);

            query = new CommonConditionQuery();
            query.add(CommonRestrictions.and(" shpc.id = :shpcId", "shpcId", shpcId));
            query.add(CommonRestrictions.and(" createUserId = :createUserId ", "createUserId", userLoginDetails.getUserid()));
            List<Shtp> shtps = this.shtpService.list(query,null);
            String shtpId = "";
            if(shtps!=null&shtps.size()>0){
                shtpId = shtps.get(0).getId();
            }
            List<Sha01Vo> sha01Vos = new ArrayList<>();
            for(Sha01 sha01 : list){
                Sha01Vo sha01Vo = new Sha01Vo();
                BeanUtils.copyProperties(sha01Vo, sha01);
                query = new CommonConditionQuery();
                query.add(CommonRestrictions.and(" sha01.id = :sha01Id", "sha01Id", sha01.getId()));
                query.add(CommonRestrictions.and(" shtp.id = :shtpId", "shtpId", shtpId));
                List<Shtpsj> shtpjss = this.shtpsjService.list(query,null);
                if(shtpjss!=null&shtpjss.size()>0){
                    ShtpsjVo shtpsjVo = new ShtpsjVo();
                    Shtpsj shtpsj = shtpjss.get(0);
                    BeanUtils.copyProperties(shtpsjVo, shtpsj);
                    sha01Vo.setShtpsjVo(shtpsjVo);
                }
                sha01Vos.add(sha01Vo);
            }
            map.put("shpcId", shpcId);
            map.put("xmQuery", xmQuery);
            map.put("datas", sha01Vos);
            map.put("noFileQuert", noFileQuert);
        } catch (Exception e) {
            throw new GenericException(e);
        }
        return new ModelAndView("/saas/xx/app/console/Sha01/wap/list", map);
    }

    public List<Sha01> mapToSha01(List<Map> mapList){
        List<Sha01> sha01s = new ArrayList<>();
        Sha01 sha01;
        for(Map map:mapList){
            sha01 = new Sha01();
            sha01.setId(map.get("id").toString());
            if(map.get("jsbs")!=null){
                sha01.setXm(map.get("jsbs").toString()+map.get("xm").toString());
            }else {
                sha01.setXm(map.get("xm") == null ? "" : map.get("xm").toString());
            }
            sha01.setXb(map.get("xb")==null ?"":map.get("xb").toString());;
            sha01.setMz(map.get("mz")==null ?"":map.get("mz").toString());
            sha01.setJg(map.get("jg")==null ?"":map.get("jg").toString());
            sha01.setCsny(map.get("csny")==null ?"":map.get("csny").toString());
            sha01.setRdsj(map.get("rdsj")==null ?"":map.get("rdsj").toString());
            sha01.setWhcd(map.get("whcd")==null ?"":map.get("whcd").toString());
            sha01.setRxjbsj(map.get("rxjbsj")==null ?"":map.get("rxjbsj").toString());
            sha01.setMztjqk(map.get("mztjqk")==null ?"":map.get("mztjqk").toString());
            sha01.setYwfpjl(map.get("ywfpjl")==null ?"":map.get("ywfpjl").toString());
            sha01.setNtzpbyj(map.get("ntzpbyj")==null ?"":map.get("ntzpbyj").toString());
            sha01.setShyj(map.get("shyj")==null ?"":map.get("shyj").toString());
            sha01.setCjgzsj(map.get("cjgzsj")==null ?"":map.get("cjgzsj").toString());
//            sha01.setCjgzsjStr(map.get("cjgzsjStr")==null ?"":map.get("cjgzsjStr").toString());
            sha01.setXgzdwjzw(map.get("xgzdwjzw")==null ?"":map.get("xgzdwjzw").toString());
            sha01.setPx(Integer.parseInt(map.get("a01_px").toString()));
            sha01.setZppath(map.get("ZP_PATH")==null ?"":map.get("ZP_PATH").toString());

            sha01.setXhXx(map.get("xh_xx")==null ?"":map.get("xh_xx").toString());
            sha01.setZzmmXx(map.get("zzmm_xx")==null ?"":map.get("zzmm_xx").toString());
            sha01.setRxsjXx(map.get("rxsj_xx")==null ?"":map.get("rxsj_xx").toString());
            sha01.setXymcXx(map.get("xymc_xx")==null ?"":map.get("xymc_xx").toString());
            sha01.setZymcXx(map.get("zymc_xx")==null ?"":map.get("zymc_xx").toString());
            sha01.setPybXx(map.get("pyb_xx")==null ?"":map.get("pyb_xx").toString());
            sha01.setJfxXx(map.get("jfx_xx")==null ?"":map.get("jfx_xx").toString());
            sha01.setDsxmXx(map.get("dsxm_xx")==null ?"":map.get("dsxm_xx").toString());
            sha01.setLunwenXx(map.get("lunwen_xx")==null ?"":map.get("lunwen_xx").toString());
            sha01s.add(sha01);
        }

        return sha01s;
    }

    @RequestMapping(value = "/un/wap/tp")
    public @ResponseBody Map<String, Object> tp(String idStr,int tp,String shpcId) {
        Map<String, Object> map = new HashMap<String, Object>();
        String[] ids = idStr.split(",");
        for(String id:ids){
            if(StringUtils.isNotEmpty(id)){
                tps(id,tp,shpcId);
            }
        }
        map.put("success", true);
        return map;

    }

    public void tps(String id,int tp,String shpcId){
        UserLoginDetails userLoginDetails = UserLoginDetailsUtil.getUserLoginDetails();
        CommonConditionQuery query = new CommonConditionQuery();
        try{
            query.add(CommonRestrictions.and(" shpc.id = :shpcId ", "shpcId", shpcId));
            query.add(CommonRestrictions.and(" createUserId = :createUserId ", "createUserId", userLoginDetails.getUserid()));
            List<Shtp> shtps = this.shtpService.list(query,null);

            if(shtps!=null&shtps.size()>0){
                Shtp shtp = shtps.get(0);
                query=new CommonConditionQuery();
                query.add(CommonRestrictions.and(" sha01.id = :id ", "id", id));
                query.add(CommonRestrictions.and(" createUserId = :createUserId ", "createUserId", userLoginDetails.getUserid()));
                List<Shtpsj> shtpsjs = this.shtpsjService.list(query,null);
                if(shtpsjs!=null&shtpsjs.size()>0){
                    Shtpsj shtpsj = shtpsjs.get(0);
                    shtpsj.setTp(tp);
                    EntityWrapper.wrapperUpdateBaseProperties(shtpsj,userLoginDetails);
                    this.shtpsjService.update(shtpsj);
                }else {
                    Shtpsj shtpsj = new Shtpsj();
                    Sha01 sha01 = this.sha01Service.getByPK(id);
                    shtpsj.setSha01(sha01);
                    shtpsj.setTp(tp);
                    shtpsj.setShtp(shtp);
                    EntityWrapper.wrapperSaveBaseProperties(shtpsj,userLoginDetails);
                    this.shtpsjService.save(shtpsj);
                }
            }else {
                Shtp shtp = new Shtp();
                query=new CommonConditionQuery();
                query.add(CommonRestrictions.and(" id = :id ", "id", id));
                Shpc shpc = this.shpcService.getByPK(shpcId);
                shtp.setShpc(shpc);
                shtp.setTpr_id(userLoginDetails.getUserid());
                shtp.setTpr_xm(userLoginDetails.getRealname());
                EntityWrapper.wrapperSaveBaseProperties(shtp,userLoginDetails);
                String shtpId = this.shtpService.save(shtp);

                Shtp shtp1 = this.shtpService.getByPK(shtpId);
                Shtpsj shtpsj = new Shtpsj();
                Sha01 sha01 = this.sha01Service.getByPK(id);
                shtpsj.setSha01(sha01);
                shtpsj.setTp(tp);
                shtpsj.setShtp(shtp1);
                EntityWrapper.wrapperSaveBaseProperties(shtpsj,userLoginDetails);
                this.shtpsjService.save(shtpsj);
            }
        }catch(Exception e){
            throw new GenericException(e);
        }
    }

    @RequestMapping("/un/wap/jgList")
    public ModelAndView jgList(HttpServletRequest req,@RequestParam(value="shpcId")String shpcId,String xmQuery,String noFileQuert,String tp) throws GenericException {
        Map<String, Object> map = new HashMap<String, Object>();
        UserLoginDetails userLoginDetails = UserLoginDetailsUtil.getUserLoginDetails();
        try {
            Session session = SecurityUtils.getSubject().getSession();
            CommonConditionQuery query = new CommonConditionQuery();
            List<Map> mapList = this.sha01Service.getSha01List(shpcId);

            List<Sha01> list = mapToSha01(mapList);

            query = new CommonConditionQuery();
            query.add(CommonRestrictions.and(" shpc.id = :shpcId", "shpcId", shpcId));
            query.add(CommonRestrictions.and(" createUserId = :createUserId ", "createUserId", userLoginDetails.getUserid()));
            List<Shtp> shtps = this.shtpService.list(query,null);
            String shtpId = "";
            if(shtps!=null&shtps.size()>0){
                shtpId = shtps.get(0).getId();
            }
            List<Sha01Vo> sha01Vos = new ArrayList<>();
            List<Sha01Vo> sha01VosEnd = new ArrayList<>();

            query = new CommonConditionQuery();
            if(StringUtils.isNotEmpty(tp)&&Integer.parseInt(tp)!=4){
                query.add(CommonRestrictions.and(" tp = :tp", "tp", Integer.parseInt(tp)));
            }
            query.add(CommonRestrictions.and(" shtp.id = :shtpId", "shtpId", shtpId));
            List<Shtpsj> shtpjss = this.shtpsjService.list(query,null);
            if(shtpjss!=null&shtpjss.size()>0){
                for(Shtpsj shtpsj:shtpjss){
                    if(StringUtils.isEmpty(tp)||Integer.parseInt(tp)==shtpsj.getTp()||(StringUtils.isNotEmpty(tp)&&Integer.parseInt(tp)==4)){
                        Sha01 sha01 = shtpsj.getSha01();
                        Sha01Vo sha01Vo = new Sha01Vo();
                        BeanUtils.copyProperties(sha01Vo, sha01);
                        ShtpsjVo shtpsjVo = new ShtpsjVo();
                        BeanUtils.copyProperties(shtpsjVo, shtpsj);
                        sha01Vo.setShtpsjVo(shtpsjVo);
                        sha01Vos.add(sha01Vo);
                    }
                }
            }
            if(StringUtils.isEmpty(tp)||(StringUtils.isNotEmpty(tp)&&Integer.parseInt(tp)==4)){
                Sha01Vo sha01Vo;
                for(Sha01 sha01:list){
                    boolean flag = false;
                    sha01Vo = new Sha01Vo();
                    BeanUtils.copyProperties(sha01Vo, sha01);
                    for(Sha01Vo sha01Vo1:sha01Vos){
                        if(sha01Vo1.getId().equals(sha01Vo.getId())){
                            sha01Vo.setShtpsjVo(sha01Vo1.getShtpsjVo());
                            if(StringUtils.isNotEmpty(tp)&&Integer.parseInt(tp)==4){
                                flag = true;
                                break;
                            }
                        }
                    }
                    if(flag&&(StringUtils.isNotEmpty(tp)&&Integer.parseInt(tp)==4)){
                        continue;
                    }
                    sha01VosEnd.add(sha01Vo);
                }
            }

            Map<String,Object> numMap=getNum(shpcId);

            map.put("tyNum",numMap.get("tyNum"));
            map.put("btyNum",numMap.get("btyNum"));
            map.put("qqNum",numMap.get("qqNum"));
            map.put("ltNum",list.size()-(int)numMap.get("tpNum"));
            map.put("shpcId", shpcId);
            map.put("xmQuery", xmQuery);
            map.put("tp", tp);
            if(StringUtils.isEmpty(tp)||Integer.parseInt(tp)==4){
                map.put("datas", sha01VosEnd);
            }else {
                map.put("datas", sha01Vos);
            }
            map.put("noFileQuert", noFileQuert);
        } catch (Exception e) {
            throw new GenericException(e);
        }
        return new ModelAndView("/saas/xx/app/console/Sha01/wap/tpjgList", map);
    }

    public Map<String,Object> getNum(String shpcId){
        Map<String,Object> map = new HashMap<>();
        int tyNum=0;//同意人数
        int btyNum=0;//不同意人数
        int qqNum=0;//弃权人数
        int tpNum=0;//投票总人数
        UserLoginDetails userLoginDetails = UserLoginDetailsUtil.getUserLoginDetails();
        CommonConditionQuery query = new CommonConditionQuery();
        query = new CommonConditionQuery();
        query.add(CommonRestrictions.and(" shpc.id = :shpcId", "shpcId", shpcId));
        query.add(CommonRestrictions.and(" createUserId = :createUserId ", "createUserId", userLoginDetails.getUserid()));
        List<Shtp> shtps = this.shtpService.list(query,null);
        String shtpId = "";
        if(shtps!=null&shtps.size()>0){
            shtpId = shtps.get(0).getId();
        }else {
            map.put("tyNum",tyNum);
            map.put("btyNum",btyNum);
            map.put("qqNum",qqNum);
            map.put("tpNum",tpNum);
            return map;
        }
        query = new CommonConditionQuery();
        query.add(CommonRestrictions.and(" shtp.id = :shtpId", "shtpId", shtpId));
        List<Shtpsj> shtpjss = this.shtpsjService.list(query,null);
        if(shtpjss!=null&shtpjss.size()>0){
            for(Shtpsj shtpsj:shtpjss){
                if(shtpsj.getTp()==1){
                    tyNum++;
                }else if(shtpsj.getTp()==2){
                    btyNum++;
                }else if(shtpsj.getTp()==3){
                    qqNum++;
                }
                tpNum++;
            }
        }
        map.put("tyNum",tyNum);
        map.put("btyNum",btyNum);
        map.put("qqNum",qqNum);
        map.put("tpNum",tpNum);
        return map;
    }
}
