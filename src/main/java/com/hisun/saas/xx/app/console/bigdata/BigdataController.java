/*
 * Copyright (c) 2018. Hunan Hisun Union Information Technology Co, Ltd. All rights reserved.
 * http://www.hn-hisun.com
 * 注意:本内容知识产权属于湖南海数互联信息技术有限公司所有,除非取得商业授权,否则不得用于商业目的.
 */

package com.hisun.saas.xx.app.console.bigdata;

import com.google.common.collect.Maps;
import com.hisun.base.controller.BaseController;
import com.hisun.base.exception.GenericException;
import com.hisun.saas.xx.app.console.bset.vo.B01TreeVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by zhouying on 2017/9/16.
 */
@Controller
@RequestMapping("/bigdata")
public class BigdataController extends BaseController{

    @RequestMapping(value = "/dashboard")
    public ModelAndView list(){
        return new ModelAndView("saas/xx/app/console/bigdata/dashboard");
    }

}
