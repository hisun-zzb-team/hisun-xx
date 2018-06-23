/*
 * Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
 * http://www.hn-hisun.com
 * 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
 */

package com.hisun.saas.xx.app.console.bset.controller;

import com.hisun.base.controller.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by zhouying on 2017/9/16.
 */
@Controller
@RequestMapping("/xx/app/console/bset/b09")
public class AppBsetB09Controller extends BaseController{



    @RequestMapping(value = "/ajax/list")
    public ModelAndView list(){
        return new ModelAndView("saas/xx/app/console/bsetB01/b09/list");
    }

    @RequestMapping(value="/ajax/add")
    public ModelAndView addOrEdit(){
     Map<String, Object> map = new HashMap<String, Object>();
        return new ModelAndView("/saas/xx/app/console/bsetB01/b09/addB09",map);
    }
}
