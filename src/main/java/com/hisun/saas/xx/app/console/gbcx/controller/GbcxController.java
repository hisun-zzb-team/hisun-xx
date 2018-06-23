/*
 * Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
 * http://www.hn-hisun.com
 * 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
 */

package com.hisun.saas.xx.app.console.gbcx.controller;

import com.hisun.base.controller.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by zhouying on 2017/9/16.
 */
@Controller
@RequestMapping("/xx/app/console/gbcx")
public class GbcxController extends BaseController{


    @RequestMapping(value = "/")
    public ModelAndView list(){

        return new ModelAndView("saas/xx/app/console/zscx/zscxManage");

    }

}
