/*
 * Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
 * http://www.hn-hisun.com
 * 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
 */

package com.hisun.saas.xx.app.console.zszyk;

import com.google.common.collect.Maps;
import com.hisun.base.controller.BaseController;
import com.hisun.base.vo.PagerVo;
import com.hisun.saas.xx.app.console.aset.vo.AppAsetA01Vo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

/**
 * Created by zhouying on 2017/9/16.
 */
@Controller
@RequestMapping("/xx/app/console/zszyk")
public class AppZszykController extends BaseController{


    //===============base
    @RequestMapping(value = "/list")
    public ModelAndView base(){
        Map<String, Object> map = Maps.newHashMap();
        PagerVo<AppAsetA01Vo> pagerVo = new PagerVo<AppAsetA01Vo>(null, 1, 1, 10);
        map.put("pager", pagerVo);
        return new ModelAndView("saas/xx/app/console/zszyk/list",map);
    }

}
